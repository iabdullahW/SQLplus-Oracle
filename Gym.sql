CREATE TABLE Members (
    MemberId NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Age NUMBER,
    Contact VARCHAR2(20),
    Gender VARCHAR2(10),
    Fees NUMBER
);
CREATE TABLE Trainers (
    TrainerId NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Contact VARCHAR2(20),
    Gender VARCHAR2(10),
    Age NUMBER,
    Salary NUMBER
);
CREATE TABLE Staff (
    StaffId NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Role VARCHAR2(30),
    Contact VARCHAR2(20),
    Age NUMBER,
    Gender VARCHAR2(10),
    Salary NUMBER
);
CREATE TABLE Membership (
    MembershipId NUMBER PRIMARY KEY,
    Type VARCHAR2(30),
    Price NUMBER
);
CREATE TABLE Payment (
    PaymentId NUMBER PRIMARY KEY,
    Amount NUMBER,
    PaymentMethod VARCHAR2(20),
    PaymentDate DATE
);
CREATE TABLE Equipment (
    EquipmentId NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Quantity NUMBER,
    Type VARCHAR2(30)
);
CREATE TABLE Member_Trainer (
    MemberId NUMBER,
    TrainerId NUMBER,
    PRIMARY KEY (MemberId, TrainerId),
    CONSTRAINT fk_mt_member FOREIGN KEY (MemberId) REFERENCES Members(MemberId),
    CONSTRAINT fk_mt_trainer FOREIGN KEY (TrainerId) REFERENCES Trainers(TrainerId)
);
CREATE TABLE Member_Equipment (
    MemberId NUMBER,
    EquipmentId NUMBER,
    PRIMARY KEY (MemberId, EquipmentId),
    CONSTRAINT fk_me_member FOREIGN KEY (MemberId) REFERENCES Members(MemberId),
    CONSTRAINT fk_me_equipment FOREIGN KEY (EquipmentId) REFERENCES Equipment(EquipmentId)
);
CREATE TABLE Member_Membership (
    MemberId NUMBER,
    MembershipId NUMBER,
    PRIMARY KEY (MemberId, MembershipId),
    CONSTRAINT fk_mm_member FOREIGN KEY (MemberId) REFERENCES Members(MemberId),
    CONSTRAINT fk_mm_membership FOREIGN KEY (MembershipId) REFERENCES Membership(MembershipId)
);
CREATE TABLE Member_Staff (
    MemberId NUMBER,
    StaffId NUMBER,
    PRIMARY KEY (MemberId, StaffId),
    CONSTRAINT fk_ms_member FOREIGN KEY (MemberId) REFERENCES Members(MemberId),
    CONSTRAINT fk_ms_staff FOREIGN KEY (StaffId) REFERENCES Staff(StaffId)
);
CREATE TABLE Member_Payment (
    MemberId NUMBER,
    PaymentId NUMBER,
    PRIMARY KEY (MemberId, PaymentId),
    CONSTRAINT fk_mp_member FOREIGN KEY (MemberId) REFERENCES Members(MemberId),
    CONSTRAINT fk_mp_payment FOREIGN KEY (PaymentId) REFERENCES Payment(PaymentId)
);
CREATE TABLE Trainer_Equipment (
    TrainerId NUMBER,
    EquipmentId NUMBER,
    PRIMARY KEY (TrainerId, EquipmentId),
    CONSTRAINT fk_te_trainer FOREIGN KEY (TrainerId) REFERENCES Trainers(TrainerId),
    CONSTRAINT fk_te_equipment FOREIGN KEY (EquipmentId) REFERENCES Equipment(EquipmentId)
);
CREATE TABLE Trainer_Staff (
    TrainerId NUMBER,
    StaffId NUMBER,
    PRIMARY KEY (TrainerId, StaffId),
    CONSTRAINT fk_ts_trainer FOREIGN KEY (TrainerId) REFERENCES Trainers(TrainerId),
    CONSTRAINT fk_ts_staff FOREIGN KEY (StaffId) REFERENCES Staff(StaffId)
);

-- MEMBERSHIP rows
INSERT INTO Membership VALUES (1, 'Monthly', 3000);
INSERT INTO Membership VALUES (2, 'Quarterly', 8000);
INSERT INTO Membership VALUES (3, 'Half-Yearly', 15000);
INSERT INTO Membership VALUES (4, 'Yearly', 25000);
INSERT INTO Membership VALUES (5, 'Premium', 35000);

