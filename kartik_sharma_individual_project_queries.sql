--CREATION OF TABLES
--1.DIRECTORS
CREATE TABLE Directors (
    director_id SERIAL PRIMARY KEY,
    director_name VARCHAR(255) UNIQUE
);

--2.RATINGS
CREATE TABLE Ratings (
    show_id VARCHAR(10) PRIMARY KEY,
    rating VARCHAR(10),
    duration VARCHAR(50),
    listed_in VARCHAR(255), 
    description TEXT,
    FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

--3.SHOW_CAST
CREATE TABLE Show_Cast (
    cast_id SERIAL PRIMARY KEY,
    show_id VARCHAR(10),
    actor_name VARCHAR(255),
    FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

--4.SHOWS
CREATE TABLE Shows (
    show_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,  
    release_year INT NOT NULL,
    country VARCHAR(100),
    date_added DATE
)

--applying 10 set of functions and concepts
-- 1) FILTERING WITH WHERE CLAUSE 
SELECT title, release_year
FROM Shows
WHERE type = 'Movie' AND release_year > 2015;

-- 2) aggregate function COUNT
SELECT COUNT(*)
FROM Shows
WHERE type = 'TV Show';

--3) filtering with like
SELECT title
FROM Shows
WHERE title LIKE '%Love%';

--4)Using GROUP BY with Aggregate Functions (COUNT, MAX)
SELECT release_year, COUNT(*) AS total_shows
FROM Shows
GROUP BY release_year
ORDER BY total_shows DESC
LIMIT 1;

--5) using having
SELECT country, COUNT(*) AS total_shows
FROM Shows
GROUP BY country
HAVING COUNT(*) > 10;

--6) joining two tables
SELECT S.title, R.rating, R.duration
FROM Shows S
JOIN Ratings R ON S.show_id = R.show_id;

--7) common table expression CTE
WITH show_counts AS (
    SELECT type, COUNT(*) AS total_shows
    FROM Shows
    GROUP BY type
)
SELECT *
FROM show_counts
WHERE total_shows > 50;

--8) USNING DISTINCT
SELECT DISTINCT rating
FROM Ratings;

--9) USING ORDER BY
SELECT title, release_year
FROM Shows
WHERE type = 'TV Show'
ORDER BY release_year DESC;

--10) SUBQUERY
SELECT S.title, R.duration
FROM Shows S
JOIN Ratings R ON S.show_id = R.show_id
WHERE R.duration LIKE '%Seasons%';

-- 1) VIEWS_movie_summary
CREATE VIEW view_movie_summary AS
SELECT S.title, 
       S.release_year, 
       R.rating, 
       R.listed_in AS genre
FROM Shows S
LEFT JOIN Ratings R 
    ON S.show_id = R.show_id
WHERE S.type = 'Movie';

--2) view-tvshow_ratings
CREATE VIEW view_tvshow_ratings AS
SELECT S.title, R.rating, R.duration, R.listed_in AS category
FROM Shows S
JOIN Ratings R ON S.show_id = R.show_id
WHERE S.type = 'TV Show';



















