-- Извлекаем количество исполнителей в каждом жанре.
select name, count(first_name) q from genres g 
join genresperformers gp on g.genre_id = gp.genre_id 
join performers p on gp.performer_id = p.performer_id 
group by name
order by q desc;

-- Извлекаем количество треков, вошедших в альбомы 2019–2020 годов.
-- Но сначала переименуем параметры-навзвания треков и альбомов "title" в соответствующих отношениях, чтобы не путаться где какой "title"
alter table albums 
rename column title to album_title;

alter table tracks 
rename column title to track_title;

select album_title, count(track_title) q from albums a 
join tracks t on a.album_id = t.album_id
where "year" >= 2019 and "year" <= 2020
group by album_title
order by q;  

-- Извлекаем среднюю продолжительность треков по каждому альбому.
select album_title, avg(duration)  from albums a 
join tracks t on a.album_id = t.album_id
group by album_title;

-- Извлекаем всех исполнителей, которые не выпустили альбомы в 2020 году.
select first_name, last_name, band_name  from performers p 
join albumsperformers ap on p.performer_id = ap.performer_id
join albums a on ap.album_id = a.album_id
where year != 2020;

-- Извлекасем названия сборников, в которых присутствует  исполнитель Ethan	Lockwood.
-- Но сначала переименуем параметр "title" на "compilation_title" в отношении "compilations"
alter table compilations 
rename column title to compilation_title;

select compilation_title from compilations c 
join compilationstracks ct on c.compilation_id = ct.compilation_id 
join tracks t on ct.track_id = t.track_id 
join albums a on t.album_id = a.album_id 
join albumsperformers ap on a.album_id = ap.album_id 
join performers p on ap.performer_id = p.performer_id
where first_name = 'Ethan' and last_name = 'Lockwood'
group by compilation_title;

-- Извлексем названия альбомов, в которых присутствуют исполнители более чем одного жанра.
-- Но сначала по доброй традиции переименуем параметр "name" на "genre_name" в отношении "genres". И добавим один трек так, чтобы условие задания выполнялось.
alter table genres 
rename column name to genre_name;

insert into genresperformers(genre_id, performer_id)
values (2, 1);

select album_title from albums a 
join albumsperformers ap on a.album_id = ap.album_id 
join performers p on ap.performer_id = p.performer_id 
join genresperformers gp on p.performer_id = gp.performer_id 
join genres g on gp.genre_id = g.genre_id
group by album_title
having count(genre_name) > 1;

-- Извлекаем наименования треков, которые не входят в сборники.
-- Но сначала добавим трек, не входящий ни в один сборник.
insert into tracks(track_title, duration, album_id)
values ('Hail Mary Hail', 254, '4');

select track_title from tracks t 
left join compilationstracks ct on t.track_id = ct.track_id 
left join compilations c on ct.compilation_id = c.compilation_id
where compilation_title is null;

-- Извлекаем исполнителя или -лей, написавшие самые короткие по продолжительности треки.
-- Но сначала сделаем еще один трек с минимальной длительностью.
update tracks
set duration = 85 
where track_title = 'Quantum Breeze';

select last_name, first_name, band_name, duration from performers p 
join albumsperformers ap on p.performer_id = ap.performer_id 
join albums a on ap.album_id  = a.album_id 
join tracks t on a.album_id = t.album_id
where t.duration = (select min(duration) 
from (select duration from performers p 
join albumsperformers ap on p.performer_id = ap.performer_id 
join albums a on ap.album_id  = a.album_id 
join tracks t on a.album_id = t.album_id) foo);

-- Извлекаем названия альбомов, содержащих наименьшее количество треков.
select album_title from albums a 
join tracks t on a.album_id = t.album_id
group by album_title
having count(t.track_title) = 
(select min(cnt) from 
(select album_title, count(t.track_title) cnt from albums a 
join tracks t on a.album_id = t.album_id
group by album_title) as foo);