CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,
    Icon NVARCHAR(100) NULL,
    Description NVARCHAR(255) NULL,
    IsActive BIT NOT NULL DEFAULT 1
);

INSERT INTO Categories (CategoryName, Icon, Description)
VALUES
('Garbage', 'garbage.png', 'Garbage collection and overflow issues'),
('Road', 'road.png', 'Road damage and potholes'),
('Street Light', 'streetlight.png', 'Street light not working'),
('Water Leakage', 'water.png', 'Water leakage and pipeline issues'),
('Drainage', 'drainage.png', 'Drainage blockage and overflow'),
('Electricity', 'electricity.png', 'Electricity related issues'),
('Traffic Signal', 'traffic.png', 'Traffic signal malfunction'),
('Public Toilet', 'toilet.png', 'Public toilet maintenance'),
('Illegal Dumping', 'dumping.png', 'Illegal garbage dumping'),
('Other', 'other.png', 'Other civic issues');

SELECT * FROM Categories;