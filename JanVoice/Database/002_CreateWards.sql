CREATE TABLE Wards
(
    WardID INT IDENTITY(1,1) PRIMARY KEY,
    WardNumber INT NOT NULL UNIQUE,
    WardName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    IsActive BIT NOT NULL DEFAULT 1
);


INSERT INTO Wards (WardNumber, WardName, Description)
VALUES
(1, 'Ward 1', 'Central Area'),
(2, 'Ward 2', 'North Area'),
(3, 'Ward 3', 'South Area'),
(4, 'Ward 4', 'East Area'),
(5, 'Ward 5', 'West Area');

SELECT * FROM Wards;