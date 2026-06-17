-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?

-- 1. First, I looked up the crime scene report using the date and location.
-- I learned that the correct table name was crime_scene, not crime_scene_reports.
-- I also learned that the date column is an INTEGER, so I used 19830715 instead of '1983-07-15'.

SELECT *
FROM crime_scene
WHERE date = 19830715
  AND location = 'West Hollywood Records';


-- 2. Next, I used the crime scene id to find the witness clues.
-- The witnesses table is connected to the crime_scene table through crime_scene_id.

SELECT *
FROM witnesses
WHERE crime_scene_id = (
  SELECT id
  FROM crime_scene
  WHERE date = 19830715
    AND location = 'West Hollywood Records'
);


-- 3. The witness clues pointed to a suspect wearing a red bandana
-- and a gold watch, so I searched the suspects table using those details.

SELECT *
FROM suspects
WHERE bandana_color = 'red'
  AND accessory = 'gold watch';


-- 4. Finally, I checked the suspect's interview transcript to confirm the confession.

SELECT suspects.name, interviews.transcript
FROM suspects
JOIN interviews
  ON suspects.id = interviews.suspect_id
WHERE suspects.bandana_color = 'red'
  AND suspects.accessory = 'gold watch';


-- Final conclusion:
-- The thief was Rico Delgado.

