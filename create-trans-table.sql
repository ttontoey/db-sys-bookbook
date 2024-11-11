-- ### 4. TRANSACTION SECTION ###

CREATE TYPE transStatus AS ENUM('Failed', 'Pending', 'Completed');
CREATE TYPE paymentMethod AS ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery', 'Apple Pay', 'Google Pay', 'Amazon Pay', 'Cryptocurrency', 'Gift Card', 'Alipay', 'WeChat Pay', 'Stripe', 'Venmo', 'Samsung Pay', 'Afterpay', 'Klarna', 'Payoneer', 'Mobile Money', 'CashApp');
CREATE TYPE shipMethod AS ENUM('Standard', 'Express');

CREATE TABLE transaction( -- 3NF matched /
    transactionId SERIAL NOT NULL,
    updatedOn TIMESTAMP,
    createdOn TIMESTAMP NOT NULL,
    buyerId INTEGER NOT NULL,
    paymentId INTEGER NOT NULL,
    postId INTEGER NOT NULL,
    status transStatus NOT NULL,
    detail TEXT, -- Data type not present in Data Dict
    failType TEXT, -- Data type not present in Data Dict
    CONSTRAINT TRANSACTION_PK PRIMARY KEY (transactionId)
);

CREATE TABLE evidence( -- Should it link to payment? 3NF matched /
    transactionId INTEGER NOT NULL,
    evidenceURL TEXT NOT NULL, -- Data type not present in Data Dict,
    CONSTRAINT EVIDENCE_PK PRIMARY KEY (evidenceURL, transactionId)
);

CREATE TABLE payment( -- Why seperate table? 3NF matched /
    paymentId SERIAL NOT NULL,
    method paymentMethod NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    isPaid BOOLEAN NOT NULL,
    paidOn TIMESTAMP, -- Modified from Data Dict (Allowed NULL)
    hashId VARCHAR(100), -- Currency removed due to difficulty
    CONSTRAINT PAYMENT_PK PRIMARY KEY (paymentId)
);

CREATE TABLE shipment( -- 3NF matched /
    transactionId INTEGER NOT NULL,
    trackingURL TEXT,
    method shipMethod NOT NULL,
    isDelivered BOOLEAN NOT NULL,
    CONSTRAINT SHIPMENT_PK PRIMARY KEY (transactionId)
);