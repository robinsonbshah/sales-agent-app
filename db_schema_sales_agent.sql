-- Sales Agent App Database Schema (with FKs and normalization)
-- Drop tables if they exist (in reverse dependency order)
IF OBJECT_ID('Outlets', 'U') IS NOT NULL DROP TABLE Outlets;
IF OBJECT_ID('Area', 'U') IS NOT NULL DROP TABLE Area;
IF OBJECT_ID('Staff', 'U') IS NOT NULL DROP TABLE Staff;
IF OBJECT_ID('Zone', 'U') IS NOT NULL DROP TABLE Zone;
IF OBJECT_ID('Product', 'U') IS NOT NULL DROP TABLE Product;
IF OBJECT_ID('NepalDate', 'U') IS NOT NULL DROP TABLE NepalDate;

-- 1. Zone Table
CREATE TABLE Zone (
    ZoneID INT PRIMARY KEY IDENTITY(1,1),
    ZoneName NVARCHAR(100) NOT NULL UNIQUE,
    ZoneManagerName NVARCHAR(100) -- ASM or RSM
);

-- 2. Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    ZoneID INT NOT NULL, -- FK to Zone
    Role NVARCHAR(50),
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    PasswordHash NVARCHAR(255),
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (ZoneID) REFERENCES Zone(ZoneID)
);

-- 3. Area Table
CREATE TABLE Area (
    AreaID INT PRIMARY KEY IDENTITY(1,1),
    RouteName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    ZoneID INT NOT NULL, -- FK to Zone
    AssignedTo INT NOT NULL, -- FK to Staff (agent)
    FOREIGN KEY (ZoneID) REFERENCES Zone(ZoneID),
    FOREIGN KEY (AssignedTo) REFERENCES Staff(StaffID)
);

-- 4. Outlets Table
CREATE TABLE Outlets (
    OutletID INT PRIMARY KEY IDENTITY(1,1),
    OutletName NVARCHAR(150) NOT NULL,
    AreaID INT NOT NULL, -- FK to Area
    ZoneID INT NOT NULL, -- FK to Zone (redundant for fast lookup)
    Address NVARCHAR(200), -- Use Location from Area
    ZoneManagerName NVARCHAR(100), -- For reporting, can be filled from Zone
    OwnerName NVARCHAR(100),
    Category NVARCHAR(50),
    Class NVARCHAR(50),
    ContactNumber NVARCHAR(20),
    GPS_Latitude DECIMAL(10,7),
    GPS_Longitude DECIMAL(10,7),
    CreatedDate NVARCHAR(10), -- Nepali date
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID),
    FOREIGN KEY (ZoneID) REFERENCES Zone(ZoneID)
);

-- 5. Product Table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Unit NVARCHAR(20),
    Price DECIMAL(18,2),
    IsActive BIT DEFAULT 1
);

-- 6. NepalDate Table
CREATE TABLE NepalDate (
    NepalDateID INT PRIMARY KEY IDENTITY(1,1),
    DateAD DATE NOT NULL,
    DateBS NVARCHAR(10) NOT NULL -- 'yyyy-MM-dd' (e.g., '2082-02-20')
);

-- Add more tables (Attendance, Orders, Returns, Payments, etc.) as needed, following the same FK and normalization principles. 