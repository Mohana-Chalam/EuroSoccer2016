
--1. Write a query in SQL to find the number of venues for EURO cup 2016. (soccer_venue)
SELECT COUNT(venue_id)
FROM [dbo.soccer_venue]

SELECT COUNT (*)
FROM [dbo.soccer_venue]

--2. Write a query in SQL to find the number of countries participated in the EURO cup 2016. (player_mast)
SELECT count(DISTINCT team_id)
FROM [dbo.player_mast]

--3. Write a query in SQL to find the number of goals scored in EURO cup 2016 within normal play schedule.(goal_details)

SELECT  DISTINCT COUNT (*)
FROM [dbo.goal_details]

--4. Write a query in SQL to find the number of matches ended with a result. (match_mast)

SELECT COUNT(*)
FROM [dbo.match_mast]
WHERE results='WIN'

--5. Write a query in SQL to find the number of matches ended with draws. (match_mast)

SELECT COUNT(*) as num_of_matches,
	CASE WHEN results ='WIN' THEN 'Win'
	ELSE 'Draw'
	END as Status
FROM [dbo.match_mast]
GROUP BY results
ORDER BY num_of_matches DESC

--6. Write a query in SQL to find the date when did Football EURO cup 2016 begin.(match_mast)

SELECT play_date as Begin_date
FROM [dbo.match_mast]
WHERE match_no=1

--7. Write a query in SQL to find the number of self-goals scored in EURO cup 2016.( goal_details)

SELECT COUNT(*)
FROM [dbo.goal_details]
WHERE goal_type = 'O'

--8. Write a query in SQL to count the number of matches ended with a results in group stage. (match_mast)

SELECT COUNT(*)
FROM [dbo.match_mast]
WHERE play_stage='G' and results = 'WIN'

--9. Write a query in SQL to find the number of matches got a result by penalty shootout. (penalty_shootout)

SELECT COUNT (DISTINCT match_no)
FROM [dbo.penalty_shootout]

--10. Write a query in SQL to find the number of matches were decided on penalties in the Round of 16. (match_mast)

SELECT count(*)
FROM [dbo.match_mast]
WHERE play_stage = 'R' AND decided_by = 'P'

--11. Write a query in SQL to find the number of goal scored in every match within normal play schedule. (goal_details)

SELECT match_no, COUNT(goal_id) as Total_goals
FROM [dbo.goal_details]
GROUP BY match_no

--12. Write a query in SQL to find the match no, date of play, and goal scored for that match in which no stoppage time have been added in 1st half of play. (match_mast)

SELECT match_no,play_date,goal_score
FROM [dbo.match_mast]
WHERE stop1_sec = 0

--13. Write a query in SQL to find the number of matches ending with a goalless draw in group stage of play. (match_details)

SELECT COUNT(DISTINCT match_no)
FROM [dbo.match_details]
WHERE win_lose = 'D' and play_stage = 'G' and goal_score = 0

--14. Write a query in SQL to find the number of matches ending with only one goal win except those matches which was decided by penalty shootout.(match_details)

SELECT COUNT(DISTINCT match_no)
FROM [dbo.match_details]
WHERE win_lose = 'W' and goal_score = 1 and penalty_score  IS NULL

--15. Write a query in SQL to find the total number of players replaced in the tournament. (player_in_out)

SELECT COUNT(player_id)
FROM [dbo.player_in_out]
WHERE in_out = 'I'

--16. Write a query in SQL to find the total number of palyers replaced within normal time of play.(player_in_out)

SELECT COUNT(player_id)
FROM [dbo.player_in_out]
WHERE play_schedule = 'NT' and in_out = 'I'

--17. Write a query in SQL to find the number of players replaced in the stoppage time. (player_in_out)

SELECT COUNT(player_id)
FROM [dbo.player_in_out]
WHERE play_schedule = 'ST' and in_out = 'I'

--18. Write a query in SQL to find the total number of players replaced in the first half of play. (player_in_out)

SELECT COUNT(player_id)
FROM [dbo.player_in_out]
WHERE play_half = 1 and in_out = 'I'
AND play_schedule = 'NT'

--19. Write a query in SQL to find the total number of goalless draws have there in the entire tournament. (match_details)

SELECT COUNT(DISTINCT match_no)
FROM [dbo.match_details]
WHERE win_lose = 'D' and goal_score = 0

--20. Write a query in SQL to fine the total number of players replaced in the extra time of play. (player_in_out)

SELECT COUNT(player_id)
FROM [dbo.player_in_out]
WHERE play_schedule = 'ET' and in_out = 'I'

--21. Write a query in SQL to compute a list to show the number of substitute happened in various stage of play for the entire tournament. (player_in_out)

SELECT play_half,play_schedule,COUNT(*) as substitude
FROM [dbo.player_in_out]
WHERE in_out = 'I'
GROUP BY play_half,play_schedule
ORDER BY substitude

--22. Write a query in SQL to find the number of shots taken in penalty shootout matches.(penalty_shootout)

SELECT COUNT(*)
FROM [dbo.penalty_shootout]

--23. Write a query in SQL to find the number of shots socred goal in penalty shootout matches. (penalty_shootout)

SELECT COUNT(score_goal)
FROM [dbo.penalty_shootout]
WHERE score_goal = 1

--24. Write a query in SQL to find the number of shots missed or saved in penalty shootout matches. (penalty_shootout)

SELECT score_goal,COUNT(score_goal)
FROM [dbo.penalty_shootout]
GROUP BY score_goal 

--25. Write a query in SQL to prepare a list of players with number of shots they taken in penalty shootout matches.(Sample table: soccer_country, penalty_shootout, player_mast)

SELECT penalty.match_no,player.player_name,country.country_name,penalty.score_goal,penalty.kick_no
FROM [dbo.penalty_shootout] penalty,[dbo.player_mast] player,[dbo.Soccer Country] country
WHERE penalty.player_id = player.player_id
AND penalty.team_id = country.country_id

--26. Write a query in SQL to find the number of penalty shots taken by the teams. (soccer_country, penalty_shootout)	

SELECT a.country_name, COUNT(*) as No_of_shots
FROM [dbo.Soccer Country] a,[dbo.penalty_shootout] b
WHERE a.country_id = b.team_id
GROUP BY a.country_name

--27. Write a query in SQL to find the number of booking happened in each half of play within normal play schedule. (player_booked)

SELECT play_half,play_schedule,COUNT(booking_time) as booking
FROM [dbo.player_booked]
WHERE play_schedule = 'NT'
GROUP BY play_half,play_schedule

--28. Write a query in SQL to find the number of booking happened in stoppage time. (player_booked)

SELECT play_schedule,COUNT(booking_time) as booking
FROM [dbo.player_booked]
WHERE play_schedule = 'ST'
GROUP BY play_schedule

--29. Write a query in SQL to find the number of booking happened in extra time. (player_booked)

SELECT play_schedule,COUNT(booking_time) as booking
FROM [dbo.player_booked]
WHERE play_schedule = 'ET'
GROUP BY play_schedule