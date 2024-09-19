-- ***********************
-- Name: Chaerin Yoo
-- ID: 102998234
-- Date: The current date
-- Purpose: Lab 06 DBS211
-- ***********************

SET AUTOCOMMIT ON;

-- Question 1 --
SELECT e.employeeNumber, e.firstName, e.lastName, o.city, o.phone, o.postalCode
FROM DBS211_EMPLOYEES e, DBS211_OFFICES o
WHERE e.officeCode = o.officeCode
  AND o.country = 'France';
  
  SELECT e.employeeNumber, e.firstName, e.lastName, o.city, o.phone, o.postalCode
FROM DBS211_EMPLOYEES e
JOIN DBS211_OFFICES o
  ON e.officeCode = o.officeCode
WHERE o.country = 'France';

-- Question 2 --
SELECT c.customerNumber, c.customerName, 
       TO_CHAR(p.PAYMENTDATE, 'DD/MM/YYYY') AS "Payment Date(DD/MM/YYYY)", 
       p.amount
FROM DBS211_CUSTOMERS c
JOIN DBS211_PAYMENTS p ON c.customerNumber = p.customerNumber
WHERE c.country = 'Canada'
ORDER BY c.customerNumber;

-- Question 3 --
SELECT c.customerNumber, c.customerName
FROM DBS211_CUSTOMERS c
JOIN DBS211_PAYMENTS p ON c.customerNumber = p.customerNumber
WHERE c.country = 'USA'
ORDER By c.customerNumber;

-- Question 4 --
CREATE VIEW vwCustomerOrder AS
SELECT c.customerNumber, o.orderNumber, o.orderDate, p.productName, od.quantityOrdered, od.priceEach
FROM DBS211_CUSTOMERS c
JOIN DBS211_ORDERS o ON c.customerNumber = o.customerNumber
JOIN DBS211_ORDERDETAILS od ON o.orderNumber = od.orderNumber
JOIN DBS211_PRODUCTS p ON od.productCode = p.productCode;

SELECT * FROM vwCustomerOrder;

-- Question 5 --
SELECT v.customerNumber, v.orderNumber, v.orderDate, v.productName, v.quantityOrdered, v.priceEach, od.orderLineNumber
FROM vwCustomerOrder v
JOIN DBS211_ORDERDETAILS od ON v.orderNumber = od.orderNumber AND v.productName = (
  SELECT productName FROM DBS211_PRODUCTS p WHERE p.productCode = od.productCode
)
WHERE v.customerNumber = 124
ORDER BY v.orderNumber, od.orderLineNumber;

-- Question 6 --
SELECT c.customerNumber, c.contactFirstName AS firstName, c.contactLastName AS lastName, c.phone, c.creditLimit
FROM DBS211_CUSTOMERS c
LEFT JOIN DBS211_ORDERS o ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL;

-- Question 7 --
CREATE VIEW vwEmployeeManager AS
SELECT e.employeeNumber, e.lastName, e.firstName, e.extension, e.email, e.officeCode, e.reportsTo, e.jobTitle,
       m.firstName AS managerFirstName, m.lastName AS managerLastName
FROM DBS211_EMPLOYEES e
LEFT JOIN DBS211_EMPLOYEES m ON e.reportsTo = m.employeeNumber;

SELECT * FROM vwEmployeeManager;

-- Question 8 --
CREATE OR REPLACE VIEW vwEmployeeManager AS
SELECT e.employeeNumber, e.lastName, e.firstName, e.extension, e.email, e.officeCode, e.reportsTo, e.jobTitle,
       m.firstName AS managerFirstName, m.lastName AS managerLastName
FROM DBS211_EMPLOYEES e
JOIN DBS211_EMPLOYEES m ON e.reportsTo = m.employeeNumber;

SELECT * FROM vwEmployeeManager;

-- Question 9 --
DROP VIEW vwCustomerOrder;

DROP VIEW vwEmployeeManager;




