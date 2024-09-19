-- ***********************
-- Name: Chaerin Yoo
-- ID: 102998234
-- Date: 2024-05-23
-- Purpose: Lab 02 DBS211
-- ***********************

-- Q1 Solution --
SELECT officecode, city, state, country, phone 
FROM DBS211_OFFICES;

-- Q2 Solution --
SELECT employeenumber, firstname, lastname, extension 
FROM DBS211_EMPLOYEES 
WHERE officecode = 1 
ORDER BY employeenumber;

-- Q3 Solution --
SELECT customernumber, customername, contactfirstname, contactlastname, phone 
FROM DBS211_CUSTOMERS 
WHERE LOWER(city) = 'paris' 
ORDER BY customernumber;

-- Q4 Solution --
SELECT customernumber, customername, 
       contactlastname || ', ' || contactfirstname AS contactname, phone 
FROM DBS211_CUSTOMERS 
WHERE LOWER(country) = 'canada' 
ORDER BY customername;

-- Q5 Solution --
SELECT DISTINCT customernumber 
FROM DBS211_PAYMENTS 
ORDER BY customernumber;

-- Q6 Solution --
SELECT customernumber, checknumber, amount 
FROM DBS211_PAYMENTS 
WHERE amount NOT BETWEEN 1500 AND 120000 
ORDER BY amount DESC;

-- Q7 Solution --
SELECT ordernumber, orderdate, status, customernumber 
FROM DBS211_ORDERS 
WHERE LOWER(status) = 'cancelled' 
ORDER BY orderdate;

-- Q8 Solution --
SELECT productcode, productname, buyprice, msrp, 
       (msrp - buyprice) AS markup, 
       ROUND(100 * (msrp - buyprice) / buyprice, 1) AS percmarkup 
FROM DBS211_PRODUCTS 
WHERE ROUND(100 * (msrp - buyprice) / buyprice, 1) > 140 
ORDER BY percmarkup;

-- Q9 Solution --
SELECT productcode, productname, quantityinstock 
FROM DBS211_PRODUCTS 
WHERE LOWER(productname) LIKE '%co%' 
ORDER BY quantityinstock;

-- Q10 Solution --
SELECT customernumber, contactfirstname, contactlastname 
FROM DBS211_CUSTOMERS 
WHERE LOWER(contactfirstname) LIKE 's%' 
  AND LOWER(contactfirstname) LIKE '%e%' 
ORDER BY customernumber;

