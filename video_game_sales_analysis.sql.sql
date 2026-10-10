create database video_game;
use video_game;
select * from video_game_genres;
select * from video_game_platforms;
select * from video_game_publishers;
select * from video_game_sales;

#Business	Task 1:	Retrieve	the	Total	Sales	for	Each	Genre,	Sorted	in	Descending	Order.

select genre, round(sum(na_sales+eu_sales+jp_sales+other_sales),2) as total_sales 
from video_game_sales as s
inner join video_game_genres as g
on s.Genre_ID=g.Genre_ID
group by genre
order by total_sales desc;

#Business	Task	2:	List	Genres	with	Above-Average	Total	Sales.

SELECT
    g.genre,
    ROUND(SUM(s.na_sales + s.eu_sales + s.jp_sales + s.other_sales),2) AS total_sales
FROM video_game_sales AS s
INNER JOIN video_game_genres AS g
    ON s.Genre_ID = g.Genre_ID
GROUP BY g.genre
HAVING SUM(s.na_sales + s.eu_sales + s.jp_sales + s.other_sales) > (SELECT AVG(genre_sales)
    FROM (SELECT SUM(na_sales + eu_sales + jp_sales + other_sales) AS genre_sales
        FROM video_game_sales AS s
        INNER JOIN video_game_genres AS g
            ON s.Genre_ID = g.Genre_ID
        GROUP BY genre) AS genre_totals);
        
#Business	Task	3:	Calculate	the	Percentage	Contribution	of	Each	Genre	to	Total	Global	Sales.

select genre, round(sum(na_sales+eu_sales+jp_sales+other_sales),2) as total_sales,
concat(round(sum(na_sales+eu_sales+jp_sales+other_sales)*100/(select (sum(na_sales+eu_sales+jp_sales+other_sales))from video_game_sales),2),'%') as pct_contribution
from video_game_sales as s
inner join video_game_genres as g
on s.Genre_ID=g.Genre_ID
group by genre;

#Business	Task	4:	Rank	Genres	by	Total	Sales	(Highest	First).

select genre, 
round(sum(na_sales+eu_sales+jp_sales+other_sales),2) as total_sales,
rank() over(order by sum(na_sales+eu_sales+jp_sales+other_sales) desc) as sales_rank
from video_game_sales as s
inner join video_game_genres as g
on s.Genre_ID=g.Genre_ID
group by genre
order by total_sales desc;

#Business	Task	5:	Calculate	the	Average	Sales	per	Game	for	Each	Genre	and	Rank	Accordingly

select 
genre, 
round(sum(na_sales+eu_sales+jp_sales+other_sales)/count(game_name),2) as Avg_Sales_Per_Game,
rank() over(order by sum(na_sales+eu_sales+jp_sales+other_sales)/count(game_name)  desc) as efficiency_rank
from video_game_sales as s
inner join video_game_genres as g
on s.Genre_ID=g.Genre_ID
group by genre;

#Business	Task	6:	Find	the	Year-over-Year	Change	in	Genre	Sales.

WITH yearly_sales AS 
   (SELECT g.genre,
        s.publish_year,
        SUM(s.na_sales + s.eu_sales + s.jp_sales + s.other_sales) AS total_sales
    FROM video_game_sales AS s
    INNER JOIN video_game_genres AS g
        ON s.Genre_ID = g.Genre_ID
    GROUP BY g.genre, s.publish_year),

sales_with_previous AS 
(SELECT genre, publish_year,total_sales,
        LAG(total_sales) OVER (PARTITION BY genre ORDER BY publish_year) AS previous_year_sales
    FROM yearly_sales)

SELECT
    genre,
    publish_year,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(previous_year_sales, 2) AS previous_year_sales,
    ROUND(
        (total_sales - previous_year_sales)
        * 100 / previous_year_sales,
        2
    ) AS yoy_change_pct
FROM sales_with_previous
ORDER BY genre, publish_year;

#Business	Task	7:	Find	the	Top	3	Genres	for	Each	Decade	Based	on	Total	Sales.

