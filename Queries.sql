-- Select data from hostshow:
select *
from project.hostshow


-- Select data from song:
select *
from project.song

-- Select data from guest:
select *
from project.guest

set search_path ='project';

--------- SONGS, ARTISTS,BANDS, AND ALBUMS -----------
--The "suggested" queries did not seem like "typical" queries to me so 
--most of the queries I made up because they seemed more typical to me
--who is a frequent user of radio websites

-- all the information on a performer
select *
from project.performer;

-- all the information on an album
select *
from project.album;

-- all information on a song
select *
from project.song;

-- the number of songs on an album
select label, count(s.song_num)
from project.album a, project.song s
where a.album_num = s.album_num
group by label;

--number of songs by an artist
select pname, count(s.song_num)
from project.performer p, project.song s
where p.performer_num = s.performer_num
group by pname;

--albums by an artist
select pname, a.label
from project.song s, project.album a, project.performer p
where s.album_num = a.album_num and s.performer_num = p.performer_num
group by a.label, pname;

--canadian songs
select s.title, a.label
from project.song s, project.album a
where s.album_num = a.album_num and cancon =true;

--canadian artist
select p.pname
from project.performer p, project.album a, project.song s
where s.cancon = true and s.album_num = a.album_num and s.performer_num = p.performer_num
group by p.pname;

--length of a song
select s.title, t.end_time
from project.song s, project.track t
where s.song_num = t.song_num;

--which host played what song
select rh.first_name, rh.last_name, s.title
from project.radiohost rh, project.song s, project.track t, project.timeslot ts, project.hostshow hs
where rh.emp_num = hs.emp_num and hs.show_num = ts.show_num and ts.sheet_num = t.sheet_num and s.song_num = t.song_num;

--what songs played on which show
select sh.show_name, s.title
from project.song s, project.track t, project.playsheet p, project.show sh, project.timeslot ts
where s.song_num = t.song_num and t.sheet_num = p.sheet_num and p.sheet_num = ts.sheet_num and ts.show_num = sh.show_num;


-------- GUESTS AND HOSTS --------
--find which hosts had which guests and in the order of guest rating
select g.first_name, g.last_name, g.rating, h.first_name, h.last_name, t.start_time
from project.guest g, project.timeslot t, project.radiohost h, project.hostshow hs
where g.slot_num = t.slot_num and t.show_num = hs.show_num and h.emp_num = hs.emp_num
order by rating desc;

--guests rating
select first_name, last_name, rating
from project.guest
order by rating desc;

--what host, hosts what show
select r.first_name, r.last_name, s.show_name
from project.radiohost r, project.show s, project.hostshow h
where h.show_num = s.show_num and h.emp_num = r.emp_num;

-- guest information
select *
from project.guest;

-- host information
select *
from project.radiohost;

--topic of a certain guest
select first_name, last_name, topic
from project.guest;

--radio hosts birthday
select first_name, last_name, birthday
from project.radiohost;

--radio host rating
select first_name,last_name, rating
from project.radiohost
order by rating desc;

--hosts stage name
select first_name, last_name, stage_name
from project.radiohost;

--host contract
select first_name, last_name, contract_start
from project.radiohost;

--guest description
select first_name, last_name, descr
from project.guest;
