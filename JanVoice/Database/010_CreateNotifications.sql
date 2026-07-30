CREATE TABLE Notifications
(
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,

    UserID INT NOT NULL,

    ComplaintID INT NULL,

    Title NVARCHAR(100) NOT NULL,

    Message NVARCHAR(300) NOT NULL,

    NotificationType NVARCHAR(50) NOT NULL,

    IsRead BIT NOT NULL DEFAULT 0,

    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Notifications_Users
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Notifications_Complaints
        FOREIGN KEY (ComplaintID)
        REFERENCES Complaints(ComplaintID)
);

INSERT INTO Notifications
(
    UserID,
    ComplaintID,
    Title,
    Message,
    NotificationType
)
VALUES
(
    3,
    1,
    'Complaint Assigned',
    'Your complaint has been assigned to an officer.',
    'Complaint'
);

SELECT * FROM Notifications;

UPDATE Notifications
SET IsRead = 1
WHERE NotificationID = 1;

SELECT *
FROM Notifications
WHERE UserID = 3
AND IsRead = 0;