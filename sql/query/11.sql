-- Scenario I: We want to classify customer tier by their total spendings
CREATE FUNCTION buyer_tier(total_spent FLOAT)
	RETURNS VARCHAR(10)
	LANGUAGE plpgsql
	AS
$$
	DECLARE
		tier VARCHAR(10);
    BEGIN
		IF (total_spent = 0) THEN
			tier := 'Normal';
		ELSEIF (total_spent > 0 AND total_spent <= 100) THEN
			tier := 'Bronze';
		ELSEIF (total_spent > 100 AND total_spent <= 1000) THEN
			tier := 'Silver';
		ELSEIF (total_spent > 1000) THEN
			tier := 'Gold';
		END IF;
		RETURN (tier);
    END;
$$

-- Example Query: List and order customers by their tiers
SELECT userid, COALESCE(sum(amount), 0) total_spending,
buyer_tier(COALESCE(sum(amount), 0)) 
FROM buyer
	LEFT JOIN transaction AS t
	ON t.buyerid = buyer.userid
	LEFT JOIN payment AS p
	ON t.paymentid = p.paymentid
GROUP BY userid
ORDER BY total_spending DESC


-- Scenario II: We want to detect inappropriate text, gambling promotion in this case
CREATE FUNCTION gamble_inapprop_text(input_string text)
	RETURNS BOOLEAN
	LANGUAGE plpgsql
	AS
$$
DECLARE
    word_list text[] := ARRAY['พนัน', 'บาคาร่า', 'โอนไว', 'mark888'];
    word text;
BEGIN
    FOREACH word IN ARRAY word_list LOOP
        IF STRPOS(input_string, word) > 0 THEN
            RETURN TRUE;
        END IF;
    END LOOP;
    RETURN FALSE;
END;
$$

-- Example Query: Find sellers who promote gambling
SELECT DISTINCT addedBy AS userid, username 
FROM
	(SELECT *, gamble_inapprop_text(title) check1, 
	gamble_inapprop_text(description) check2 
	FROM book) AS temp
JOIN seller
ON seller.userid = temp.addedby
WHERE (check1 OR check2)