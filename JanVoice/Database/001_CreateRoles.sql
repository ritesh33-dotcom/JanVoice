use JanVoiceDB;

-- 1) Roles Table

CREATE TABLE Roles
(
    RoleID INT PRIMARY KEY,
    RoleName NVARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO Roles (RoleID, RoleName)
VALUES
(1, 'Citizen'),
(2, 'Officer'),
(3, 'Admin');

SELECT * FROM Roles;