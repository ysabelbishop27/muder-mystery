-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?
-- 1. First, I found the crime scene report using the date and location.
-- The date column is an INTEGER, so I used 19860814.
-- The location was Coral Bay Marina.

SELECT *
FROM crime_scene
WHERE date = 19860814
  AND location = 'Coral Bay Marina';

-- 2. The crime scene description said two people were seen nearby:
-- one person lives on 300ish "Ocean Drive"
-- and another person's first name ends with "ul"
-- and last name ends with "ez".


-- 3. I searched for the person who lived on 300ish Ocean Drive.
-- This helped me find Carlos Mendez.

SELECT *
FROM person
WHERE address LIKE '3%Ocean Drive';


-- 4. I searched for the person whose first name ends with "ul"
-- and whose last name ends with "ez".
-- This helped me find Raul Gutierrez.

SELECT *
FROM person
WHERE name LIKE '%ul %ez';


-- 5. Next, I checked the interviews for Carlos Mendez and Raul Gutierrez.
-- Carlos said someone checked into a hotel on August 13 and looked nervous.
-- Raul said someone checked into a hotel with "Sunset" in the name.

SELECT person.name,
       person.alias,
       person.occupation,
       person.address,
       interviews.transcript
FROM person
JOIN interviews
  ON person.id = interviews.person_id
WHERE person.name IN ('Carlos Mendez', 'Raul Gutierrez');


-- 6. Using those clues, I searched hotel check-ins.
-- I looked for someone who checked into a hotel on August 13, 1986
-- and the hotel name had "Sunset" in it.

SELECT person.name,
       person.alias,
       person.occupation,
       hotel_checkins.hotel_name,
       hotel_checkins.check_in_date
FROM hotel_checkins
JOIN person
  ON person.id = hotel_checkins.person_id
WHERE hotel_checkins.check_in_date = 19860813
  AND hotel_checkins.hotel_name LIKE '%Sunset%';


-- 7. I checked the surveillance records connected to that hotel check-in.

SELECT person.name,
       person.alias,
       person.occupation,
       hotel_checkins.hotel_name,
       hotel_checkins.check_in_date,
       surveillance_records.suspicious_activity
FROM surveillance_records
JOIN person
  ON person.id = surveillance_records.person_id
JOIN hotel_checkins
  ON hotel_checkins.id = surveillance_records.hotel_checkin_id
WHERE hotel_checkins.check_in_date = 19860813
  AND hotel_checkins.hotel_name LIKE '%Sunset%';


-- 8. I checked the confession for the person who matched the hotel clue.

SELECT person.name,
       person.alias,
       confessions.confession
FROM confessions
JOIN person
  ON person.id = confessions.person_id
WHERE person.name = 'Thomas Brown';


-- Final conclusion:
-- The murderer was Thomas Brown.

