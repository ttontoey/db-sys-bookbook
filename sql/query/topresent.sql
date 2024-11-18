-- > 8.A) INSERT a new post
INSERT INTO sellpost (postOwner, listedBook, sellingPrice)
VALUES (2, 2, 50);

SELECT * FROM sellpost;

-- Referential integrity violated example
INSERT INTO sellpost (postOwner, listedBook, sellingPrice)
VALUES (1000, 2, 10);

-- Constraint violated example
INSERT INTO sellpost (postOwner, listedBook, sellingPrice)
VALUES (2, 2, -10);

-- > 8.B) DELETE seller

INSERT INTO seller (email, password, ssn, username, profilepictureurl)
VALUES (
	'tontoeylnwzasellbook@gmail.com',
	'78590657fe72bb2e9d87a3f4f89d47e48ecd28dd42660c0c1c7ddb3ac286825f',
	'1112223334446',
	'tontoeysellbook',
	'https://cdn.anime-planet.com/characters/primary/hamtaro-1.jpg?t=1625777064'
);

-- Working example
DELETE FROM seller WHERE userid = 5;
SELECT * FROM seller;

-- Referential integrity violated example
DELETE FROM seller WHERE userid = 1;

-- > 8.C) UPDATE buyer username

-- Working example
UPDATE buyer SET username = 'bo0k'
WHERE userId = 2;

SELECT userid, email, ssn, username FROM buyer;

-- Referential integrity violated example
UPDATE buyer SET SSN = '1110000004444'
WHERE userId = 2;

-- Constraint violated example
UPDATE buyer SET username = 'farofaro'
WHERE userId = 2;

-- > 9.) Indexing
-- Viewing seller profile
SELECT * FROM sellpost WHERE postowner = 1;

-- Posts comparison for buyers
SELECT * FROM sellpost WHERE listedbook = 7;

-- > 10.) Stored Procedures
-- Suspending seller id 4 and disapprove all user posts
CALL perm_suspend_seller(4);
SELECT * FROM seller;
SELECT * FROM sellpost;

-- Removing contact with mark888.com gambling site promotion
CALL remove_contact_with_keyword('mark888.com');

-- 11.) Stored Functions
-- List and order customers by their tiers
SELECT userid, COALESCE(sum(amount), 0) total_spending,
buyer_tier(COALESCE(sum(amount), 0)) 
FROM buyer
	LEFT JOIN transaction AS t
	ON t.buyerid = buyer.userid
	LEFT JOIN payment AS p
	ON t.paymentid = p.paymentid
GROUP BY userid
ORDER BY total_spending DESC;

-- Find sellers who promote gambling
SELECT DISTINCT addedBy AS userid, username 
FROM
	(SELECT *, gamble_inapprop_text(title) check1, 
	gamble_inapprop_text(description) check2 
	FROM book) AS temp
JOIN seller
ON seller.userid = temp.addedby
WHERE (check1 OR check2);

-- 12.) Triggers
-- Buyer username is changed -> lastupdatedon is also updated
UPDATE buyer SET username = 'tontoeyngaeee'
WHERE userid = 3;

SELECT * FROM buyer;

-- Certain shipment is delivered -> transaction status = completed
UPDATE shipment
SET isdelivered = true
WHERE shipmentid = 1;

SELECT * FROM transaction;
SELECT * FROM shipment;

-- 13.) Execution Path Comparison
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


-- 14.) Complex Queries
-- Scenario I: We want to list buyer user (who has at least 1 payment) by their average discount percentage givens
SELECT buyerid, f firstname, l lastname, 
ROUND(AVG(((1 - c/b))), 3) * 100 avg_percent_discount 
FROM
	(
	SELECT transaction.buyerid AS buyerid, u.firstname f, u.lastname l, sellingprice b, amount c FROM transaction
	JOIN sellpost
	ON transaction.postid = sellpost.postid
	JOIN payment
	ON transaction.paymentid = payment.paymentid
	JOIN buyer
	ON transaction.buyerid = buyer.userid
	JOIN userinformation AS u
	ON buyer.ssn = u.ssn
	WHERE transaction.paymentid IS NOT NULL
	) AS temp
GROUP BY buyerid, f, l
ORDER BY SUM(ROUND((1 - c/b),4) * 100) DESC;

-- Scenario II: We want to find gambling promotion contents by sellers using any features on the platform
(SELECT sellerid, 'Message' feature, text 
FROM message
WHERE sender = 'Seller' AND gamble_inapprop_text(text))
UNION
(SELECT addedby sellerid, 'Book Description' feature, description
FROM book
WHERE gamble_inapprop_text(description))
UNION
(SELECT userid, 'Contact' feature, contact 
FROM sellercontact
WHERE gamble_inapprop_text(contact))
ORDER BY sellerid;

-- Scenario III: We want to find books with genre that interest buyers the most
SELECT title, genre
FROM book
JOIN bookgenre
ON book.bookid = bookgenre.bookid
WHERE genre 
IN
(
	SELECT genre 
	FROM interestedgenre
	GROUP BY genre
	HAVING COUNT(*) = (
	    SELECT MAX(genre_count) 
	    FROM (
	        SELECT COUNT(*) AS genre_count 
	        FROM interestedgenre
	        GROUP BY genre
	    ) AS temp
	)
);




