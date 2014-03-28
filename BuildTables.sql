-- Questions:
-- track title = song title?
-- if I reference song title in track table, then error. so leaving it out for now

-- Changed:
-- Artist/band replaced by "performer" table
-- Performer contains is_band attribute, there is no band table
-- alum has record_year integer instead of record_date

-- Uncomment to reset tables:
drop table project.radiohost cascade;
drop table project.show cascade;
drop table project.hostshow;
drop table project.playsheet cascade;
drop table project.timeslot cascade;
drop table project.guest;
-- drop table project.band cascade;
-- drop table project.artist cascade;
drop table project.album cascade;
drop table project.performer cascade;
drop table project.song cascade;
drop table project.track;

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

-- COPY radiohost FROM 'csv_files/radiohost.csv' DELIMITER ',' CSV;
insert into project.radiohost values
(0, 'Jane', 'Palmer', 'Pama', 'January 11 1990', 7, 'June 1 2007', 45000),
(1, 'Carl', 'Tyson', 'Crazy Carl', 'May 5 1985', 8, 'December 6 2009', 42000),
(2, 'Brita', 'Fearson', 'Bee', 'April 12 1995', 9, 'April 6 2012', 33000),
(3, 'John', 'Kramer', 'JK', 'March 4 1978', 6, 'November 28 2005', 43000),
(4, 'Kat', 'Barry', 'Katy', 'February 24 1992', 8, 'February 17 2011', 47000),
(5, 'Barb', 'Steinberg', 'Barbie', 'October 7 1984', 7, 'July 4 2007', 44000);
