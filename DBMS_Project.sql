--Create Tables
CREATE TABLE Location(
    location_id INT PRIMARY KEY, 
    city VARCHAR2(50),
    country VARCHAR2(50)
);

CREATE TABLE Users (
    user_id INT Primary key,
    first_name VARCHAR2(50),
    middle_name VARCHAR2(50),
    last_name VARCHAR2(50),
    phone_no VARCHAR2(20),
    email VARCHAR2(100) unique,
    street VARCHAR2(100),
    location_id INT,
    date_reg DATE DEFAULT SYSDATE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

CREATE TABLE Landlords (
    landlord_id INT Primary Key,
    user_id INT UNIQUE,
    Foreign key (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Tenants(
    tenant_id INT PRIMARY KEY,
    user_id INT UNIQUE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Properties(
    prop_id INT PRIMARY KEY,
    landlord_id INT,
    type VARCHAR2(50),
    location_id INT,
    rent DECIMAL(10,2),
    bedrooms INT,
    bathrooms int,
    avail CHAR(1) CHECK (avail IN ('Y','N')),
    list_date DATE DEFAULT SYSDATE,
    add_amen VARCHAR2(100),
    FOREIGN KEY (landlord_id) REFERENCES Landlords(landlord_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

CREATE TABLE Preferences(
    tenant_id INT,
    prop_id INT,
    min_bedrooms INT,
    max_budget DECIMAL(10,2),
    amenities VARCHAR2(200),
    location_id INT,
    PRIMARY KEY(tenant_id,prop_id),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id),
    FOREIGN KEY (prop_id) REFERENCES Properties(prop_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

CREATE TABLE Legal_Documents (
    doc_id INT PRIMARY KEY,
    user_id INT,
    doc_type VARCHAR2(50),
    doc_url VARCHAR2(100),
    upload_date DATE DEFAULT SYSDATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Property_Matches (
    match_id INT PRIMARY KEY,
    tenant_id INT,
    prop_id INT,
    status VARCHAR2(20) CHECK(status IN('Matched','Pending','Rejected')),
    match_date DATE DEFAULT SYSDATE,
    FOREIGN KEY (prop_id) REFERENCES Properties(prop_id),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);

CREATE TABLE Complaints (
    comp_id INT PRIMARY KEY,
    tenant_id INT,
    complaint CLOB,
    status VARCHAR2(20) CHECK (status IN ('Open','Closed','In Progress') ),
    date_filed DATE DEFAULT SYSDATE,
    date_res DATE,
    remarks VARCHAR2(100),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);
--Complaint history
--CREATE TABLE Complaint_History (
  --  history_id NUMBER GENERATED ALWAYS AS IDENTITY,
    --comp_id NUMBER,
    --old_status VARCHAR2(50),
    --new_status VARCHAR2(50),
    --changed_on DATE DEFAULT SYSDATE
--);


CREATE TABLE Rent_Payments (
    pay_id INT PRIMARY KEY,
    tenant_id INT,
    amount DECIMAL(10,2),
    pay_date DATE DEFAULT SYSDATE,
    status VARCHAR2(20) CHECK (status IN ('Paid','Unpaid','Pending')),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);


--INSERT DATA
--Location
INSERT INTO Location VALUES (1, 'Delhi', 'India');
INSERT INTO Location VALUES (2, 'Mumbai', 'India');
INSERT INTO Location VALUES (3, 'Bengaluru', 'India');
INSERT INTO Location VALUES (4, 'Chennai', 'India');
INSERT INTO Location VALUES (5, 'Hyderabad', 'India');
INSERT INTO Location VALUES (6, 'Pune', 'India');
INSERT INTO Location VALUES (7, 'Jaipur', 'India');
INSERT INTO Location VALUES (8, 'Kolkata', 'India');
INSERT INTO Location VALUES (9, 'Ahmedabad', 'India');
INSERT INTO Location VALUES (10, 'Noida', 'India');

SELECT * FROM Location;

--USERS
INSERT INTO Users VALUES (101, 'Amit', '', 'Verma', '9876543210', 'amitv@gmail.com', 'A-12 Street', 1, SYSDATE);
INSERT INTO Users VALUES (102, 'Riya', '', 'Kapoor', '9812345678', 'riyark@gmail.com', 'B-55 Avenue', 2, SYSDATE);
INSERT INTO Users VALUES (103, 'Arjun', '', 'Rao', '9123456789', 'arjunr@gmail.com', 'C-9 Lane', 3, SYSDATE);
INSERT INTO Users VALUES (104, 'Sneha', '', 'Sharma', '9988776655', 'snehas@gmail.com', 'D-42 Main', 4, SYSDATE);
INSERT INTO Users VALUES (105, 'Dev', '', 'Mishra', '9001122334', 'devm@gmail.com', 'E-77 Square', 5, SYSDATE);
INSERT INTO Users VALUES (106, 'Nisha', '', 'Iyer', '9898989898', 'nishai@gmail.com', 'F-5 Park', 1, SYSDATE);
INSERT INTO Users VALUES (107, 'Vikram', '', 'Desai', '9777765432', 'vikd@gmail.com', 'G-1 Road', 2, SYSDATE);
INSERT INTO Users VALUES (108, 'Priya', '', 'Menon', '9666677777', 'priyam@gmail.com', 'H-12 Blvd', 3, SYSDATE);
INSERT INTO Users VALUES (109, 'Karan', '', 'Thakur', '9555567890', 'karant@gmail.com', 'I-33 Gate', 4, SYSDATE);
INSERT INTO Users VALUES (110, 'Meera', '', 'Joshi', '9444456789', 'meeraj@gmail.com', 'J-44 Turn', 5, SYSDATE);
INSERT INTO Users VALUES (111, 'Tanvi', '', 'Mehta', '9333344455', 'tanvim@gmail.com', 'K-18 Block', 6, SYSDATE);
INSERT INTO Users VALUES (112, 'Rahul', '', 'Seth', '9111122233', 'rahuls@gmail.com', 'L-21 Hills', 7, SYSDATE);
INSERT INTO Users VALUES (113, 'Ananya', '', 'Singh', '9222233344', 'ananyas@gmail.com', 'M-31 Valley', 8, SYSDATE);
INSERT INTO Users VALUES (114, 'Kabir', '', 'Gupta', '9000099999', 'kabirg@gmail.com', 'N-91 Heights', 9, SYSDATE);
INSERT INTO Users VALUES (115, 'Divya', '', 'Jain', '9777700001', 'divyaj@gmail.com', 'O-15 Cross', 10, SYSDATE);

SELECT * FROM Users;

--Landlords
INSERT INTO Landlords VALUES (201, 101);
INSERT INTO Landlords VALUES (202, 102);
INSERT INTO Landlords VALUES (203, 103);
INSERT INTO Landlords VALUES (204, 111);
INSERT INTO Landlords VALUES (205, 112);

SELECT * FROM Landlords;

--Tenants
INSERT INTO Tenants VALUES (301, 104);
INSERT INTO Tenants VALUES (302, 105);
INSERT INTO Tenants VALUES (303, 106);
INSERT INTO Tenants VALUES (304, 107);
INSERT INTO Tenants VALUES (305, 108);
INSERT INTO Tenants VALUES (306, 109);
INSERT INTO Tenants VALUES (307, 113);
INSERT INTO Tenants VALUES (308, 114);
INSERT INTO Tenants VALUES (309, 115);

SELECT * FROM Tenants;

--Properties
INSERT INTO Properties VALUES (401, 201, '1BHK', 1, 10000.00, 1, 1, 'Y', SYSDATE, 'Parking, Water');
INSERT INTO Properties VALUES (402, 201, '2BHK', 2, 18000.00, 2, 2, 'Y', SYSDATE, 'Balcony, Lift');
INSERT INTO Properties VALUES (403, 202, 'Studio', 3, 8000.00, 1, 1, 'N', SYSDATE, 'WiFi');
INSERT INTO Properties VALUES (404, 203, '3BHK', 4, 25000.00, 3, 2, 'Y', SYSDATE, 'Gym, Security');
INSERT INTO Properties VALUES (405, 203, '1RK', 5, 6000.00, 1, 1, 'Y', SYSDATE, 'Pet-Friendly');
INSERT INTO Properties VALUES (406, 204, '2BHK', 6, 15000.00, 2, 2, 'Y', SYSDATE, 'Playground, WiFi');
INSERT INTO Properties VALUES (407, 204, '1BHK', 7, 9500.00, 1, 1, 'N', SYSDATE, 'Lift, Water');
INSERT INTO Properties VALUES (408, 205, '3BHK', 8, 24000.00, 3, 2, 'Y', SYSDATE, 'Gym, Balcony');
INSERT INTO Properties VALUES (409, 205, 'Studio', 9, 7000.00, 1, 1, 'Y', SYSDATE, 'Parking');
INSERT INTO Properties VALUES (410, 205, '2BHK', 10, 16000.00, 2, 2, 'Y', SYSDATE, 'Security, WiFi');

SELECT * FROM Properties;

--Preferences
INSERT INTO Preferences VALUES (301, 401, 1, 12000.00, 'Parking, Water', 1);
INSERT INTO Preferences VALUES (302, 402, 2, 20000.00, 'Lift, Balcony', 2);
INSERT INTO Preferences VALUES (303, 403, 1, 9000.00, 'WiFi', 3);
INSERT INTO Preferences VALUES (304, 404, 3, 26000.00, 'Gym, Security', 4);
INSERT INTO Preferences VALUES (305, 405, 1, 7000.00, 'Pet-Friendly', 5);
INSERT INTO Preferences VALUES (307, 406, 2, 16000.00, 'WiFi, Playground', 6);
INSERT INTO Preferences VALUES (308, 408, 3, 25000.00, 'Balcony, Gym', 8);
INSERT INTO Preferences VALUES (309, 410, 2, 17000.00, 'WiFi, Security', 10);

SELECT * FROM Preferences;

--Local Documents
INSERT INTO Legal_Documents VALUES (501, 104, 'Aadhar', 'docs/aadhar_sneha.pdf', SYSDATE);
INSERT INTO Legal_Documents VALUES (502, 105, 'PAN', 'docs/pan_dev.pdf', SYSDATE);
INSERT INTO Legal_Documents VALUES (503, 106, 'Rental Agreement', 'docs/rental_nisha.pdf', SYSDATE);
INSERT INTO Legal_Documents VALUES (504, 113, 'PAN', 'docs/pan_ananya.pdf', SYSDATE);
INSERT INTO Legal_Documents VALUES (505, 114, 'Aadhar', 'docs/aadhar_kabir.pdf', SYSDATE);
INSERT INTO Legal_Documents VALUES (506, 115, 'Rental Agreement', 'docs/rent_divya.pdf', SYSDATE);

SELECT * FROM Legal_Documents;

--Rent Payments
INSERT INTO Rent_Payments VALUES (601, 301, 10000.00, SYSDATE, 'Paid');
INSERT INTO Rent_Payments VALUES (602, 302, 18000.00, SYSDATE, 'Unpaid');
INSERT INTO Rent_Payments VALUES (603, 303, 8000.00, SYSDATE, 'Paid');
INSERT INTO Rent_Payments VALUES (604, 307, 15000.00, SYSDATE, 'Paid');
INSERT INTO Rent_Payments VALUES (605, 308, 24000.00, SYSDATE, 'Paid');
INSERT INTO Rent_Payments VALUES (606, 309, 16000.00, SYSDATE, 'Unpaid');

SELECT * FROM Rent_Payments;

--Complaints
INSERT INTO Complaints VALUES (701, 301, 'Water leakage from ceiling.', 'Open', SYSDATE, NULL, 'Urgent fix needed');
INSERT INTO Complaints VALUES (702, 302, 'Elevator not working.', 'Closed', SYSDATE, SYSDATE, 'Resolved quickly');
INSERT INTO Complaints VALUES (703, 307, 'WiFi connection unstable.', 'Open', SYSDATE, NULL, 'Pending technician');
INSERT INTO Complaints VALUES (704, 308, 'Power backup not working.', 'In Progress', SYSDATE, NULL, 'Under investigation');
INSERT INTO Complaints VALUES (705, 309, 'Noisy neighbours.', 'Closed', SYSDATE, SYSDATE, 'Issue resolved');

SELECT * FROM Complaints;

--Property Matches
INSERT INTO Property_Matches VALUES (801, 301, 401, 'Matched', SYSDATE);
INSERT INTO Property_Matches VALUES (802, 302, 402, 'Pending', NULL);
INSERT INTO Property_Matches VALUES (803, 307, 406, 'Matched', SYSDATE);
INSERT INTO Property_Matches VALUES (804, 308, 408, 'Matched', SYSDATE);
INSERT INTO Property_Matches VALUES (805, 309, 410, 'Pending', NULL);

SELECT * FROM Property_Matches;

--QUERIES

--Match tenants to properties based on preferences
SELECT 
  t.tenant_id, u.first_name || ' ' || u.last_name AS tenant_name,
  p.prop_id, p.type, p.rent, p.bedrooms
FROM Preferences pref
JOIN Properties p ON pref.prop_id = p.prop_id
JOIN Tenants t ON pref.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
WHERE p.rent <= pref.max_budget
  AND p.bedrooms >= pref.min_bedrooms
  AND p.avail = 'Y';


--Show all available properties by city
SELECT 
  p.prop_id, p.type, p.rent, p.bedrooms, l.city, p.avail
FROM Properties p
JOIN Location l ON p.location_id = l.location_id
WHERE p.avail = 'Y'
ORDER BY l.city, p.rent;

SELECT DISTINCT avail FROM Properties;
SELECT prop_id, type, rent, bedrooms, location_id, avail FROM Properties;


--View rent payment status for all tenants
SELECT 
  t.tenant_id, u.first_name || ' ' || u.last_name AS name,
  r.amount, r.pay_date, r.status
FROM Rent_Payments r
JOIN Tenants t ON r.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
ORDER BY r.pay_date DESC;



--Monthly rent collection summary
SELECT 
  TO_CHAR(pay_date, 'YYYY-MM') AS month,
  COUNT(*) AS total_payments,
  SUM(amount) AS total_amount
FROM Rent_Payments
WHERE status = 'Paid'
GROUP BY TO_CHAR(pay_date, 'YYYY-MM')
ORDER BY month;



--List tenants who haven’t paid rent
SELECT 
  t.tenant_id,
  u.first_name || ' ' || u.last_name AS tenant_name,
  r.amount, r.pay_date
FROM Rent_Payments r
JOIN Tenants t ON r.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
WHERE r.status = 'Unpaid';


--Property listings sorted by rent (low to high)
SELECT prop_id, type, rent FROM Properties
WHERE avail = 'Y'
ORDER BY rent ASC;


-- Cities with highest number of properties
SELECT l.city, COUNT(p.prop_id) AS total_properties
FROM Properties p
JOIN Location l ON p.location_id = l.location_id
GROUP BY l.city
ORDER BY total_properties DESC;


--PLSQL Queries

--Procedures
--Register a new user
CREATE OR REPLACE PROCEDURE register_user (
  p_user_id       IN USERS.user_id%TYPE,
  p_first_name    IN USERS.first_name%TYPE,
  p_middle_name   IN USERS.middle_name%TYPE,
  p_last_name     IN USERS.last_name%TYPE,
  p_phone_no      IN USERS.phone_no%TYPE,
  p_email         IN USERS.email%TYPE,
  p_street        IN USERS.street%TYPE,
  p_location_id   IN USERS.location_id%TYPE
)
IS
BEGIN
  INSERT INTO USERS (
    user_id, first_name, middle_name, last_name,
    phone_no, email, street, location_id, date_reg
  ) VALUES (
    p_user_id, p_first_name, p_middle_name, p_last_name,
    p_phone_no, p_email, p_street, p_location_id, SYSDATE
  );
END;
/
--Call
BEGIN
  register_user(116, 'Neha', '', 'Chawla', '9876512345', 'neha@gmail.com', 'A-123 Block', 1);
END;
/
Select * from Users;

--Register Complaint
CREATE OR REPLACE PROCEDURE register_complaint (
  p_comp_id    IN COMPLAINTS.comp_id%TYPE,
  p_tenant_id  IN COMPLAINTS.tenant_id%TYPE,
  p_complaint  IN COMPLAINTS.complaint%TYPE
)
IS
BEGIN
  INSERT INTO COMPLAINTS (comp_id, tenant_id, complaint, date_filed)
  VALUES (p_comp_id, p_tenant_id, p_complaint, SYSDATE);
END;
/
--Call
BEGIN
  register_complaint(736, 302, 'Power fluctuations in room');
END;
/
SELECT * FROM Complaints;

--Notify overdue rent
CREATE OR REPLACE PROCEDURE notify_overdue_rent
IS
BEGIN
  FOR rec IN (
    SELECT t.tenant_id
    FROM TENANTS t
    WHERE NOT EXISTS (
      SELECT 1 FROM RENT_PAYMENTS r
      WHERE r.tenant_id = t.tenant_id
        AND EXTRACT(MONTH FROM r.pay_date) = EXTRACT(MONTH FROM SYSDATE)
        AND EXTRACT(YEAR FROM r.pay_date) = EXTRACT(YEAR FROM SYSDATE)
    )
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Tenant ' || rec.tenant_id || ' has not paid rent this month.');
  END LOOP;
END;
/
--Call
BEGIN
  notify_overdue_rent;
END;
/

--FUNCTIONS

--is match found
CREATE OR REPLACE FUNCTION is_match_found(p_tenant_id INT)
RETURN VARCHAR2 IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM Property_Matches
  WHERE tenant_id = p_tenant_id AND status = 'Matched';

  RETURN CASE WHEN v_count > 0 THEN 'Yes' ELSE 'No' END;
END;
/
SELECT is_match_found(301) AS match_status FROM dual;


--Total Rent Paid by Tenant
CREATE OR REPLACE FUNCTION get_total_rent(p_tenant_id INT)
RETURN NUMBER IS
  total NUMBER := 0;
BEGIN
  SELECT SUM(amount)
  INTO total
  FROM Rent_Payments
  WHERE tenant_id = p_tenant_id AND status = 'Paid';
  RETURN NVL(total, 0);
END;
/
SELECT get_total_rent(301) AS total_rent FROM dual;


--Get Tenant Preferred Amenities
CREATE OR REPLACE FUNCTION get_pref_amenities(p_tenant_id INT)
RETURN VARCHAR2 IS
  amenity VARCHAR2(200);
BEGIN
  SELECT amenities INTO amenity
  FROM Preferences
  WHERE tenant_id = p_tenant_id
  FETCH FIRST 1 ROWS ONLY;
  RETURN amenity;
END;
/

SELECT get_pref_amenities(301) AS amenities FROM dual;


--Check If Property Is Already Matched
CREATE OR REPLACE FUNCTION is_property_matched(p_prop_id INT)
RETURN VARCHAR2 IS
  match_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO match_count
  FROM Property_Matches
  WHERE prop_id = p_prop_id AND status = 'Matched';

  RETURN CASE WHEN match_count > 0 THEN 'Yes' ELSE 'No' END;
END;
/

SELECT is_property_matched(401) AS matched FROM dual;

--TRIGGERS

--Trigger1: Set Default Created Date
CREATE OR REPLACE TRIGGER trg_set_created_at
BEFORE INSERT ON Properties
FOR EACH ROW
BEGIN
  :NEW.created_at := SYSDATE;
END;
/
-- Test trig1
INSERT INTO Properties (prop_id, type, rent, bedrooms, location_id, landlord_id, avail)
VALUES (901, 'Studio', 7000, 1, 101, 201, 'Y');
SELECT * FROM Landlords WHERE landlord_id = 201;
SELECT * FROM Location WHERE location_id = 101;
INSERT INTO Location (location_id, city, country)
VALUES (101, 'Amritsar', 'India');
INSERT INTO Properties (prop_id, type, rent, bedrooms, location_id, landlord_id, avail)
VALUES (901, 'Studio', 7000, 1, 101, 201, 'Y');
SELECT prop_id, created_at FROM Properties WHERE prop_id = 901;

SELECT * FROM PROPERTIES;

--Trigger 2: Prevent Rent < 1000
CREATE OR REPLACE TRIGGER trg_min_rent_check
BEFORE INSERT OR UPDATE ON Properties
FOR EACH ROW
BEGIN
  IF :NEW.rent < 1000 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Rent cannot be less than 1000.');
  END IF;
END;
/
-- Test
INSERT INTO Properties (prop_id, type, rent, bedrooms, location_id, landlord_id, avail)
VALUES (902, 'Studio', 800, 1, 101, 201, 'Y');  -- Should raise error
INSERT INTO Properties (prop_id, type, rent, bedrooms, location_id, landlord_id, avail)
VALUES (903, '1BHK', 1200, 1, 101, 201, 'Y');--Test passed
SELECT * FROM PROPERTIES;



--Trigger 4 : Auto Timestamp on Complaint Creation
CREATE OR REPLACE TRIGGER trg_auto_complaint_timestamp
BEFORE INSERT ON Complaints
FOR EACH ROW
BEGIN
  IF :NEW.date_filed IS NULL THEN
    :NEW.date_filed := SYSDATE;
  END IF;
END;
/
-- Test
INSERT INTO Complaints VALUES (706, 303, 'Power issue.', 'Open', NULL, NULL, 'No electricity');
SELECT * FROM Complaints WHERE comp_id = 706;

--Trigger 5: Prevent Duplicate User Phone Numbers
CREATE OR REPLACE TRIGGER trg_unique_phone
BEFORE INSERT OR UPDATE ON Users
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM Users
  WHERE phone_no = :NEW.phone_no AND user_id != :NEW.user_id;

  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Duplicate phone number not allowed.');
  END IF;
END;
/
--Test1
-- This should raise an error since '9876543210' already exists
INSERT INTO Users VALUES (116, 'Test', '', 'User', '9876543210', 'test@example.com', 'Dummy Addr', 1, SYSDATE);




--CURSORS

--Available properties cursor
SET SERVEROUTPUT ON;

DECLARE
  CURSOR cur_available_props IS
    SELECT prop_id, type, rent FROM Properties WHERE avail = 'Y';

BEGIN
  FOR rec IN cur_available_props LOOP
    DBMS_OUTPUT.PUT_LINE('Property ID: ' || rec.prop_id || ' | Type: ' || rec.type || ' | Rent: ₹' || rec.rent);
  END LOOP;
END;
/


--Tenants with open complaints cursor

SET SERVEROUTPUT ON;

DECLARE
  CURSOR cur_open_complaints IS
    SELECT c.comp_id, t.tenant_id, c.status
    FROM Complaints c
    JOIN Tenants t ON c.tenant_id = t.tenant_id
    WHERE c.status = 'Open';

BEGIN
  FOR rec IN cur_open_complaints LOOP
    DBMS_OUTPUT.PUT_LINE('Complaint ID: ' || rec.comp_id || ' | Tenant ID: ' || rec.tenant_id || ' | Status: ' || rec.status);
  END LOOP;
END;
/

--Unpaid rent cursor

SET SERVEROUTPUT ON;

DECLARE
  CURSOR cur_unpaid_rent IS
    SELECT tenant_id, amount, pay_date FROM Rent_Payments
    WHERE status = 'Unpaid';

BEGIN
  FOR rec IN cur_unpaid_rent LOOP
    DBMS_OUTPUT.PUT_LINE('Tenant ID: ' || rec.tenant_id || ' | Unpaid Amount: ₹' || rec.amount || ' | Date: ' || TO_CHAR(rec.pay_date, 'DD-MON-YYYY'));
  END LOOP;
END;
/

--Property match status cursor

SET SERVEROUTPUT ON;

DECLARE
  CURSOR cur_matches IS
    SELECT tenant_id, prop_id, status, match_date FROM Property_Matches;

BEGIN
  FOR rec IN cur_matches LOOP
    DBMS_OUTPUT.PUT_LINE('Tenant ' || rec.tenant_id || ' matched with Property ' || rec.prop_id || ' | Status: ' || rec.status || ' on ' || TO_CHAR(rec.match_date, 'DD-MON-YYYY'));
  END LOOP;
END;
/

--Property count per landlord cursor

SET SERVEROUTPUT ON;

DECLARE
  CURSOR cur_landlord_prop_count IS
    SELECT landlord_id, COUNT(*) AS total_props
    FROM Properties
    GROUP BY landlord_id;

BEGIN
  FOR rec IN cur_landlord_prop_count LOOP
    DBMS_OUTPUT.PUT_LINE('Landlord ID: ' || rec.landlord_id || ' | Property Count: ' || rec.total_props);
  END LOOP;
END;
/










