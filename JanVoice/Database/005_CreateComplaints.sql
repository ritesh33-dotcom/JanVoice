use JanVoiceDB;
CREATE TABLE Complaints
(
    ComplaintID INT IDENTITY(1,1) PRIMARY KEY,

    UserID INT NOT NULL,
    CategoryID INT NOT NULL,
    WardID INT NOT NULL,

    AssignedOfficerID INT NULL,

    Title NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,

    Latitude DECIMAL(10,8) NULL,
    Longitude DECIMAL(11,8) NULL,

    Landmark NVARCHAR(200) NULL,

    Status NVARCHAR(30) NOT NULL DEFAULT 'Pending',

    Priority NVARCHAR(20) NOT NULL DEFAULT 'Medium',

    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),

    UpdatedDate DATETIME NULL,

    CONSTRAINT FK_Complaints_User
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Complaints_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID),

    CONSTRAINT FK_Complaints_Ward
        FOREIGN KEY (WardID)
        REFERENCES Wards(WardID),

    CONSTRAINT FK_Complaints_Officer
        FOREIGN KEY (AssignedOfficerID)
        REFERENCES Users(UserID)
);





INSERT INTO Complaints
(
    UserID,
    CategoryID,
    WardID,
    AssignedOfficerID,
    Title,
    Description,
    Latitude,
    Longitude,
    Landmark
)
VALUES
(
    3,
    1,
    5,
    2,
    'Garbage Overflow Near Bus Stop',
    'Garbage has not been collected for several days and it is causing a bad smell.',
    17.659900,
    75.906400,
    'Near Main Bus Stop'
);

SELECT * FROM Complaints;