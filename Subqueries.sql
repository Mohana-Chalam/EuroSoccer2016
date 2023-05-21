
--1. Write a query in SQL to find the teams played the first match of EURO cup 2016.  ( match_details, soccer_country)
SELECT matchh.match_no,country.country_name
FROM [dbo.Soccer Country] country, [dbo.match_details] matchh
WHERE country.country_id = matchh.team_id
AND match_no = 1

--2. Write a query in SQL to find the winner of EURO cup 2016. (soccer_country, match_details)

SELECT country_name
FROM [dbo.Soccer Country]
WHERE country_id  in (SELECT team_id FROM [dbo.match_details]
WHERE play_stage = 'F' AND win_lose = 'W')

--3. Write a query in SQL to find the match with match no, play stage, goal scored, and the audence which was the heighest audence match. (match_mast)

SELECT match_no,play_stage,goal_score,audence
FROM [dbo.match_mast]
WHERE audence in (SELECT MAX(audence) FROM [dbo.match_mast])

--4. Write a query in SQL to find the match no in which Germany played against Poland(match_details, soccer_country)
SELECT match_no
FROM [dbo.match_details]
WHERE team_id in (SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'Germany') 
OR team_id in (SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'Poland')
GROUP BY match_no
HAVING COUNT(team_id) = 2

--5. Write a query in SQL to find the match no, play stage, date of match, number of gole scored, and the result of the match where Portugal played against Hungary. (match_mast, match_details, soccer_country)

SELECT match_no,play_stage, play_date,goal_score,results
FROM [dbo.match_mast]
WHERE match_no in 
(SELECT match_no FROM [dbo.match_details] WHERE team_id in 
(SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'Portugal') OR team_id in 
(SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'Hungary')
GROUP BY match_no
HAVING COUNT(match_no) = 2)

--6. Write a query in SQL to display the list of players scored number of goals in every matches(goal_details, soccer_country, player_mast)

SELECT match_no,jersey_no,player_name,COUNT(match_no) as goals,country_name
FROM [dbo.goal_details]goal,[dbo.Soccer Country]country,[dbo.player_mast]player
WHERE player.team_id = country.country_id AND goal.team_id = player.team_id
GROUP BY match_no,jersey_no,player_name,country_name
ORDER BY match_no

--7. Write a SQL query to find the highest audience match.(soccer_country, match_mast, goal_details)

SELECT country_name
FROM [dbo.Soccer Country]
WHERE country_id IN
	(SELECT team_id 
	FROM [dbo.goal_details] 
	WHERE match_no IN 
		(SELECT match_no 
		FROM [dbo.match_mast] 
		WHERE audence IN
			(SELECT MAX(audence) FROM [dbo.match_mast])))

--8. Write a SQL query to find the player who scored the last goal for Portugal against Hungary.(soccer_country, match_details, goal_details, player_mast)

SELECT player_name 
FROM [dbo.player_mast]
WHERE player_id=(
  SELECT player_id 
  FROM [dbo.goal_details] 
    where match_no=(SELECT match_no FROM [dbo.match_details] 
WHERE team_id=(
SELECT country_id FROM [dbo.Soccer Country] 
WHERE country_name='Hungary') 
or team_id=(SELECT country_id FROM [dbo.Soccer Country] 
WHERE country_name='Portugal') 
GROUP BY match_no HAVING COUNT(DISTINCT team_id)=2) 
    AND team_id=(SELECT team_id
FROM [dbo.Soccer Country] c, [dbo.soccer_team] ct
WHERE c.country_id=ct.team_id AND country_name='Portugal') 
    AND goal_time=(
      SELECT max(goal_time) 
      FROM [dbo.goal_details] 
        WHERE match_no=(SELECT match_no FROM [dbo.match_details] 
WHERE team_id=(
SELECT country_id FROM [dbo.Soccer Country] 
WHERE country_name='Hungary') 
or team_id=(SELECT country_id FROM [dbo.Soccer Country] 
WHERE country_name='Portugal') 
GROUP BY match_no HAVING COUNT(DISTINCT team_id)=2) AND team_id=(
SELECT team_id
FROM [dbo.Soccer Country] c, [dbo.soccer_team] ct
WHERE c.country_id=ct.team_id AND country_name='Portugal'))
                );

