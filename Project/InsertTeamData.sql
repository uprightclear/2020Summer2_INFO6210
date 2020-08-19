/*
To TA team:
We suggest that you run the statements one by one. We are using identity ids, if one row is randomly inserted,
it may break the links of the data. This may lead to an error that our other data can not be inserted.
If this situation happens, please delete the database and rerun the creation code.
 */

USE TEAM17_20SUMMER
-----------------------Account------------------------
OPEN SYMMETRIC KEY Team17_SymmetricKey
DECRYPTION BY CERTIFICATE Team17_Certificate
INSERT INTO Account(AccountType, LastName, FirstName, Birthday, Gender, AccountPassword)
VALUES
---------------SJQ-----------------------
/*10000*/('Doctor', 'Sun', 'John', '1988-03-24', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'), convert(varbinary, 'SJ123456789'))),
/*10001*/('Doctor', 'Tom', 'Key', '1968-07-16', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'), convert(varbinary, 'TK123456789'))),
/*10002*/('Doctor', 'Jessie', 'Merry', '1975-12-05', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'), convert(varbinary, 'JM123456789'))),
/*10003*/('Patient', 'Li', 'Jerry', '1994-03-14', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'), convert(varbinary, 'LJ987654321'))),
/*10004*/('Patient', 'Jennie', 'Swill', '2001-01-15', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'), convert(varbinary, 'JS987654321'))),
/*10005*/('Patient', 'Bianca', 'West', '1984-09-04', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'), convert(varbinary, 'BW987654321'))),
----------------DXJ-------------------------
/*10006*/('Doctor', 'Williams', 'Lance', '1979-08-20', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'EW33234432')),
/*10007*/('Doctor', 'Wilson', 'Hugo', '1977-09-16', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'ED13233232234' )),
/*10008*/('Doctor', 'Taylor', 'Claudia', '1983-09-05', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'AS21221132')),
/*10009*/('Patient', 'Jackson', 'Ivan', '1999-09-14', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'), 'RW!22324431')),
/*10010*/('Patient', 'Harris', 'Fiona', '1989-03-25', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'WE0O22123212')),
/*10011*/('Patient', 'Davis', 'Gina', '1979-12-04', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'oo32123322')),
----------------JXY--------------------------
/*10012*/('Doctor','Smith','Adam','1970-05-06','Male',EncryptByKey(Key_GUID('Team17_SymmetricKey'), convert(varbinary, 'AS7056'))),
/*10013*/('Doctor','White','Amanda','1985-08-14','Female',EncryptByKey(Key_GUID('Team17_SymmetricKey'), convert(varbinary, '12321'))),
/*10014*/('Doctor','Brain','Ken','1963-10-20','Male',EncryptByKey(Key_GUID('Team17_SymmetricKey'), convert(varbinary, 'brain12'))),
/*10015*/('Patient','Jensen','Charles','1997-12-20','Male',EncryptByKey(Key_GUID('Team17_SymmetricKey'), convert(varbinary, '971220'))),
/*10016*/('Patient','Brown','Abby','2011-09-09','Female',EncryptByKey(Key_GUID('Team17_SymmetricKey'), convert(varbinary, '9009090'))),
/*10017*/('Patient','Brown','Harry','1977-11-22','Male',EncryptByKey(Key_GUID('Team17_SymmetricKey'), convert(varbinary, 'Bh771122'))),
-----------------GC----------------------------
/*10018*/('Doctor', 'Johnson', 'Bob', '1980-01-01', 'Male', ENCRYPTBYKEY(KEY_GUID(N'Team17_SymmetricKey'), 'Pass123')),
/*10019*/('Patient', 'George', 'Peter', '1995-08-01', 'Male', ENCRYPTBYKEY(KEY_GUID(N'Team17_SymmetricKey'), 'Pass456')),
/*10020*/('Patient', 'Alice', 'Mary', '2002-09-25', 'Female', ENCRYPTBYKEY(KEY_GUID(N'Team17_SymmetricKey'), 'Pass789')),
/*10021*/('Patient', 'Banner', 'Bruce', '1970-01-01', 'Male', ENCRYPTBYKEY(KEY_GUID(N'Team17_SymmetricKey'), 'Hero123')),
/*10022*/('Doctor', 'Stark', 'Tony', '1970-05-29', 'Male', ENCRYPTBYKEY(KEY_GUID(N'Team17_SymmetricKey'), 'Hero456')),
/*10023*/('Doctor', 'Romanova', 'Natasha', '1964-04-01', 'Female', ENCRYPTBYKEY(KEY_GUID(N'Team17_SymmetricKey'), 'Hero789')),
-----------------LYH--------------------------------
/*10024*/('Doctor', 'Miller', 'Adam', '1978-10-20', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'PW111111111')),
/*10025*/('Doctor', 'Brown', 'Chris', '1987-09-16', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'PW22222222' )),
/*10026*/('Doctor', 'Johnson', 'Alina', '1993-07-05', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'PW33333333')),
/*10027*/('Patient', 'Rodriguez', 'Edgar', '1981-10-16', 'Male', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'), 'PW44444444')),
/*10028*/('Patient', 'Wilson', 'Cherry', '1973-02-05', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'PW5555555')),
/*10029*/('Patient', 'Smith', 'Cindy', '1961-10-14', 'Female', EncryptByKey(Key_GUID(N'Team17_SymmetricKey'),'PW66666666'))

