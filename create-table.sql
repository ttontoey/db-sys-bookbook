-- ### 1. USERS SECTION ###

CREATE TYPE titles AS ENUM('Mr.', 'Ms.', 'Mrs.');

-- 1.1.) Buyer

CREATE TYPE bookGenre AS ENUM('Fiction', 'Non-Fiction', 'Mystery', 'Thriller', 'Romance', 'Science Fiction', 'Fantasy', 'Historical Fiction', 'Horror', 'Biography', 'Memoir', 'Self-Help', 'Health & Wellness', 'Psychology', 'Poetry', 'Drama', 'Adventure', 'Children''s Literature', 'Young Adult', 'Graphic Novels/Comics', 'Crime', 'True Crime', 'Dystopian', 'Contemporary', 'Religious/Spiritual');

CREATE TABLE buyer(
    userId UUID NOT NULL DEFAULT uuid_generate_v4(),
    nameTitle titles NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    birthDate DATE NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    displayName VARCHAR(50) NOT NULL, -- Clarificaton from Data Dict required (Username -> Displayname?)
    profilePictureURL TEXT,
    KYCpicture TEXT,  -- Clarificaton from Data Dict required
    lastUpdatedOn TIMESTAMP NOT NULL, 
    isSuspended BOOLEAN NOT NULL, -- Clarificaton from Schema required
    CONSTRAINT BUYER_PK PRIMARY KEY (userId)
);

CREATE TABLE buyerContact(
    userId UUID NOT NULL,
    contact VARCHAR(100) UUID NOT NULL,
    CONSTRAINT BUYERCONTACT_PK PRIMARY KEY (userId, contact)
);

CREATE TABLE interestedGenre(
    buyerId UUID NOT NULL,
    genre bookGenre NOT NULL,
    CONSTRAINT INTERESTGENRE_PK PRIMARY KEY (buyerId, genre)
);

CREATE TABLE markedBook(
    buyerId UUID NOT NULL,
    bookId UUID NOT NULL,
    CONSTRAINT MARKEDBOOK_PK PRIMARY KEY (bookId, buyerId)
);

-- 1.2.) Seller

CREATE TABLE seller(
    userId UUID NOT NULL DEFAULT uuid_generate_v4(),
    nameTitle titles NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    birthDate DATE NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    displayName VARCHAR(50) NOT NULL, -- Clarificaton from Data Dict required (Username -> Displayname?)
    profilePictureURL TEXT,
    KYCpicture TEXT, -- Clarificaton from Data Dict required
    lastUpdatedOn TIMESTAMP NOT NULL,
    suspendedUntil TIMESTAMP, -- Clarificaton from Schema required
    isVerified BOOLEAN NOT NULL,
    verifiedBy UUID,
    CONSTRAINT SELLER_PK PRIMARY KEY (userId)
);

CREATE TABLE sellerContact(
    userId UUID NOT NULL,
    contact VARCHAR(100) UUID NOT NULL,
    CONSTRAINT SELLERCONTACT_PK PRIMARY KEY (userId, contact)
);

-- 1.3.) Admin

CREATE TABLE admin(
    userId UUID NOT NULL DEFAULT uuid_generate_v4(),
    nameTitle titles NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    birthDate DATE NOT NULL,
    SSN VARCHAR(20) NOT NULL,
    displayName VARCHAR(50) NOT NULL,
    profilePictureURL TEXT,
    KYCpicture TEXT,
    lastUpdatedOn TIMESTAMP NOT NULL,
    isSuspended BOOLEAN NOT NULL,
    CONSTRAINT ADMIN_PK PRIMARY KEY (userId)
);

CREATE TABLE adminContact(
    userId UUID NOT NULL,
    contact VARCHAR(100) NOT NULL,
    CONSTRAINT ADMINCONTACT_PK PRIMARY KEY (userId, contact)
);

-- ### 2. BOOK SECTION ###

CREATE TYPE bookTag AS ENUM('Bestseller', 'New Release', 'Classic', 'Award-Winning', 'Must-Read', 'Highly Recommended', 'Inspirational', 'Coming of Age', 'Family Saga', 'Historical', 'Dark Fantasy', 'Detective', 'LGBTQ+', 'Young Adult', 'Children''s Book', 'Short Stories', 'Mystery', 'Self-Help', 'Thriller', 'Romantic Comedy');
CREATE TYPE bookGenre AS ENUM('Fiction', 'Non-Fiction', 'Mystery', 'Thriller', 'Romance', 'Science Fiction', 'Fantasy', 'Historical Fiction', 'Horror', 'Biography', 'Memoir', 'Self-Help', 'Health & Wellness', 'Psychology', 'Poetry', 'Drama', 'Adventure', 'Children''s Literature', 'Young Adult', 'Graphic Novels/Comics', 'Crime', 'True Crime', 'Dystopian', 'Contemporary', 'Religious/Spiritual');


CREATE TABLE book(
    bookId UUID NOT NULL DEFAULT uuid_generate_v4(),
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    description TEXT,
    bookPhotoURL TEXT NOT NULL,
    ISBN VARCHAR(13),
    approvedOn TIMESTAMP,
    rejectedOn TIMESTAMP,
    isApproved BOOLEAN NOT NULL,
    approvedBy UUID,
    addedBy UUID,
    page INTEGER,
    CONSTRAINT BOOK_PK PRIMARY KEY (bookId)
);