-- MEMBERS rows
INSERT INTO Members VALUES (101, 'Ali', 22, '03001234567', 'Male', 3000, 1);
INSERT INTO Members VALUES (102, 'Sara', 25, '03007654321', 'Female', 8000, 2);
INSERT INTO Members VALUES (103, 'Ahmed', 28, '03001112223', 'Male', 15000, 3);
INSERT INTO Members VALUES (104, 'Aisha', 30, '03112223344', 'Female', 25000, 4);
INSERT INTO Members VALUES (105, 'Hassan', 26, '03213334455', 'Male', 35000, 5);

-- TRAINERS rows
INSERT INTO Trainers VALUES (201, 'Bilal', '03009998888', 'Male', 32, 40000);
INSERT INTO Trainers VALUES (202, 'Hina',  '03004566789', 'Female', 29, 38000);
INSERT INTO Trainers VALUES (203, 'Usman', '03001239876', 'Male', 35, 45000);
INSERT INTO Trainers VALUES (204, 'Sadia', '03003455678', 'Female', 27, 36000);
INSERT INTO Trainers VALUES (205, 'Imran', '03117894563', 'Male', 31, 42000);

-- STAFF rows
INSERT INTO Staff VALUES (301, 'Kamran', 'Receptionist', '03334567890', 28, 'Male', 25000);
INSERT INTO Staff VALUES (302, 'Nadia', 'Cleaner', '03456789012', 35, 'Female', 18000);
INSERT INTO Staff VALUES (303, 'Salman', 'Manager', '03012349876', 40, 'Male', 50000);
INSERT INTO Staff VALUES (304, 'Hira', 'Accountant', '03216789045', 30, 'Female', 35000);
INSERT INTO Staff VALUES (305, 'Jamal', 'Security', '03033445566', 38, 'Male', 20000);

-- PAYMENT rows
INSERT INTO Payment VALUES (401, 101, 3000, 'Cash', SYSDATE);
INSERT INTO Payment VALUES (402, 102, 8000, 'Card', SYSDATE);
INSERT INTO Payment VALUES (403, 103, 15000, 'Online', SYSDATE);
INSERT INTO Payment VALUES (404, 104, 25000, 'Cash', SYSDATE);
INSERT INTO Payment VALUES (405, 105, 35000, 'Card', SYSDATE);

-- EQUIPMENT rows
INSERT INTO Equipment VALUES (501, 'Treadmill', 4, 'Cardio');
INSERT INTO Equipment VALUES (502, 'Bench Press', 2, 'Strength');
INSERT INTO Equipment VALUES (503, 'Dumbbells', 20, 'Strength');
INSERT INTO Equipment VALUES (504, 'Exercise Bike', 3, 'Cardio');
INSERT INTO Equipment VALUES (505, 'Rowing Machine', 2, 'Cardio');

CREATE OR REPLACE PROCEDURE insert_member(
    p_id NUMBER,
    p_name VARCHAR2,
    p_age NUMBER,
    p_contact VARCHAR2,
    p_gender VARCHAR2,
    p_fees NUMBER
)
AS
BEGIN
    INSERT INTO MEMBERS (MEMBERID, Name, AGE, CONTACT, GENDER, FEES)
    VALUES (p_id, p_name, p_age, p_contact, p_gender, p_fees);
END;
/

EXEC insert_member(106, 'Zara', 24, '03335556677', 'Female', 3000);

CREATE OR REPLACE PROCEDURE update_member_fees(
    p_id NUMBER,
    p_fees NUMBER
)
AS
BEGIN
    UPDATE Members
    SET Fees = p_fees
    WHERE MemberId = p_id;
END;
/
EXEC update_member_fees(106, 3500);

CREATE OR REPLACE PROCEDURE insert_trainer(
    p_id NUMBER,
    p_name VARCHAR2,
    p_contact VARCHAR2,
    p_gender VARCHAR2,
    p_age NUMBER,
    p_salary NUMBER
)
AS
BEGIN
    INSERT INTO TRAINERS(TRAINERID , NAME ,CONTACT , GENDER , AGE , SALARY)
    VALUES(p_id, p_name, p_contact, p_gender, p_age, p_salary);
END;
/
EXEC insert_trainer(211, 'Ahmed Khan', '03001234567', 'Male', 30, 45000);

CREATE OR REPLACE PROCEDURE update_trainer_salary(
    p_id NUMBER,
    p_salary NUMBER
)
AS
BEGIN
    UPDATE Trainers
    SET Salary = p_salary
    WHERE TrainerId = p_id;
END;
/
EXEC update_trainer_salary(116, 3500);
