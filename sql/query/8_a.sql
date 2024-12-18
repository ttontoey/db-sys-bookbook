-- 8.A) SQL INSERT
-- Scenario: Posting new book selling
-- Note that sellingPrice must be strictly POSITIVE !

-- View all posts
SELECT * FROM sellpost;

-- Working example
INSERT INTO sellpost (postOwner, listedBook, sellingPrice)
VALUES (2, 2, 50);

SELECT * FROM sellpost;

-- Referential integrity violated example
INSERT INTO sellpost (postOwner, listedBook, sellingPrice)
VALUES (1000, 2, 10);

-- Constraint violated example
INSERT INTO sellpost (postOwner, listedBook, sellingPrice)
VALUES (2, 2, -10);

SELECT * FROM sellpost;