CREATE TABLE bookGenre(
    bookId UUID NOT NULL,
    genre bookGenre NOT NULL,
    CONSTRAINT BOOKGENRE_PK PRIMARY KEY (bookId, genre)
);

CREATE TABLE bookTag(
    bookId UUID NOT NULL,
    tag bookTag NOT NULL,
    CONSTRAINT BOOKTAG_PK PRIMARY KEY (bookId, tag)
);

-- ### 3. POST SECTION ###

CREATE TYPE bookSpecDesc AS ENUM('Author Signature', 'Limited Edition', 'First Edition', 'Special Cover Art', 'Illustrated Edition', 'Collector''s Edition', 'Slipcase Edition', 'Leather-Bound', 'Gilded Edges', 'Deckle Edges', 'Pop-Up Elements', 'Fold-Out Pages', 'Handwritten Notes by Author', 'Personalized Message', 'Numbered Edition', 'Exclusive Artwork', 'Embossed Cover', 'Gold Foil Stamping', 'Box Set', 'Anniversary Edition', 'Hardcover with Dust Jacket', 'Transparent Cover', 'Annotated Edition', 'Signed by Illustrator', 'Map Insert', 'Supplementary Materials', 'Exclusive Content', 'Fan Art Edition', 'Interactive Elements (e.g., Augmented Reality)', 'Bilingual Edition');

CREATE TABLE sellPost(
    postId UUID NOT NULL DEFAULT uuid_generate_v4(),
    createdOn TIMESTAMP NOT NULL,
    deletedOn TIMESTAMP, -- Clarificaton from Data Dict required
    isApproved BOOLEAN NOT NULL,
    sellingPrice DECIMAL(10,2) NOT NULL,
    postOwner UUID NOT NULL,
    listedBook UUID NOT NULL,
    CONSTRAINT SELLPOST_PK PRIMARY KEY (postId)
);

CREATE TABLE specialDescription(
    postId UUID NOT NULL,
    specialDescription bookSpecDesc NOT NULL,
    CONSTRAINT SPECIALDESCRIPTION_PK PRIMARY KEY (postId, specialDescription)
);


CREATE TABLE damage(
    postId UUID NOT NULL,
    damagePictureURL TEXT NOT NULL, -- Data type not present in Data Dict
    CONSTRAINT DAMAGE_PK PRIMARY KEY (postId, damagePictureURL)
);

-- ### 4. TRANSACTION SECTION ###

CREATE TYPE transStatus AS ENUM('Failed', 'Pending', 'Completed');
CREATE TYPE paymentMethod AS ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery', 'Apple Pay', 'Google Pay', 'Amazon Pay', 'Cryptocurrency', 'Gift Card', 'Alipay', 'WeChat Pay', 'Stripe', 'Venmo', 'Samsung Pay', 'Afterpay', 'Klarna', 'Payoneer', 'Mobile Money', 'CashApp');
CREATE TYPE shipMethod AS ENUM('Standard', 'Express');

CREATE TABLE transaction(
    transactionId UUID NOT NULL DEFAULT uuid_generate_v4(),
    updatedOn TIMESTAMP,
    createdOn TIMESTAMP NOT NULL,
    buyerId UUID NOT NULL,
    paymentId UUID NOT NULL,
    postId UUID NOT NULL,
    status transStatus NOT NULL,
    detail TEXT NOT NULL, -- Data type not present in Data Dict
    failType TEXT NOT NULL, -- Data type not present in Data Dict
    CONSTRAINT TRANSACTION_PK PRIMARY KEY (transactionId)
);

CREATE TABLE evidence(
    transactionId UUID NOT NULL,
    evidenceURL TEXT NOT NULL, -- Data type not present in Data Dict,
    CONSTRAINT EVIDENCE_PK PRIMARY KEY (evidenceURL, transactionId)
);

CREATE TABLE payment(
    paymentId UUID NOT NULL DEFAULT uuid_generate_v4(),
    method paymentMethod NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    isPaid BOOLEAN NOT NULL,
    paidOn TIMESTAMP, -- Modified from Data Dict (Allowed NULL)
    hashId VARCHAR(100),
    currency CHAR(3) NOT NULL,
    CONSTRAINT PAYMENT_PK PRIMARY KEY (paymentId)
);

CREATE TABLE shipment(
    transactionId UUID NOT NULL,
    trackingURL TEXT,
    method shipMethod NOT NULL,
    isDelivered BOOLEAN NOT NULL,
    CONSTRAINT SHIPMENT_PK PRIMARY KEY (transactionId)

);

-- ### 5. OTHER FEATURES SECTION ###

CREATE TYPE messageType AS ENUM('Text', 'Image');

CREATE TABLE searchHistory(
    buyerId UUID NOT NULL,
    searchText VARCHAR(100) NOT NULL,
    CONSTRAINT SEARCHHISTORY_PK PRIMARY KEY (buyerId, searchText)
);

CREATE TABLE message(
    messageId UUID NOT NULL DEFAULT uuid_generate_v4(),
    buyerId UUID NOT NULL,
    sellerId UUID NOT NULL,
    dateSent TIMESTAMP NOT NULL,
    dateRead TIMESTAMP,
    type messageType NOT NULL,
    imageURL TEXT,
    text TEXT,
    sender UUID NOT NULL, -- Clarificaton from Data Dict required
    CONSTRAINT MESSAGE_PK PRIMARY KEY (messageId)
);


