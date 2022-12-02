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
SELECT d.first_name, d.last_name, m.name, m.year
FROM directors as d
JOIN movies_directors as md ON d.id = md.movie_id
JOIN movies as m ON md.movie_id = m.id
JOIN movies_genres as mg ON m.id = mg.movie_id
WHERE mg.genre = 'Film-Noir' AND m.year % 4 = 0
ORDER BY m.name;

//9
-- SELECT a.first_name, a.last_name, m.name
-- FROM directors as d
-- JOIN movies_directors as md ON d.id = md.director_id
-- JOIN movies as m ON md.movie_id = m.id
-- JOIN movies_genres as mg ON m.id = mg.movie_id
-- JOIN roles as r ON mg.movie_id = r.movie_id
-- JOIN actors as a ON r.actor_id = a.id
-- WHERE d.first_name = 'Kevin' and d.last_name = 'Bacon' and mg.genre = 'Drama' and (a.first_name || a.last_name != 'KevinBacon')
-- ORDER BY m.name;

SELECT m.id
FROM actors as a
JOIN roles as r ON a.id = r.actor_id
JOIN movies as m ON r.movie_id = m.id
WHERE a.first_name = 'Kevin' and a.last_name = 'Bacon';


SELECT DISTINCT a.first_name, a.last_name, m.name
FROM actors as a
JOIN roles as r ON a.id = r.actor_id
JOIN movies as m ON r.movie_id = m.id
JOIN movies_genres as mg ON m.id = mg.movie_id
WHERE mg.genre = 'Drama' AND m.id IN (
	SELECT m.id
	FROM actors as a
	JOIN roles as r ON a.id = r.actor_id
	JOIN movies as m ON r.movie_id = m.id
	WHERE a.first_name = 'Kevin' and a.last_name = 'Bacon'
) AND (a.first_name || a.last_name != 'KevinBacon')
ORDER BY a.last_name DESC;

//10
SELECT r.actor_id
FROM roles as r 
JOIN movies as m ON r.movie_id = m.id
WHERE m.year < 1900
ORDER BY m.year ASC;

SELECT r.actor_id, m.name, m.year
FROM roles as r 
JOIN movies as m ON r.movie_id = m.id
WHERE m.year > 2000
ORDER BY m.year ASC;

SELECT *
FROM actors
WHERE id IN (
	SELECT r.actor_id
	FROM roles as r 
	JOIN movies as m ON r.movie_id = m.id
	WHERE m.year < 1900
) AND id IN (
	SELECT r.actor_id
	FROM roles as r 
	JOIN movies as m ON r.movie_id = m.id
	WHERE m.year > 2000
);


//11
SELECT a.first_name AS NOMBRE, a.last_name as APELLIDO, m.name AS PELICULA, COUNT(DISTINCT role) as Total
FROM actors AS a
JOIN roles AS r ON a.id = r.actor_id
JOIN movies AS m ON m.id = r.movie_id
WHERE m.year > 1990
GROUP BY a.id, m.id
HAVING COUNT(DISTINCT role) > 5;

//12
SELECT r.movie_id
FROM roles as r
JOIN actors as a ON a.id = r.actor_id
WHERE a.gender = 'M'
LIMIT 100;


SELECT year, COUNT(DISTINCT id)
FROM movies as m
WHERE id NOT IN (
	SELECT r.movie_id
	FROM roles as r
	JOIN actors as a ON a.id = r.actor_id
	WHERE a.gender = 'M'
)
GROUP BY year
ORDER BY year DESC;

