use JanVoiceDB;
CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Mobile VARCHAR(10) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Address NVARCHAR(250) NULL,
    WardID INT NOT NULL,
    RoleID INT NOT NULL,
    ProfilePhoto NVARCHAR(255) NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Users_Wards
        FOREIGN KEY (WardID)
        REFERENCES Wards(WardID),

    CONSTRAINT FK_Users_Roles
        FOREIGN KEY (RoleID)
        REFERENCES Roles(RoleID)
);

SELECT * FROM Users;


INSERT INTO Users
(
    FullName,
    Email,
    Mobile,
    PasswordHash,
    Address,
    WardID,
    RoleID
)
VALUES
(
    'Admin User',
    'admin@nagarbandhu.com',
    '9876543210',
    'Admin@123',
    'Head Office',
    1,
    3
),
(
    'Officer One',
    'officer@nagarbandhu.com',
    '9876543211',
    'Officer@123',
    'Ward Office',
    2,
    2
),
(
    'Ritesh Jadhav',
    'ritesh@example.com',
    '9876543212',
    'Citizen@123',
    'Ward 5',
    5,
    1
);