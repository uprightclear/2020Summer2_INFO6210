/*
 * Team 17
 * Xuejiao Dong, Chang Ge, Xiaoyang Jin, Yuanhao Li, Jiqing Sun
 * 
 * */
DROP DATABASE TEAM17_20SUMMER
GO

CREATE DATABASE TEAM17_20SUMMER
GO

USE TEAM17_20SUMMER

/*users password column encryption*/
CREATE MASTER KEY 
ENCRYPTION BY PASSWORD = 'Team17_P@sswOrd'

-- Create certificate to protect symmetric key
CREATE CERTIFICATE Team17_Certificate
WITH SUBJECT = 'Project Team17 Certificate',
EXPIRY_DATE = '2026-10-31'

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY Team17_SymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE Team17_Certificate

-- Open symmetric key
OPEN SYMMETRIC KEY Team17_SymmetricKey
DECRYPTION BY CERTIFICATE Team17_Certificate
----------------------------------------------------------------
/*
 * Create Table
 */

CREATE TABLE Account
(
	AccountID INT IDENTITY(10000, 1) NOT NULL PRIMARY KEY,
	AccountType VARCHAR(45) NOT NULL,
	LastName VARCHAR(45) NOT NULL,
	FirstName VARCHAR(45) NOT NULL,
	Birthday Date,
	Age AS DATEDIFF(hour, Birthday, GETDATE()) / 8766,
	Gender VARCHAR(45) NOT NULL CHECK (Gender IN ('Male', 'Female')),
	AccountPassword VARBINARY(MAX) NOT NULL
)

CREATE TABLE Patient
(
	PatientID INT NOT NULL REFERENCES Account(AccountID) PRIMARY KEY,
	PatientPhoneNum VARCHAR(20) NOT NULL
)

CREATE TABLE Department
(
	DepartmentID INT IDENTITY(100, 1) NOT NULL PRIMARY KEY,
	DepartmentName VARCHAR(45) NOT NULL,
	DepartmentDescription VARCHAR(MAX) NOT NULL
)

CREATE TABLE Doctor
(
	DoctorID INT NOT NULL REFERENCES Account(AccountID) PRIMARY KEY,
	DoctorTitle VARCHAR(45) NOT NULL,
	DepartmentID INT NOT NULL REFERENCES Department(DepartmentID)
)

CREATE TABLE Symptom
(
	SymptomID INT IDENTITY(1000, 1) NOT NULL PRIMARY KEY,
	SymptomName VARCHAR(45) NOT NULL,
	SymptomDescription VARCHAR(MAX) NOT NULL
)

CREATE TABLE DoctorSymptomSpecialty 
(
	SymptomID INT NOT NULL REFERENCES Symptom(SymptomID),
	DoctorID INT NOT NULL REFERENCES Doctor(DoctorID),
	CONSTRAINT PK_DoctorSymptomSpecialty PRIMARY KEY CLUSTERED (SymptomID, DoctorID)
	
)

CREATE TABLE ConsultationRoom
(
	ConsultationRoomID INT IDENTITY(20000, 1) NOT NULL PRIMARY KEY,
	RoomLink VARCHAR(60) NOT NULL
)


CREATE TABLE DoctorSchedule
(
	ScheduleID INT IDENTITY(40000, 1) NOT NULL PRIMARY KEY,
	DoctorID INT NOT NULL REFERENCES Doctor(DoctorID),
	StartTime DATETIME NOT NULL,
	EndTime DATETIME NOT NULL,
	CONSTRAINT CHECK_DS CHECK (StartTime < EndTime)
)

CREATE TABLE Booking
(
	BookingID INT IDENTITY(30000, 1) NOT NULL PRIMARY KEY,
	ScheduleID INT NOT NULL REFERENCES DoctorSchedule(ScheduleID),
	PatientID INT NOT NULL REFERENCES Patient(PatientID),
	ConsultationRoomID INT NOT NULL REFERENCES ConsultationRoom(ConsultationRoomID)
)

CREATE TABLE ElectronicPrescription
(
	PrescriptionID INT IDENTITY(50000, 1) NOT NULL PRIMARY KEY,
	DoctorComment VARCHAR(MAX) NOT NULL
)

CREATE TABLE [Case]
(
	CaseID INT IDENTITY(60000, 1) NOT NULL PRIMARY KEY,
	BookingID INT NOT NULL REFERENCES Booking(BookingID),
	PrescriptionID INT NOT NULL REFERENCES ElectronicPrescription(PrescriptionID),
	[Result] VARCHAR(MAX) NOT NULL,
	Advice VARCHAR(MAX) NOT NULL
)

