
create table table_net
(
show_id varchar(1000) ,
 show_type varchar(1000),
 title varchar(1000), 
 director varchar(1000),
 movie_cast varchar(1000), 
 country varchar(1000), 
 date_added varchar(1000) , 
 release_year int, 
 rating varchar(1000), 
 duration varchar(1000), 
 listed_in varchar(1000), 
 show_description varchar(1000));
 select * from table_net;


 -- 1)Total No of movies and TV shows are in the dataset?

 select show_type,  count(*) from table_net
 group by show_type

 
 -- 2)The most common rating for Netflix content, and 
 --   how does it differ between movies and TV shows?
 select show_type, rating,  count(*)
 from table_net 
 group by show_type,rating
 order by count desc;


 -- 3)The year with most releases?

 SELECT release_year, COUNT(*) AS total_releases
FROM table_net
GROUP BY release_year
ORDER BY total_releases DESC
LIMIT 1;


-- 4)Top 4 Years with most releases.

 SELECT release_year, COUNT(*) AS total_releases
FROM table_net
GROUP BY release_year
ORDER BY total_releases DESC
LIMIT 4;


-- 5)All the movies and TV shows directed by A particular director like 'Rob Minkoff'

select title , director from table_net
where director = 'Rob Minkoff' 


--6)Movies and TV shows with a particular actor/actress like 'Chris Hemsworth'

SELECT title, release_year 
FROM table_net
WHERE movie_cast LIKE '%Chris Hemsworth%';



--7)List all TV shows with more than 5 seasons.

select title, duration from table_net
where show_type = 'TV Show'
and (duration not like '1%' 
and duration not like '2%' 
and duration not like '3%' 
and duration not like '4%' )
order by duration desc
limit 10;  


--8)total No of shows with more than 5 seasons
select rating, count(*) as total_no_of_shows
from table_net
where show_type = 'TV Show'
and (duration not like '1%' and duration not like '2%' and duration not like '3%' and duration not like '4%' )  
group by rating
order by total_no_of_shows desc;



--9)Total movies in the dataset are categorized as documentaries.
SELECT COUNT(*) AS total_documentaries
FROM table_net
WHERE listed_in = 'Documentaries';


--10)Releases Shot in countries including India.

SELECT title from table_net 
where country like '%India%'





--11)Total No of releases shot in countries including India.

SELECT COUNT(*) 
FROM table_net 
WHERE country LIKE '%India%';


--12)Top 5 countries with most releases.

SELECT TRIM(UPPER(unnest(string_to_array(country, ',')))) AS new_country,
       COUNT(show_id) AS total_content
FROM table_net
GROUP BY new_country
ORDER BY total_content DESC
LIMIT 10;



--13)Most versatile directors(Different type of shows like action,suspense,etc).

SELECT director,
       COUNT(DISTINCT genre) AS unique_genres
FROM table_net,
     LATERAL unnest(string_to_array(listed_in, ',')) AS genre
	 WHERE director IS NOT NULL
GROUP BY director
ORDER BY unique_genres DESC
limit 10;

--14)Most versatile Actors (Different type of shows like action,suspense,etc).
SELECT movie_cast,
       COUNT(DISTINCT genre) AS unique_genres
FROM table_net,
     LATERAL unnest(string_to_array(listed_in, ',')) AS genre
	 WHERE movie_cast IS NOT NULL
GROUP BY movie_cast
ORDER BY unique_genres DESC
limit 10;


--15)Most common genres for content released in a year (like i take 2018).

SELECT genre,
       COUNT(*) AS genre_count
FROM table_net,
     LATERAL unnest(string_to_array(listed_in, ',')) AS genre
WHERE release_year = 2018
GROUP BY genre
ORDER BY genre_count DESC
limit 10;

--16)Top 10 longest movie in the dataset
SELECT title, duration
FROM table_net
WHERE show_type = 'Movie' and duration is not null
ORDER BY CAST(SUBSTRING(duration FROM '^\d+') AS INTEGER) DESC
LIMIT 10;




--17)Average Duration of movies in different Genres

SELECT genre,
       AVG(CAST(SUBSTRING(duration FROM '^\d+') AS INTEGER)) AS avg_duration
FROM table_net,
     LATERAL unnest(string_to_array(listed_in, ',')) AS genre
WHERE show_type = 'Movie' AND duration IS NOT NULL
GROUP BY genre
ORDER BY avg_duration DESC
limit 10;

--18)The percentage of movies and TV shows with 'R' rating.
SELECT show_type, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) 
	   FROM table_net WHERE show_type = table_net.show_type) AS percentage_R_rating
FROM table_net
WHERE rating like 'R'
GROUP BY show_type;



--19)Years with most no of R rated TV shows and movies.

SELECT release_year, 
       COUNT(*) AS total_R_rated_shows
FROM table_net
WHERE rating like 'R'
GROUP BY release_year
ORDER BY total_R_rated_shows DESC
limit 10;


--20)Years with most no of PG-13 rated TV shows and movies.
SELECT release_year, 
       COUNT(*) AS total_PG_13_rated_shows
FROM table_net
WHERE rating like 'PG-13'
GROUP BY release_year
ORDER BY total_PG_13_rated_shows DESC
limit 10;

