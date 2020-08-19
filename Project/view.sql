CREATE VIEW GetBookings_vw
AS
SELECT p.PatientID, d.DoctorID, b.BookingID, cr.RoomLink, ds.StartTime, ds.EndTime
FROM Patient p
INNER JOIN Booking b ON p.PatientID = b.PatientID
INNER JOIN DoctorSchedule ds ON b.ScheduleID = ds.ScheduleID
INNER JOIN Doctor d ON ds.DoctorID = d.DoctorID
INNER JOIN ConsultationRoom cr ON b.ConsultationRoomID = cr.ConsultationRoomID

SELECT * FROM GetBookings_vw


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

SELECT * FROM GetDoctorSpeciality_vw

CREATE FUNCTION CheckAccType (@AccType VARCHAR(45))
RETURNS SMALLINT
AS
BEGIN
    DECLARE @Flag SMALLINT;
    IF @AccType IN ('Doctor', 'Patient')
        SET @Flag = 1
    ELSE
        SET @Flag = 0

    RETURN @Flag
END

ALTER TABLE Account ADD CONSTRAINT BanBadInput CHECK (dbo.CheckAccType(AccountType) = 1)

INSERT Account (AccountType, LastName, FirstName, Birthday, Gender, AccountPassword)
VALUES
('Dod', 'John', 'Bob', '1980-01-01', 'Male', ENCRYPTBYKEY(KEY_GUID(N'Team17_SymmetricKey'), 'Pass123'))