SELECT * FROM Account

SELECT DecryptByKey(AccountPassword) 
FROM Account

SELECT CONVERT(VARCHAR, DecryptByKey(AccountPassword)) 
FROM Account

-----------------------Patient------------------------
INSERT INTO Patient(PatientID, PatientPhoneNum)
VALUES
	  ----------SJQ----------------------
	  (10003, '18598567548'),
	  (10004, '13598756854'),
	  (10005, '15968542985'),
	  ----------DXJ-------------------------
	  (10009, '+20 33232445'),
	  (10010, '+30 18800001234'),
	  (10011, '+00 54390093'),
	  ----------JXY-------------------------
	  (10015,'13022159876'),
	  (10016,'15033159880'),
	  (10017,'13825799878'),
	  ----------GC-------------------------
	  (10019, '123-456-7890'),
	  (10020, '222-333-4444'),
   	  (10021, '789-555-1234'),
	  ----------LYH-------------------------
	  (10027, '+20 1234134'),
	  (10028, '+10 19945444'),
    (10029, '+00 55541632')

SELECT * FROM Patient

-----------------------Department------------------------
INSERT INTO Department(DepartmentName, DepartmentDescription)
VALUES
--------------SJQ-------------------
/*100*/('Cardiology', 'This department provides medical care to patients who have problems with their heart or circulation'),
/*101*/('ENT', 'The ENT department provides care for patients with a variety of ear, nose and throat problems'),
/*102*/('Gastroenterology', 'This department investigates and treats upper and lower gastrointestinal disease'),
--------------DXJ-------------------
/*103*/('Dentistry', 'The department provides medical services to patients with dental and periodontal related diseases'),
/*104*/('Infectious Disease', 'department provides medical services to patients with infectious diseases. Common infectious diseases include bacillary dysentery, typhoid fever, cholera, toxic hepatitis A, meningitis, scarlet fever, whooping cough, influenza, measles, filariasis, Japanese encephalitis, schistosomiasis, etc.'),
/*105*/('Psychiatric', 'The department provides medical services to patients with Nervous system diseases dominated by disorders of behavior and mental activity'),
--------------JXY-------------------
/*106*/('Ophtalmology','This department provide diagnosis and treatments for patients with their eyes'),
/*107*/('Pediatrics','This department provide diagnosis and treatments for children'),
/*108*/('Orthopedic','This department provide diagnosis and treatments for patients with their bones'),
--------------GC-------------------
/*109*/('Allergy', 'This department provides services about a number of conditions caused by hypersensitivity of the immune system to typically harmless substances in the environment'),
/*110*/('Dermatology', 'This department provides services with skin problems'),
/*111*/('Pediatrics', 'This department provides services of the medical care of infants, children, and adolescents'),
	  --------------LYH-------------------
