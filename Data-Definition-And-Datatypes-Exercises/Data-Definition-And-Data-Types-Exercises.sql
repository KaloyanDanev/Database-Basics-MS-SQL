/********************************************
	Problem 1. Create Database
*********************************************/

CREATE DATABASE Minions
GO
USE Minions

/********************************************
	Problem 2. Create Tables
*********************************************/

CREATE TABLE Minions(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR,
Age INT,
TownId INT FOREIGN KEY REFERENCES Minions(Id)
)

CREATE TABLE Towns(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR
)

/********************************************
	Problem 3. Alter Minions Table
*********************************************/

ALTER TABLE Minions
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL

/********************************************
	Problem 4. Insert Records in Both Tables
*********************************************/

INSERT INTO Towns (Id, Name)
VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions (Id, Name, Age, TownId)
VALUES 
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

/********************************************
	Problem 5. Truncate Table Minions
*********************************************/

TRUNCATE TABLE Minions

/********************************************
	Problem 6. Drop All Tables
*********************************************/

DROP TABLE Minions

DROP TABLE Towns

/********************************************
	Problem 7. Create Table People
*********************************************/

CREATE TABLE People(
Id INT UNIQUE IDENTITY,
Name NVARCHAR(200) NOT NULL,
Picture VARBINARY(MAX),
Height FLOAT(2),
Weight FLOAT(2),
Gender CHAR(1) NOT NULL,
Birthdate DATE NOT NULL,
Biography NVARCHAR(MAX),
CONSTRAINT PK_People PRIMARY KEY(Id)
)

INSERT INTO People(Name,Picture,Height,Weight,Gender,Birthdate,Biography)
VALUES
('Kiro', 0231, 1.77, 66.32,'m','1985/02/17', 'Kiros Bio'),
('Minka', 230255, 1.65, 54.51,'f','1995/05/22', 'Minkas Bio'),
('Ivo', 02314, 1.95, 98.31,'m','1982/10/05', 'Ivos Bio'),
('Mitio', 04215151, 2.21, 124.55,'m','1992/11/09', 'Mitios Bio'),
('Vancheto', 3215161, 1.98, 84.64,'f','1977/04/11', 'Vanchetos Bio')

/********************************************
	Problem 8. Create Table Users
*********************************************/

CREATE TABLE Users(
Id INT UNIQUE IDENTITY,
Username NVARCHAR(30) UNIQUE NOT NULL,
Password NVARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(900) ,
LastLoginTime DATETIME,
IsDeleted bit DEFAULT 0,
CONSTRAINT PK_Users PRIMARY KEY(Id)
)

INSERT INTO USERS(Username,Password,ProfilePicture,LastLoginTime,IsDeleted)
VALUES
('Kiro','123456',00465,'2018/01/18 21:01:50',1),
('Minka','qwerty',41216,'2018/03/21 03:12:10',0),
('Ivo', '123qwe',93453,'2018/02/03 03:12:10',0),
('Mitio', '321ewq',00532,'2013/01/12 22:41:55',1),
('Vancheto','qweasdzxc',05326,'2015/01/22 21:33:10',1)

/********************************************
	Problem 9. Change Primary Key
*********************************************/

ALTER TABLE Users DROP CONSTRAINT PK_Users

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username)

/********************************************
	Problem 10. Add Check Constraint
*********************************************/

ALTER TABLE Users
ADD CONSTRAINT CHK_Users_Password CHECK (LEN(Password) >= 5)

/********************************************
	Problem 11. Set Default Value of a Field
*********************************************/

ALTER TABLE Users
ADD CONSTRAINT DEF_Users_LastLogin DEFAULT getdate() FOR LastLoginTime

/********************************************
	Problem 12. Set Unique Field
*********************************************/

ALTER TABLE Users DROP CONSTRAINT PK_Users

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY(Id)

ALTER TABLE Users
ADD CONSTRAINT CK_Users_UserName CHECK (LEN(UserName) >= 3)

/********************************************
	Problem 13. Movies Database
*********************************************/

CREATE TABLE Directors (
Id int NOT NULL IDENTITY,
DirectorName NVARCHAR NOT NULL UNIQUE,
Notes NVARCHAR,
CONSTRAINT PK_Directors PRIMARY KEY (Id)
)