CREATE TABLE Feedback
(
	FeedbackID INT IDENTITY(70000, 1) NOT NULL PRIMARY KEY,
	CaseID INT NOT NULL REFERENCES [Case](CaseID),
	Content VARCHAR(MAX) NOT NULL
)

CREATE TABLE DrugOrder
(
	DrugOrderID INT IDENTITY(80000, 1) NOT NULL PRIMARY KEY,
	PrescriptionID INT NOT NULL REFERENCES ElectronicPrescription(PrescriptionID),
	OrderDate DATETIME NOT NULL
)

CREATE TABLE Drug
(
	DrugID INT IDENTITY(90000, 1) NOT NULL PRIMARY KEY,
	DrugName VARCHAR(45) NOT NULL,
	Company VARCHAR(45) NOT NULL,
	UnitPrice MONEY NOT NULL
)

CREATE TABLE DrugPrescripted
(
	DrugID INT NOT NULL REFERENCES Drug(DrugID),
	PrescriptionID INT NOT NULL REFERENCES ElectronicPrescription(PrescriptionID),
	CONSTRAINT PK_DrugPrescripted PRIMARY KEY CLUSTERED (DrugID, PrescriptionID),
	Quantity INT NOT NULL
)
GO

/*
 * Create Function
 */
-- Constraint Account.AccountType
CREATE FUNCTION dbo.CheckAccType (@AccType VARCHAR(45))
RETURNS SMALLINT
AS
BEGIN
    DECLARE @Flag SMALLINT
    IF @AccType IN ('Doctor', 'Patient')
        SET @Flag = 1
    ELSE
        SET @Flag = 0

    RETURN @Flag
END
GO

ALTER TABLE Account ADD CONSTRAINT BanBadInput CHECK (dbo.CheckAccType(AccountType) = 1)
GO

-- Calculate the total price of a specific drug order
CREATE FUNCTION dbo.CalDrugOrderPrice
(@DrugOrderID INT)
RETURNS MONEY
AS
	BEGIN
		DECLARE @ReturnOrderPrice MONEY 
	    SELECT @ReturnOrderPrice = (
		    SELECT SUM(dp.Quantity * d.UnitPrice) 
		    FROM DrugPrescripted dp
		    LEFT OUTER JOIN Drug d
		    ON dp.DrugID = d.DrugID
		    LEFT OUTER JOIN DrugOrder do
		    ON do.PrescriptionID = dp.PrescriptionID
		    WHERE do.DrugOrderID = @DrugOrderID
		    GROUP BY DrugOrderID   
		)
	    RETURN ISNULL(@ReturnOrderPrice, 0) 
	END
GO

ALTER TABLE DrugOrder ADD TotalPrice AS (dbo.CalDrugOrderPrice(DrugOrderID))
GO

/*
 * Create View
 */
CREATE VIEW GetBookings_vw
AS
SELECT p.PatientID, d.DoctorID, b.BookingID, cr.RoomLink, ds.StartTime, ds.EndTime
FROM Patient p
INNER JOIN Booking b ON p.PatientID = b.PatientID
INNER JOIN DoctorSchedule ds ON b.scheduleID = ds.scheduleID
INNER JOIN Doctor d ON ds.DoctorID = d.DoctorID
INNER JOIN ConsultationRoom cr ON b.ConsultationRoomID = cr.ConsultationRoomID
GO 

SELECT * FROM GetBookings_vw
GO

CREATE VIEW GetDoctorSpeciality_vw
AS
WITH temp AS
    (SELECT d.DoctorID, (a.FirstName + ' ' + a.LastName) AS FullName, s.SymptomName
     FROM Doctor d
     INNER JOIN Account a ON d.DoctorID = a.AccountID
     INNER JOIN DoctorSymptomSpecialty dss ON d.DoctorID = dss.DoctorID
     INNER JOIN Symptom s ON dss.SymptomID = s.SymptomID)
SELECT DISTINCT DoctorID, FullName,
    STUFF((SELECT ', ' + t1.SymptomName
        FROM temp t1
        WHERE t1.DoctorID = t2.DoctorID
        FOR XML PATH('')), 1, 2, '') AS DoctorSpeciality
FROM temp t2
GO

SELECT * FROM GetDoctorSpeciality_vw