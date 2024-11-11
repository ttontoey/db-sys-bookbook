-- ### 1. USERS SECTION ###

CREATE TYPE titles AS ENUM('Mr.', 'Ms.', 'Mrs.');

CREATE TABLE userInformation( -- 3NF not matched X /
    SSN VARCHAR(20) NOT NULL,
    nameTitle titles NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    KYCpicture TEXT,  -- Clarificaton from Data Dict required
    birthDate DATE NOT NULL

);

-- 1.1.) Buyer

CREATE TYPE genres AS ENUM('Fiction', 'Non-Fiction', 'Mystery', 'Thriller', 'Romance', 'Science Fiction', 'Fantasy', 'Historical Fiction', 'Horror', 'Biography', 'Memoir', 'Self-Help', 'Health & Wellness', 'Psychology', 'Poetry', 'Drama', 'Adventure', 'Children''s Literature', 'Young Adult', 'Graphic Novels/Comics', 'Crime', 'True Crime', 'Dystopian', 'Contemporary', 'Religious/Spiritual');

CREATE TABLE buyer( -- 3NF not matched X /
    userId SERIAL NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    userName VARCHAR(50) NOT NULL, -- Clarificaton from Data Dict required (Username -> Displayname?)
    profilePictureURL TEXT,
    lastUpdatedOn TIMESTAMP NOT NULL, 
    isSuspended BOOLEAN NOT NULL, -- Clarificaton from Schema required
    CONSTRAINT BUYER_PK PRIMARY KEY (userId)
);

CREATE TABLE buyerContact( -- 3NF matched /
    userId INTEGER NOT NULL,
    contact VARCHAR(100) NOT NULL,
    CONSTRAINT BUYERCONTACT_PK PRIMARY KEY (userId, contact)
);

CREATE TABLE interestedGenre( -- 3NF matched /
    userId INTEGER NOT NULL,
    genre genres NOT NULL,
    CONSTRAINT INTERESTGENRE_PK PRIMARY KEY (userId, genre)
);

CREATE TABLE markedBook( -- Wishlist 3NF matched /
    userId INTEGER NOT NULL,
    bookId INTEGER NOT NULL,
    CONSTRAINT MARKEDBOOK_PK PRIMARY KEY (userId, bookId)
);

-- 1.2.) Seller

CREATE TABLE seller( -- 3NF not matched X
    userId SERIAL NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    userName VARCHAR(50) NOT NULL, -- Clarificaton from Data Dict required (Username -> Displayname?)
    profilePictureURL TEXT,
    lastUpdatedOn TIMESTAMP NOT NULL,
    suspendedUntil TIMESTAMP, -- Clarificaton from Schema required
    isVerified BOOLEAN NOT NULL,
    verifiedBy INTEGER,
    CONSTRAINT SELLER_PK PRIMARY KEY (userId)
);

CREATE TABLE sellerContact( -- 3NF matched /
    userId INTEGER NOT NULL,
    contact VARCHAR(100) NOT NULL,
    CONSTRAINT SELLERCONTACT_PK PRIMARY KEY (userId, contact)
);

-- 1.3.) Admin

CREATE TABLE admin( -- 3NF not matched X
    userId SERIAL NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    displayName VARCHAR(50) NOT NULL,
    profilePictureURL TEXT,
    lastUpdatedOn TIMESTAMP NOT NULL,
    isSuspended BOOLEAN NOT NULL,
    CONSTRAINT ADMIN_PK PRIMARY KEY (userId)
);

CREATE TABLE adminContact( -- 3NF matched /
    userId INTEGER NOT NULL,
    contact VARCHAR(100) NOT NULL,
    CONSTRAINT ADMINCONTACT_PK PRIMARY KEY (userId, contact)
);