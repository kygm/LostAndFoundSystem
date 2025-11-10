
CREATE TABLE Users (
    UserId SERIAL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    UserType VARCHAR(20) NOT NULL CHECK (UserType IN ('Student', 'Staff', 'Admin')),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20),
    CONSTRAINT pkUsers PRIMARY KEY (UserId)
);

CREATE TABLE Items (
    ItemId SERIAL,
    Description TEXT NOT NULL,
    Category VARCHAR(50) NOT NULL,
    ImagePath VARCHAR(255),
    DatePosted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) CHECK (Status IN ('Lost', 'Found', 'Returned')) DEFAULT 'Lost',
    CONSTRAINT pkItems PRIMARY KEY (ItemId)
);

CREATE TABLE QrCodes (
    QrCodeId SERIAL,
    LocationId INT,
    QrCodePath VARCHAR(255) NOT NULL,
    CreatedOn TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pkQrCodes PRIMARY KEY (QrCodeId)
);

CREATE TABLE Locations (
    LocationId SERIAL,
    QrCodeId INT,
    BuildingName VARCHAR(100) NOT NULL,
    Description TEXT,
    CONSTRAINT pkLocations PRIMARY KEY (LocationId),
    CONSTRAINT fkLocationsQrCodes FOREIGN KEY (QrCodeId)
        REFERENCES QrCodes (QrCodeId)
        ON DELETE SET NULL
);

ALTER TABLE QrCodes
ADD CONSTRAINT fkQrCodesLocations FOREIGN KEY (LocationId)
    REFERENCES Locations (LocationId)
    ON DELETE SET NULL;


CREATE TABLE UserItems (
    UserItemId SERIAL,
    PostedByUserId INT NOT NULL,
    LocationId INT,
    ItemId INT NOT NULL,
    IsFound BOOLEAN NOT NULL DEFAULT FALSE,
    DatePosted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pkUserItems PRIMARY KEY (UserItemId),
    CONSTRAINT fkUserItemsUsers FOREIGN KEY (PostedByUserId)
        REFERENCES Users (UserId)
        ON DELETE CASCADE,
    CONSTRAINT fkUserItemsLocations FOREIGN KEY (LocationId)
        REFERENCES Locations (LocationId)
        ON DELETE SET NULL,
    CONSTRAINT fkUserItemsItems FOREIGN KEY (ItemId)
        REFERENCES Items (ItemId)
        ON DELETE CASCADE
);
