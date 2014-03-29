-- Questions:
-- track title = song title?
-- if I reference song title in track table, then error. so leaving it out for now

-- Changed:
-- Artist/band replaced by "performer" table
-- Performer contains is_band attribute, there is no band table
-- alum has record_year integer instead of record_date

-- Uncomment to reset schema/tables:
drop schema project cascade;
-- drop table project.radiohost cascade;
-- drop table project.show cascade;
-- drop table project.hostshow;
-- drop table project.playsheet cascade;
-- drop table project.timeslot cascade;
-- drop table project.guest;
-- drop table project.album cascade;
-- drop table project.performer cascade;
-- drop table project.song cascade;
-- drop table project.track;

create schema project AUTHORIZATION rmurr085;
set search_path='project';

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

insert into project.radiohost values
(0, 'Jane', 'Palmer', 'Pama', 'January 11 1990', 7, 'June 1 2007', 45000),
(1, 'Carl', 'Tyson', 'Crazy Carl', 'May 5 1985', 8, 'December 6 2009', 42000),
(2, 'Brita', 'Fearson', 'Bee', 'April 12 1995', 9, 'April 6 2012', 33000),
(3, 'John', 'Kramer', 'JK', 'March 4 1978', 6, 'November 28 2005', 43000),
(4, 'Kat', 'Barry', 'Katy', 'February 24 1992', 8, 'February 17 2011', 47000),
(5, 'Barb', 'Steinberg', 'Barbie', 'October 7 1984', 7, 'July 4 2007', 44000);

insert into project.show values
(0, 'Good Morning Show', 'A show to wake you up!', 'rock'),
(1, 'Jazz Hour', 'Smooth jazz', 'jazz'),
(2, 'Lunch Break', 'Classical music for you lunch break', 'classical'),
(3, 'Just Hip Hop', 'Old school hip hop', 'hiphop'),
(4, 'Night Time Tunes', 'Relaxing music', 'reggae');

insert into project.hostshow values
(0, 0, 0, 2009, 'Mar'),
(1, 1, 0, 2011, 'Feb'),
(2, 3, 1, 2008, 'Jun'),
(3, 4, 1, 2013, 'Oct'),
(4, 3, 2, 2009, 'Nov'),
(5, 5, 2, 2007, 'Dec'),
(6, 1, 3, 2010, 'May'),
(7, 2, 3, 2012, 'Aug'),
(8, 4, 4, 2014, 'Sep'),
(9, 2, 4, 2013, 'Apr');

insert into project.playsheet values
(0, 'January 3 2010', 'Wed'),
(1, 'January 5 2010', 'Fri'),
(2, 'January 6 2010', 'Sat'),
(3, 'January 8 2010', 'Mon'),
(4, 'January 12 2010', 'Fri'),
(5, 'January 13 2010', 'Sat'),
(6, 'January 15 2010', 'Mon'),
(7, 'January 18 2010', 'Thu'),
(8, 'January 22 2010', 'Mon'),
(9, 'January 25 2010', 'Thu');

insert into project.timeslot values
(0, 6000, 6010, 0, 0),
(1, 6010, 6020, 0, 1),
(2, 6020, 6035, 0, 3),
(3, 6000, 6010, 1, 4),
(4, 6010, 6025, 1, 0),
(5, 6025, 6035, 1, 9),
(6, 6000, 6015, 2, 2),
(7, 6015, 6025, 2, 5),
(8, 6025, 6035, 2, 7),
(9, 6000, 6020, 3, 8),
(10, 6020, 6040, 3, 6),
(11, 6040, 6055, 3, 2),
(12, 6000, 6013, 4, 7),
(13, 6013, 6029, 4, 5),
(14, 6029, 6045, 4, 1);

insert into project.guest values
(0, 'Morgan', 'Goodall', 'Pianist', 'Pianos', 8, 0),
(1, 'Bob', 'Mercer', 'Guitarist', 'World tours', 7, 2),
(2, 'Eva', 'Bentley', 'Singer', 'Life story', 9, 3),
(3, 'Janette', 'Melee', 'Drummer', 'Life story', 5, 6),
(4, 'Brian', 'Christian', 'Manager', 'Managing a band', 8, 9),
(5, 'Jordan', 'Foster', 'Flutist', 'Life story', 4, 10),
(6, 'Valerie', 'Hoggan', 'Singer', 'Becoming a star', 7, 13);

insert into project.performer values
(0, 'ac dc', 'USA', 'January 3 1983', true),
(1, 'Rush', 'USA', 'February 22 1985', true),
(2, 'Billy Talent', 'Canada', 'June 4 2003', true),
(3, 'Dave Brubeck', 'USA', 'April 6 2008', false),
(4, 'John Coltrane', 'USA', 'October 9 2001', false),
(5, 'Mozart', 'Austria', 'July 6 1775', false),
(6, 'Beethoven', 'Germany', 'November 9 1795', false),
(7, 'Tupac', 'USA', 'December 20 1983', false),
(8, 'Biggie smalls', 'USA', 'September 12 1981', false),
(9, 'Bob Marley', 'Jamaica', 'April 23 1986', false),
(10, 'Ken Boothe', 'Jamaica', 'March 3 1989', false );

insert into project.album values
(0, 'rock', 'Back in Black', 1987),
(1, 'rock', 'Snakes & Arrows', 2007),
(2, 'jazz', 'Dead Silence', 2012),
(3, 'jazz', 'Take Five', 1959),
(4, 'jazz', 'Cookin', 1956),
(5, 'hiphop', 'Me Against the World', 1995),
(6, 'hiphop', 'Blue Funk', 1993),
(7, 'reggae', 'Exodus', 1977),
(8, 'reggae', 'Journey', 2012 );

-- TO DO
-- insert into project.song values ;
-- insert into project.track values ;

select *
from project.guest