/*112*/('Otolaryngology—Ear, Nose, and Throat Surgery', 'The department provides medical services to patients with dental and periodontal related diseases'),
/*113*/('Hay fever—allergic rhinitis', 'The department evaluates approximately 13,000 patients per year in the otolaryngology outpatient clinics and performs nearly 1,700 hospital-based surgical procedures annually. The Department of Otolaryngology - Head and Neck Surgery provides care for patients with problems involving the ears, sinuses, oral cavity, nose, throat, neck (ENT) including sinus conditions, allergy, sleep disorders, and snoring.'),
/*114*/('Gastroenterology', 'Gastroenterology services at Boston Medical Center include the diagnosis and treatment of all kinds of digestive disorders, from peptic ulcers and reflux to Crohn’s disease and cancer. In addition, the team cares for patients with motility disturbances, neuroendocrine tumors and hepatobiliary disorders such as cirrhosis, hepatitis, pancreatic disease, and biliary obstruction. Through the Dempsey Center for Digestive Disorders (CDD), patients receive a comprehensive, interdisciplinary approach to care that not only includes medical and surgical doctors, but also experts in nutrition, nursing, psychiatry, radiology, urology, and more.')

SELECT * FROM Department

-----------------------Doctor------------------------
INSERT INTO Doctor(DoctorID, DoctorTitle, DepartmentID)
VALUES
	  --------------SJQ-------------------
	  (10000, 'Expert', 100),
	  (10001, 'Genaral', 101),
	  (10002, 'Expert', 102),
	  --------------DXJ-------------------
	  (10006, 'Senior', 103),
	  (10007, 'Genaral', 104),
	  (10008, 'Expert', 105),
	  --------------JXY-------------------
	  (10012, 'Expert', 106),
	  (10013, 'Genaral', 107),
	  (10014, 'Expert', 108),
	  --------------GC-------------------
	  (10018, 'Genaral', 109),
	  (10022, 'Senior', 110),
	  (10023, 'Expert', 111),
	  --------------LYH-------------------
	  (10024, 'Genaral', 112),
	  (10025, 'Senior', 113),
	  (10026, 'Expert', 114)

SELECT * FROM Doctor

-----------------------Symptom------------------------
INSERT INTO Symptom(SymptomName, SymptomDescription)
VALUES
--------------SJQ-------------------
/*1000*/('Coronary Heart Disease', 'The reduction of blood flow to the heart muscle due to build-up of plaque in the arteries of the heart'),
/*1001*/('Rhinitis', 'Rhinitis is inflammation and swelling of the mucous membrane of the nose'),
/*1002*/('gastritis', 'Gastritis is inflammation of the lining of the stomach'),
--------------DXJ-------------------
/*1003*/('Wisdom Teeth Pericoronitis', 'The main symptoms are swelling and pain of the soft tissue around the crown. If the inflammation affects the masticatory muscles, it can cause varying degrees of restriction of mouth opening. If it spreads to the pharynx, swallowing pain will occur, causing the patient to have difficulty chewing, eating and swallowing. Severe cases may still have systemic symptoms such as general discomfort, headache, rise in body temperature, and loss of appetite.'),
/*1004*/('Periodontitis', 'Bleeding gums when brushing teeth or biting hard objects.'),
/*1005*/('Bacillary Dysentery', 'Symptoms of systemic poisoning, abdominal pain, diarrhea.'),
/*1006*/('Cholera', 'Severe and painless diarrhea and vomiting, rice swill-like stool, severe dehydration, muscle cramps and peripheral circulatory failure, etc.'),
/*1007*/('Self-compulsive Disorder', 'Symptoms of repetitive thoughts or stereotyped movements in the brain.'),
--------------JXY-------------------
/*1008*/('Blurred vision','Blurred vision means decreased vision that you can  not see things as clear as before'),
/*1009*/('Fever','Fever means your body temperature is higher than before'),
/*1010*/('Cataclasis','Cataclasis means that your bone is broken because of outside impact'),
--------------GC-------------------
/*1011*/('Food Allergy', 'Allergic reactions caused by a wide variety of foods'),
/*1012*/('Stress Allergy', 'Allergic conditions caused by chronic stress'),
/*1013*/('Acne', 'A long-term skin disease such as blackheads and whiteheads'),
--------------LYH-------------------
/*1014*/('Hay fever—allergic rhinitis', 'The patient feels like a common cold with common cold symptoms including sneezing, minor congestion, coughing, itchy watery eyes, and throat, and fatigue. Serious problems with runny nose of thin, watery discharge. Not contagious.'),
/*1015*/('Uterine Prolapse', 'Sensation of heaviness or pulling in your pelvis. The patient is having problems with urine leakage (incontinence) and urine retention, sometimes having trouble with bowel movement.'),
/*1016*/('Irregular heartbeat', 'Heart beats with an irregular or abnormal rhythm. Sometimes the patient feels that heart “skip a beat')

