-- ### 1. USERS SECTION ###

CREATE TYPE titles AS ENUM('Mr.', 'Ms.', 'Mrs.');

CREATE TABLE userInformation(
    SSN VARCHAR(20) NOT NULL,
    nameTitle titles NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    KYCpicture TEXT NOT NULL,
    birthDate DATE NOT NULL,
    CONSTRAINT USERINFO_PK PRIMARY KEY (SSN)
);

-- 1.1.) Buyer

CREATE TYPE genres AS ENUM('Fiction', 'Non-Fiction', 'Mystery', 'Thriller', 'Romance', 'Science Fiction', 'Fantasy', 'Historical Fiction', 'Horror', 'Biography', 'Memoir', 'Self-Help', 'Health & Wellness', 'Psychology', 'Poetry', 'Drama', 'Adventure', 'Children''s Literature', 'Young Adult', 'Graphic Novels/Comics', 'Crime', 'True Crime', 'Dystopian', 'Contemporary', 'Religious/Spiritual');

CREATE TABLE buyer(
    userId SERIAL NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    userName VARCHAR(50) NOT NULL,
    profilePictureURL TEXT,
    lastUpdatedOn TIMESTAMP NOT NULL DEFAULT NOW()::timestamp(0), --
    isSuspended BOOLEAN NOT NULL DEFAULT false, --
    CONSTRAINT BUYER_PK PRIMARY KEY (userId),
    CONSTRAINT BUYER_UNIQUE_USERNAME UNIQUE (userName)
);

CREATE TABLE buyerContact(
    userId INTEGER NOT NULL,
    contact VARCHAR(100) NOT NULL,
    CONSTRAINT BUYERCONTACT_PK PRIMARY KEY (userId, contact)
);

CREATE TABLE interestedGenre(
    userId INTEGER NOT NULL,
    genre genres NOT NULL,
    CONSTRAINT INTERESTGENRE_PK PRIMARY KEY (userId, genre)
);

CREATE TABLE markedBook(
    userId INTEGER NOT NULL,
    bookId INTEGER NOT NULL,
    CONSTRAINT MARKEDBOOK_PK PRIMARY KEY (userId, bookId)
);

-- 1.2.) Seller

CREATE TABLE seller(
    userId SERIAL NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    userName VARCHAR(50) NOT NULL,
    profilePictureURL TEXT,
    lastUpdatedOn TIMESTAMP NOT NULL DEFAULT NOW()::timestamp(0), --
    isSuspended BOOLEAN NOT NULL DEFAULT false, -- !!
    suspendedUntil TIMESTAMP,
    isVerified BOOLEAN NOT NULL DEFAULT false, --
    verifiedBy INTEGER,
    CONSTRAINT SELLER_PK PRIMARY KEY (userId),
    CONSTRAINT SELLER_UNIQUE_USERNAME UNIQUE (userName)

);

CREATE TABLE sellerContact(
    userId INTEGER NOT NULL,
    contact VARCHAR(100) NOT NULL,
    CONSTRAINT SELLERCONTACT_PK PRIMARY KEY (userId, contact)
);

-- 1.3.) Admin

CREATE TABLE admin(
    userId SERIAL NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    userName VARCHAR(50) NOT NULL,
    profilePictureURL TEXT,
    lastUpdatedOn TIMESTAMP NOT NULL DEFAULT NOW()::timestamp(0), --
    isSuspended BOOLEAN NOT NULL DEFAULT false, --
    CONSTRAINT ADMIN_PK PRIMARY KEY (userId),
    CONSTRAINT ADMIN_UNIQUE_USERNAME UNIQUE (userName)

);

CREATE TABLE adminContact(
    userId INTEGER NOT NULL,
    contact VARCHAR(100) NOT NULL,
    CONSTRAINT ADMINCONTACT_PK PRIMARY KEY (userId, contact)
);