CREATE TABLE Genres (
Id int NOT NULL IDENTITY,
GenreName NVARCHAR NOT NULL UNIQUE,
Notes NVARCHAR,
CONSTRAINT PK_Genres PRIMARY KEY (Id)
)

CREATE TABLE Categories (
Id int NOT NULL IDENTITY,
CategoryName NVARCHAR NOT NULL UNIQUE,
Notes NVARCHAR,
CONSTRAINT PK_Categories PRIMARY KEY (Id)
)

CREATE TABLE Movies (
Id int NOT NULL IDENTITY,
Title NVARCHAR(200) NOT NULL UNIQUE,
DirectorId INT NOT NULL,
CopyrightYear INT NOT NULL,
Length INT NOT NULL,
GenreId INT NOT NULL, 
CategoryId INT NOT NULL, 
Rating NUMERIC(2, 1), 
Notes NVARCHAR,
CONSTRAINT PK_Movies PRIMARY KEY (Id),
CONSTRAINT FK_Movies_Directors FOREIGN KEY (DirectorId) REFERENCES Directors (Id),
CONSTRAINT FK_Movies_Genres FOREIGN KEY (GenreId) REFERENCES Genres (Id),
CONSTRAINT FK_Movies_Categories FOREIGN KEY (CategoryId) REFERENCES Categories (Id),
CONSTRAINT CK_Movies_CopyrightYear CHECK (CopyrightYear >= 1900),
CONSTRAINT CK_Movies_Rating CHECK (Rating > 0 AND Rating <= 10),
CONSTRAINT CK_Movies_Length CHECK (Length > 0)	
)

INSERT INTO Directors (DirectorName, Notes)
VALUES
('Явор Гърдев', 'Изключителен български режисьор'),
('Christopher Nolan', 'Best known for his cerebral, often nonlinear story-telling'),
('Susanne Bier', 'Known for In a Better World (2010), After the Wedding (2006) and Brothers (2004).'),
('Kathryn Bigelow', 'Director of The Hurt Locker'),
('Ridley Scott', 'His reputation remains solidly intact.')

INSERT INTO Genres (GenreName)
VALUES
('Drama'),('History'),('Thriller'),('Romance'),('Sci-Fi')

INSERT INTO Categories (CategoryName)
VALUES
('R'),('PG-13'),('PG-18'),('Avoid at all cost'),('Hmmmm')

