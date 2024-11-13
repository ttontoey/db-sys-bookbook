-- Scenario I: We want suspend seller and ALSO DISAPPROVE all of seller existing posts
CREATE PROCEDURE perm_suspend_seller(sellerid INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE seller
    SET issuspended = true
    WHERE userid = sellerid;
    UPDATE sellpost
    SET isapproved = false
    WHERE postowner = sellerid;
END;
$$;

-- Example Query: Suspending seller #4
CALL perm_suspend_seller(4);
SELECT * FROM seller;
SELECT * FROM sellpost;

-- Scenario II: Remove buyer, seller or admin contacts which contain certain text keyword
CREATE PROCEDURE remove_contact_with_keyword(keyword VARCHAR)
LANGUAGE plpgsql
AS $$
	DECLARE
	    deleted_seller INT := 0;
	    deleted_buyer INT := 0;
	    deleted_admin INT := 0;
	BEGIN
	    DELETE FROM sellercontact
	    WHERE contact LIKE '%' || keyword || '%';
	    GET DIAGNOSTICS deleted_seller = ROW_COUNT;
	
	    DELETE FROM buyercontact
	    WHERE contact LIKE '%' || keyword || '%';
	    GET DIAGNOSTICS deleted_buyer = ROW_COUNT;
	
	    DELETE FROM admincontact
	    WHERE contact LIKE '%' || keyword || '%';
	    GET DIAGNOSTICS deleted_admin = ROW_COUNT;
	
		RAISE NOTICE 'Deleted % row(s) from sellercontact, % row(s) from buyercontact, and % row(s) from admincontact where contact contains "%".',
	    deleted_seller, deleted_buyer, deleted_admin, keyword;
	END;
$$;

-- Example Query: Removing contact with mark888.com gambling site promotion
CALL remove_contact_with_keyword('mark888.com');