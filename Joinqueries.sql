--1. Write a query in SQL to find the name of the venue with city where the EURO cup 2016 final match was played. (soccer_venue, soccer_city, match_mast)

SELECT v.venue_name,c.city,m.play_date
FROM [dbo.soccer_venue] v
INNER JOIN [dbo.Soccer_city] c
ON v.city_id = c.city_id
INNER JOIN [dbo.match_mast] m
ON v.venue_id = m.venue_id
WHERE m.play_stage = 'F'

--2. Write a query in SQL to find the number of goal scored by each team in every match within normal play schedule.  (match_details, soccer_country)

SELECT m.match_no,c.country_name,m.goal_score
FROM [dbo.Soccer Country] c
JOIN [dbo.match_details] m
ON c.country_id = m.team_id
WHERE decided_by = 'N'
ORDER BY m.match_no

--3. Write a query in SQL to find the total number of goals scored by each player within normal play schedule and arrange the result set according to the heighest to lowest scorer.  (goal_details, player_mast, soccer_country)

SELECT jersey_no,player_name,COUNT(goal_time) goals,country_name
FROM [dbo.player_mast] p
JOIN [dbo.goal_details] g
ON p.player_id = g.player_id
JOIN [dbo.Soccer Country] c
ON p.team_id = c.country_id
WHERE g.goal_schedule = 'NT'
GROUP BY jersey_no,player_name,country_name
ORDER BY COUNT(goal_time) DESC

--4. Write a query in SQL to find the highest individual scorer in EURO cup 2016.  (goal_details, player_mast, soccer_country)

SELECT player_name,COUNT(player_name),country_name
FROM [dbo.player_mast] p
JOIN [dbo.goal_details] g ON p.player_id = g.player_id
JOIN [dbo.Soccer Country] c ON p.team_id = c.country_id
GROUP BY player_name,country_name
HAVING COUNT(player_name) >= ALL 
	(SELECT COUNT(player_name) FROM [dbo.player_mast] p 
	JOIN [dbo.goal_details] g ON p.player_id = g.player_id
	JOIN [dbo.Soccer Country] c ON p.team_id = c.country_id
	GROUP BY player_name,country_name) 

--5. Write a query in SQL to find the scorer of only goal along with his country and jersey number in the final of EURO cup 2016.  (goal_details, player_mast, soccer_country)

SELECT jersey_no,player_name,country_name
FROM [dbo.goal_details] g
JOIN [dbo.player_mast] p ON g.player_id = p.player_id
JOIN [dbo.Soccer Country] c ON g.team_id = c.country_id
WHERE play_stage = 'F'

--6. Write a query in SQL to find the country,venue and city where Football EURO cup 2016 held.  (soccer_country, soccer_city, soccer_venue,match_mast)

SELECT country_name,venue_name,city
FROM [dbo.Soccer Country] co
JOIN [dbo.Soccer_city] ci ON co.country_id = ci.country_id
JOIN [dbo.soccer_venue] v ON ci.city_id = v.city_id
JOIN [dbo.match_mast] m ON v.venue_id = m.venue_id
WHERE m.play_stage = 'F'

--7. Write a query in SQL to find the player who socred first goal of EURO cup 2016.  (soccer_country, player_mast, goal_details)

SELECT player_name,jersey_no,goal_time,country_name
FROM [dbo.Soccer Country] c
JOIN [dbo.player_mast] p ON c.country_id = p.team_id
JOIN [dbo.goal_details] g ON p.player_id = g.player_id
WHERE g.goal_id = 1

--8. Write a query in SQL to find the name and country of the referee who managed the opening match.  (soccer_country, match_mast, referee_mast)

SELECT referee_name,country_name
FROM [dbo.Soccer Country] c
JOIN [dbo.referee_mast] r ON c.country_id = r.country_id
JOIN [dbo.match_mast] m ON r.referee_id = m.referee_id
WHERE m.match_no = 1

--9. Write a query in SQL to find the name and country of the referee who managed the final match.  (soccer_country, match_mast, referee_mast)

SELECT referee_name,country_name
FROM [dbo.Soccer Country] c
JOIN [dbo.referee_mast] r ON c.country_id = r.country_id
JOIN [dbo.match_mast] m ON r.referee_id = m.referee_id
WHERE m.play_stage = 'F' 

