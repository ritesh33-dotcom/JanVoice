CREATE TABLE Feedback
(
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,

    UserID INT NOT NULL,

    Rating INT NOT NULL,

    Subject NVARCHAR(100) NOT NULL,

    Suggestion NVARCHAR(500) NOT NULL,

    FeedbackDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Feedback_Users
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID),

    CONSTRAINT CHK_Feedback_Rating
        CHECK (Rating BETWEEN 1 AND 5)
);


INSERT INTO Feedback
(
    UserID,
    Rating,
    Subject,
    Suggestion
)
VALUES
(
    3,
    5,
    'Excellent Platform',
    'The Community Feed feature is very useful. Please add Dark Mode support.'
);

SELECT * FROM Feedback;

SELECT AVG(CAST(Rating AS DECIMAL(3,2))) AS AverageRating
FROM Feedback;

