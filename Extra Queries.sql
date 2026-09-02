-- Extra Queries

--List all legal documents of tenants
SELECT 
  u.first_name || ' ' || u.last_name AS tenant_name,
  d.doc_type, d.doc_url, d.upload_date
FROM Legal_Documents d
JOIN Users u ON d.user_id = u.user_id
JOIN Tenants t ON u.user_id = t.user_id;

--Total rent paid per tenant
SELECT 
  t.tenant_id,
  u.first_name || ' ' || u.last_name AS tenant_name,
  SUM(r.amount) AS total_paid
FROM Rent_Payments r
JOIN Tenants t ON r.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
WHERE r.status = 'Paid'
GROUP BY t.tenant_id, u.first_name, u.last_name
ORDER BY total_paid DESC;

--All unresolved complaints
SELECT 
  c.comp_id, u.first_name || ' ' || u.last_name AS tenant_name,
  c.complaint, c.status, c.date_filed
FROM Complaints c
JOIN Tenants t ON c.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
WHERE c.status IN ('Open', 'In Progress')
ORDER BY c.date_filed DESC;

--Number of properties managed by each landlord
SELECT 
  l.landlord_id,
  u.first_name || ' ' || u.last_name AS landlord_name,
  COUNT(p.prop_id) AS total_properties
FROM Properties p
JOIN Landlords l ON p.landlord_id = l.landlord_id
JOIN Users u ON l.user_id = u.user_id
GROUP BY l.landlord_id, u.first_name, u.last_name
ORDER BY total_properties DESC;

-- Preferences of a specific tenant
SELECT 
  u.first_name || ' ' || u.last_name AS tenant_name,
  pr.min_bedrooms, pr.max_budget, pr.amenities
FROM Preferences pr
JOIN Tenants t ON pr.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
WHERE t.tenant_id = 301;

--List properties that match tenant preferences exactly
SELECT 
  t.tenant_id,
  u.first_name || ' ' || u.last_name AS tenant_name,
  p.prop_id, p.type, p.rent, p.bedrooms, p.add_amen
FROM Preferences pref
JOIN Tenants t ON pref.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
JOIN Properties p ON pref.location_id = p.location_id
WHERE p.rent <= pref.max_budget
  AND p.bedrooms >= pref.min_bedrooms
  AND p.avail = 'Y';

--Get all complaints for a specific tenant
SELECT 
  c.comp_id, c.complaint, c.status, c.date_filed, c.remarks
FROM Complaints c
WHERE c.tenant_id = 301;

--Show all tenants and their matched properties
SELECT 
  pm.tenant_id,
  u.first_name || ' ' || u.last_name AS tenant_name,
  p.prop_id, p.type, l.city, pm.status
FROM Property_Matches pm
JOIN Tenants t ON pm.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
JOIN Properties p ON pm.prop_id = p.prop_id
JOIN Location l ON p.location_id = l.location_id;

--Number of complaints per city
SELECT 
  loc.city,
  COUNT(*) AS total_complaints
FROM Complaints c
JOIN Tenants t ON c.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
JOIN Location loc ON u.location_id = loc.location_id
GROUP BY loc.city
ORDER BY total_complaints DESC;

--Show documents uploaded in the past 30 days
SELECT 
  doc_id, doc_type, doc_url, upload_date
FROM Legal_Documents
WHERE upload_date >= SYSDATE - 30;

--Properties listed in last 7 days
SELECT 
  prop_id, type, rent, bedrooms, list_date
FROM Properties
WHERE list_date >= SYSDATE - 7;

--Top 3 tenants by total rent paid
SELECT 
  t.tenant_id,
  u.first_name || ' ' || u.last_name AS name,
  SUM(r.amount) AS total_paid
FROM Rent_Payments r
JOIN Tenants t ON r.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
WHERE r.status = 'Paid'
GROUP BY t.tenant_id, u.first_name, u.last_name
ORDER BY total_paid DESC
FETCH FIRST 3 ROWS ONLY;

--Average rent by property type
SELECT 
  type,
  ROUND(AVG(rent), 2) AS avg_rent
FROM Properties
GROUP BY type
ORDER BY avg_rent DESC;

--Find tenants whose rent payments are below the average rent of their matched property location
SELECT 
  t.tenant_id,
  u.first_name || ' ' || u.last_name AS tenant_name,
  r.amount AS tenant_rent,
  loc.city,
  (
    SELECT ROUND(AVG(p2.rent), 2)
    FROM Properties p2
    WHERE p2.location_id = loc.location_id
  ) AS avg_city_rent