--10. Write a query in SQL to find the name and country of the referee who assisted the referee in the opening match.  (asst_referee_mast, soccer_country, match_details)

SELECT ass_ref_name,country_name
FROM [dbo.Soccer Country] c
JOIN [dbo.asst_referee_mast] ar ON c.country_id = ar.country_id
JOIN [dbo.match_details] m ON ar.ass_ref_id = m.ass_ref
WHERE m.match_no = 1

--11. Write a query in SQL to find the name and country of the referee who assisted the referee in the final match.  (asst_referee_mast, soccer_country, match_details)

SELECT ass_ref_name,country_name
FROM [dbo.Soccer Country] c
JOIN [dbo.asst_referee_mast] ar ON c.country_id = ar.country_id
JOIN [dbo.match_details] m ON ar.ass_ref_id = m.ass_ref
WHERE m.play_stage = 'F'

--12. Write a query in SQL to find the city where the opening match of EURO cup 2016 played.  (soccer_venue, soccer_city, match_mast)

SELECT city
FROM [dbo.Soccer_city] c
JOIN [dbo.soccer_venue] v ON c.city_id = v.city_id
JOIN [dbo.match_mast] m ON v.venue_id = m.venue_id
WHERE m.match_no = 1

--13. Write a query in SQL to find the stadium hosted the final match of EURO cup 2016 along with the capacity, and audence for that match.  (soccer_venue, soccer_city, match_mast)

SELECT venue_name,aud_capacity,audence
FROM [dbo.soccer_venue] v
JOIN [dbo.Soccer_city] c ON v.city_id = c.city_id
JOIN [dbo.match_mast] m ON v.venue_id = m.venue_id
WHERE m.play_stage = 'F'

--14. Write a query in SQL to compute a report that contain the number of matches played in each venue along with their city.  (soccer_venue, soccer_city, match_mast)

SELECT venue_name,city,COUNT(DISTINCT match_no) as no_of_match
FROm [dbo.soccer_venue] v
JOIN [dbo.Soccer_city] c ON v.city_id = c.city_id
JOIN [dbo.match_mast] m ON v.venue_id = m.venue_id
GROUP BY venue_name,city

--15. Write a query in SQL to find the player who was the first player to be sent off at the tournament EURO cup 2016.  ( player_booked, player_mast, soccer_country)

SELECT player_name,jersey_no,booking_time as sent_off_time,country_name
FROM [dbo.player_booked] pb
JOIN [dbo.player_mast] pm ON pb.player_id = pm.player_id
JOIN [dbo.Soccer Country] c ON pm.team_id = c.country_id
WHERE sent_off = 'Y' AND match_no = 1


--16. Write a query in SQL to find the teams that scored only one goal to the torunament.  (soccer_team, soccer_country)

SELECT t.team_group,c.country_name
FROM [dbo.Soccer_team] t
JOIN [dbo.Soccer Country] c ON t.team_id = c.country_id
WHERE t.goal_for = 1

--17. Write a query in SQL to find the yellow cards received by each country. (soccer_country, player_booked)

SELECT country_name,COUNT(*)
FROM [dbo.Soccer Country] c
JOIN [dbo.player_booked] pb ON c.country_id = pb.team_id
GROUP BY country_name
ORDER BY COUNT(*) DESC

--18. Write a query in SQL to find the venue with number of goals that has seen. (soccer_country, goal_details, match_mast, soccer_venue)

SELECT venue_name,COUNT(venue_name)
FROM [dbo.Soccer Country] c
JOIN [dbo.goal_details] g ON c.country_id = g.team_id
JOIN [dbo.match_mast] m ON g.match_no = m.match_no
JOIN [dbo.soccer_venue] v ON m.venue_id = v.venue_id
GROUP BY venue_name
ORDER BY COUNT(venue_name) DESC

--19. Write a query in SQL to find the match and the teams where no stoppage time added in 1st half of play. (match_details, match_mast, soccer_country)

