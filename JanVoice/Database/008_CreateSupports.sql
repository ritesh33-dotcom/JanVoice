CREATE TABLE Supports
(
    SupportID INT IDENTITY(1,1) PRIMARY KEY,

    ComplaintID INT NOT NULL,

    UserID INT NOT NULL,

    SupportDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Supports_Complaints
        FOREIGN KEY (ComplaintID)
        REFERENCES Complaints(ComplaintID),

    CONSTRAINT FK_Supports_Users
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID),

    CONSTRAINT UQ_Supports_UserComplaint
        UNIQUE (ComplaintID, UserID)
);

INSERT INTO Supports
(
    ComplaintID,
    UserID
)
VALUES
(
    1,
    3
);

SELECT * FROM Supports;

SELECT COUNT(*) AS TotalSupports
FROM Supports
WHERE ComplaintID = 1;


