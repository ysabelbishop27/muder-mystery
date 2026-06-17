-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?

-- 1. First, I checked the crime scene report for the Blue Note Lounge.
-- I wanted to find the main clue from the witness report.

SELECT *
FROM crime_scene
WHERE location = 'Blue Note Lounge';
-- 2. Next, I searched the suspects table for anyone matching the witness description.
-- I looked for suspects wearing a trench coat and having a scar on the left cheek.

SELECT *
FROM suspects
WHERE attire = 'trench coat'
  AND scar = 'left cheek';
-- 3. Then, I checked the interviews for the suspects who matched the description.
-- I joined the suspects table with the interviews table so I could read their transcripts.

SELECT suspects.name, interviews.transcript
FROM suspects
JOIN interviews
ON suspects.id = interviews.suspect_id
WHERE suspects.attire = 'trench coat'
  AND suspects.scar = 'left cheek';
-- Final Conclusion:
-- The culprit is Vincent Malone.
-- He matched the witness description and his interview confirmed that he stole the briefcase.
