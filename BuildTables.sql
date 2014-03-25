-- Questions:
-- track title = song title?
-- if I reference song title in track table, then error. so leaving it out for now

-- Changed:
-- Artists are part of 0 or 1 bands
-- Only artists can "perform" songs, not bands (at least not directly)

-- Uncomment to reset tables:
-- drop table project.host cascade;
-- drop table project.show cascade;
-- drop table project.hostshow cascade;
-- drop table project.playsheet cascade;
-- drop table project.timeslot cascade;
-- drop table project.guest cascade;
-- drop table project.band cascade;
-- drop table project.artist cascade;
-- drop table project.album cascade;
-- drop table project.song cascade;
-- drop table project.track cascade;

create table project.host (
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
emp_num integer references host(emp_num) on delete restrict,
show_num integer references show(show_num) on delete restrict,
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
show_num integer references show(show_num) on delete restrict,
sheet_num integer references playsheet(sheet_num) on delete restrict );

create table project.guest (
guest_num integer primary key,
first_name text not null,
last_name text not null,
descr text,
topic text,
rating integer default 0 check (rating >= 0),
slot_num integer references timeslot(slot_num) on delete restrict );

create table project.band (
band_num integer primary key,
band_name text not null,
start_year integer check (start_year >= 0),
nationality text );

create table project.artist (
artist_num integer primary key,
band_num integer references band(band_num),
first_name text not null,
last_name text,
stage_name text,
nationality text,
birthday text );

create table project.album (
album_num integer primary key,
album_type text,
label text,
recording_date text );

create table project.song (
song_num integer primary key,
title text not null,
cancon boolean default false,
instrumental boolean default false,
album_num integer references album(album_num) on delete restrict,
artist_num integer references artist(artist_num) on delete restrict );

create table project.track (
track_num integer primary key,
title text,
start_time integer check (start_time >= 0),
end_time integer check (end_time >= 0),
track_type text,
song_num integer references song(song_num) on delete restrict );
