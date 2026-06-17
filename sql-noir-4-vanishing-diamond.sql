-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?

-- 1. First, I found the crime scene report for the diamond theft.
-- I searched for the Fontainebleau Hotel and the Heart of Atlantis diamond necklace.
-- The crime scene report said only two guests gave valuable clues:
-- one famous actor and one woman who works as a consultant
-- whose first name ends with "an".

SELECT *
FROM crime_scene
WHERE location LIKE '%Fontainebleau%'
   OR description LIKE '%diamond%'
   OR description LIKE '%Heart of Atlantis%';

-- 2. Next, I searched the witness statements.
-- I looked for the famous actor and the consultant whose first name ends with "an".
-- The famous actor was Clint Eastwood.
-- His clue said: "Meet me at the marina, dock 3."
-- The consultant was Vivian Nair.
-- Her clue said the suspect had an invitation ending in "-R"
-- and was wearing a navy suit and white tie.

SELECT guest.name,
       guest.occupation,
       guest.invitation_code,
       witness_statements.clue
FROM witness_statements
JOIN guest
  ON guest.id = witness_statements.guest_id;


-- 3. I searched for the consultant whose first name ends with "an".

SELECT *
FROM guest
WHERE occupation LIKE '%Consultant%'
  AND name LIKE '%an %';


-- 4. I searched the attire registry for someone wearing a navy suit
-- and a white tie.

SELECT guest.name,
       guest.occupation,
       guest.invitation_code,
       attire_registry.note
FROM attire_registry
JOIN guest
  ON guest.id = attire_registry.guest_id
WHERE attire_registry.note LIKE '%navy suit%'
  AND attire_registry.note LIKE '%white tie%';


-- 5. I checked marina rentals for dock 3,
-- because Clint Eastwood's clue mentioned marina dock 3.

SELECT guest.name,
       guest.occupation,
       guest.invitation_code,
       marina_rentals.dock_number,
       marina_rentals.rental_date,
       marina_rentals.boat_name
FROM marina_rentals
JOIN guest
  ON guest.id = marina_rentals.renter_guest_id
WHERE marina_rentals.dock_number = 3;


-- 6. I combined the clues:
-- invitation code ending in "R",
-- navy suit,
-- white tie,
-- and marina dock 3.
-- This pointed to Mike Manning.

SELECT guest.name,
       guest.occupation,
       guest.invitation_code,
       attire_registry.note,
       marina_rentals.dock_number,
       marina_rentals.rental_date,
       marina_rentals.boat_name
FROM guest
JOIN attire_registry
  ON guest.id = attire_registry.guest_id
JOIN marina_rentals
  ON guest.id = marina_rentals.renter_guest_id
WHERE guest.invitation_code LIKE '%R'
  AND attire_registry.note LIKE '%navy suit%'
  AND attire_registry.note LIKE '%white tie%'
  AND marina_rentals.dock_number = 3;


-- 7. Finally, I checked the final interview/confession for Mike Manning.

SELECT guest.name,
       final_interviews.confession
FROM final_interviews
JOIN guest
  ON guest.id = final_interviews.guest_id
WHERE guest.name = 'Mike Manning';


-- Final conclusion:
-- The person who stole the Heart of Atlantis diamond necklace was Mike Manning.
```
