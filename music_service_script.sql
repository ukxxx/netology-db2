-- Создаем таблицу жанров
create table if not exists Genres (
genre_id serial primary key,
name varchar(40) unique not null
);

-- Создаем таблицу исполнителей
create table if not exists Performers (
performer_id serial primary key,
first_name varchar(60) not null,
last_name varchar(60) not null,
band_name varchar(60)
);

-- Создаем таблицу альбомов
create table if not exists Albums (
album_id serial primary key,
name varchar(60) not null,
cover_art varchar(255) not null
);

-- Создаем таблицу треков
create table if not exists Tracks (
track_id serial primary key,
title varchar(60) not null,
duration integer,
album_id integer not null references Albums(album_id)
);


-- Создаем таблицу сборников
create table if not exists Compilations (
compilation_id serial primary key,
name varchar(60) not null,
year integer not null check(year >= 1900),
cover_art varchar(255) not null
);

-- Создаем таблицу жанры-исполнители
create table if not exists GenresPerformers (
genre_id integer references Genres(genre_id),
performer_id integer references Performers(performer_id),
constraint pk_gp primary key (genre_id, performer_id)
);

-- Создаем таблицу альбомы-исполнители
create table if not exists AlbumsPerformers (
performer_id integer references Performers(performer_id),
album_id integer references Albums(album_id),
constraint pk_ap primary key (performer_id, album_id)
);

-- Создаем таблицу сборники-треки
create table if not exists CompilationsTracks (
track_id integer references Tracks(track_id),
compilation_id integer references Compilations(compilation_id),
constraint pk_ct primary key (track_id, compilation_id)
);