--9. Write a query in SQL to find the 2nd highest stoppage time which had been added in 2nd half of play. (match_mast)

SELECT MAX(stop2_sec)
FROM [dbo.match_mast]
WHERE stop2_sec <> (SELECT MAX(stop2_sec) FROM [dbo.match_mast])

--10. Write a query in SQL to find the teams played the match where 2nd highest stoppage time had been added in 2nd half of play. (soccer_country, match_details, match_mast)

SELECT country_name 
FROM [dbo.Soccer Country] 
WHERE country_id IN 
	(SELECT team_id FROM [dbo.match_details] WHERE match_no IN
	(SELECT match_no FROM [dbo.match_mast] WHERE stop2_sec IN 
	(SELECT MAX(stop2_sec) FROM [dbo.match_mast] WHERE stop2_sec <> 
	(SELECT MAX(stop2_sec) FROM [dbo.match_mast]))))

--11. Write a query in SQL to find the match no, date of play and the 2nd highest stoppage time which have been added in the 2nd half of play.(match_mast)

SELECT match_no,play_date,stop2_sec
FROM [dbo.match_mast] a
WHERE (2-1) = (
SELECT COUNT(DISTINCT b.stop2_sec)
FROM [dbo.match_mast] b
WHERE b.stop2_sec > a.stop2_sec)

--12. Write a SQL query to find the team, which was defeated by Portugal in EURO cup 2016 final.(soccer_country, match_details)

SELECT country_name
FROM [dbo.Soccer Country]
WHERE country_id IN 
(SELECT team_id FROM [dbo.match_details] WHERE play_stage = 'F' and win_lose = 'L')

--13. Write a query in SQL to find the club which supplied the most number of players to the 2016 EURO cup. player_mast

SELECT playing_club,COUNT(playing_club)
FROM [dbo.player_mast] GROUP BY playing_club
HAVING COUNT(playing_club) = (
SELECT MAX(club_count)
FROM (
SELECT playing_club,COUNT(playing_club) club_count 
FROM [dbo.player_mast] 
GROUP BY playing_club) club_count)

--14. Write a query in SQL to find the player and his jersey number Who scored the first penalty of the tournament. (player_mast, goal_details)

SELECT jersey_no,player_name
FROM [dbo.player_mast]
WHERE player_id IN 
(SELECT player_id FROM [dbo.goal_details] WHERE goal_type = 'P' 
AND match_no =(SELECT MIN(match_no) FROM [dbo.goal_details] 
WHERE goal_type = 'P' AND play_stage = 'G'))

--15. Write a query in SQL to find the player along with his team and jersey number who scored the first penalty of the tournament (player_mast, goal_details, soccer_country)

SELECT p.jersey_no,p.player_name,c.country_name
FROM [dbo.player_mast] p,[dbo.goal_details] g,[dbo.goal_details] g2, [dbo.Soccer Country] c
WHERE p.player_id=g.player_id AND p.team_id=c.country_id
AND p.player_id =
(SELECT g.player_id FROM [dbo.goal_details] g WHERE g.goal_type = 'P' 
AND g.match_no =(SELECT MIN(g2.match_no) FROM [dbo.goal_details] g2 
WHERE g2.goal_type = 'P' AND g2.play_stage = 'G'))
GROUP BY p.jersey_no,p.player_name,c.country_name

--16. Write a query in SQL to find the player who was the goalkeeper for Italy in penalty shootout against Germany in Football EURO cup 2016. (player_mast, penalty_gk, soccer_country)

