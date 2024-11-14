-- 12.) Triggers
-- Scenario I: Set buyer lastUpdatedOn field to CURRENT TIME whenever username OR profile picture is UPDATED
CREATE FUNCTION update_lastupdatedon()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS 
$$
	BEGIN
	    IF (NEW.username <> OLD.username) OR (NEW.profilepictureurl <> OLD.profilepictureurl) THEN
	        NEW.lastupdatedon := NOW()::timestamp(0);
	    END IF;
	    RETURN NEW;
	END;
$$;

CREATE TRIGGER update_lastupdatedon_trigger
BEFORE UPDATE ON buyer
FOR EACH ROW
EXECUTE FUNCTION update_lastupdatedon();

-- Example Query: Buyer username is changed
UPDATE buyer SET username = 'tontoeyngaeee'
WHERE userid = 3;

SELECT * FROM buyer;

-- Scenario II: Set transaction status to completed whenever book Shipment is delivered
CREATE OR REPLACE FUNCTION update_transaction_status()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.isdelivered = TRUE AND OLD.isdelivered = FALSE THEN
        UPDATE transaction
        SET status = 'Completed', failtype = null
        WHERE transactionid = NEW.transactionid;
    END IF;
    RETURN NEW;
END;
$$ 

CREATE TRIGGER trigger_update_trans_status
AFTER UPDATE OF isdelivered ON shipment
FOR EACH ROW
WHEN (NEW.isdelivered = TRUE)
EXECUTE FUNCTION update_transaction_status();

-- Example Query: Certain shipment is delivered
UPDATE shipment
SET isdelivered = true
WHERE shipmentid = 1;

SELECT * FROM transaction;
SELECT * FROM shipment;