SELECT * FROM Symptom

---------------DoctorSymptomSpecialty-------------------
INSERT INTO DoctorSymptomSpecialty(SymptomID, DoctorID)
VALUES
	  --------------SJQ-------------------
	  (1000, 10000),
	  (1001, 10001),
	  (1002, 10002),
	  --------------DXJ-------------------
	  (1003, 10006),
	  (1004, 10006),
	  (1005, 10007),
	  (1006, 10007),
	  (1007, 10008),
	  --------------JXY-------------------
	  (1008, 10012),
	  (1009, 10013),
	  (1010, 10014),
	  --------------GC-------------------
	  (1011, 10018),
	  (1012, 10022),
	  (1013, 10023),
	  --------------LYH-------------------
		(1014, 10024),
	  (1015, 10025),
	  (1016, 10026)

SELECT * FROM DoctorSymptomSpecialty

-------------------ConsultationRoom---------------------
INSERT INTO ConsultationRoom(RoomLink)
VALUES
	  --------------SJQ-------------------
/*20000*/('www.room.com/1'),
/*20001*/('www.room.com/2'),
/*20002*/('www.room.com/3'),
	  --------------DXJ-------------------
/*20003*/('www.room.com/4'),
/*20004*/('www.room.com/5'),
/*20005*/('www.room.com/6'),
	  --------------JXY-------------------
/*20006*/('www.room.com/7'),
/*20007*/('www.room.com/8'),
/*20008*/('www.room.com/9'),
	  --------------GC-------------------
/*20009*/('www.room.com/10'),
/*20010*/('www.room.com/11'),
/*20011*/('www.room.com/12'),
	  --------------LYH-------------------
/*20012*/('www.room.com/13'),
/*20013*/('www.room.com/14'),
/*20014*/('www.room.com/15')

SELECT * FROM ConsultationRoom

---------------------DoctorSchedule----------------------
INSERT INTO DoctorSchedule(DoctorID, StartTime, EndTime)
VALUES
--------------SJQ-------------------
/*40000*/(10000, '2020-08-01 17:30:00', '2020-08-01 18:00:00'),
/*40001*/(10001, '2020-08-03 08:00:00', '2020-08-03 09:00:00'),
/*40002*/(10002, '2020-08-05 13:10:00', '2020-08-05 13:50:00'),
--------------DXJ-------------------
/*40003*/(10006, '2020-08-01 09:00:00', '2020-08-01 10:00:00'),
/*40004*/(10006, '2020-08-01 11:00:00', '2020-08-01 12:00:00'),
/*40005*/(10006, '2020-08-01 13:00:00', '2020-08-01 14:00:00'),
/*40006*/(10006, '2020-08-02 09:00:00', '2020-08-02 10:00:00'),
/*40007*/(10006, '2020-08-02 11:00:00', '2020-08-02 12:00:00'),
/*40008*/(10006, '2020-08-02 13:00:00', '2020-08-02 14:00:00'),
/*40009*/(10007, '2020-08-01 09:00:00', '2020-08-01 10:00:00'),
/*40010*/(10007, '2020-08-01 11:00:00', '2020-08-01 12:00:00'),
/*40011*/(10007, '2020-08-01 13:00:00', '2020-08-01 14:00:00'),
/*40012*/(10007, '2020-08-02 09:00:00', '2020-08-02 10:00:00'),
/*40013*/(10007, '2020-08-02 11:00:00', '2020-08-02 12:00:00'),
/*40014*/(10007, '2020-08-02 13:00:00', '2020-08-02 14:00:00'),
/*40015*/(10008, '2020-08-01 09:00:00', '2020-08-01 10:00:00'),
/*40016*/(10008, '2020-08-01 11:00:00', '2020-08-01 12:00:00'),
/*40017*/(10008, '2020-08-01 13:00:00', '2020-08-01 14:00:00'),
/*40018*/(10008, '2020-08-02 09:00:00', '2020-08-02 10:00:00'),
/*40019*/(10008, '2020-08-02 11:00:00', '2020-08-02 12:00:00'),
/*40020*/(10008, '2020-08-02 13:00:00', '2020-08-02 14:00:00'),
--------------JXY-------------------
/*40021*/(10012, '2020-07-20 09:30:00', '2020-07-20 10:00:00'),
/*40022*/(10014, '2020-07-31 15:00:00', '2020-07-31 15:25:00'),
/*40023*/(10013, '2020-07-25 10:00:00', '2020-07-25 10:38:00'),
--------------GC-------------------
/*40024*/(10018, '2020-08-04 16:00:00', '2020-08-04 17:00:00'),
/*40025*/(10022, '2020-08-02 13:00:00', '2020-08-02 14:00:00'),
/*40026*/(10022, '2020-08-04 15:00:00', '2020-08-04 16:00:00'),
--------------LYH-------------------
/*40027*/(10024, '2020-08-04 09:00:00', '2020-08-04 10:00:00'),
/*40028*/(10025, '2020-08-06 14:00:00', '2020-08-06 15:00:00'),
/*40029*/(10026, '2020-08-08 16:00:00', '2020-08-08 17:00:00')

