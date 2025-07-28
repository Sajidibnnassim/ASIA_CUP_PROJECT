🔹 Aliases
Q1. Display player names and their runs from batsman_data_odi, but rename columns as "Name" and "TotalRuns".
SOLUTION: select player_name as NAME , runs as TOTAL_RUNS from batsman_data_odi;

Q2. Why would you use column aliases in real-time dashboards or reports?
✔️ For user-friendly headers, dynamic reporting, or when dealing with expressions/calculations.


🔹 Column Concatenation
Q3. Show player and team as a single column like Virat Kohli (India) from batsman_data_t20i.
SOLUTION: select player_name,country,concat(player_name,country) AS PlayerInfo  from batsman_data_t20i;
		  select player_name || ' ' || country AS PlayerInfo  from batsman_data_t20i;

		  select player_name || ' (' || country || ')' AS PlayerInfo  from batsman_data_t20i;


Q4. How would you handle concatenation if the value can be NULL?
✔️ Use NVL(column, '') to avoid getting NULL in the final result.


🔹 Column Calculations
Q5. Calculate the average runs per match from batsman_data_odi.
SOLUTION: SELECT Player_name, ROUND(Runs / Matches, 2) AS AvgRunsPerMatch FROM batsman_data_odi WHERE Matches > 0;

Q6. Multiply economy by overs to get total runs given in bowler_data_odi.
SOLUTION: select player_name,economy_rate * overs as RunsConceded from bowler_data_odi;


🔹 DISTINCT
Q7. List all distinct teams in the Asia Cup.
SOLUTION: select distinct(team) from asiacup;

Q8. Why would you use DISTINCT instead of GROUP BY?
✔️ When you only need unique values, not aggregations.


🔹 IN / NOT IN
Q9. Show all players from India or Pakistan.
SOLUTION: select Player_name from batsman_data_odi where country IN('India','Pakistan');

Q10. List players who are not from Sri Lanka or Bangladesh.
SOLUTION: select Player_name from batsman_data_odi where country NOT IN('Sri Lanka','Bangladesh'); 


🔹 AND / OR / NOT
Q11. Get players who scored over 100 runs and played less than 10 matches.
SOLUTION: select player_name from batsman_data_t20i where runs > '100' and matches < '10';

Q12. Find bowlers with less than 10 wickets or economy less than 6.
SOLUTION: select player_name from bowler_data_t20i where wickets < 10 or economy_rate < 6;

Q13. Exclude players with 0 runs.
SOLUTION: select player_name from batsman_data_odi where NOT runs = 0;


🔹 IS NULL / IS NOT NULL
Q14. Find players whose strike rate is not available.
SOLUTION: select player_name from batsman_data_odi where strike_rate IS NULL;

Q15. Get all records where Economy is available.
SOLUTION: select player_name from bowler_data_t20i where economy_rate IS NOT NULL;


🔹 LIKE
Q16. Find all players whose name starts with ‘R’.
SOLUTION: select Player_name from batsman_data_odi where player_name like 'R%'

Q17. List players whose name contains “Singh”.
SOLUTION: SELECT Player FROM wicketkeeper_data_odi WHERE Player LIKE '%Singh%';

Q18. What’s the difference between _ and % in LIKE?
✔️ _ matches exactly one character, % matches zero or more characters.


🔹 ROWNUM / ROWID
Q19. Get top 5 players based on rownum.
SOLUTION: select ROWNUM ,Player_name from batsman_data_odi where ROWNUM <= 5;

Q20. Show the ROWID of a player.
SOLUTION: SELECT Player_Name, ROWID FROM bowler_data_t20i;


🔹 ORDER BY
Q21. List all bowlers ordered by wickets (desc) and economy (asc).
SOLUTION: select Player_name,wickets,economy_RATE from bowler_data_odi   order by wickets DESC , economy_RATE ASC;

Q22. Why is ORDER BY important in production reports?
✔️ It ensures consistent data presentation and easy trend spotting.


🔹 DATE / TO_CHAR
Q23. Display today’s date in 'YYYY-MM-DD' format.
SOLUTION: SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS Today FROM DUAL;

Q24. Show the current day of the week.
SOLUTION: SELECT TO_CHAR(SYSDATE, 'Day') AS Day FROM DUAL;

Q25. Get Asia Cup matches hosted after 2010.
SOLUTION: select team || ' Vs ' || opponent  AS matches_hosted, YEAR  from asiacup where year >= 2010;


🔹 DUAL Table
Q26. Generate a dummy row for testing.
SOLUTION: SELECT 'Asia Cup Practice' AS Title FROM DUAL;

Q27. Get system info in reports.
SOLUTION: SELECT USER, SYSDATE, TO_CHAR(SYSDATE, 'Day') FROM DUAL;


🔹 Bonus – Mixed Questions
Q28. Show a report like: 'PlayerName has scored Runs runs in Matches matches'.
SOLUTION: SELECT Player_NAME || ' has scored ' || Runs || ' runs in ' || Matches || ' matches' AS Report 
FROM batsman_data_t20i;

Q29. Show distinct number of players by team.
SOLUTION: SELECT DISTINCT Player_name, Country FROM batsman_data_odi;

Q30. Show the first 10 players with total runs more than 500.
SOLUTION: select rownum,player_name,Runs FROM batsman_data_odi where Runs > 500 AND rownum <= 10;
