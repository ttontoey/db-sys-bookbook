-- ### 3. POST SECTION ###

CREATE TYPE bookSpecDesc AS ENUM('Author Signature', 'Limited Edition', 'First Edition', 'Special Cover Art', 'Illustrated Edition', 'Collector''s Edition', 'Slipcase Edition', 'Leather-Bound', 'Gilded Edges', 'Deckle Edges', 'Pop-Up Elements', 'Fold-Out Pages', 'Handwritten Notes by Author', 'Personalized Message', 'Numbered Edition', 'Exclusive Artwork', 'Embossed Cover', 'Gold Foil Stamping', 'Box Set', 'Anniversary Edition', 'Hardcover with Dust Jacket', 'Transparent Cover', 'Annotated Edition', 'Signed by Illustrator', 'Map Insert', 'Supplementary Materials', 'Exclusive Content', 'Fan Art Edition', 'Interactive Elements (e.g., Augmented Reality)', 'Bilingual Edition');

CREATE TABLE sellPost(
    postId SERIAL NOT NULL,
    createdOn TIMESTAMP NOT NULL,
    deletedOn TIMESTAMP,
    isApproved BOOLEAN NOT NULL,
    sellingPrice DECIMAL(10,2) NOT NULL,
    postOwner INTEGER NOT NULL,
    listedBook INTEGER NOT NULL,
    CONSTRAINT SELLPOSTPOST_PK PRIMARY KEY (postId),
    CONSTRAINT SELLPOSTPOST_PRICE_POSITIVE CHECK (sellingPrice > 0),
    CONSTRAINT SELLPOSTPOST_DELETE_AFTER_CREATED CHECK (deletedOn > createdOn)
);

CREATE TABLE specialDescription(
    postId INTEGER NOT NULL,
    specialDescription bookSpecDesc NOT NULL,
    CONSTRAINT SPECIALDESCRIPTION_PK PRIMARY KEY (postId, specialDescription)
);

CREATE TABLE damage(
    postId INTEGER NOT NULL,
    damagePictureURL TEXT NOT NULL,
    CONSTRAINT DAMAGE_PK PRIMARY KEY (postId, damagePictureURL)
);