SELECT * FROM DoctorSchedule

-------------------------Booking------------------------

INSERT INTO Booking(PatientID, ScheduleID, ConsultationRoomID)
VALUES
--------------SJQ-------------------
/*30000*/(10003, 40000, 20000),--10000
/*30001*/(10004, 40001, 20001),--10001
/*30002*/(10005, 40002, 20002), --10002
--------------DXJ-------------------
/*30003*/(10009, 40003, 20003),--10000  Dentistry
/*30004*/(10010, 40012, 20004),--10001  Infectious Disease
/*30005*/(10011, 40018, 20005),
--------------JXY-------------------
/*30006*/(10015, 40021, 20006),
/*30007*/(10016, 40022, 20007),
/*30008*/(10017, 40023, 20008),
--------------GC-------------------
/*30009*/(10019, 40024, 20009),
/*30010*/(10020, 40025, 20010),
/*30011*/(10021, 40026, 20011),
--------------LYH-------------------
/*30012*/(10027, 40027, 20012),
/*30013*/(10028, 40028, 20013),
/*30014*/(10029, 40029, 20014)

SELECT * FROM Booking

----------------ElectronicPrescription-------------------
INSERT INTO ElectronicPrescription(DoctorComment)
VALUES
--------------SJQ-------------------
/*50000*/('Take medicine as prescribed'),
/*50001*/('You can buy drugs according to your own situation'),
/*50002*/('Take medicine as prescribed'), 
--------------DXJ-------------------
/*50003*/('Communicate more with friends, take medicine when the condition is serious and take medicine after meals'),
/*50004*/('Eat liquid food, take medicine after meals, and take a break'),
/*50005*/('Take medicine once a day as prescribed'),
--------------JXY-------------------
/*50006*/('Take medicine as prescribed'),
/*50007*/('Take medicine as prescribed and have good rest'),
/*50008*/('Take medicine as prescribed, leave the broken part dry'),
--------------GC-------------------
/*50009*/('Optional purchase'),
/*50010*/('Please get the medicine ASAP'),
/*50011*/('Take the medicine on time'),
--------------LYH-------------------
/*50012*/('Please get the medicine ASAP'),
/*50013*/('Overlapping Sphincteroplasty'),
/*50014*/('Take the medicine on time')

SELECT * FROM ElectronicPrescription

