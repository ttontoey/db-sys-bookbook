-- Users

ALTER TABLE buyer ADD CONSTRAINT fk_1 FOREIGN KEY (SSN) REFERENCES userinformation(SSN);

ALTER TABLE interestedGenre ADD CONSTRAINT fk_1 FOREIGN KEY (userId) REFERENCES buyer(userId);

ALTER TABLE markedBook ADD CONSTRAINT fk_1 FOREIGN KEY (userId) REFERENCES buyer(userId);

ALTER TABLE buyerContact ADD CONSTRAINT fk_1 FOREIGN KEY (userId) REFERENCES buyer(userId);

ALTER TABLE seller ADD CONSTRAINT fk_1 FOREIGN KEY (SSN) REFERENCES userinformation(SSN);

ALTER TABLE seller ADD CONSTRAINT fk_2 FOREIGN KEY (verifiedBy) REFERENCES admin(userId);

ALTER TABLE admin ADD CONSTRAINT fk_1 FOREIGN KEY (SSN) REFERENCES userinformation(SSN);

ALTER TABLE admincontact ADD CONSTRAINT fk_1 FOREIGN KEY (userId) REFERENCES admin(userId);


-- Book

ALTER TABLE book ADD CONSTRAINT fk_1 FOREIGN KEY (addedBy) REFERENCES seller(userId);

ALTER TABLE book ADD CONSTRAINT fk_2 FOREIGN KEY (moderatedBy) REFERENCES admin(userId);

ALTER TABLE bookgenre ADD CONSTRAINT fk_1 FOREIGN KEY (bookId) REFERENCES book(bookId);

ALTER TABLE booktag ADD CONSTRAINT fk_1 FOREIGN KEY (bookId) REFERENCES book(bookId);


-- Post

ALTER TABLE sellpost ADD CONSTRAINT fk_1 FOREIGN KEY (postOwner) REFERENCES seller(userId);

ALTER TABLE sellpost ADD CONSTRAINT fk_2 FOREIGN KEY (listedBook) REFERENCES book(bookId);

ALTER TABLE specialdescription ADD CONSTRAINT fk_1 FOREIGN KEY (postId) REFERENCES sellpost(postId);

ALTER TABLE damage ADD CONSTRAINT fk_1 FOREIGN KEY (postId) REFERENCES sellpost(postId);


-- Transaction

ALTER TABLE transaction ADD CONSTRAINT fk_1 FOREIGN KEY (buyerId) REFERENCES buyer(userId);

ALTER TABLE transaction ADD CONSTRAINT fk_2 FOREIGN KEY (paymentId) REFERENCES payment(paymentId);

ALTER TABLE transaction ADD CONSTRAINT fk_3 FOREIGN KEY (postId) REFERENCES sellpost(postId);

ALTER TABLE evidence ADD CONSTRAINT fk_1 FOREIGN KEY (transactionId) REFERENCES transaction(transactionId);

ALTER TABLE shipment ADD CONSTRAINT fk_1 FOREIGN KEY (transactionId) REFERENCES transaction(transactionId);


-- Other features

ALTER TABLE message ADD CONSTRAINT fk_1 FOREIGN KEY (buyerId) REFERENCES buyer(userId);

ALTER TABLE message ADD CONSTRAINT fk_2 FOREIGN KEY (sellerId) REFERENCES seller(userId);

ALTER TABLE searchhistory ADD CONSTRAINT fk_1 FOREIGN KEY (buyerId) REFERENCES buyer(userId);

-- Serial setups

SELECT setval('admin_userid_seq', (SELECT MAX(userid) FROM admin));

SELECT setval('book_bookid_seq', (SELECT MAX(bookid) FROM book));

SELECT setval('buyer_userid_seq', (SELECT MAX(userid) FROM buyer));

SELECT setval('message_messageid_seq', (SELECT MAX(messageid) FROM message));

SELECT setval('payment_paymentid_seq', (SELECT MAX(paymentid) FROM payment));

SELECT setval('seller_userid_seq', (SELECT MAX(userid) FROM seller));

SELECT setval('sellpost_postid_seq', (SELECT MAX(postid) FROM sellpost));

SELECT setval('shipment_shipmentid_seq', (SELECT MAX(shipmentid) FROM shipment));

SELECT setval('transaction_transactionid_seq', (SELECT MAX(transactionid) FROM transaction));