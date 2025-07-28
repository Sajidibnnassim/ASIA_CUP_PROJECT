--1. Uppercase all player names (ODI)
SELECT UPPER(player_name) AS upper_name FROM batsman_data_odi;

--2. Lowercase country names (T20I)
SELECT LOWER(country) AS lower_country FROM batsman_data_t20i;

--3. Initcap on player names (ODI)
SELECT INITCAP(player_name) AS proper_name FROM batsman_data_odi;

--4. Length of player names (ODI)
SELECT player_name, LENGTH(player_name) AS name_length FROM batsman_data_odi;

--5. First 5 characters of player_name (T20I)
SELECT SUBSTR(player_name, 1, 5) AS short_name FROM batsman_data_t20i;

--6. Position of first space in player_name (ODI)
SELECT INSTR(player_name, ' ') AS space_pos FROM batsman_data_odi;

--7. Replace "India" with "IND" in country (ODI)
SELECT REPLACE(country, 'India', 'IND') AS short_country FROM batsman_data_odi;

--8. Replace vowels with * in player_name (T20I)
SELECT TRANSLATE(player_name, 'AEIOUaeiou', '**********') AS censored_name FROM batsman_data_t20i;

--9. Pad player_name left to 20 chars with * (ODI)
SELECT LPAD(player_name, 20, '*') AS padded_name FROM batsman_data_odi;

--10. Pad player_name right to 25 chars with - (T20I)
SELECT RPAD(player_name, 25, '-') AS padded_name FROM batsman_data_t20i;

--11. Trim leading spaces from player_name (T20I)
SELECT LTRIM(player_name) AS ltrim_name FROM batsman_data_t20i;

--12. Trim trailing spaces from player_name (ODI)
SELECT RTRIM(player_name) AS rtrim_name FROM batsman_data_odi;

--13. Trim both sides of country (ODI)
SELECT TRIM(country) AS trimmed_country FROM batsman_data_odi;

--14. Replace space with underscore in player_name (T20I)
SELECT REPLACE(player_name, ' ', '_') AS underscored_name FROM batsman_data_t20i;

--15. Reverse team name (Asia Cup)
SELECT team, REVERSE(team) AS reversed_team FROM asiacup;

--16. Concatenate player_name and country (ODI)
SELECT player_name || ' - ' || country AS player_country FROM batsman_data_odi;

--17. Player names longer than 15 chars (ODI)
SELECT player_name FROM batsman_data_odi WHERE LENGTH(player_name) > 15;

--18. Last 3 chars of team name (Asia Cup)
SELECT SUBSTR(team, -3) AS last_three FROM asiacup;

--19. Where “Sri” starts at position 1 in opponent (Asia Cup)
SELECT opponent FROM asiacup WHERE INSTR(opponent, 'Sri') = 1;

--20. First 3 letters of country (ODI)
SELECT SUBSTR(country, 1, 3) AS country_code FROM batsman_data_odi;

--21. Replace dash with N/A in T20I batting_average
SELECT REPLACE(batting_average, '-', 'N/A') AS cleaned_avg FROM batsman_data_t20i;

--22. Last word in player_of_the_match (Asia Cup)
SELECT player_of_the_match,
       SUBSTR(player_of_the_match, INSTR(player_of_the_match, ' ', -1) + 1) AS last_word
FROM asiacup;

--23. Extract year from time_period (ODI)
SELECT SUBSTR(time_period, -4) AS year_only FROM batsman_data_odi;

--24. Translate vowels to # in team name (Asia Cup)
SELECT TRANSLATE(team, 'AEIOUaeiou', '##########') AS masked_team FROM asiacup;

--25. Initials of player (ODI)
SELECT SUBSTR(player_name, 1, 1) || 
       SUBSTR(player_name, INSTR(player_name, ' ') + 1, 1) AS initials
FROM batsman_data_odi
WHERE INSTR(player_name, ' ') > 1;