SELECT mm.match_no,country_name
FROM [dbo.match_details]md
JOIN [dbo.match_mast]mm ON md.match_no = mm.match_no
JOIN [dbo.Soccer Country] c ON md.team_id = c.country_id
WHERE stop1_sec = 0

--20. Write a query in SQL to find the team(s) who conceded the most goals in EURO cup 2016. (soccer_team, soccer_country)

SELECT c.country_name,t.team_group,t.match_played,t.goal_for,t.goal_agnst
FROM [dbo.Soccer_team]t
JOIN [dbo.Soccer Country]c ON t.team_id = c.country_id
WHERE goal_agnst = 
	(SELECT MAX(goal_agnst) FROM [dbo.Soccer_team]) 

--21. Write a query in SQL to find the match where highest stoppege time added in 2nd half of play. (match_details, match_mast, soccer_country)

SELECT mm.match_no,country_name,stop2_sec
FROM [dbo.match_details]md
JOIN [dbo.match_mast]mm ON md.match_no = mm.match_no
JOIN [dbo.Soccer Country]c ON md.team_id = c.country_id
WHERE stop2_sec IN
	(SELECT MAX(stop2_sec) FROM [dbo.match_mast])

--22. Write a query in SQL to find the matchs ending with a goalless draw in group stage of play. (match_details, soccer_country)

SELECT match_no,country_name
FROM [dbo.match_details]md
JOIN [dbo.Soccer Country]c ON md.team_id = c.country_id
WHERE win_lose = 'D' 
AND goal_score = 0
AND play_stage = 'G'
GROUP BY match_no,country_name

--23. Write a query in SQL to find the match no. and the teams played in that match where the 2nd highest stoppage time had been added in the 2nd half of play. (match_mast, match_details, soccer_country)

SELECT mm.match_no,c.country_name,mm.stop2_sec
FROM [dbo.match_mast] mm
JOIN [dbo.match_details] md ON mm.match_no = md.match_no
JOIN [dbo.Soccer Country] c ON md.team_id = c.country_id
WHERE (2-1) = (SELECT COUNT(DISTINCT mm2.stop2_sec)
	FROM [dbo.match_mast] mm2
	WHERE mm2.stop2_sec > mm.stop2_sec)

--24. Write a query in SQL to find the number of matches played by a player as a goalkeeper for his team.  (player_mast, match_details, soccer_country)

SELECT player_name,jersey_no,country_name,COUNT(match_no) as matches
FROM [dbo.player_mast] p
JOIN [dbo.match_details] m ON p.player_id = m.player_gk
JOIN [dbo.Soccer Country] c ON m.team_id = c.country_id
GROUP BY player_name,jersey_no,country_name
ORDER BY COUNT(match_no) DESC

--25. Write a query in SQL to find the venue that has seen the most goals.  (goal_details, soccer_country, match_mast, soccer_venue)

SELECT venue_name,COUNT(venue_name)
FROM [dbo.goal_details] g
JOIN [dbo.Soccer Country] c ON g.team_id = c.country_id
JOIN [dbo.match_mast] m ON g.match_no = m.match_no
JOIN [dbo.soccer_venue] v ON m.venue_id = v.venue_id
GROUP BY venue_name
HAVING COUNT(venue_name) =
	(SELECT MAX(goal) FROM (SELECT venue_name,COUNT(venue_name) goal
	FROM [dbo.goal_details] g
	JOIN [dbo.Soccer Country] c ON g.team_id = c.country_id
	JOIN [dbo.match_mast] m ON g.match_no = m.match_no
	JOIN [dbo.soccer_venue] v ON m.venue_id = v.venue_id
	GROUP BY venue_name)as tt)

--26. Write a query in SQL to find the oldest player to have appeared in a EURO cup 2016 match.  (player_mast, soccer_country)

SELECT *
FROM [dbo.player_mast]
SELECT player_name,jersey_no,age,country_name
FROM [dbo.player_mast] p 
JOIN [dbo.Soccer Country] c ON p.team_id = c.country_id
WHERE age IN
	(SELECT MAX(age) FROM [dbo.player_mast])

--27. Write a query in SQL to find those two teams which scored three goals in a single game at this tournament.  (match_details, soccer_country)

