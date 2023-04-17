-- Добавляем в отношение "albums" параметр "year", так как в прошлом задании такого параметра не создавали
alter table albums 
add column year int;

-- Наполняем значениями только что созданный параметр
update albums 
set year = 2018
where album_id = 1 or album_id = 2;

update albums 
set year = 2019
where album_id = 3 or album_id = 4;

update albums 
set year = 2020
where album_id = 5 or album_id = 6;

update albums 
set year = 2021
where album_id = 7 or album_id = 8;

-- Меняем название параметра "name" на более подходящее "title" в отношении albums
ALTER TABLE albums
RENAME COLUMN name TO title;

-- Выбираем название и год выхода альбомов, вышедших в 2018 году.
select title, year from albums
where year = 2018;

-- Выбираем название и продолжительность самого длительного трека.
select title, duration from tracks
order by duration desc
limit 1;

-- Выбираем названия треков, продолжительность которых не менее 3,5 минут.
select title from tracks
where duration >= 3.5 * 60;

-- Выбираем названия сборников, вышедших в период с 2018 по 2020 год включительно.
-- Но сначала меняем название параметра "name" на более подходящее "title" в отношении compilations
alter table compilations 
rename column name to title;

select title from compilations
where year between 2018 and 2020;

-- Выбираем исполнителей, чьё имя состоит из одного слова.
-- Но сначала изменим имя одного исполнителя на подходящее по условию.
update performers
set first_name = concat(first_name, ' Jr.') 
where first_name = 'Liam';

select first_name, last_name from performers
where first_name not like '% %';

-- Выбираем названия треков, которые содержат слова «мой» или «my» вне зависимости от регистра или положения в предложении. 
select title from tracks
where title ilike 'my %' or title ilike '% my %' or title ilike '% my' 
or title ilike 'мой %' or title ilike '% мой %' or title ilike '% мой';

