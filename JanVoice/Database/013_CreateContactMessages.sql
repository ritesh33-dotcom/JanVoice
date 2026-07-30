CREATE TABLE ContactMessages
(
    MessageID INT IDENTITY(1,1) PRIMARY KEY,

    FullName NVARCHAR(100) NOT NULL,

    Email NVARCHAR(100) NOT NULL,

    Mobile VARCHAR(10) NULL,

    Subject NVARCHAR(150) NOT NULL,

    Message NVARCHAR(MAX) NOT NULL,

    IsReplied BIT NOT NULL DEFAULT 0,

    SubmittedDate DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO ContactMessages
(
    FullName,
    Email,
    Mobile,
    Subject,
    Message
)
VALUES
(
    'Ritesh Jadhav',
    'ritesh@example.com',
    '9876543212',
    'Feature Suggestion',
    'Please add Marathi language support in NagarBandhu.'
);

SELECT * FROM ContactMessages;

SELECT *
FROM ContactMessages
WHERE IsReplied = 0;

UPDATE ContactMessages
SET IsReplied = 1
WHERE MessageID = 1;