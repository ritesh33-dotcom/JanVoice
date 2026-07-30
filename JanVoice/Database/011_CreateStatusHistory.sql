CREATE TABLE StatusHistory
(
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,

    ComplaintID INT NOT NULL,

    OldStatus NVARCHAR(30) NULL,

    NewStatus NVARCHAR(30) NOT NULL,

    ChangedBy INT NOT NULL,

    Remarks NVARCHAR(300) NULL,

    ChangeDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_StatusHistory_Complaints
        FOREIGN KEY (ComplaintID)
        REFERENCES Complaints(ComplaintID),

    CONSTRAINT FK_StatusHistory_Users
        FOREIGN KEY (ChangedBy)
        REFERENCES Users(UserID)
);

INSERT INTO StatusHistory
(
    ComplaintID,
    OldStatus,
    NewStatus,
    ChangedBy,
    Remarks
)
VALUES
(
    1,
    NULL,
    'Pending',
    3,
    'Complaint submitted successfully.'
);


INSERT INTO StatusHistory
(
    ComplaintID,
    OldStatus,
    NewStatus,
    ChangedBy,
    Remarks
)
VALUES
(
    1,
    'Pending',
    'Assigned',
    1,
    'Complaint assigned to Officer.'
);

INSERT INTO StatusHistory
(
    ComplaintID,
    OldStatus,
    NewStatus,
    ChangedBy,
    Remarks
)
VALUES
(
    1,
    'Assigned',
    'In Progress',
    2,
    'Work started.'
);


INSERT INTO StatusHistory
(
    ComplaintID,
    OldStatus,
    NewStatus,
    ChangedBy,
    Remarks
)
VALUES
(
    1,
    'In Progress',
    'Resolved',
    2,
    'Issue resolved successfully.'
);

SELECT *
FROM StatusHistory
WHERE ComplaintID = 1
ORDER BY ChangeDate;