SELECT match_no,goal_score,country_name
FROM [dbo.match_details] m
JOIN [dbo.Soccer Country] c ON m.team_id = c.country_id
WHERE goal_score = 3 
AND win_lose = 'D'

--28. Write a query in SQL to find the teams with other information that finished bottom of their respective groups after conceding four times in three games.  (soccer_team, soccer_country)

SELECT team_group,country_name,match_played,goal_agnst
FROM [dbo.Soccer Country] c
JOIN [dbo.Soccer_team] t ON c.country_id = t.team_id
WHERE group_position = 4
AND goal_agnst = 4

--29. Write a query in SQL to find those three players with other information, who contracted to Lyon participated in the EURO cup 2016 Finals.  (player_mast, soccer_country, match_details)

SELECT country_name,player_name,jersey_no,posi_to_play,age,playing_club
FROM [dbo.player_mast]p
JOIN [dbo.Soccer Country]c ON p.team_id = c.country_id
JOIN [dbo.match_details]m ON m.team_id = c.country_id
WHERE playing_club = 'Lyon'
GROUP BY country_name,player_name,jersey_no,posi_to_play,age,playing_club

--30. Write a query in SQL to find the final four teams in the tournament.  (soccer_country, match_details)

SELECT country_name
FROM [dbo.Soccer Country]c
JOIN [dbo.match_details]m ON c.country_id = m.team_id
WHERE play_stage = 'Q'
AND win_lose = 'W'

--31. Write a query in SQL to find the captains for the top four teams with other information which participated in the semifinals (match 48 and 49) in the tournament. (soccer_country, match_captain, player_mast)

SELECT country_name,player_name,jersey_no,posi_to_play,age,playing_club
FROM [dbo.Soccer Country]c
JOIN [dbo.match_captain]mc ON c.country_id = mc.team_id
JOIN [dbo.player_mast]p ON mc.player_captain= p.player_id
WHERE match_no = 48 OR match_no = 49
GROUP BY country_name,player_name,jersey_no,posi_to_play,age,playing_club,player_captain

--32. Write a query in SQL to find the captains with other information for all the matches in the tournament.  (soccer_country, match_captain, player_mast)

SELECT match_no,country_name,player_name,jersey_no,posi_to_play,age,playing_club
FROM [dbo.Soccer Country]c
JOIN [dbo.match_captain]mc ON c.country_id = mc.team_id
JOIN [dbo.player_mast]p ON mc.player_captain= p.player_id
GROUP BY match_no,player_name,country_name,jersey_no,posi_to_play,age,playing_club

--33. Write a query in SQL to find the captain and goal keeper with other information for all the matches for all the team.  (soccer_country, match_captain, match_details, player_mast)

SELECT md.match_no,c.country_name,pm2.player_name as Caption,pm.player_name as gk_name
FROM [dbo.match_captain]mc
JOIN [dbo.match_details]md ON mc.team_id = md.team_id
JOIN [dbo.Soccer Country]c ON md.team_id = c.country_id
JOIN [dbo.player_mast]pm ON md.player_gk = pm.player_id
JOIN [dbo.player_mast]pm2 ON mc.player_captain = pm2.player_id
GROUP BY md.match_no,c.country_name,pm.player_name,pm2.player_name

--34. Write a query in SQL to find the player who was selected for the Man of the Match Award in the finals of EURO cup 2016.  (soccer_country, match_mast, player_mast)

SELECT country_name,player_name,jersey_no,posi_to_play,age,playing_club
FROM [dbo.Soccer Country]c
JOIN [dbo.player_mast]p ON c.country_id= p.team_id
JOIN [dbo.match_mast]m ON p.player_id = m.plr_of_match 
WHERE play_stage = 'F'
GROUP BY player_name,country_name,jersey_no,posi_to_play,age,playing_club

--35. Write a query in SQL to find the substitute players who came into the field in the first half of play within normal play schedule.  (player_in_out, player_mast, soccer_country)

SELECT match_no,country_name,player_name,jersey_no,posi_to_play,in_out,time_in_out
FROM [dbo.Soccer Country]c
JOIN [dbo.player_mast]pm ON c.country_id= pm.team_id
JOIN [dbo.player_in_out]pio ON pm.player_id = pio.player_id
WHERE play_schedule = 'NT'
AND play_half = 1
AND in_out = 'I' 

