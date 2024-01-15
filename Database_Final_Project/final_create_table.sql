create table public.spotify_dataset(
	track_id varchar(30) not null,
	track_name varchar(1000),
	popularity int,
	available_markets varchar(1500),
	duration_ms varchar(10),
	track_number int,
	album_id varchar(50),
	album_name varchar(1000),
	album_type varchar(500),
	album_total_tracks int,
	artists_names varchar(1000),
	artists_ids varchar(1000),
	principal_artist_id varchar(50),
	principal_artist_name varchar(1000),
	artist_genres varchar(1500),
	principal_artist_followers int,
	acousticness double precision,
	danceability double precision,
	energy double precision,
	instrumentalness double precision,
	key_ int,
	liveness double precision,
	loudness double precision,
	mode_ int,
	speechiness double precision,
	tempo double precision,
	time_signature int,
	valence double precision,
	year int,
	duration_min double precision 
);

-- Artist
create table public.Artist(
	artist_id varchar(1000),
	artist_name varchar(1000),
	artist_followers int,
	primary key (artist_id)
);

insert into public.Artist(artist_id, artist_name)
select distinct unnest(string_to_array(spotify_dataset.artists_ids, ';')) AS artist_id, 
				unnest(string_to_array(spotify_dataset.artists_names, ';')) AS artist_name
from spotify_dataset;

UPDATE Artist
SET artist_followers = spotify_dataset.principal_artist_followers
FROM spotify_dataset
WHERE Artist.artist_id = spotify_dataset.principal_artist_id;

--Genre
create table public.Genre(
	artist_id varchar(1000),
	artist_genre varchar(1500),
	primary key (artist_id, artist_genre),
	foreign key (artist_id) references public.Artist(artist_id)
);

insert into public.Genere(artist_id, artist_genre)
select distinct principal_artist_id, unnest(string_to_array(spotify_dataset.artist_genres, ';')) AS artist_genre
from spotify_dataset;

--Song
create table public.Song(
	track_id varchar(30),
	track_name varchar(1000),
	popularity int,
	primary key (track_id)
);

insert into public.Song
select distinct track_id, track_name, popularity
from spotify_dataset;

--Song to Artist
create table public.Song_to_Artist(
	track_id varchar(30),
	artist_id varchar(1000),
	primary key (track_id, artist_id),
	foreign key (track_id) references Song,
	foreign key (artist_id) references Artist
);

insert into public.Song_to_Artist
select distinct track_id as track_id,
	unnest(string_to_array(spotify_dataset.artists_ids, ';')) AS artist_id
from spotify_dataset;

--Constraints
create table public.Constraints(
	track_id varchar(30),
	duration_ms varchar(10),
	year int,
	primary key (track_id),
	foreign key (track_id) references Song
);
ALTER TABLE public.Constraints
ALTER COLUMN year TYPE date
USING to_date(year::text, 'YYYY');

insert into public.Constraints
select distinct track_id, duration_ms, year
from spotify_dataset;



--Parameter
create table public.Parameter(
	track_id varchar(30),
	acousticness double precision,
	danceability double precision,
	energy double precision,
	instrumentalness double precision,
	key_ int,
	liveness double precision,
	loudness double precision,
	mode_ int,
	speechiness double precision,
	tempo double precision,
	time_signature int,
	valence double precision,
	primary key (track_id),
	foreign key (track_id) references Song
);

insert into public.Parameter
select distinct track_id, acousticness, danceability, energy, instrumentalness,
	key_, liveness, loudness, mode_, speechiness, tempo, time_signature, valence
from spotify_dataset;

--Album
create table public.Album(
	album_id varchar(50),
	album_name varchar(1000),
	album_type varchar(500),
	album_total_tracks int,
	primary key (album_id)
);

insert into public.Album
select distinct album_id, album_name, album_type, album_total_tracks
from spotify_dataset;

--Artist to Album
create table public.Artist_of_Album(
	artist_id varchar(1000),
	album_id varchar(50),
	primary key (artist_id, album_id),
	foreign key (artist_id) references Artist,
	foreign key (album_id) references Album
);

insert into public.Artist_of_Album
select distinct principal_artist_id, album_id
from spotify_dataset;

--Song to Album
create table public.Song_to_Album(
	track_id varchar(30),
	album_id varchar(50),
	track_number int,
	primary key (track_id),
	foreign key (track_id) references Song
);

insert into public.Song_to_Album
select distinct track_id, album_id, track_number
from spotify_dataset;

--User Information
create table public.User_Information(
	user_name varchar(30),
	password_ varchar(30),
	nickname  varchar(30),
	primary key (user_name)
);

--Song List
create table public.Song_List(
	user_name varchar(30),
	track_id  varchar(30),
	add_time  date,
	primary key (user_name, track_id, add_time),
	foreign key (user_name) references User_Information,
	foreign key (track_id) references Song
);

--Weekly List
create table public.Weekly_List(
	id_ varchar(30),
	track_id  varchar(30),
	primary key (id_),
	foreign key (track_id) references Song
);

--Guess Ranking List
create table public.Guess_Ranking_List(
	user_name varchar(30),
	nickname  varchar(30),
	right_number int,
	primary key (user_name),
	foreign key (user_name) references User_Information
);