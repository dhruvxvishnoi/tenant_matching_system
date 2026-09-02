--Extra plsql functions

--Last Payment Date

CREATE OR REPLACE FUNCTION last_payment_date(p_tenant_id INT)
RETURN DATE IS
  last_date DATE;
BEGIN
  SELECT MAX(pay_date)
  INTO last_date
  FROM Rent_Payments
  WHERE tenant_id = p_tenant_id AND status = 'Paid';
  RETURN last_date;
END;
/

SELECT last_payment_date(301) AS last_paid_on FROM dual;

--Is Tenant in Default
CREATE OR REPLACE FUNCTION is_tenant_default(p_tenant_id INT)
RETURN VARCHAR2 IS
  count_unpaid NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO count_unpaid
  FROM Rent_Payments
  WHERE tenant_id = p_tenant_id AND status = 'Unpaid';
  RETURN CASE WHEN count_unpaid > 0 THEN 'Yes' ELSE 'No' END;
END;
/

SELECT is_tenant_default(301) AS default_status FROM dual;

-- Average Rent Paid
CREATE OR REPLACE FUNCTION avg_rent_paid(p_tenant_id INT)
RETURN NUMBER IS
  avg_amt NUMBER;
BEGIN
  SELECT AVG(amount)
  INTO avg_amt
  FROM Rent_Payments
  WHERE tenant_id = p_tenant_id AND status = 'Paid';
  RETURN NVL(avg_amt, 0);
END;
/

SELECT avg_rent_paid(301) AS avg_paid FROM dual;

--Count Rent Payments
CREATE OR REPLACE FUNCTION rent_payment_count(p_tenant_id INT)
RETURN NUMBER IS
  total NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO total
  FROM Rent_Payments
  WHERE tenant_id = p_tenant_id;
  RETURN total;
END;
/

SELECT rent_payment_count(301) AS payments_made FROM dual;

-- Complaint Count
CREATE OR REPLACE FUNCTION complaint_count(p_tenant_id INT)
RETURN NUMBER IS
  total NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO total
  FROM Complaints
  WHERE tenant_id = p_tenant_id;
  RETURN total;
END;
/

SELECT complaint_count(301) AS complaints FROM dual;

--Has Open Complaints
CREATE OR REPLACE FUNCTION has_open_complaints(p_tenant_id INT)
RETURN VARCHAR2 IS
  cnt NUMBER;
BEGIN
  SELECT COUNT(*) INTO cnt
  FROM Complaints
  WHERE tenant_id = p_tenant_id AND status = 'Open';
  RETURN CASE WHEN cnt > 0 THEN 'Yes' ELSE 'No' END;
END;
/

SELECT has_open_complaints(301) AS open_status FROM dual;


--Complaint Status by ID
CREATE OR REPLACE FUNCTION get_complaint_status(p_comp_id INT)
RETURN VARCHAR2 IS
  status VARCHAR2(20);
BEGIN
  SELECT status INTO status
  FROM Complaints
  WHERE comp_id = p_comp_id;
  RETURN status;
END;
/

SELECT get_complaint_status(701) AS status FROM dual;


--Average Resolution Time

CREATE OR REPLACE FUNCTION avg_res_time
RETURN NUMBER IS
  avg_days NUMBER;
BEGIN
  SELECT AVG(date_res - date_filed)
  INTO avg_days
  FROM Complaints
  WHERE status = 'Closed' AND date_res IS NOT NULL;
  RETURN ROUND(avg_days, 2);
END;
/

SELECT avg_res_time AS avg_days FROM dual;

--Days Since Last Complaint
CREATE OR REPLACE FUNCTION days_since_last_complaint(p_tenant_id INT)
RETURN NUMBER IS
  days_passed NUMBER;
BEGIN
  SELECT SYSDATE - MAX(date_filed)
  INTO days_passed
  FROM Complaints
  WHERE tenant_id = p_tenant_id;
  RETURN days_passed;
END;
/
SELECT days_since_last_complaint(301) AS days_ago FROM dual;

-- Matched Property Count

CREATE OR REPLACE FUNCTION match_count(p_tenant_id INT)
RETURN NUMBER IS
  count_match NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO count_match
  FROM Property_Matches
  WHERE tenant_id = p_tenant_id AND status = 'Matched';
  RETURN count_match;
END;
/

SELECT match_count(301) AS matched_props FROM dual;

CREATE OR REPLACE PROCEDURE Get_Unpaid_Tenants IS
BEGIN
    FOR t IN (
        SELECT t.tenant_id, t.name, t.contact_number
        FROM Tenants t
        JOIN Rent_Payments r ON t.tenant_id = r.tenant_id
        WHERE r.status = 'Unpaid'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Tenant ID: ' || t.tenant_id || ', Name: ' || t.name || ', Contact: ' || t.contact_number);
    END LOOP;
END;
/