--36. Write a query in SQL to prepare a list for the player of the match against each match.  (match_mast, player_mast, soccer_country)

SELECT match_no,country_name,player_name,jersey_no,posi_to_play
FROM [dbo.Soccer Country]c
JOIN [dbo.player_mast]pm ON c.country_id= pm.team_id
JOIN [dbo.match_mast]mm ON pm.player_id=mm.plr_of_match

--37. Write a query in SQL to find the player along with his country who taken the penalty shot number 26.  (penalty_shootout, player_mast, soccer_country)

SELECT match_no,player_name,jersey_no,country_name
FROM [dbo.Soccer Country]c
JOIN [dbo.player_mast]pm ON c.country_id= pm.team_id
JOIN [dbo.penalty_shootout]pe ON pe.player_id =pm.player_id
WHERE kick_id =26

--38. Write a query in SQL to find the team against which the penalty shot number 26 had been taken. (penalty_shootout, soccer_country)

SELECT match_no,country_name
FROM [dbo.Soccer Country]c
JOIN [dbo.penalty_shootout]pe ON pe.team_id =c.country_id
WHERE match_no IN  
	(SELECT match_no FROM [dbo.penalty_shootout] 
	WHERE kick_id =26)
AND country_name <>
	(SELECT country_name
	FROM [dbo.Soccer Country] 
	WHERE country_id IN 
		(SELECT team_id 
		FROM [dbo.penalty_shootout]
		WHERE kick_id = 26))
GROUP BY match_no,country_name

--39. Write a query in SQL to find the captain who was also the goalkeeper. (match_captain, soccer_country, player_mast)

SELECT mc.match_no,country_name as Captain,player_name,jersey_no,posi_to_play,age,playing_club
FROM [dbo.Soccer Country]c
JOIN [dbo.match_captain]mc ON c.country_id = mc.team_id
JOIN [dbo.player_mast]p ON mc.player_captain= p.player_id
AND posi_to_play = 'GK'
ORDER BY mc.match_no

--40. Write a query in SQL to find the number of captains who was also the goalkeeper.  (match_captain, player_mast, soccer_country)

SELECT COUNT(DISTINCT country_name) as Total_capt_as_gk
FROM [dbo.Soccer Country]c
JOIN [dbo.match_captain]mc ON c.country_id = mc.team_id
JOIN [dbo.player_mast]p ON mc.player_captain= p.player_id
AND posi_to_play = 'GK'

--41. Write a query in SQL to find the players along with their team booked number of times in the tournament.( soccer_country, player_booked, player_mast)

SELECT country_name,player_name,jersey_no,COUNT(pb.player_id) bookedtimes
FROM [dbo.Soccer Country]c
JOIN [dbo.player_booked]pb ON c.country_id = pb.team_id
JOIN [dbo.player_mast]pm ON pb.player_id = pm.player_id
GROUP BY country_name,player_name,jersey_no  

--42. Write a query in SQL to find the players who booked most number of times.  (soccer_country, player_booked, player_mast)

SELECT player_name,COUNT(pb.player_id) bookedtimes
FROM [dbo.Soccer Country]c
JOIN [dbo.player_booked]pb ON c.country_id = pb.team_id
JOIN [dbo.player_mast]pm ON pb.player_id = pm.player_id
GROUP BY player_name
HAVING COUNT(pb.player_id) = 
	(SELECT MAX(bookedplayers) FROM (SELECT COUNT(player_id) bookedplayers FROM [dbo.player_booked] GROUP BY player_id) tt)

--43. Write a query in SQL to find the number of players booked for each team.  (soccer_country, player_booked)

SELECT country_name,COUNT(pb.player_id) bookedplayers
FROM [dbo.Soccer Country]c
JOIN [dbo.player_booked]pb ON c.country_id = pb.team_id
GROUP BY country_name
ORDER BY COUNT(pb.player_id) DESC

--44. Write a SQL query to find the matches in which the most cards are displayed.  (soccer_country, player_booked, player_mast)