FROM Rent_Payments r
JOIN Tenants t ON r.tenant_id = t.tenant_id
JOIN Users u ON t.user_id = u.user_id
JOIN Location loc ON u.location_id = loc.location_id
WHERE r.status = 'Paid'
  AND r.amount < (
    SELECT AVG(p2.rent)
    FROM Properties p2
    WHERE p2.location_id = loc.location_id
  );

--Show each landlord's total number of properties, total number of tenants matched to their properties, and total rent collected
SELECT 
  l.landlord_id,
  u.first_name || ' ' || u.last_name AS landlord_name,
  COUNT(DISTINCT p.prop_id) AS total_properties,
  COUNT(DISTINCT pm.tenant_id) AS matched_tenants,
  NVL(SUM(r.amount), 0) AS total_rent_collected
FROM Landlords l
JOIN Users u ON l.user_id = u.user_id
LEFT JOIN Properties p ON p.landlord_id = l.landlord_id
LEFT JOIN Property_Matches pm ON p.prop_id = pm.prop_id AND pm.status = 'Matched'
LEFT JOIN Rent_Payments r ON pm.tenant_id = r.tenant_id AND r.status = 'Paid'
GROUP BY l.landlord_id, u.first_name, u.last_name
ORDER BY total_rent_collected DESC;

--All available properties in a city
SELECT p.*, l.city
FROM Properties p
JOIN Location l ON p.location_id = l.location_id
WHERE p.avail = 'Y' AND l.city = 'Delhi';

--Properties with rent less than ₹15,000
SELECT * FROM Properties WHERE rent < 15000 AND avail = 'Y';

--Match tenants to available properties
SELECT t.tenant_id, p.prop_id, p.rent, p.bedrooms
FROM Preferences pref
JOIN Properties p ON pref.prop_id = p.prop_id
JOIN Tenants t ON pref.tenant_id = t.tenant_id
WHERE p.rent <= pref.max_budget
  AND p.bedrooms >= pref.min_bedrooms
  AND p.avail = 'Y';

--Show all tenants with their matched properties
SELECT pm.tenant_id, pm.status, p.prop_id, p.type
FROM Property_Matches pm
JOIN Properties p ON pm.prop_id = p.prop_id;

--Rent paid by each tenant (with total)
SELECT r.tenant_id, SUM(r.amount) AS total_paid
FROM Rent_Payments r
WHERE r.status = 'Paid'
GROUP BY r.tenant_id;

--Rent not paid yet (identify defaulters)
SELECT tenant_id, amount, pay_date
FROM Rent_Payments
WHERE status = 'Unpaid';

--Monthly rent summary
SELECT TO_CHAR(pay_date, 'YYYY-MM') AS month, SUM(amount) AS collected
FROM Rent_Payments
WHERE status = 'Paid'
GROUP BY TO_CHAR(pay_date, 'YYYY-MM');

--List open/in-progress complaints
SELECT * FROM Complaints WHERE status IN ('Open', 'In Progress');

--Complaint count per tenant
SELECT tenant_id, COUNT(*) AS total_complaints
FROM Complaints
GROUP BY tenant_id;

--Average time to resolve a complaint
SELECT AVG(date_res - date_filed) AS avg_resolution_days
FROM Complaints
WHERE status = 'Closed' AND date_res IS NOT NULL;

--List of all uploaded documents with dates
SELECT doc_type, doc_url, upload_date FROM Legal_Documents;

--Tenants with missing documents (if required doc count < X)
SELECT u.user_id, u.first_name, COUNT(doc_id) AS docs_uploaded
FROM Users u
LEFT JOIN Legal_Documents d ON u.user_id = d.user_id
GROUP BY u.user_id, u.first_name
HAVING COUNT(doc_id) < 2;

-- Properties per landlord
SELECT landlord_id, COUNT(*) AS total_properties
FROM Properties
GROUP BY landlord_id;

--Rent collected from a landlord’s properties
SELECT l.landlord_id, SUM(r.amount) AS total_rent
FROM Landlords l
JOIN Properties p ON l.landlord_id = p.landlord_id
JOIN Property_Matches pm ON pm.prop_id = p.prop_id
JOIN Rent_Payments r ON r.tenant_id = pm.tenant_id
WHERE r.status = 'Paid'
GROUP BY l.landlord_id;

--Average rent per property type
SELECT type, ROUND(AVG(rent), 2) AS avg_rent
FROM Properties
GROUP BY type;

--Landlords with no available properties
SELECT l.landlord_id
FROM Landlords l
WHERE NOT EXISTS (
  SELECT 1 FROM Properties p
  WHERE p.landlord_id = l.landlord_id AND p.avail = 'Y'
);

--Recently listed properties (past 7 days)
SELECT * FROM Properties
WHERE list_date >= SYSDATE - 7;