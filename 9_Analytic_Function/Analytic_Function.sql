 --Rank T20I batsmen by runs (highest first)\
 SELECT player_name, country, runs,
       RANK() OVER (ORDER BY runs DESC) AS run_rank
FROM batsman_data_t20i;

--Rank ODI bowlers by wickets taken
SELECT player_name, country, wickets,
       DENSE_RANK() OVER (ORDER BY wickets DESC) AS wicket_rank
FROM bowler_data_odi;

--Assign row numbers to batsmen by country (alphabetically)
SELECT player_name, country,
       ROW_NUMBER() OVER (PARTITION BY country ORDER BY player_name) AS row_num
FROM batsman_data_t20i;

--Divide ODI bowlers into 3 performance buckets based on wickets
SELECT player_name, wickets,
       NTILE(3) OVER (ORDER BY wickets DESC) AS performance_bucket
FROM bowler_data_odi;

--Show previous player’s runs within the same country
SELECT player_name, country, runs,
       LAG(runs) OVER (PARTITION BY country ORDER BY runs DESC) AS previous_player_runs
FROM batsman_data_t20i;

--Show next bowler’s wickets within the same country
SELECT player_name, country, wickets,
       LEAD(wickets) OVER (PARTITION BY country ORDER BY wickets DESC) AS next_player_wickets
FROM bowler_data_odi;

--Cumulative runs per country
SELECT player_name, country, runs,
       SUM(runs) OVER (PARTITION BY country ORDER BY runs DESC) AS country_cumulative_runs
FROM batsman_data_t20i;

--Average wickets per country
SELECT player_name, country, wickets,
       AVG(wickets) OVER (PARTITION BY country) AS avg_wickets_country
FROM bowler_data_odi;

--Top run scorer from each country
SELECT player_name, country, runs,
       FIRST_VALUE(player_name) OVER (PARTITION BY country ORDER BY runs DESC) AS top_scorer_in_country
FROM batsman_data_t20i;

--Lowest run scorer per country
SELECT player_name, country, runs,
       LAST_VALUE(player_name) OVER (
           PARTITION BY country ORDER BY runs DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS lowest_scorer_in_country
FROM batsman_data_t20i;
