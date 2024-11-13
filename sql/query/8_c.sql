-- 8.C) SQL UPDATE
-- Scenario: Changing buyer username
-- Note that username must be UNIQUE !

-- View buyer usernames
SELECT userid, email, ssn, username FROM buyer;

-- Working example
UPDATE buyer SET username = 'bo0k'
WHERE userId = 2;

SELECT userid, email, ssn, username FROM buyer;

-- Constraint violated example
UPDATE buyer SET username = 'farofaro'
WHERE userId = 2;