-- ### 2. BOOK SECTION ###

CREATE TYPE tags AS ENUM('Bestseller', 'New Release', 'Classic', 'Award-Winning', 'Must-Read', 'Highly Recommended', 'Inspirational', 'Coming of Age', 'Family Saga', 'Historical', 'Dark Fantasy', 'Detective', 'LGBTQ+', 'Young Adult', 'Children''s Book', 'Short Stories', 'Mystery', 'Self-Help', 'Thriller', 'Romantic Comedy');
CREATE TYPE genres AS ENUM('Fiction', 'Non-Fiction', 'Mystery', 'Thriller', 'Romance', 'Science Fiction', 'Fantasy', 'Historical Fiction', 'Horror', 'Biography', 'Memoir', 'Self-Help', 'Health & Wellness', 'Psychology', 'Poetry', 'Drama', 'Adventure', 'Children''s Literature', 'Young Adult', 'Graphic Novels/Comics', 'Crime', 'True Crime', 'Dystopian', 'Contemporary', 'Religious/Spiritual');

CREATE TABLE book(
    bookId SERIAL NOT NULL,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    description TEXT,
    bookPhotoURL TEXT NOT NULL,
    ISBN VARCHAR(13), 
    isApproved BOOLEAN NOT NULL,
    approvedOn TIMESTAMP, -- moderatedOn?
    rejectedOn TIMESTAMP,
    moderatedBy INTEGER,
    addedBy INTEGER,
    page INTEGER,
    CONSTRAINT BOOK_PK PRIMARY KEY (bookId),
    CONSTRAINT BOOK_PAGE_POSITIVE CHECK (page > 0)
);

CREATE TABLE bookGenre(
    bookId INTEGER NOT NULL,
    genre genres NOT NULL,
    CONSTRAINT BOOKGENRE_PK PRIMARY KEY (bookId, genre)
);

CREATE TABLE bookTag(
    bookId INTEGER NOT NULL,
    tag tags NOT NULL,
    CONSTRAINT BOOKTAG_PK PRIMARY KEY (bookId, tag)
);