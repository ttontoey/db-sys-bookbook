-- 13.) Execution Path
-- Scenario: Find sellers who are NOT suspended

-- Query I
SELECT username, ssn 
FROM seller
WHERE NOT isSuspended;

-- Query II
SELECT username, ssn 
FROM seller
WHERE userid IN
(SELECT userid FROM seller
WHERE NOT isSuspended);