SELECT player_name
FROM [dbo.player_mast]
WHERE player_id IN 
(SELECT player_gk FROM [dbo.penalty_gk] 
WHERE match_no IN 
(SELECT match_no FROM [dbo.penalty_gk]
WHERE team_id IN 
(SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'Italy') 
OR team_id IN (SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'Germany')
GROUP BY match_no
HAVING COUNT(DISTINCT team_id) = 2)
AND team_id=(
SELECT country_id 
FROM [dbo.Soccer Country] 
WHERE country_name='Italy')
)

--17. Write a query in SQL to find the number of goals Germany scored at the tournament. (goal_details, soccer_country)

SELECT COUNT(team_id) as Total_goal
FROM [dbo.goal_details]
WHERE team_id IN 
(SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'Germany')

--18. Write a query in SQL to find the players along with their jersey no., and playing club, who were the goalkeepers for the England squad for 2016 EURO cup. (player_mast, soccer_country)

SELECT jersey_no,player_name,playing_club
FROM [dbo.player_mast]
WHERE team_id IN 
(SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'England')
AND posi_to_play = 'GK'

--19. Write a query in SQL to find the players along with their jersey no. under contract to Liverpool were in the Squad of England in 2016 EURO cup.  (player_mast, soccer_country)

SELECT jersey_no,player_name
FROM [dbo.player_mast]
WHERE team_id IN 
(SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'England')
AND playing_club = 'Liverpool'

--20. Write a query in SQL to find the player with other infromation Who scored the last goal in the 2nd semi final i.e. 50th match in EURO cub 2016.  (player_mast, goal_details, soccer_country)

SELECT p.jersey_no,p.player_name,g.goal_time,g.goal_half,c.country_name
FROM [dbo.player_mast] p,[dbo.goal_details] g,[dbo.Soccer Country] c
WHERE p.player_id =g.player_id AND p.team_id = c.country_id 
AND g.match_no = 50
AND g.goal_time = (SELECT MAX(g.goal_time) FROM [dbo.goal_details] g WHERE g.match_no = 50) 

--21. Write a query in SQL to find the player Who was the captain of the EURO cup 2016 winning team from Portugal. (player_mast, match_captain, match_details)

SELECT player_name
FROM [dbo.player_mast]
WHERE player_id IN
(SELECT player_captain FROM [dbo.match_captain] WHERE team_id IN
(SELECT team_id FROM [dbo.match_details] WHERE play_stage = 'F' AND win_lose = 'W'))

--22. Write a query in SQL to find the number of players played for france in the final. (player_in_out, match_mast, soccer_country)

SELECT COUNT(in_out)+11 as Total_players_France
FROM [dbo.player_in_out]
WHERE match_no IN 
(SELECT match_no FROM [dbo.match_mast] WHERE play_stage ='F')
AND team_id IN (SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'France')

--23. Write a query in SQL to find the goalkeeper of the team Germany who didn't concede any goal in their group stage matches.  (player_mast, match_details, soccer_country)

SELECT jersey_no,player_name
FROM [dbo.player_mast]
WHERE player_id IN (SELECT player_gk FROM [dbo.match_details] WHERE play_stage = 'G')
AND player_id IN (SELECT player_gk FROM [dbo.match_details] WHERE goal_score = 0 AND penalty_score IS NULL)
AND team_id IN (SELECT country_id FROM [dbo.Soccer Country] WHERE country_name = 'Germany')

--24. Write a query in SQL to find the runners-up in Football EURO cup 2016.  (match_details, soccer_country)

SELECT country_name
FROM [dbo.Soccer Country] 
WHERE country_id IN 
	(SELECT team_id 
	FROM [dbo.match_details] 
	WHERE play_stage = 'F'
	AND win_lose = 'L'
	AND team_id <> 
	(SELECT country_id 
	FROM [dbo.Soccer Country] 
	WHERE country_name = 'Portugal'))

--25. Write a query in SQL to find the maximum penalty shots taken by the teams.  (soccer_country, penalty_shootout)

