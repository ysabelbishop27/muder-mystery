
-- Record your SQL detective process here!  Write down: 
--   1. The SQL queries you ran
--   2. Any notes or insights as SQL comments
--   3. Your final conclusion: who did it?

-- Using these SQL clauses will help you solve the mystery: 
--    SELECT, FROM, WHERE, AND, OR, ORDER BY, LIMIT, LIKE, DISTINCT, BETWEEN, AS

-- selecting all columns from the crime scene report
SELECT * 
FROM crime_scene_report;

-- finding the murder report that happened in SQL City
SELECT * 
FROM crime_scene_report
WHERE type = 'murder'
  AND city = 'SQL City';

-- Notes:
-- The crime scene report says the murder happened on January 15, 2018.
-- It says there were 2 witnesses.
-- One witness lives at the last house on Northwestern Dr.
-- The second witness is named Annabel and lives on Franklin Ave.

-- finding the first witness who lives at the last house on Northwestern Dr
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

-- finding the second witness named Annabel on Franklin Ave
SELECT *
FROM person
WHERE name LIKE 'Annabel%'
  AND address_street_name = 'Franklin Ave';

-- checking the interviews from both witnesses
SELECT *
FROM interview
WHERE person_id IN (14887, 16371);

-- Notes:
-- The first witness said the killer had a Get Fit Now gym membership.
-- The membership number started with 48Z.
-- The person was a gold member.
-- The second witness said she saw the killer at the gym on January 9, 2018.
-- The killer's car plate included H42W.

-- finding the person who matches the gym membership, check-in date, gold status, and license plate clue
SELECT p.name AS killer_name
FROM get_fit_now_member AS g
JOIN get_fit_now_check_in AS c
  ON g.id = c.membership_id
JOIN person AS p
  ON g.person_id = p.id
JOIN drivers_license AS d
  ON p.license_id = d.id
WHERE g.id LIKE '48Z%'
  AND g.membership_status = 'gold'
  AND c.check_in_date = 20180109
  AND d.plate_number LIKE '%H42W%';

-- Final conclusion:
-- The person who committed the murder was Jeremy Bowers.

-- checking my solution
INSERT INTO solution
VALUES (1, 'Jeremy Bowers');

SELECT value
FROM solution;
```
