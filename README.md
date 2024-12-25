# Analysis of Netflix Movies And TV Shows using SQL.
![Net](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/download.jpeg)

## Project Overview

This project demonstrates various SQL queries to analyze the Netflix dataset and extract meaningful insights. The dataset was analyzed using SQL to answer questions such as the most common ratings, top directors, release trends, and more.


##-- Create table to hold Netflix data
```sql
CREATE TABLE table_net (
    show_id VARCHAR(1000),
    show_type VARCHAR(1000),
    title VARCHAR(1000),
    director VARCHAR(1000),
    movie_cast VARCHAR(1000),
    country VARCHAR(1000),
    date_added VARCHAR(1000),
    release_year INT,
    rating VARCHAR(1000),
    duration VARCHAR(1000),
    listed_in VARCHAR(1000),
    show_description VARCHAR(1000)
);
```
![table](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/table.png)
##-- Query 1: Total number of movies and TV shows in the dataset
```sql
SELECT show_type, COUNT(*) 
FROM table_net 
GROUP BY show_type;
```
![q1](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/1.png)
##-- Query 2: Most common ratings for Netflix content
```sql
SELECT show_type, rating, COUNT(*) 
FROM table_net 
GROUP BY show_type, rating
ORDER BY COUNT(*) DESC;
```
![q2](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/2.png)
##-- Query 3: The year with the most releases
```sql
SELECT release_year, COUNT(*) AS total_releases
FROM table_net
GROUP BY release_year
ORDER BY total_releases DESC
LIMIT 1;
```
![q3](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/3.png)
##-- Query 4: Top 4 years with the most releases
```sql
SELECT release_year, COUNT(*) AS total_releases
FROM table_net
GROUP BY release_year
ORDER BY total_releases DESC
LIMIT 4;
```
![q4](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/4.png)
##-- Query 5: Movies and TV shows directed by 'Rob Minkoff'
```sqlSELECT title, director 
FROM table_net
WHERE director = 'Rob Minkoff';
```
![q5](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/5.png)
##-- Query 6: Movies and TV shows with actor 'Chris Hemsworth'
```sql
SELECT title, release_year 
FROM table_net
WHERE movie_cast LIKE '%Chris Hemsworth%';
```
![q6](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/6.png)
##-- Query 7: TV shows with more than 5 seasons
```sql
SELECT title, duration 
FROM table_net
WHERE show_type = 'TV Show' 
AND duration NOT LIKE '1%' 
AND duration NOT LIKE '2%' 
AND duration NOT LIKE '3%' 
AND duration NOT LIKE '4%' 
ORDER BY duration DESC
LIMIT 10;
```
![q7](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/7.png)
##-- Query 8: Total number of shows with more than 5 seasons
```sql
SELECT rating, COUNT(*) AS total_no_of_shows
FROM table_net
WHERE show_type = 'TV Show'
AND duration NOT LIKE '1%' 
AND duration NOT LIKE '2%' 
AND duration NOT LIKE '3%' 
AND duration NOT LIKE '4%' 
GROUP BY rating
ORDER BY total_no_of_shows DESC;
```
![q8](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/8.png)
##-- Query 9: Total number of documentaries in the dataset
```sql
SELECT COUNT(*) AS total_documentaries
FROM table_net
WHERE listed_in = 'Documentaries';
```
![q9](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/9.png)
##-- Query 10: Movies and TV shows shot in India
```sql
SELECT title 
FROM table_net 
WHERE country LIKE '%India%';
```
![q10](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/10.png)
##-- Query 11: Total number of releases shot in India
```sql
SELECT COUNT(*) 
FROM table_net 
WHERE country LIKE '%India%';
```
![q11](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/11.png)
##-- Query 12: Top 5 countries with the most releases
```sql
SELECT TRIM(UPPER(unnest(string_to_array(country, ',')))) AS new_country,
       COUNT(show_id) AS total_content
FROM table_net
GROUP BY new_country
ORDER BY total_content DESC
LIMIT 5;
```
![q12](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/12.png)
##-- Query 13: Most versatile directors (Different genres)
```sql
SELECT director, COUNT(DISTINCT genre) AS unique_genres
FROM table_net, LATERAL unnest(string_to_array(listed_in, ',')) AS genre
WHERE director IS NOT NULL
GROUP BY director
ORDER BY unique_genres DESC
LIMIT 10;
```
![q13](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/13.png)
##-- Query 14: Most versatile actors (Different genres)
```sql
SELECT movie_cast, COUNT(DISTINCT genre) AS unique_genres
FROM table_net, LATERAL unnest(string_to_array(listed_in, ',')) AS genre
WHERE movie_cast IS NOT NULL
GROUP BY movie_cast
ORDER BY unique_genres DESC
LIMIT 10;
```
![q14](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/14.png)
##-- Query 15: Most common genres for content released in a specific year (e.g., 2018)
```sql
SELECT genre, COUNT(*) AS genre_count
FROM table_net, LATERAL unnest(string_to_array(listed_in, ',')) AS genre
WHERE release_year = 2018
GROUP BY genre
ORDER BY genre_count DESC
LIMIT 10;
```
![q15](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/15.png)
##-- Query 16: Top 10 longest movies in the dataset
```sql
SELECT title, duration
FROM table_net
WHERE show_type = 'Movie' AND duration IS NOT NULL
ORDER BY CAST(SUBSTRING(duration FROM '^\d+') AS INTEGER) DESC
LIMIT 10;
```
![q16](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/16.png)
##-- Query 17: Average duration of movies in different genres
```sql
SELECT genre,
       AVG(CAST(SUBSTRING(duration FROM '^\d+') AS INTEGER)) AS avg_duration
FROM table_net,
     LATERAL unnest(string_to_array(listed_in, ',')) AS genre
WHERE show_type = 'Movie' AND duration IS NOT NULL
GROUP BY genre
ORDER BY avg_duration DESC
limit 10;
```
![q17](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/Screenshot%202024-12-25%20143443.png)
##-- Query 18: Percentage of movies and TV shows with 'R' rating
```sql
SELECT show_type, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM table_net WHERE show_type = table_net.show_type) AS percentage_R_rating
FROM table_net
WHERE rating LIKE 'R'
GROUP BY show_type;
```
![q18](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/18.png)
##-- Query 19: Years with the most 'R' rated TV shows and movies
```sql
SELECT release_year, COUNT(*) AS total_R_rated_shows
FROM table_net
WHERE rating LIKE 'R'
GROUP BY release_year
ORDER BY total_R_rated_shows DESC
LIMIT 10;
```
![q19](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/19.png)
##-- Query 20: Years with the most 'PG-13' rated TV shows and movies
```sql
SELECT release_year, COUNT(*) AS total_PG_13_rated_shows
FROM table_net
WHERE rating LIKE 'PG-13'
GROUP BY release_year
ORDER BY total_PG_13_rated_shows DESC
LIMIT 10;
```
![q20](https://github.com/VBBBBBB/Netflix_SQL_Annalysis./blob/main/20.png)
