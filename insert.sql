-- Наполняем жанры
insert into genres(genre_name)
values
('Pop'),
('Rock'),
('Jazz'),
('Instrumental'),
('Hip-hop');

-- Наполняем исполнителей
insert into performers(first_name, last_name, band_name)
values 
('Liam', 'Stratus', 'The Quantum Harmonies'),
('Zoe', 'Blackstone', 'Celestial Frequency'),
('Ethan', 'Lockwood', 'Timeless Echoes'),
('Elara', 'Blackstone', 'Wayfinder'),
('Nolan', 'Silverleaf', 'Midnight Dreamscapes'),
('Aurora', 'Skysong', 'Starlit Constellations'),
('Jasper', 'Thornwood', 'Sonic Landscapes'),
('Sienna', 'Sunfire', 'The Aurora Symphonies');

-- Наполняем альбомы
insert into albums(album_title, cover_art, album_year)
values 
('Quantum Melodies', '/home/user/music/covers/quantum_melodies.jpg', 2018),
('Celestial Awakening', '/home/user/music/covers/celestial_awakening.jpg', 2018),
('Time Traveler''s Serenade', '/home/user/music/covers/time_travelers_serenade.jpg', 2019),
('Ethereal Journey', '/home/user/music/covers/ethereal_journey.jpg', 2019),
('Dreamwalker''s Lullaby', '	/home/user/music/covers/dreamwalkers_lullaby.jpg', 2020),
('Constellation Stories', '/home/user/music/covers/constellation_stories.jpg', 2020),
('Landscapes of Sound', '/home/user/music/covers/landscapes_of_sound.jpg', 2021),
('Aurora''s Symphony', '	/home/user/music/covers/auroras_symphony.jpg', 2021);

-- Наполняем треки
insert into tracks(track_title, duration, album_id)
values
('Quantum Breeze', 85, '1'),
('Harmonic Nebula', 182, '1'),
('Frequency of My Stars', 194, '2'),
('Cosmic Whispers', 217, '2'),
('Timeless Waltz', 162, '3'),
('Echoes of Eternity', 351, '3'),
('Pulse of the Universe', 85, '4'),
('Ethereal Awakening', 100, '4'),
('Midnight Drifter', 173, '5'),
('My Dreamweaver''s Trail', 136, '5'),
('Starlit Memoirs', 148, '6'),
('Constellation Lullaby', 192, '6'),
('Sonic Horizons', 144, '7'),
('Rhythms of the Forest', 167, '7'),
('Symphony of Light', 124, '8'),
('Aurora''s Embrace', 166, '8')
('Hail Mary Hail', 254, '4');

-- Наполняем сборники
insert into compilations(compilation_title, year, cover_art)
values
('Space-Time Chronicles', '2023', '/home/user/music/covers/space_time_chronicles.jpg'),
('Celestial Soundscapes', '2023', '/home/user/music/covers/celestial_soundscapes.jpg'),
('Timeless Tunes', '2022', '/home/user/music/covers/timeless_tunes.jpg'),
('Ethereal Vibrations', '2022', '/home/user/music/covers/ethereal_vibrations.jpg'),
('Midnight Meditationss', '2021', '/home/user/music/covers/midnight_meditations.jpg'),
('Starry Night Serenades', '2021', '/home/user/music/covers/starry_night_serenades.jp'),
('Sonic Explorationss', '2020', '/home/user/music/covers/sonic_explorations.jpg'),
('Aurora''s Enchantment', '2020', '/home/user/music/covers/auroras_enchantment.jpg');

-- Наполняем таблицу сборники-треки
insert into compilationstracks (compilation_id, track_id)
values
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 11),
(6, 12),
(7, 13),
(7, 14),
(8, 15),
(8, 16);

-- Наполняем таблицу альбомы-исполнители
insert into albumsperformers(performer_id, album_id)
values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

-- Наполняем таблицу жанры-исполнители
insert into genresperformers(genre_id, performer_id)
values
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(5, 8),
(2, 1);