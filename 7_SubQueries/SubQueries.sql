--Find teams that have won the Asia Cup.
SELECT DISTINCT team
FROM asiacup
WHERE result = 'Win';

--Find matches where the team scored more than the average score.
SELECT *
FROM asiacup
WHERE run_scored > (SELECT AVG(run_scored) FROM asiacup);

--List players from batsman_data_odi who have hit more fours than the average.
SELECT player_name
FROM batsman_data_odi
WHERE fours > (SELECT AVG(fours) FROM batsman_data_odi);

--Display ODI players whose highest score is above the overall average highest score.
SELECT player_name, highest_score
FROM batsman_data_odi
WHERE highest_score > (SELECT AVG(highest_score) FROM batsman_data_odi);

SELECT player_name, highest_score
FROM batsman_data_odi
WHERE highest_score > (SELECT AVG(highest_score) FROM batsman_data_odi) order by highest_score desc;

--Get player names who have a strike rate above all T20I players’ average.
SELECT player_name
FROM batsman_data_odi
WHERE strike_rate > (SELECT AVG(strike_rate) FROM batsman_data_t20i);

--Find the player(s) who scored the highest runs in ODI.
SELECT player_name, runs
FROM batsman_data_odi
WHERE runs = (SELECT MAX(runs) FROM batsman_data_odi);

--List years when the toss winner did not win the match.
SELECT year
FROM asiacup
WHERE toss != result;

--Find the runner-up country that never won the Asia Cup.
SELECT runner_up
FROM champion
WHERE runner_up NOT IN (SELECT DISTINCT champion FROM champion);

--Get the players who have the least ducks in ODI.
SELECT player_name, ducks
FROM batsman_data_odi
WHERE ducks = (SELECT MIN(ducks) FROM batsman_data_odi);

--Get Asia Cup matches played in the same year when India won the championship.
SELECT *
FROM asiacup
WHERE year IN (
    SELECT year
    FROM champion
    WHERE champion = 'India'
);

--List T20I players who scored more than any ODI player's highest score.
SELECT player_name, highest_score
FROM batsman_data_t20i
WHERE highest_score > ALL (
    SELECT highest_score FROM batsman_data_odi
);

--Get ODI players who played more matches than the average of T20I players.
SELECT player_name, matches
FROM batsman_data_odi
WHERE matches > (SELECT AVG(matches) FROM batsman_data_t20i);

--Find the match with the highest run rate in the Asia Cup.
SELECT *
FROM asiacup
WHERE run_rate = (SELECT MAX(run_rate) FROM asiacup);

--Find the player with the highest strike rate in both ODI and T20I.
SELECT player_name, strike_rate
FROM batsman_data_odi
WHERE strike_rate = (SELECT MAX(strike_rate) FROM batsman_data_odi)
UNION
SELECT player_name, strike_rate
FROM batsman_data_t20i
WHERE strike_rate = (SELECT MAX(strike_rate) FROM batsman_data_t20i);

--List players who are not the top run scorer nor player of the series in any year.
SELECT player_name
FROM batsman_data_odi
WHERE player_name NOT IN (
    SELECT player_of_the_series FROM champion
    UNION
    SELECT highest_run_scorer FROM champion
);

--Find Asia Cup matches where the player of the match was also the highest wicket taker for that year.
SELECT *
FROM asiacup
WHERE player_of_the_match IN (
    SELECT highest_wicket_taker
    FROM champion
    WHERE year = asiacup.year
);

--List the number of sixes hit by batsmen who scored more than 500 runs in ODI.
SELECT Player_name,sixes
FROM batsman_data_odi
WHERE runs > 500  order by  Player_name,sixes DESC;

--List all grounds where the highest individual score was above the average of all highest_scores.
SELECT DISTINCT ground
FROM asiacup
WHERE highest_score > (
    SELECT AVG(highest_score)
    FROM asiacup
);

--Find the player(s) with the best (max) batting average in both ODI and T20I formats.
SELECT player_name, batting_average
FROM batsman_data_odi
WHERE batting_average = (SELECT MAX(batting_average) FROM batsman_data_odi)
UNION
SELECT player_name, TO_NUMBER(batting_average)
FROM batsman_data_t20i
WHERE TO_NUMBER(batting_average DEFAULT 0 ON CONVERSION ERROR) = (
    SELECT MAX(TO_NUMBER(batting_average DEFAULT 0 ON CONVERSION ERROR))
    FROM batsman_data_t20i
);

--Find the champion who hosted the most Asia Cups.
SELECT champion
FROM champion
WHERE host = (
    SELECT host
    FROM (
        SELECT host, COUNT(*) AS cnt
        FROM champion
        GROUP BY host
        ORDER BY cnt DESC
    )
    WHERE ROWNUM = 1
);

--Find players who scored the maximum runs with the fewest balls faced.
SELECT player_name
FROM batsman_data_odi
WHERE runs = (SELECT MAX(runs) FROM batsman_data_odi)
AND balls_faced = (
    SELECT MIN(balls_faced)
    FROM batsman_data_odi
    WHERE runs = (SELECT MAX(runs) FROM batsman_data_odi)
);
