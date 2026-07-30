CREATE TABLE Followers
(
    FollowerID INT IDENTITY(1,1) PRIMARY KEY,

    ComplaintID INT NOT NULL,

    UserID INT NOT NULL,

    FollowDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Followers_Complaints
        FOREIGN KEY (ComplaintID)
        REFERENCES Complaints(ComplaintID),

    CONSTRAINT FK_Followers_Users
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID),

    CONSTRAINT UQ_Followers_UserComplaint
        UNIQUE (ComplaintID, UserID)
);

INSERT INTO Followers
(
    ComplaintID,
    UserID
)
VALUES
(
    1,
    3
);

SELECT * FROM Followers;

SELECT COUNT(*) AS TotalFollowers
FROM Followers
WHERE ComplaintID = 1;