--Find players who played either as T20I batsmen or as ODI bowlers (no duplicates)
SELECT player_name FROM batsman_data_t20i
UNION
SELECT player_name FROM bowler_data_odi;

--Find all players who are in both tables (with duplicates if any)
SELECT player_name FROM batsman_data_t20i
UNION ALL
SELECT player_name FROM bowler_data_odi;

--Find players who have records in both T20I batsmen and ODI bowlers
SELECT player_name FROM batsman_data_t20i
INTERSECT
SELECT player_name FROM bowler_data_odi;

-- Find T20I batsmen who never bowled in ODI format
SELECT player_name FROM batsman_data_t20i
MINUS
SELECT player_name FROM bowler_data_odi;

--Find ODI bowlers who never batted in T20Is
SELECT player_name FROM bowler_data_odi
MINUS
SELECT player_name FROM batsman_data_t20i;

-- Combine country values from both tables (distinct)
SELECT country FROM batsman_data_t20i
UNION
SELECT country FROM bowler_data_odi;

--List all player_name with their role type (using UNION ALL + static column)
SELECT player_name, 'Batsman' AS role FROM batsman_data_t20i
UNION ALL
SELECT player_name, 'Bowler' AS role FROM bowler_data_odi;

-- List all common player_name with their country (only players present in both tables)
SELECT player_name, country FROM batsman_data_t20i
INTERSECT
SELECT player_name, country FROM bowler_data_odi;

-- List T20I players who are not from any country present in the ODI bowlers list
SELECT DISTINCT country FROM batsman_data_t20i
MINUS
SELECT DISTINCT country FROM bowler_data_odi;

-- List all unique match counts (matches column) from both tables
SELECT DISTINCT matches FROM batsman_data_t20i
UNION
SELECT DISTINCT matches FROM bowler_data_odi;