------------------------Case-----------------------------
INSERT INTO [Case](BookingID, PrescriptionID, Result, Advice)
VALUES
--------------SJQ-------------------
/*60000*/(30000, 50000, 'Overall heart health with irregular heartbeat', 'No surgery, just take medicine'),
/*60001*/(30001, 50001, 'Mild rhinitis', 'Optionally take drugs to relieve pain'),
/*60002*/(30002, 50002, 'Mild gastritis', 'No surgery, just take medicine'),
--------------DXJ-------------------
/*60003*/(30003, 50004, 'Periodontitis', 'Prohibit eating raw and cold stimulating food'),
/*60004*/(30004, 50005, 'Cholera', 'Pay attention to rest and take medicine on time, and come back next week'),
/*60005*/(30005, 50003, 'Self-compulsive Disorder', 'Relax and chat more with family and friends'),
--------------JXY-------------------
/*60006*/(30006, 50006, 'Myopia', 'To be fitted with eyeglasses as soon as possible and do not use your eyes too much'),
/*60007*/(30007, 50007, 'Flu', 'Take drugs until the temperature becomes normal'),
/*60008*/(30008, 50008, 'Fracture', 'Optionally take drugs to relieve pain, pay attention to leave the broken part dry'),
--------------GC-------------------
/*60009*/(30009, 50009, 'Food allergic caused by having bad food.', 'Take some rest, not necessary to take medicine'),
/*60010*/(30010, 50010, 'Acne caused by working or studying overnight multiple times.', 'Take medicine and rest on time'),
/*60011*/(30011, 50011, 'Normal acne', 'Take medicine on time. Following the prescription.'),
--------------LYH-------------------
/*60012*/(30012, 50012, 'Allergic Rhinitis', 'Avoid exposure to allergens like pollen or animal dander. As your allergen might be animals, wash your hands immediately after petting any animals wash your clothes after visiting friends with pets.Close the air ducts to your bedroom if you have forced-air or central heating or cooling. Replace carpeting with hardwood, tile, or linoleum, all of which are easier to keep dander-free.'),
/*60013*/(30013, 50013, 'Uterine Prolapse', 'Perform Kegel exercises regularly. These exercises can strengthen your pelvic floor muscles — especially important after you have a baby. Avoid heavy lifting and lift correctly. When lifting, use your legs instead of your waist or back. Avoid weight gain. Talk with your doctor to determine your ideal weight and get advice on weight-loss strategies, if you need them.'),
/*60014*/(30014, 50014, 'Arrhythmia', 'Perform Kegel exercises regularly. These exercises can strengthen your pelvic floor muscles — especially important after you have a baby. Avoid heavy lifting and lift correctly. When lifting, use your legs instead of your waist or back. Avoid weight gain. Talk with your doctor to determine your ideal weight and get advice on weight-loss strategies, if you need them.')

SELECT * FROM [Case]

------------------------FeedBack-----------------------------
ALTER TABLE FeedBack
ALTER COLUMN Content VARCHAR(max) NOT NULL
INSERT INTO FeedBack(CaseID, Content)
VALUES
--------------SJQ-------------------
/*70000*/(60000, 'The  medical skills of the doctor are superb and the advice given is very good'),
/*70001*/(60001, 'The prescription is very good and it quickly relieved my pain'),
/*70002*/(60002, 'A bad experience, the doctor did not give me much help'),
--------------DXJ-------------------
/*70003*/(60003, 'The doctor is very kindful and my tooth no longer hurts soon'),
/*70004*/(60004, 'I love this doctor and it is a good experience'),
/*70005*/(60005, 'The doctor talked a lot with me and it relieved my obsessive-compulsive disorder to a great extent'),
--------------JXY-------------------
/*70006*/(60006, 'Just so so.'),
/*70007*/(60007, 'The doctor is very kind and gave me lots of patients.'),
/*70008*/(60008, 'Very good experience, helped me a lot.'),
--------------GC-------------------
/*70009*/(60009, 'I recommend this doctor'),
/*70010*/(60010, 'Good doctor, good advice'),
/*70011*/(60011, 'I love this doctor!!!'),
--------------LYH-------------------
/*70012*/(60012, 'He is such a class act! Very accommodating and helpful! Saw him 8 years prior and he remembered me. I am happy he is right around the corner from my office. And he brings in fellow docs he can trust and will help make your case top priority.'),
/*70013*/(60013, 'I am writing to express my gratitude from my family for the care given to my mother. In the SICU, there was care, compassion, and respect. A special thank you to your social workers as well they provided professional guidance, comfort, and strength to make our own decisions. Finally, I cannot praise the Palliative Care and Hospice team enough. They were patient and helpful. All our hope that you continue along this path.'),
/*70014*/(60014, 'I recently had a three-day stay at the Cardiovascular Center and I wanted to express how impressed I was with the level of care I received from everyone I encountered. The Trauma Center saved my life! I found it amazing and I am grateful that it services my community.')