SELECT c.country_name, COUNT(*) as kicks
FROM [dbo.Soccer Country] c,[dbo.penalty_shootout] p
WHERE c.country_id = p.team_id
GROUP BY c.country_name
HAVING COUNT(*) = 
	(SELECT MAX(max_kick) 
		FROM (SELECT COUNT(kick_no) as max_kick	
			FROM [dbo.penalty_shootout] 
			GROUP BY match_no) max_kick)

--26. Write a query in SQL to find the maximum number of penalty shots taken by the players.  (player_mast, penalty_shootout, soccer_country)

SELECT c.country_name,a.player_name, a.jersey_no,COUNT(b.kick_no) shots 
FROM [dbo.player_mast] a, [dbo.penalty_shootout] b, [dbo.Soccer country] c
WHERE b.player_id=a.player_id
AND b.team_id=c.country_id
GROUP BY c.country_name,a.player_name,a.jersey_no
HAVING COUNT(b.kick_no)=(
SELECT MAX(shots) FROM (
SELECT COUNT(*) shots 
FROM [dbo.penalty_shootout]
GROUP BY player_id) inner_result)

--27. Write a query in SQL to find the match no. where highest number of penalty shots taken.  (penalty_shootout)

SELECT match_no,COUNT(*)
FROM [dbo.penalty_shootout]
GROUP BY match_no 
HAVING COUNT(*) = (SELECT MAX(score) 
	FROM (SELECT COUNT(kick_no) score
	FROM [dbo.penalty_shootout] 
	GROUP BY match_no)score)

--28. Write a query in SQL to find the match no. and teams who played the match where highest number of penalty shots had been taken.  (penalty_shootout,soccer_country)

SELECT p.match_no,c.country_name
FROM [dbo.penalty_shootout] p,[dbo.Soccer Country] c
WHERE p.team_id = c.country_id
AND p.match_no IN (SELECT p.match_no FROM [dbo.penalty_shootout] p GROUP BY p.match_no 
	HAVING COUNT(*) = (SELECT MAX(score) FROM 
	(SELECT COUNT(*) score FROM [dbo.penalty_shootout] p GROUP BY p.match_no) score)) 
GROUP BY p.match_no,c.country_name

--29. Write a query in SQL to find the player of portugal who taken the 7th kick against poland.  (player_mast, penalty_shootout, soccer_country)

SELECT pl.jersey_no,pl.player_name,pe.kick_no
FROM [dbo.player_mast]pl,[dbo.penalty_shootout]pe
WHERE pl.player_id = pe.player_id 
AND pe.kick_no = 7  
AND pe.team_id IN (SELECT country_id FROM [dbo.Soccer Country]
		WHERE country_name = 'Portugal')
GROUP BY pl.jersey_no,pl.player_name,pe.kick_no

--30. Write a query in SQL to find the stage of match where the penalty kick number 23 had been taken.(match_mast, penalty_shootout) 

SELECT match_no,play_stage
FROM [dbo.match_mast]  
WHERE match_no IN
	(SELECT match_no FROM [dbo.penalty_shootout] WHERE kick_id = 23)

--31. Write a query in SQL to find the venues where penalty shootout matches played. (soccer_venue, match_mast, penalty_shootout)

SELECT venue_name
FROM [dbo.soccer_venue]
WHERE venue_id IN 
	(SELECT venue_id FROM [dbo.match_mast] WHERE decided_by = 'P'
	AND match_no IN (SELECT match_no FROM [dbo.penalty_shootout]))

--32. Write a query in SQL to find the date when penalty shootout matches played.  (match_mast, penalty_shootout)

SELECT match_no,play_date 
FROM [dbo.match_mast]
WHERE match_no IN 
	(SELECT match_no FROM [dbo.match_mast] WHERE decided_by ='P')

--33. Write a query in SQL to find the most quickest goal at the EURO cup 2016, after 5 minutes.  (goal_details)

SELECT MIN(goal_time) as quickest_goal_after5_min
FROM (SELECT goal_time 
	FROM [dbo.goal_details]
	WHERE goal_time > 5) tt