SELECT match_no,COUNT(pb.player_id) as num_of_cards
FROM [dbo.Soccer Country]c
JOIN [dbo.player_booked]pb ON c.country_id = pb.team_id
JOIN [dbo.player_mast]pm ON pb.player_id = pm.player_id
GROUP BY match_no
HAVING COUNT(pb.player_id) = 
	(SELECT MAX(cards)
	FROM (SELECT COUNT(player_id) cards FROM [dbo.player_booked] GROUP BY match_no) tt) 

--45. Write a query in SQL to list the name of assistant referees with their countries for each matches.  (match_details, asst_referee_mast, soccer_country)

SELECT match_no,ass_ref_name,country_name
FROM [dbo.asst_referee_mast]ar 
JOIN [dbo.match_details]m ON ar.ass_ref_id = m.ass_ref
JOIN [dbo.Soccer Country]c ON m.team_id = c.country_id

--46. Write a query in SQL to find the assistant referees of each countries assists the number of matches. (match_details, asst_referee_mast, soccer_country)

SELECT country_name,count(DISTINCT match_no) asst
FROM [dbo.match_details]m
JOIN [dbo.asst_referee_mast]ar ON m.ass_ref=ar.ass_ref_id
JOIN [dbo.Soccer Country]c ON ar.country_id=c.country_id
GROUP BY country_name
ORDER BY count(*) DESC

--47. Write a query in SQL to find the countries from where the assistant referees assist most of the matches. (match_details, asst_referee_mast, soccer_country)

SELECT *
FROM [dbo.asst_referee_mast]ar
JOIN [dbo.match_details]m ON ar.ass_ref_id=m.ass_ref
JOIN [dbo.Soccer Country]c ON m.team_id=c.country_id


--48. Write a query in SQL to list the name of referees with their countries for each match.  (match_mast, referee_mast, soccer_country)

SELECT mm.match_no,rm.referee_name,c.country_name
FROM [dbo.match_mast]mm
JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
JOIN [dbo.Soccer Country]c ON rm.country_id = c.country_id

--49. Write a query in SQL to find the referees of each country managed number of matches. (match_mast, referee_mast, soccer_country)

SELECT c.country_name,COUNT(DISTINCT mm.match_no) No_of_match
FROM [dbo.match_mast]mm
JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
JOIN [dbo.Soccer Country]c ON rm.country_id = c.country_id
GROUP BY c.country_name
ORDER BY No_of_match DESC

--50. Write a query in SQL to find the countries from where the referees managed most of the matches.  (match_mast, referee_mast, soccer_country)

SELECT c.country_name,COUNT(match_no) matches
FROM [dbo.match_mast]mm
JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
JOIN [dbo.Soccer Country]c ON rm.country_id = c.country_id
GROUP BY c.country_name
HAVING COUNT(match_no) = 
	(SELECT MAX(matches) 
		FROM (SELECT COUNT(match_no) matches 
		FROM [dbo.match_mast]mm
		JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
		JOIN [dbo.Soccer Country]c ON rm.country_id = c.country_id
		GROUP BY c.country_name) tt)

--51. Write a query in SQL to find the referees managed the number of matches. (match_mast, referee_mast, soccer_country)

SELECT rm.referee_name,c.country_name,COUNT(DISTINCT mm.match_no) No_of_match
FROM [dbo.match_mast]mm
JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
JOIN [dbo.Soccer Country]c ON rm.country_id = c.country_id
GROUP BY rm.referee_name,c.country_name
ORDER BY No_of_match DESC

--52. Write a query in SQL to find those referees who managed most of the match.  ( match_mast, referee_mast, soccer_country)

SELECT rm.referee_name,c.country_name,COUNT(match_no) matches
FROM [dbo.match_mast]mm
JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
JOIN [dbo.Soccer Country]c ON rm.country_id = c.country_id
GROUP BY c.country_name,rm.referee_name
HAVING COUNT(match_no) = 
	(SELECT MAX(matches) 
		FROM (SELECT COUNT(match_no) matches 
		FROM [dbo.match_mast]mm
		JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
		JOIN [dbo.Soccer Country]c ON rm.country_id = c.country_id
		GROUP BY c.country_name,rm.referee_name) tt)