INSERT INTO Movies (Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
VALUES
('Gladiator', 5, 2000, 155, 1, 1, 8.5, NULL),
('The Prestige', 2, 2006, 130, 5, 2, 8.5, 'One of my favourite movies'),
('The Hurt Locker', 4, 2008, 131, 3, 1, 7.6, NULL),
('After the Wedding', 3, 2006, 155, 1, 1, 7.8, 'Amazing performance from everyone'),
('Дзифт', 1, 2008, 120, 1, 1, 7.4, NULL)

 /********************************************
	Problem 14. Car Rental Database
 *********************************************/

CREATE TABLE Categories (
Id int NOT NULL IDENTITY, 
Category nvarchar(200) NOT NULL UNIQUE, 
DailyRate money CHECK (DailyRate >= 0), 
WeeklyRate money CHECK (WeeklyRate >= 0), 
MonthlyRate money CHECK (MonthlyRate >= 0), 
WeekendRate money CHECK (WeekendRate >= 0),
PRIMARY KEY (Id)
)

CREATE TABLE Cars (
Id int NOT NULL IDENTITY, 
PlateNumber varchar(10) NOT NULL UNIQUE, 
Make varchar(200) NOT NULL, 
Model varchar(200) NOT NULL, 
CarYear int NOT NULL CHECK (CarYear >= 1900), 
CategoryId int NOT NULL, 
Doors int NOT NULL CHECK (Doors > 0 AND Doors <= 5), 
Picture varbinary(max),
Condition nvarchar(200),
Available bit,
PRIMARY KEY (Id),
FOREIGN KEY (CategoryId) REFERENCES Categories (Id)
)

CREATE TABLE Employees (
Id int NOT NULL IDENTITY,
FirstName nvarchar(200) NOT NULL, 
LastName nvarchar(200) NOT NULL, 
Title nvarchar(200) NOT NULL, 
Notes nvarchar(max),
PRIMARY KEY (Id)
)

CREATE TABLE Customers (
Id int NOT NULL IDENTITY,
DriverLicenceNumber varchar(200) NOT NULL, 
FullName nvarchar(200) NOT NULL, 
Address nvarchar(max) NOT NULL, 
City nvarchar(200) NOT NULL, 
ZIPCode varchar(50) NOT NULL, 
Notes nvarchar(max),
PRIMARY KEY (Id)
)

CREATE TABLE RentalOrders(
Id int NOT NULL IDENTITY,
EmployeeId int NOT NULL,
CustomerId int NOT NULL,
CarId int NOT NULL,
CarCondition nvarchar(200) NOT NULL,
TankLevel float NOT NULL,
KilometrageStart float NOT NULL,
KilometrageEnd float NOT NULL,
TotalKilometrage float NOT NULL,
StartDate date NOT NULL,
EndDate date NOT NULL,
TotalDays int NOT NULL,
RateApplied money NOT NULL,
TaxRate money NOT NULL,
OrderStatus nvarchar(200) NOT NULL,
Notes nvarchar(max),
PRIMARY KEY (Id),
FOREIGN KEY (EmployeeId) REFERENCES Employees (Id),
FOREIGN KEY (CustomerId) REFERENCES Customers (Id),
FOREIGN KEY (CarId) REFERENCES Cars (Id),
CHECK (TotalKilometrage = KilometrageEnd - KilometrageStart),
CHECK (TotalDays = DATEDIFF(day, StartDate, EndDate) + 1)
)

INSERT INTO Categories (Category, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
('Economy', 15, 50, 1000, 40),
('Standard', 80, 500, 2000, 200),
('Premium', 100, NULL, NULL, NULL)

INSERT INTO Cars (PlateNumber, Make, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
('CA12345XB', 'Sedan', 'Renault', 2016, 1, 4, 0101010, 'Excellent', 1),
('TT4444TT', 'SUV', 'VW', 2016, 1, 4, 111000, 'Outstanding', 1),
('VV5555HH', 'Sedan', 'Mercedes', 2016, 3, 4, 01111, 'Excellent', 0)
	
INSERT INTO Employees (FirstName, LastName, Title)
VALUES
('Tom', 'Barnes', 'Sales Representative'),
('David', 'Jones', 'CEO'),
('Eva', 'Michado', 'Software developer')

INSERT INTO Customers (DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
VALUES
('A111111', 'Angela MErkel', 'Willy-Brandt-Strasse 1', 'Berlin', '10557', 'New leader of the free world'),
('B222222', 'Barack Obama', '1600 Pennsylvania Ave NW', 'Washington', 'DC 20500', 'Previous leader of the free world'),
('C333333', 'Bill Clinton', '555 Bloomberg Avenue', 'New York', 'NY 1000', NULL)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, CarCondition, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES
(1, 1, 1, 'Excellent', 100, 30100, 30200.5, 100.5, '2017-01-22', '2017-01-22', 1, 15, 0.20, 'Rented', NULL),
(2, 2, 2, 'Returned with damages', 100, 30100, 30250.5, 150.5, '2017-01-20', '2017-01-22', 3, 80, 0.20, 'Pending', 'TBD'),
(3, 3, 3, 'Excellent', 100, 30000, 30200.5, 200.5, '2017-01-21', '2017-01-22', 2, 110, 0.20, 'Closed', NULL)

 /********************************************
	Problem 15. Hotel Database
 *********************************************/

CREATE TABLE Employees (
	Id int IDENTITY,
	FirstName nvarchar(200) NOT NULL, 
	LastName nvarchar(200) NOT NULL, 
	Title nvarchar(200) NOT NULL, 
	Notes nvarchar(max),
	PRIMARY KEY (Id)
)

CREATE TABLE Customers (
	AccountNumber int IDENTITY,
	FirstName nvarchar(200) NOT NULL, 
	LastName nvarchar(200) NOT NULL, 
	PhoneNumber bigint NOT NULL,
	EmergencyName nvarchar(200),
	EmergencyNumber bigint,
	Notes nvarchar(max),
	PRIMARY KEY (AccountNumber),
	CHECK (PhoneNumber > 0)
)

CREATE TABLE RoomStatus (
	RoomStatus nvarchar(200) NOT NULL UNIQUE, 
	Notes nvarchar(max),
	PRIMARY KEY (RoomStatus)
)

CREATE TABLE RoomTypes (
	RoomType nvarchar(200) NOT NULL UNIQUE, 
	Notes nvarchar(max),
	PRIMARY KEY (RoomType)
)

CREATE TABLE BedTypes (
	BedType nvarchar(200) NOT NULL UNIQUE, 
	Notes nvarchar(max),
	PRIMARY KEY (BedType)
)

CREATE TABLE Rooms (
	RoomNumber int IDENTITY,
	RoomType nvarchar(200) NOT NULL,
	BedType nvarchar(200) NOT NULL,
	Rate money NOT NULL,
	RoomStatus nvarchar(200) NOT NULL,
	Note nvarchar(max),
	PRIMARY KEY (RoomNumber),
	FOREIGN KEY (RoomType) REFERENCES RoomTypes (RoomType),
	FOREIGN KEY (BedType) REFERENCES BedTypes (BedType),
	FOREIGN KEY (RoomStatus) REFERENCES RoomStatus (RoomStatus),
	CHECK (Rate >= 0)	
)

CREATE TABLE Payments (
	Id int IDENTITY, 
	EmployeeId int NOT NULL, 
	PaymentDate date NOT NULL, 
	AccountNumber int NOT NULL, 
	FirstDateOccupied date NOT NULL, 
	LastDateOccupied date NOT NULL, 
	TotalDays int NOT NULL, 
	AmountCharged money NOT NULL, 
	TaxRate money NOT NULL, 
	TaxAmount money NOT NULL, 
	PaymentTotal money NOT NULL, 
	Notes nvarchar(max),
	PRIMARY KEY (Id),
	FOREIGN KEY (EmployeeId) REFERENCES Employees (Id),
	FOREIGN KEY (AccountNumber) REFERENCES Customers (AccountNumber),
	CHECK (TotalDays = DATEDIFF(day, FirstDateOccupied, LastDateOccupied)),
	--drop the next 2 TaxRate ralated constraints before a TaxRate update (Problem 23)
	CONSTRAINT CK_Payments_TaxAmount CHECK (TaxAmount = AmountCharged * TaxRate), 
	CONSTRAINT CK_Payments_PaymentTotal CHECK (PaymentTotal = AmountCharged + TaxAmount)
)

CREATE TABLE Occupancies (
	Id int IDENTITY, 
	EmployeeId int NOT NULL, 
	DateOccupied date NOT NULL, 
	AccountNumber int NOT NULL, 
	RoomNumber int NOT NULL, 
	RateApplied money NOT NULL, 
	PhoneCharge money NOT NULL DEFAULT 0, 
	Notes nvarchar(max),
	PRIMARY KEY (Id),
	FOREIGN KEY (EmployeeId) REFERENCES Employees (Id),
	FOREIGN KEY (AccountNumber) REFERENCES Customers (AccountNumber),
	FOREIGN KEY (RoomNumber) REFERENCES Rooms (RoomNumber),
	CHECK (PhoneCharge >= 0)
)

INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
	('Tom', 'Barnes', 'Hotel Manager', NULL),
	('David', 'Jones', 'CEO', NULL),
	('Eva', 'Michado', 'Chambermaid', 'Late for work')
	
INSERT INTO Customers (FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber)
VALUES
	('Angela','Merkel', 49123456789, 'Barroso', 32987654321),
	('Barack','Obama', 1123456789, NULL, NULL),
	('Margaret','Thacher', 41987654321, NULL, NULL)

INSERT INTO RoomStatus (RoomStatus)
VALUES
	('Reserved'), ('Occupied'), ('Available')

INSERT INTO RoomTypes (RoomType)
VALUES
	('Single'), ('Double'), ('Suite')

INSERT INTO BedTypes (BedType)
VALUES
	('Single'), ('Twin'), ('Double')

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus)
VALUES
	('Single', 'Single', 70, 'Reserved'),
	('Double', 'Twin', 100, 'Occupied'),
	('Suite', 'Double', 110, 'Available')

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal)
VALUES
	(1, '2017-01-22', 1, '2017-01-21', '2017-01-22', 1, 100, 0.20, 20, 120),
	(1, '2017-01-22', 2, '2017-01-20', '2017-01-22', 2, 200, 0.20, 40, 240),
	(1, '2017-01-22', 3, '2017-01-19', '2017-01-22', 3, 300, 0.20, 60, 360)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge)
VALUES
	(1, '2014-01-22', 1, 1, 70, 0),
	(2, '2014-01-22', 2, 2, 100, 0),
	(3, '2014-01-22', 3, 3, 110, 10)

 /********************************************
	Problem 16. Create SoftUni Database
 *********************************************/

CREATE DATABASE SoftUni;
GO

USE SoftUni

CREATE TABLE Towns(
Id INT IDENTITY,
Name NVARCHAR NOT NULL,
CONSTRAINT PK_Towns PRIMARY KEY (Id)
)

CREATE TABLE Addresses(
Id INT IDENTITY,
AddressText NVARCHAR NOT NULL,
TownId INT NOT NULL,
CONSTRAINT PK_Addresses PRIMARY KEY (Id),
CONSTRAINT FK_Addresses_Towns FOREIGN KEY (TownId) REFERENCES Towns (Id)
)

CREATE TABLE Departments (
Id INT IDENTITY, 
Name NVARCHAR NOT NULL,
CONSTRAINT PK_Departments PRIMARY KEY (Id)
)

CREATE TABLE Employees(
Id INT IDENTITY,
FirstName NVARCHAR NOT NULL,
MiddleName NVARCHAR NOT NULL,
LastName NVARCHAR NOT NULL,
JobTitle NVARCHAR NOT NULL,
DepartmentId INT NOT NULL,
HireDate DATE NOT NULL,
Salary FLOAT NOT NULL,
AddressId INT,
CONSTRAINT PK_Employees PRIMARY KEY (Id),
CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentId) REFERENCES Departments (Id),
CONSTRAINT FK_Employees_Addresses FOREIGN KEY (AddressId) REFERENCES Addresses (Id),
)

