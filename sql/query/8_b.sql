-- 8.B) SQL DELETE
-- Scenario: Seller table is referenced by Book, Post and Message
-- Note that referential integrity MUST be maintained !

-- First, try adding a new Seller
-- This user is already a Buyer so UserInformation already exists
-- The user is trying to create new Seller account which is seperated from the Buyer one
INSERT INTO seller (email, password, ssn, username, profilepictureurl)
VALUES (
	'tontoeylnwzasellbook@gmail.com',
	'78590657fe72bb2e9d87a3f4f89d47e48ecd28dd42660c0c1c7ddb3ac286825f',
	'1112223334446',
	'tontoeysellbook',
	'https://cdn.anime-planet.com/characters/primary/hamtaro-1.jpg?t=1625777064'
);

SELECT * FROM seller;

-- Working example
DELETE FROM seller WHERE userid = 5;
SELECT * FROM seller;

-- Referential integrity violated example
DELETE FROM seller WHERE userid = 1;