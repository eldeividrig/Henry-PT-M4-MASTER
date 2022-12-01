CREATE TABLE movies (
	id INTEGER PRIMARY KEY,
	name TEXT DEFAULT NULL,
	year INTEGER DEFAULT NULL,
	rank REAL DEFAULT NULL
);

CREATE TABLE actors (
	id INTEGER PRIMARY KEY,
	first_name TEXT DEFAULT NULL,
    last_name TEXT DEFAULT NULL,
    gender TEXT DEFAULT NULL
);

CREATE TABLE roles (
	actor_id INTEGER,
	movie_id INTEGER,
	role_name TEXT DEFAULT NULL
);

//1
SELECT * FROM movies WHERE year = 1986;

//2
SELECT COUNT(*) FROM movies WHERE year = 1982;

//3
SELECT * 
FROM actors
WHERE last_name
LIKE '%stack%';

//4
SELECT first_name, last_name,  COUNT(*) as total
FROM actors
GROUP BY LOWER(first_name), LOWER(last_name)
ORDER BY total DESC
LIMIT 10;

//5
SELECT a.first_name, a.last_name, COUNT(*) AS total
FROM roles AS r
JOIN actors AS a
ON a.id = r.actor_id
GROUP BY r.actor_id
ORDER BY total DESC
LIMIT 100;

//6
SELECT genre, COUNT(*) AS total
FROM movies_genres
GROUP BY genre
ORDER BY total ASC;

//7
SELECT a.first_name, a.last_name
FROM actors as a
JOIN roles as r ON a.id = r.actor_id
JOIN movies as m ON m.id = r.movie_id
WHERE m.name = "Braveheart" and m.year = 1995
ORDER BY a.last_name;

//8
