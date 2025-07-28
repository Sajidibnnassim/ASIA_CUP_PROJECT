--Total Wickets Taken by All ODI Bowlers
SELECT SUM(wickets) AS total_wickets FROM bowler_data_odi;
--individual
SELECT  player_name,SUM(wickets) AS total_wickets FROM bowler_data_odi group by player_name;


--Average Bowling Average of ODI Bowlers
SELECT AVG(bowling_average) AS avg_bowling_average FROM bowler_data_odi;
--individual
SELECT player_name,AVG(bowling_average) AS avg_bowling_average FROM bowler_data_odi group by player_name;

--Maximum Economy Rate Among ODI Bowlers
SELECT MAX(economy_rate) AS max_economy_rate FROM bowler_data_odi;

--Minimum Strike Rate Among ODI Bowlers
SELECT MIN(strike_rate) AS min_strike_rate FROM bowler_data_odi;

--Total Number of Bowlers Per Country (ODI)
SELECT country, COUNT(*) AS bowler_count FROM bowler_data_odi GROUP BY country;

--Sum of Maiden Overs Bowled in ODIs
SELECT SUM(maiden_overs) AS total_maiden_overs FROM bowler_data_odi;

--Average Overs Bowled per Player (ODI)
SELECT player_name, AVG(overs) AS avg_overs FROM bowler_data_odi GROUP BY player_name;

--Player with Highest Number of Five-Wicket Hauls in ODIs
SELECT player_name, MAX(five_wickets) AS max_five_wickets FROM bowler_data_odi GROUP BY player_name ORDER BY max_five_wickets DESC FETCH FIRST 1 ROW ONLY;

--Total Four-Wicket Hauls in ODIs by Country
SELECT country, SUM(four_wickets) AS total_4_wickets FROM bowler_data_odi GROUP BY country;

--Count of ODI Bowlers with Bowling Average Below 25
SELECT COUNT(*) AS count_below_25_avg FROM bowler_data_odi WHERE bowling_average < 25;

--Total Runs Given by All T20I Bowlers
SELECT SUM(runs) AS total_runs FROM bowler_data_t20i;

--Average Strike Rate in T20Is
SELECT AVG(strike_rate) AS avg_strike_rate FROM bowler_data_t20i;

--Bowler with Most Matches Played in T20Is
SELECT player_name, MAX(matches) AS matches_played FROM bowler_data_t20i GROUP BY player_name ORDER BY matches_played DESC FETCH FIRST 1 ROW ONLY;

--Count of T20I Bowlers from 'India'
SELECT COUNT(*) AS indian_bowlers FROM bowler_data_t20i WHERE country = 'India';

--Maximum Wickets in T20I by a Single Bowler
SELECT MAX(wickets) AS max_wickets FROM bowler_data_t20i;

--Sum of Four-Wicket Hauls Across All T20I Bowlers
SELECT SUM(four_wickets) AS total_4wkts FROM bowler_data_t20i;

--Minimum Economy Rate Among All T20I Bowlers
SELECT MIN(economy_rate) AS min_economy_rate FROM bowler_data_t20i;

--Players with More Than 10 T20I Wickets
SELECT player_name, wickets FROM bowler_data_t20i WHERE wickets > 10;

--Average Number of Matches Played Per Country in T20I
SELECT country, AVG(matches) AS avg_matches FROM bowler_data_t20i GROUP BY country;

SELECT country, ROUND(AVG(matches),3) AS avg_matches FROM bowler_data_t20i GROUP BY country;

--Bowler with the Least Runs Conceded in T20I
SELECT player_name, MIN(runs) AS least_runs FROM bowler_data_t20i GROUP BY player_name ORDER BY least_runs ASC FETCH FIRST 3 ROW ONLY;

--Total Dismissals by All Wicketkeepers in ODI
SELECT SUM(dismissals) AS total_dismissals FROM wicketkeeper_data_odi;

--Average Catches per Wicketkeeper in ODI
SELECT AVG(catches) AS avg_catches FROM wicketkeeper_data_odi;

--Wicketkeeper with Maximum Stumpings in ODI
SELECT player_name, MAX(stumpings) AS max_stumpings FROM wicketkeeper_data_odi GROUP BY player_name ORDER BY max_stumpings DESC FETCH FIRST 1 ROW ONLY;

--Count of Wicketkeepers per Country in ODI
SELECT country, COUNT(*) AS wicketkeeper_count FROM wicketkeeper_data_odi GROUP BY country;

