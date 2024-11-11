-- ### 5. OTHER FEATURES SECTION ###

CREATE TYPE messageType AS ENUM('Text', 'Image');

CREATE TABLE searchHistory( -- 3NF matched /
    buyerId INTEGER NOT NULL,
    searchText VARCHAR(100) NOT NULL,
    CONSTRAINT SEARCHHISTORY_PK PRIMARY KEY (buyerId, searchText)
);

CREATE TABLE message( -- 3NF matched /
    messageId SERIAL NOT NULL,
    buyerId INTEGER NOT NULL,
    sellerId INTEGER NOT NULL,
    dateSent TIMESTAMP NOT NULL,
    dateRead TIMESTAMP,
    type messageType NOT NULL,
    imageURL TEXT,
    text TEXT,
    buyerSent BOOLEAN NOT NULL, -- Clarificaton from Data Dict required: How do we know buyer or seller?
    CONSTRAINT MESSAGE_PK PRIMARY KEY (messageId)
);