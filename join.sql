-- Извлекаем количество исполнителей в каждом жанре.
select name, count(first_name) q from genres g 
join genresperformers gp on g.genre_id = gp.genre_id 
join performers p on gp.performer_id = p.performer_id 
group by name
order by q desc;

-- Извлекаем количество треков, вошедших в альбомы 2019–2020 годов. 
-- По поводу вашего комментария: что именно требуется вывести абсолютно не понятно из формулировки задания, стоит подуать над переформулированием.
/* Старое решение
select album_title, count(track_title) q from albums a 
join tracks t on a.album_id = t.album_id
where "album_year" >= 2019 and "album_year" <= 2020
group by album_title
order by q;
*/

select count(track_title) q from albums a 
join tracks t on a.album_id = t.album_id
where album_year between 2019 and 2020;  

-- Извлекаем среднюю продолжительность треков по каждому альбому.
select album_title, avg(duration)  from albums a 
join tracks t on a.album_id = t.album_id
group by album_title;

-- Извлекаем всех исполнителей, которые не выпустили альбомы в 2020 году.
/* Старое решение
select first_name, last_name, band_name from performers p 
join albumsperformers ap on p.performer_id = ap.performer_id
join albums a on ap.album_id = a.album_id
where album_year != 2020;
*/

select first_name, last_name, band_name from performers p 
where p.performer_id not in 
	(select p2.performer_id from performers p2 
	join albumsperformers ap on p2.performer_id = ap.performer_id 
	join albums a on ap.album_id  = a.album_id
	where album_year = 2020);

-- Извлекасем названия сборников, в которых присутствует  исполнитель Ethan	Lockwood.
/* Старое решение
select compilation_title from compilations c 
join compilationstracks ct on c.compilation_id = ct.compilation_id 
join tracks t on ct.track_id = t.track_id 
join albums a on t.album_id = a.album_id 
join albumsperformers ap on a.album_id = ap.album_id 
join performers p on ap.performer_id = p.performer_id
where first_name = 'Ethan' and last_name = 'Lockwood'
group by compilation_title;
*/

-- На мой взгляд, группировку луше было бы оставить (дело не в использовании аггрегирующих функций), так как исполнитель имеет 2 трека в сборнике "Timeless Tunes" и поэтому выводится дважды - не комильфо
select compilation_title from compilations c 
join compilationstracks ct on c.compilation_id = ct.compilation_id 
join tracks t on ct.track_id = t.track_id 
join albums a on t.album_id = a.album_id 
join albumsperformers ap on a.album_id = ap.album_id 
join performers p on ap.performer_id = p.performer_id
where first_name = 'Ethan' and last_name = 'Lockwood';

-- Извлекаем названия альбомов, в которых присутствуют исполнители более чем одного жанра.
/* Старое решение
select album_title from albums a 
join albumsperformers ap on a.album_id = ap.album_id 
join performers p on ap.performer_id = p.performer_id 
join genresperformers gp on p.performer_id = gp.performer_id 
join genres g on gp.genre_id = g.genre_id
group by album_title
having count(genre_name) > 1;
*/

select distinct album_title from albums a 
join albumsperformers ap on a.album_id = ap.album_id 
join performers p on ap.performer_id = p.performer_id 
join genresperformers gp on p.performer_id = gp.performer_id 
join genres g on gp.genre_id = g.genre_id
group by a.album_id, gp.performer_id  
having count(gp.genre_id) > 1;

-- Извлекаем наименования треков, которые не входят в сборники.
select track_title from tracks t 
left join compilationstracks ct on t.track_id = ct.track_id 
left join compilations c on ct.compilation_id = c.compilation_id
where compilation_title is null;

-- Извлекаем исполнителя или -лей, написавшие самые короткие по продолжительности треки.
/* Старое решение
select last_name, first_name, band_name, duration from performers p 
join albumsperformers ap on p.performer_id = ap.performer_id 
join albums a on ap.album_id  = a.album_id 
join tracks t on a.album_id = t.album_id
where t.duration = (select min(duration) 
from (select duration from performers p 
join albumsperformers ap on p.performer_id = ap.performer_id 
join albums a on ap.album_id  = a.album_id 
join tracks t on a.album_id = t.album_id) foo);
*/

select last_name, first_name, band_name, duration from performers p 
join albumsperformers ap on p.performer_id = ap.performer_id 
join albums a on ap.album_id  = a.album_id 
join tracks t on a.album_id = t.album_id
where t.duration = (
	select min(duration) from tracks t2);

-- Извлекаем названия альбомов, содержащих наименьшее количество треков.
/* Старое решение
select album_title from albums a 
join tracks t on a.album_id = t.album_id
group by album_title
having count(t.track_title) = 
(select min(cnt) from 
(select album_title, count(t.track_title) cnt from albums a 
join tracks t on a.album_id = t.album_id
group by album_title) as foo);
*/

select album_title from albums a 
join tracks t on a.album_id = t.album_id
group by a.album_title 
having count(t.track_title) = 
(select count(track_id) from tracks
group by album_id
order by 1
limit 1);