--53. Write a query in SQL to find the referees managed the number of matches in each venue.  (match_mast, referee_mast, soccer_country, soccer_venue)

SELECT v.venue_name,referee_name,c.country_name,COUNT(match_no) matches
FROM [dbo.match_mast]mm
JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
JOIN [dbo.Soccer Country]c ON rm.country_id = c.country_id
JOIN [dbo.soccer_venue]v ON mm.venue_id = v.venue_id
GROUP BY c.country_name,rm.referee_name,v.venue_name
ORDER BY matches DESC

--54. Write a query in SQL to find the referees and number of bookings they made. (player_booked, match_mast, referee_mast)

SELECT referee_name,COUNT(pb.player_id) bookings
FROM [dbo.player_booked]pb 
JOIN [dbo.match_mast]mm ON pb.match_no = mm.match_no
JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
GROUP BY referee_name
ORDER BY bookings DESC

--55. Write a query in SQL to find the referees who booked most number of players.  (player_booked, match_mast, referee_mast)

SELECT rm.referee_name,COUNT(pb.player_id) bookings
FROM [dbo.player_booked]pb 
JOIN [dbo.match_mast]mm ON pb.match_no = mm.match_no
JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
GROUP BY referee_name
HAVING COUNT(pb.player_id) = 
	(SELECT MAX(bookings) 
	FROM (SELECT COUNT(pb.player_id) bookings 
			FROM [dbo.player_booked]pb 
			JOIN [dbo.match_mast]mm ON pb.match_no = mm.match_no
			JOIN [dbo.referee_mast]rm ON mm.referee_id = rm.referee_id
			GROUP BY referee_name)tt)

--56. Write a query in SQL to find the player of each team who wear jersey number 10.  (player_mast, soccer_country)

SELECT country_name,player_name,jersey_no,posi_to_play,playing_club
FROM [dbo.player_mast]pm
JOIN [dbo.Soccer Country]c ON pm.team_id = c.country_id
WHERE pm.jersey_no = 10

--57. Write a query in SQL to find the defender who scored goal for his team.  (goal_details, player_mast, soccer_country)

SELECT country_name,player_name,jersey_no,posi_to_play,playing_club
FROM [dbo.goal_details]gd
JOIN [dbo.player_mast]pm ON gd.player_id = pm.player_id
JOIN [dbo.Soccer Country]c ON pm.team_id = c.country_id
WHERE posi_to_play = 'DF'

--58. Write a query in SQL to find out which players scored against his own team by accident.  (goal_details, player_mast, soccer_country)

SELECT country_name,player_name,jersey_no,posi_to_play,playing_club
FROM [dbo.goal_details]gd
JOIN [dbo.player_mast]pm ON gd.player_id = pm.player_id
JOIN [dbo.Soccer Country]c ON pm.team_id = c.country_id
WHERE goal_type = 'O'

--59. Write a query in SQL to find the results of penalty shootout matches. (match_details, soccer_country)

SELECT match_no,country_name,penalty_score,play_stage,win_lose
FROM [dbo.match_details]md
JOIN [dbo.Soccer Country]c ON md.team_id = c.country_id
WHERE decided_by = 'P'
ORDER BY match_no,penalty_score

--60. Write a query in SQL to find the number of goal scored by the players according to their playing position.  (goal_details, player_mast, soccer_country)

SELECT country_name,posi_to_play,COUNT(*) goals
FROM [dbo.goal_details]gd
JOIN [dbo.player_mast]pm ON gd.player_id = pm.player_id
JOIN [dbo.Soccer Country]c ON pm.team_id = c.country_id
GROUP BY posi_to_play,country_name
ORDER BY goals DESC

--61. Write a query in SQL to find those players who came into the field in the most last time of play.  (player_in_out, player_mast, soccer_country)

SELECT match_no,player_name,jersey_no,country_name,time_in_out
FROM [dbo.player_in_out]pio
JOIN [dbo.player_mast]pm ON pio.player_id = pm.player_id
JOIN [dbo.Soccer Country]c ON pm.team_id = c.country_id
WHERE time_in_out =
	(SELECT MAX(time_in_out)
	FROM [dbo.player_in_out])
AND in_out= 'I'