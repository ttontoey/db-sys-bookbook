-- ### 5. OTHER FEATURES SECTION ###

CREATE TYPE messageType AS ENUM('Text', 'Image');
CREATE TYPE userType AS ENUM('Buyer', 'Seller');


CREATE TABLE searchHistory(
    buyerId INTEGER NOT NULL,
    searchText VARCHAR(100) NOT NULL,
    CONSTRAINT SEARCHHISTORY_PK PRIMARY KEY (buyerId, searchText)
);

CREATE TABLE message(
    messageId SERIAL NOT NULL,
    buyerId INTEGER NOT NULL,
    sellerId INTEGER NOT NULL,
    dateSent TIMESTAMP NOT NULL,
    dateRead TIMESTAMP,
    type messageType NOT NULL,
    imageURL TEXT,
    text TEXT,
    sender userType NOT NULL,
    CONSTRAINT MESSAGE_PK PRIMARY KEY (messageId),
    CONSTRAINT MESSAGE_READ_AFTER_SENT CHECK (dateRead > dateSent)
);