/********************************************
	Problem 17. Backup Database
*********************************************/

BACKUP DATABASE SoftUni TO DISK = 'D:\softuni-backup.bak'

USE CarRental

DROP DATABASE SoftUni

RESTORE DATABASE SoftUni FROM DISK = 'D:\softuni-backup.bak'

/********************************************
	Problem 19. Basic Insert
*********************************************/

INSERT INTO Towns (Name)
VALUES
('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas')

INSERT INTO Departments (Name)
VALUES
('Engineering'), 
('Sales'), 
('Marketing'), 
('Software Development'), 
('Quality Assurance')

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013/02/01', 3500.00), 
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004/03/02', 4000.00), 
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016/08/28', 525.25), 
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007/12/09', 3000.00), 
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016/08/28', 599.88)

/********************************************
	Problem 19. Basic Select All Fields
*********************************************/

SELECT * FROM Towns

SELECT * FROM Departments

SELECT * FROM Employees

/********************************************
	Problem 20. Basic Select All Fields and Order Them
*********************************************/

SELECT * FROM Towns
ORDER BY Name ASC

SELECT * FROM Departments
ORDER BY Name ASC

SELECT * FROM Employees
ORDER BY Salary DESC

/* ******************************************
	Problem 21.	Basic Select Some Fields
*********************************************/

SELECT Name FROM Towns
ORDER BY Name ASC

SELECT Name FROM Departments
ORDER BY Name ASC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

/* ******************************************
	Problem 22.	Increase Employees Salary
*********************************************/

UPDATE Employees
SET Salary *= 1.10

SELECT Salary
FROM Employees

/* ******************************************
	Problem 23.	Decrease Tax Rate
*********************************************/

USE Hotel

UPDATE Payments
SET TaxRate = TaxRate - (TaxRate * 0.03);

SELECT TaxRate
FROM Payments

/********************************************
	Problem 24.	Delete All Records
*********************************************/

TRUNCATE TABLE Occupancies;