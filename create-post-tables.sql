-- ### 3. POST SECTION ###

CREATE TYPE bookSpecDesc AS ENUM('Author Signature', 'Limited Edition', 'First Edition', 'Special Cover Art', 'Illustrated Edition', 'Collector''s Edition', 'Slipcase Edition', 'Leather-Bound', 'Gilded Edges', 'Deckle Edges', 'Pop-Up Elements', 'Fold-Out Pages', 'Handwritten Notes by Author', 'Personalized Message', 'Numbered Edition', 'Exclusive Artwork', 'Embossed Cover', 'Gold Foil Stamping', 'Box Set', 'Anniversary Edition', 'Hardcover with Dust Jacket', 'Transparent Cover', 'Annotated Edition', 'Signed by Illustrator', 'Map Insert', 'Supplementary Materials', 'Exclusive Content', 'Fan Art Edition', 'Interactive Elements (e.g., Augmented Reality)', 'Bilingual Edition');

CREATE TABLE sellPost( -- 3NF matched /
    postId SERIAL NOT NULL,
    createdOn TIMESTAMP NOT NULL,
    deletedOn TIMESTAMP, -- Clarificaton from Data Dict required
    isApproved BOOLEAN NOT NULL,
    sellingPrice DECIMAL(10,2) NOT NULL,
    postOwner INTEGER NOT NULL,
    listedBook INTEGER NOT NULL,
    CONSTRAINT SELLPOST_PK PRIMARY KEY (postId)
);

CREATE TABLE specialDescription( -- 3NF matched /
    postId INTEGER NOT NULL,
    specialDescription bookSpecDesc NOT NULL,
    CONSTRAINT SPECIALDESCRIPTION_PK PRIMARY KEY (postId, specialDescription)
);

CREATE TABLE damage( -- 3NF matched /
    postId INTEGER NOT NULL,
    damagePictureURL TEXT NOT NULL, -- Data type not present in Data Dict
    CONSTRAINT DAMAGE_PK PRIMARY KEY (postId, damagePictureURL)
);