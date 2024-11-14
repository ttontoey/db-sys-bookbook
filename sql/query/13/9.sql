
-- Scenario 1: On SellPost table, we frequently have to filter posts by postowner (viewing seller profile)
SELECT * FROM sellpost WHERE postowner = 1;

CREATE INDEX sellpost_postowner_idx 
ON sellpost USING btree (postowner);


-- Scenario 2: On SellPost table, we frequently have to filter post by listedbook (posts comparison for buyers)
SELECT * FROM sellpost WHERE listedbook = 7;

CREATE INDEX sellpost_listedbook_idx 
ON sellpost USING btree (listedbook);