SELECT * FROM FeedBack

---------------------------Drug----------------------------------
INSERT INTO Drug(DrugName, Company, UnitPrice)
VALUES
--------------SJQ-------------------
/*90000*/('Aspirin', 'Bayer', 12),
/*90001*/('Fexofenadine', 'Bayer', 8),
/*90002*/('Antacids', 'Muhi Biology', 5),
--------------DXJ-------------------
/*90003*/('Metronidazole ', 'JD Biology', 15),
/*90004*/('Clindamycin', 'JD Biology', 20),
/*90005*/('Tetracycline', 'XUH', 35),
/*90006*/('Fluoxetine', 'DJ Biology', 28),
/*90007*/('Physiological saline', 'DJ Biology', 5 ),
--------------JXY-------------------
/*90008*/('Tropicamide Eye Drops', 'Bayer', 9),
/*90009*/('Pediatric Paracetamol', 'Bayer', 2),
/*90010*/('Brufen', 'ChemicalBook', 10),
--------------GC-------------------
/*90011*/('Panacea1', 'Stark.Co', 100),
/*90012*/('Panacea2', 'Wakanda', 200),
/*90013*/('Panacea3', 'Wakanda', 20),
--------------LYH-------------------
/*90014*/('Metronidazole', 'JD Biology', 15),
/*90015*/('Antihistamines in tablet', 'BiondVax', 9.9),
/*90016*/('Ibuprofen', 'Pharma Nord', 5.9)
	  
SELECT * FROM Drug

----------------------DrugPrescripted----------------------------
INSERT INTO DrugPrescripted(DrugID, PrescriptionID, Quantity)
VALUES
	  --------------SJQ-------------------
	  (90000, 50000, 5),
	  (90002, 50000, 2),
	  (90001, 50001, 3),
	  (90002, 50002, 4),
	  --------------DXJ-------------------
	  (90003, 50004, 1),
	  (90004, 50004, 2),
	  (90007, 50004, 1),
	  (90005, 50005, 2),
	  (90006, 50003, 3),
	  --------------JXY-------------------
	  (90008, 50006, 1),
	  (90009, 50007, 1),
	  (90010, 50008, 2),
	  --------------GC-------------------
	  (90011, 50009, 4),
	  (90011, 50010, 2),
	  (90013, 50010, 3),
	  (90012, 50011, 2),
	  --------------LYH-------------------
		(90016, 50012, 3),
	  (90015, 50012, 1),
	  (90008, 50013, 1),
	  (90001, 50013, 2),
		(90006, 50013, 1),
	  (90016, 50014, 1)
	  
SELECT * FROM DrugPrescripted

------------------------DrugOrder-------------------------------
INSERT INTO DrugOrder(PrescriptionID, OrderDate)
VALUES
--------------SJQ-------------------
/*80000*/(50000, '2020-08-01'),
/*80001*/(50001, '2020-08-03'),
/*80002*/(50002, '2020-08-05'),
--------------DXJ-------------------
/*80003*/(50003, '2020-08-09'),
/*80004*/(50004, '2020-08-10'),
/*80005*/(50005, '2020-08-05'),
--------------JXY-------------------
/*80006*/(50006, '2020-07-20'),
/*80007*/(50007, '2020-07-31'),
/*80008*/(50008, '2020-07-25'), 
--------------GC-------------------
/*80009*/(50009, '2020-08-10'),
/*80010*/(50010, '2020-08-10'),
/*80011*/(50011, '2020-08-11'),
--------------LYH-------------------
/*80012*/(50012, '2020-08-04'),
/*80013*/(50013, '2020-08-06'),
/*80014*/(50014, '2020-08-08')
	  
SELECT * FROM DrugOrder