--Total Maximum Dismissals by Country in ODI
SELECT country, SUM(maximum_dismissals) AS sum_max_dismissals FROM wicketkeeper_data_odi GROUP BY country;

--Wicketkeepers with More Than 10 ODI Dismissals
SELECT player_name, dismissals FROM wicketkeeper_data_odi WHERE dismissals > 10;

--Average Dismissals per Match in ODI
SELECT AVG(dismissals/matches) AS avg_dismissals_per_match FROM wicketkeeper_data_odi WHERE matches > 0;

--Country with Most ODI Catches by Wicketkeepers
SELECT country, SUM(catches) AS total_catches FROM wicketkeeper_data_odi GROUP BY country ORDER BY total_catches DESC FETCH FIRST 1 ROW ONLY;

--Player with Least Number of Stumpings in ODI
SELECT player_name, MIN(stumpings) AS min_stumpings FROM wicketkeeper_data_odi GROUP BY player_name ORDER BY min_stumpings ASC FETCH FIRST 1 ROW ONLY;

--Total Number of Matches Played by All ODI Wicketkeepers
SELECT SUM(matches) AS total_matches FROM wicketkeeper_data_odi;

--BIT TRICKY..

--Find the ODI bowler(s) with the best (lowest) average bowling average per country (i.e., top performer by country).
SELECT player_name, country, bowling_average
FROM bowler_data_odi b
WHERE bowling_average = (
    SELECT MIN(bowling_average)
    FROM bowler_data_odi
    WHERE country = b.country
);

--Show the top 3 T20I bowlers with the highest wickets per match ratio.
SELECT player_name, wickets, matches, (wickets/matches) AS wickets_per_match
FROM bowler_data_t20i
WHERE matches > 0
ORDER BY wickets_per_match DESC
FETCH FIRST 3 ROWS ONLY;

--List countries with average ODI economy rate below 5 and more than 5 bowlers in the database.
SELECT country, AVG(economy_rate) AS avg_economy, COUNT(*) AS bowler_count
FROM bowler_data_odi
GROUP BY country
HAVING AVG(economy_rate) < 5 AND COUNT(*) > 5;

--For each country, get the ODI bowler with the most maiden overs.
SELECT player_name, country, maiden_overs
FROM bowler_data_odi b
WHERE maiden_overs = (
    SELECT MAX(maiden_overs)
    FROM bowler_data_odi
    WHERE country = b.country
);

--Display all T20I bowlers whose overall wickets are above the country average.
SELECT id, player_name, country, wickets
FROM bowler_data_t20i b
WHERE wickets > (
    SELECT AVG(wickets)
    FROM bowler_data_t20i
    WHERE country = b.country
);

--Which ODI wicketkeeper(s) have caught above the average catches per match (overall)?
SELECT player_name, catches, matches, (catches/matches) AS catch_per_match
FROM wicketkeeper_data_odi
WHERE matches > 0
  AND (catches/matches) > (
        SELECT AVG(catches/matches)
        FROM wicketkeeper_data_odi
        WHERE matches > 0
      );


--Give the 5 bowlers (ODI + T20I) with the best economy rate (lowest, across both tables).
SELECT player_name, 'ODI' AS format, economy_rate
FROM bowler_data_odi
UNION ALL
SELECT player_name, 'T20I', economy_rate
FROM bowler_data_t20i
ORDER BY economy_rate ASC
FETCH FIRST 5 ROWS ONLY;

--Find the ODI bowler(s) who have a five-wicket haul in more than 10% of their matches.
SELECT player_name, matches, five_wickets, (five_wickets/matches)*100 AS pct_five_haul
FROM bowler_data_odi
WHERE matches > 0
  AND (five_wickets/matches) > 0.10;

--Show, for each ODI wicketkeeper, their rank (1 = most) by total dismissals within their country (use window function).
SELECT player_name, country, dismissals,
       RANK() OVER(PARTITION BY country ORDER BY dismissals DESC) AS rank_in_country
FROM wicketkeeper_data_odi;

--Identify T20I bowlers who have both a four-wicket and a five-wicket haul and whose economy rate is below their country average.
SELECT player_name, country, economy_rate, four_wickets, five_wickets
FROM bowler_data_t20i b
WHERE four_wickets > 0 AND five_wickets > 0
  AND economy_rate < (
        SELECT AVG(economy_rate)
        FROM bowler_data_t20i
        WHERE country = b.country
      );


