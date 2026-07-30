CREATE TABLE EmergencyContacts
(
    ContactID INT IDENTITY(1,1) PRIMARY KEY,

    DepartmentName NVARCHAR(100) NOT NULL,

    ContactPerson NVARCHAR(100) NULL,

    PhoneNumber VARCHAR(15) NOT NULL,

    Email NVARCHAR(100) NULL,

    Address NVARCHAR(250) NULL,

    IsAvailable24x7 BIT NOT NULL DEFAULT 0,

    IsActive BIT NOT NULL DEFAULT 1,

    CreatedDate DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO EmergencyContacts
(
    DepartmentName,
    ContactPerson,
    PhoneNumber,
    Email,
    Address,
    IsAvailable24x7
)
VALUES
('Police', 'Police Control Room', '100', 'police@nagarbandhu.gov.in', 'Police Headquarters', 1),

('Ambulance', 'Emergency Medical Service', '108', 'ambulance@nagarbandhu.gov.in', 'District Hospital', 1),

('Fire Brigade', 'Fire Station Officer', '101', 'fire@nagarbandhu.gov.in', 'Central Fire Station', 1),

('Electricity Department', 'MSEB Office', '1912', 'electricity@nagarbandhu.gov.in', 'Electricity Office', 0),

('Water Supply Department', 'Water Department', '1800123456', 'water@nagarbandhu.gov.in', 'Municipal Office', 0),

('Municipal Corporation', 'Citizen Help Desk', '1800987654', 'help@nagarbandhu.gov.in', 'Municipal Corporation Office', 0);

SELECT * FROM EmergencyContacts;

SELECT *
FROM EmergencyContacts
WHERE IsActive = 1;

SELECT *
FROM EmergencyContacts
WHERE IsAvailable24x7 = 1;