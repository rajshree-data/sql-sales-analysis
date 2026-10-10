# SQL Sales Analysis Case Study

## Project Overview

This project analyzes video game sales data using SQL to uncover business insights related to genre performance, regional sales patterns, and trends over time. The goal is to turn raw sales records into actionable information that can help evaluate product performance and guide strategic decision-making.

The analysis includes 10 business-oriented SQL tasks that explore sales totals, performance rankings, regional comparisons, and year-over-year trends.

## Business Problem

The business question behind this project is simple: which genres and product categories are performing best, and what patterns can we identify from historical sales data? By examining market performance across genres and regions, this analysis helps answer questions such as:

- Which genres generate the highest total sales?
- Which genres perform above the average benchmark?
- How much does each genre contribute to global sales?
- Which genres are most consistent or most variable across regions?
- How have genre sales changed over time?

## Dataset

This project uses a fictional/structured video game sales dataset containing sales information by game, genre, platform, publisher, and year. The data is organized into multiple tables, including:

- `video_game_sales`
- `video_game_genres`
- `video_game_platforms`
- `video_game_publishers`

The sales table includes key metrics such as:

- `na_sales` (North America sales)
- `eu_sales` (Europe sales)
- `jp_sales` (Japan sales)
- `other_sales`
- `publish_year`
- `Genre_ID`
- `game_name`

## Objectives

This case study aims to:

- Measure total sales by genre
- Identify high- and low-performing genres
- Compare sales against average performance
- Evaluate regional variation in sales
- Analyze sales trends year over year
- Rank genres based on performance and efficiency
- Highlight long-term market patterns across decades

## Tools and Technologies

- MySQL
- SQL
- Data aggregation and analysis techniques
- Window functions and ranking logic

## SQL Concepts Used

The project demonstrates a range of SQL techniques, including:

- `SUM()`, `AVG()`, and `COUNT()`
- `GROUP BY` and `HAVING`
- `JOIN` operations
- Subqueries
- Common Table Expressions (CTEs)
- Window functions such as `RANK()`, `LAG()`, and cumulative totals
- Conditional analysis using `GREATEST()` and `LEAST()`

## Project Structure

- `README.md` — project overview and documentation
- `video_game_sales_analysis.sql.sql` — SQL script containing all business queries

## Analysis Performed

The SQL script answers the following 10 business questions:

1. Total sales by genre
2. Genres performing above average sales
3. Percentage contribution of each genre to global sales
4. Ranking of genres by total sales
5. Average sales per game by genre
6. Year-over-year sales change by genre
7. Top 3 genres for each decade
8. Running total of yearly sales for the leading genre
9. Least popular genres by total sales and number of games released
10. Genre with the greatest regional sales variation

## Business Insights to Explore

After running the queries, the analysis can help answer:

- Which genres dominate the market?
- Are sales concentrated in a few genres or spread across many?
- Which genres are strong performers in specific regions?
- Are there long-term growth or decline patterns over time?
- Which genres should be prioritized for marketing or product expansion?

## Key Findings

This section will be updated with the final results from the SQL analysis after executing the queries on the dataset.

Example areas to summarize later:

- Top-performing genres by total sales
- Lowest-selling genres
- Market share contribution by genre
- Regional performance differences
- Long-term sales trends and significant shifts over time

## How to Run

1. Open MySQL or any SQL client.
2. Create the database and tables used in the project.
3. Import the dataset into the relevant tables.
4. Run the queries in `video_game_sales_analysis.sql.sql`.
5. Review the output for each business task.

## Learning Outcomes

This project helps build practical SQL skills in:

- Data aggregation
- Business analysis
- Trend analysis
- Ranking and performance comparisons
- Regional market evaluation
- Structured SQL problem solving

## Conclusion

This case study demonstrates how SQL can be used to transform raw sales data into business insight. By combining sales metrics, ranking logic, and time-based analysis, the project showcases a strong example of data-driven decision-making using SQL.

---

Author: Rajshree

Project Type: SQL Business Case Study
