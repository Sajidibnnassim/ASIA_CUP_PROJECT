--Examples of INNER (NORMAL) JOIN

--Batsmen and Bowlers from the same country (ODI):
SELECT b.Player_Name, bw.player_name
FROM batsman_data_odi b INNER JOIN bowler_data_odi bw 
ON b.Country = bw.country;

--Champions and hosts matching by year:
SELECT DISTINCT c.Year, c.Host, c.Champion
FROM champion c INNER JOIN asiacup a 
ON c.Year = a.year;

--Match results with Player of the Match details:
SELECT a.ground, a.year, a.player_of_the_match, b.Player_Name
FROM asiacup a INNER JOIN batsman_data_odi b 
ON a.player_of_the_match = b.Player_Name;

--ODI wicketkeepers who are also batsmen:
SELECT w.Player_Name, w.Country, b.Runs
FROM wicketkeeper_data_odi w INNER JOIN batsman_data_odi b 
ON w.Player_Name = b.Player_Name;

--ODI batsmen and their corresponding ODI bowling stats:
SELECT b.Player_Name, b.Country, b.Runs, bw.wickets
FROM batsman_data_odi b INNER JOIN bowler_data_odi bw 
ON b.Player_Name = bw.player_name 
AND b.Country = bw.country;


--5 Examples of LEFT JOIN

-- 1. List all T20I bowlers and their matching ODI stats (if any)
SELECT t.player_name, t.country AS t20i_country, o.country AS odi_country
FROM bowler_data_t20i t LEFT JOIN bowler_data_odi o 
ON t.player_name = o.player_name;

-- 2. All ODI bowlers and their Asia Cup matches (if any)
SELECT DISTINCT o.player_name, a.year, a.team
FROM bowler_data_odi o LEFT JOIN asiacup a 
ON o.country = a.team;

-- 3. Champions and their highest wicket-taker's T20I stats
SELECT c.champion, b.player_name, b.wickets
FROM champion c LEFT JOIN bowler_data_t20i b 
ON c.highest_wicket_taker = b.player_name;

-- 4. Asia Cup matches and the T20I record of their top wicket taker
SELECT a.player_of_the_match, b.wickets
FROM asiacup a LEFT JOIN bowler_data_t20i b 
ON a.player_of_the_match = b.player_name;

-- 5. ODI bowlers and whether they played in Asia Cup (match by country)
SELECT o.player_name, o.country, a.team AS asiacup_team
FROM bowler_data_odi o LEFT JOIN asiacup a 
ON o.country = a.team;


--5 Examples of RIGHT JOIN

-- 1. Asia Cup teams and any T20I bowler from those countries
SELECT DISTINCT t.player_name, t.country, a.team
FROM bowler_data_t20i t RIGHT JOIN asiacup a 
ON t.country = a.team;

-- 2. Champion teams and their country-wise ODI bowler stats
SELECT DISTINCT o.player_name, c.champion
FROM bowler_data_odi o RIGHT JOIN champion c 
ON o.country = c.champion;

-- 3. T20I bowler and if they were highest wicket-taker in champion table
SELECT b.player_name, c.highest_wicket_taker
FROM bowler_data_t20i b RIGHT JOIN champion c 
ON b.player_name = c.highest_wicket_taker;

-- 4. ODI bowler and player_of_the_match in Asia Cup
SELECT o.player_name, a.player_of_the_match
FROM bowler_data_odi o RIGHT JOIN asiacup a 
ON o.player_name = a.player_of_the_match;

-- 5. T20I bowler vs Asia Cup team where bowler's country = team
SELECT DISTINCT t.player_name, t.country, a.team
FROM bowler_data_t20i t RIGHT JOIN asiacup a 
ON t.country = a.team;


 --5 FULL OUTER JOINs

-- 1. Merge both bowler tables on player name (compare ODI and T20I bowlers)
SELECT t.player_name AS t20i_player, o.player_name AS odi_player, t.wickets AS t20i_wkts, o.wickets AS odi_wkts
FROM bowler_data_t20i t FULL OUTER JOIN bowler_data_odi o 
ON t.player_name = o.player_name;

-- 2. T20I and ODI bowlers by country
SELECT DISTINCT t.country AS t20i_country, o.country AS odi_country
FROM bowler_data_t20i t FULL OUTER JOIN bowler_data_odi o 
ON t.country = o.country;

-- 3. Asia Cup vs Champion table (team and champion match)
SELECT DISTINCT a.team, c.champion
FROM asiacup a FULL OUTER JOIN champion c 
ON a.team = c.champion;

-- 4. Player of the match vs highest wicket-taker
SELECT DISTINCT a.player_of_the_match, c.highest_wicket_taker
FROM asiacup a FULL OUTER JOIN champion c 
ON a.player_of_the_match = c.highest_wicket_taker;

-- 5. T20I bowlers vs Asia Cup player_of_the_match
SELECT DISTINCT t.player_name, a.player_of_the_match
FROM bowler_data_t20i t FULL OUTER JOIN asiacup a 
ON t.player_name = a.player_of_the_match;
