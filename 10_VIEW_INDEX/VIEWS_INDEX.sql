--------------------------------------------------------------INDEX--------------------------------------------------------------

--Create a basic index on player_name column in batsman_data_t20i
CREATE INDEX idx_batsman_name ON batsman_data_t20i(player_name);

--Create a composite index on country and runs in batsman_data_t20i
CREATE INDEX idx_country_runs ON batsman_data_t20i(country, runs);

-- Drop the index created on player_name
DROP INDEX idx_batsman_name;

-- Create a unique index on player_name in bowler_data_odi (assumes names are unique)
CREATE UNIQUE INDEX uniq_bowler_name ON bowler_data_odi(player_name);

--Check existing indexes on batsman_data_t20i
SELECT index_name, table_name, column_name
FROM user_ind_columns
WHERE table_name = 'BATSMAN_DATA_T20I';


--------------------------------------------------------------VIEWS--------------------------------------------------------------

--Create a view showing only key T20I batsman details
CREATE OR REPLACE VIEW vw_batsman_basic AS
SELECT player_name, country, matches, runs, strike_rate
FROM batsman_data_t20i;

-- Query from the view vw_batsman_basic for Indian batsmen
SELECT * FROM vw_batsman_basic
WHERE country = 'India';

--Create a view for top 5 bowlers by wickets in ODI
CREATE OR REPLACE VIEW vw_top5_bowlers AS
SELECT player_name, wickets
FROM (
  SELECT player_name, wickets,
         RANK() OVER (ORDER BY wickets DESC) AS rnk
  FROM bowler_data_odi
)
WHERE rnk <= 5;

--Drop the view vw_batsman_basic
DROP VIEW vw_batsman_basic;

--Create a view combining batsman and bowler stats using UNION
CREATE OR REPLACE VIEW vw_players_combined AS
SELECT player_name, country, matches, 'Batsman' AS role FROM batsman_data_t20i
UNION
SELECT player_name, country, matches, 'Bowler' AS role FROM bowler_data_odi;

--List all views you have created (in your schema):
SELECT view_name FROM user_views;

--List Particular view
SELECT * FROM vw_batsman_basic;

SELECT * FROM vw_top5_bowlers;

DESC vw_batsman_basic;

SELECT player_name, runs
FROM vw_batsman_basic
WHERE strike_rate > 140;