WITH genre_sales AS (
    SELECT
        FLOOR(s.publish_year / 10) * 10 AS decade,
        g.genre,
        SUM(s.na_sales + s.eu_sales + s.jp_sales + s.other_sales) AS total_sales
    FROM video_game_sales s
    JOIN video_game_genres g
        ON s.Genre_ID = g.Genre_ID
    WHERE s.publish_year IS NOT NULL
    GROUP BY decade, g.genre
),
ranked AS (
    SELECT
        decade,
        genre,
        total_sales,
        RANK() OVER (
            PARTITION BY decade
            ORDER BY total_sales DESC
        ) AS decade_rank
    FROM genre_sales
)
SELECT
    decade,
    genre,
    ROUND(total_sales, 2) AS total_sales,
    decade_rank
FROM ranked
WHERE decade_rank <= 3
ORDER BY decade, decade_rank;

#Business	Task	8:	Calculate	the	Running	Total	of	Sales	by	Year	for	the	Top	Genre

with genre_total as 
(select genre, sum(na_sales+eu_sales+jp_Sales+other_sales) as total_sales
from video_game_sales s
join video_game_genres g
on s.Genre_ID = g.Genre_ID
group by genre),
top_genre as
(select genre from genre_total
order by total_sales desc
limit 1) ,
yearly_sales as (
    select
        g.genre,
        s.publish_year as year,
        SUM(s.na_sales + s.eu_sales + s.jp_sales
            + s.other_sales) as yearly_sales
    from video_game_sales s
    join video_game_genres g
        on s.Genre_ID = g.Genre_ID
    join top_genre t
        on g.genre = t.genre
    where s.publish_year is not null
    group by g.genre, s.publish_year
)
select
    genre,
    year,
    ROUND(yearly_sales, 2) as yearly_sales,
    ROUND(
        SUM(yearly_sales) over (
            order by year
            rows between unbounded preceding and current row
        ), 2
    ) as running_total
from yearly_sales
order by year;

#Business	Task	9:	Identify	the	Least	Popular	Genre	in	Terms	of	Total	Sales	and	Number	of	Games	Released.

SELECT *
FROM (
    SELECT
        'Lowest Total Sales' AS Metric_Type,
        genre,
        ROUND(SUM(na_sales + eu_sales + jp_sales + other_sales), 2) AS Value
    FROM video_game_sales AS s
    INNER JOIN video_game_genres AS g
        ON s.Genre_ID = g.Genre_ID
    GROUP BY genre
    ORDER BY Value
    LIMIT 1
) AS sales_result

UNION ALL

SELECT *
FROM (
    SELECT
        'Fewest Games Released' AS Metric_Type,
        genre,
        COUNT(game_name) AS Value
    FROM video_game_sales AS s
    INNER JOIN video_game_genres AS g
        ON s.Genre_ID = g.Genre_ID
    GROUP BY genre
    ORDER BY Value
    LIMIT 1
) AS games_result;


#Business	Task	10:	Determine	Which	Genre	Has	the	Most	Significant	Regional	Sales	Variation

SELECT
    g.genre,

    GREATEST(
        SUM(s.na_sales),
        SUM(s.eu_sales),
        SUM(s.jp_sales),
        SUM(s.other_sales)
    ) AS Max_Region_Sales,

    LEAST(
        SUM(s.na_sales),
        SUM(s.eu_sales),
        SUM(s.jp_sales),
        SUM(s.other_sales)
    ) AS Min_Region_Sales,

    ROUND(
        GREATEST(
            SUM(s.na_sales),
            SUM(s.eu_sales),
            SUM(s.jp_sales),
            SUM(s.other_sales)
        )
        -
        LEAST(
            SUM(s.na_sales),
            SUM(s.eu_sales),
            SUM(s.jp_sales),
            SUM(s.other_sales)
        ),
        2
    ) AS Sales_Variation

FROM video_game_sales AS s
INNER JOIN video_game_genres AS g
    ON s.Genre_ID = g.Genre_ID

GROUP BY g.genre
ORDER BY Sales_Variation DESC
LIMIT 1;