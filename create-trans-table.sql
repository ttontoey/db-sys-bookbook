-- ### 4. TRANSACTION SECTION ###

CREATE TYPE transStatus AS ENUM('Failed', 'Pending', 'Completed');
CREATE TYPE paymentMethod AS ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery', 'Apple Pay', 'Google Pay', 'Amazon Pay', 'Cryptocurrency', 'Gift Card', 'Alipay', 'WeChat Pay', 'Stripe', 'Venmo', 'Samsung Pay', 'Afterpay', 'Klarna', 'Payoneer', 'Mobile Money', 'CashApp');
CREATE TYPE shipMethod AS ENUM('Standard', 'Express');
CREATE TYPE failure AS ENUM('Buyer', 'Shipping', 'Other');

CREATE TABLE transaction(
    transactionId SERIAL NOT NULL,
    updatedOn TIMESTAMP,
    createdOn TIMESTAMP NOT NULL,
    buyerId INTEGER NOT NULL,
    paymentId INTEGER NOT NULL,
    postId INTEGER NOT NULL,
    status transStatus NOT NULL,
    detail TEXT,
    failType failure,
    CONSTRAINT TRANSACTION_PK PRIMARY KEY (transactionId)
);

CREATE TABLE evidence(
    transactionId INTEGER NOT NULL,
    evidenceURL TEXT NOT NULL,
    CONSTRAINT EVIDENCE_PK PRIMARY KEY (transactionId, evidenceURL)
);

CREATE TABLE payment(
    paymentId SERIAL NOT NULL,
    method paymentMethod NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    isPaid BOOLEAN NOT NULL,
    paidOn TIMESTAMP,
    hashId VARCHAR(100),
    CONSTRAINT PAYMENT_PK PRIMARY KEY (paymentId),
    CONSTRAINT PAYMENT_AMOUNT_POSITIVE CHECK (amount > 0)
);

CREATE TABLE shipment(
    shipmentId SERIAL NOT NULL,
    transactionId INTEGER NOT NULL,
    trackingURL TEXT,
    method shipMethod NOT NULL,
    isDelivered BOOLEAN NOT NULL,
    CONSTRAINT SHIPMENT_PK PRIMARY KEY (shipmentId, transactionId)
);