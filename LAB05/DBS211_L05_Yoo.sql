-- ***********************
-- Name: Chaerin Yoo
-- ID: 102998234
-- Date: The current date
-- Purpose: Lab 06 DBS211
-- ***********************

-- Question 1 --

SELECT e.employee_number, e.first_name, e.last_name, l.city, l.phone_number, l.postal_code
FROM employees e, locations l
WHERE e.location_id = l.location_id
  AND l.country = 'France';