--26. Round run_rate to 1 decimal (Asia Cup)
SELECT ROUND(run_rate, 1) AS rounded_rate FROM asiacup;

--27. Truncate run_rate to 2 decimals
SELECT TRUNC(run_rate, 2) AS truncated_rate FROM asiacup;

--28. Floor of avg_bat_strike_rate
SELECT FLOOR(avg_bat_strike_rate) AS floor_strike FROM asiacup;

--29. Ceiling of avg_bat_strike_rate
SELECT CEIL(avg_bat_strike_rate) AS ceil_strike FROM asiacup;

--30. MOD of fours by 5 (ODI)
SELECT MOD(fours, 5) AS fours_mod_5 FROM batsman_data_odi;

--31. Round strike_rate to integer (T20I)
SELECT ROUND(strike_rate, 0) AS rounded_strike FROM batsman_data_t20i;

--32. Floor of run_rate for complete overs
SELECT FLOOR(run_rate) AS full_overs FROM asiacup;

--33. MOD of year to find odd/even
SELECT year, MOD(year, 2) AS odd_even_flag FROM asiacup;
SELECT distinct year, MOD(year, 2) AS odd_even_flag FROM asiacup;

--34. Add 10 to centuries and round (ODI)
SELECT ROUND(centuries + 10) AS updated_centuries FROM batsman_data_odi;

--35. Runs per match, rounded to 2 decimals (ODI)
SELECT ROUND(runs / NULLIF(matches, 0), 2) AS runs_per_match FROM batsman_data_odi;

--36. Multiply sixes * 4 and round (ODI)
SELECT ROUND(sixes * 4) AS bonus_points FROM batsman_data_odi;

--37. CEIL of runs/matches (ODI)
SELECT CEIL(runs / NULLIF(matches, 0)) AS run_ratio FROM batsman_data_odi;

--38. TRUNC strike_rate to 1 digit (T20I)
SELECT TRUNC(strike_rate, 1) AS short_rate FROM batsman_data_t20i;

--39. MOD of matches by 3 (T20I)
SELECT MOD(matches, 3) AS mod_3 FROM batsman_data_t20i;

--40. Add 0.5 to average and round (ODI)
SELECT ROUND(batting_average + 0.5, 2) AS adj_average FROM batsman_data_odi;

--41. Months between today and 2024-01-01
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2024-01-01', 'YYYY-MM-DD')) AS months_diff FROM dual;

--42. Next Sunday after match year
SELECT year, NEXT_DAY(TO_DATE(year || '-01-01', 'YYYY-MM-DD'), 'SUNDAY') AS next_sunday FROM asiacup;

--43. Last day of match year (Jan)
SELECT LAST_DAY(TO_DATE(year || '-01-01', 'YYYY-MM-DD')) AS last_day FROM asiacup;

--44. Add 6 months to match year
SELECT ADD_MONTHS(TO_DATE(year || '-01-01', 'YYYY-MM-DD'), 6) AS mid_year FROM asiacup;

--45. Truncate current date
SELECT TRUNC(SYSDATE) AS trunc_today FROM dual;

--46. Round current date
SELECT ROUND(SYSDATE) AS rounded_today FROM dual;

--47. Month number of today
SELECT TO_CHAR(SYSDATE, 'MM') AS month_number FROM dual;

--48. Day name of match year
SELECT year, TO_CHAR(TO_DATE(year || '-01-01', 'YYYY-MM-DD'), 'Day') AS match_day FROM asiacup;

--49. Add 15 days to match date (assumed June 1)
SELECT ADD_MONTHS(TO_DATE(year || '-06-01', 'YYYY-MM-DD'), 0) + 15 AS extended_match FROM asiacup;

--50. Months between 2016 and 2022
SELECT MONTHS_BETWEEN(TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2016-01-01', 'YYYY-MM-DD')) AS month_gap FROM dual;