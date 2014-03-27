-- Questions:
-- track title = song title?
-- if I reference song title in track table, then error. so leaving it out for now

-- Changed:
-- Artist contains band attribute
-- alum has record_year integer instead of data

-- Uncomment to reset tables:
-- drop table project.radiohost;
-- drop table project.show;
-- drop table project.hostshow;
-- drop table project.playsheet;
-- drop table project.timeslot;
-- drop table project.guest;
-- drop table project.band;
-- drop table project.artist;
-- drop table project.album;
-- drop table project.song;
-- drop table project.track;

create table project.radiohost (
emp_num integer primary key,
first_name text not null,
last_name text not null,
stage_name text,
birthday text,
rating integer default 0 check (rating >= 0),
contract_start text,
salary decimal default 0 );

create table project.show (
show_num integer primary key,
show_name text not null,
descr text,
category text );

create table project.hostshow (
contract_num integer primary key,
emp_num integer references project.radiohost(emp_num) on delete restrict,
show_num integer references project.show(show_num) on delete restrict,
host_start_year integer,
host_start_month text check (host_start_month in('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')) );

create table project.playsheet (
sheet_num integer primary key,
date_played text,
week_day text check (week_day in('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')) );

create table project.timeslot (
slot_num integer primary key,
start_time integer not null check (start_time >= 0),
end_time integer not null check(end_time >= 0),
show_num integer references project.show(show_num) on delete restrict,
sheet_num integer references project.playsheet(sheet_num) on delete restrict );

create table project.guest (
guest_num integer primary key,
first_name text not null,
last_name text not null,
descr text,
topic text,
rating integer default 0 check (rating >= 0),
slot_num integer references project.timeslot(slot_num) on delete restrict );

-- removed bands
-- create table project.band (
-- band_num integer primary key,
-- band_name text not null,
-- start_year integer check (start_year >= 0),
-- nationality text );

-- performer can be a band or an individual
create table project.performer (
performer_num integer primary key,
pname text,
nationality text,
start_date text, 
is_band boolean default false );

create table project.album (
album_num integer primary key,
album_type text,
label text,
recording_year integer );

create table project.song (
song_num integer primary key,
title text not null,
cancon boolean default false,
instrumental boolean default false,
album_num integer references project.album(album_num) on delete restrict,
performer_num integer references project.performer(performer_num) on delete restrict );

create table project.track (
track_num integer primary key,
title text,
start_time integer check (start_time >= 0),
end_time integer check (end_time >= 0),
track_type text,
sheet_num integer references project.playsheet(sheet_num) on delete restrict,
song_num integer references project.song(song_num) on delete restrict );
