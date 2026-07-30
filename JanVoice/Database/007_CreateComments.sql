CREATE TABLE Comments
(
    CommentID INT IDENTITY(1,1) PRIMARY KEY,

    ComplaintID INT NOT NULL,

    UserID INT NOT NULL,

    Comment NVARCHAR(MAX) NOT NULL,

    CommentDate DATETIME NOT NULL DEFAULT GETDATE(),

    IsEdited BIT NOT NULL DEFAULT 0,

    CONSTRAINT FK_Comments_Complaints
        FOREIGN KEY (ComplaintID)
        REFERENCES Complaints(ComplaintID),

    CONSTRAINT FK_Comments_Users
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID)
);

INSERT INTO Comments
(
    ComplaintID,
    UserID,
    Comment
)
VALUES
(
    1,
    3,
    'The garbage has not been collected for several days.'
);

INSERT INTO Comments
(
    ComplaintID,
    UserID,
    Comment
)
VALUES
(
    1,
    2,
    'Our team has been assigned and work will begin shortly.'
);

SELECT * FROM Comments;