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
)




