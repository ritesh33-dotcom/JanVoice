CREATE TABLE ComplaintImages
(
    ImageID INT IDENTITY(1,1) PRIMARY KEY,

    ComplaintID INT NOT NULL,

    UploadedBy INT NOT NULL,

    ImagePath NVARCHAR(255) NOT NULL,

    ImageType NVARCHAR(20) NOT NULL DEFAULT 'Complaint',

    UploadDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_ComplaintImages_Complaints
        FOREIGN KEY (ComplaintID)
        REFERENCES Complaints(ComplaintID),

    CONSTRAINT FK_ComplaintImages_Users
        FOREIGN KEY (UploadedBy)
        REFERENCES Users(UserID)
);



INSERT INTO ComplaintImages
(
    ComplaintID,
    UploadedBy,
    ImagePath,
    ImageType
)
VALUES
(
    1,
    3,
    'Uploads/Complaints/garbage1.jpg',
    'Complaint'
);

SELECT * FROM ComplaintImages;