-- ***********************
-- Name: Chaerin Yoo
-- ID:102998234
-- Date: June 14
-- Purpose: Assignment 01 DBS211
-- ***********************

-- Q1 SOLUTION --
SELECT e.employeenumber AS "Employee Number",
   e.firstname || ', ' || e.lastname AS "Employee Name",
   o.phone AS "Phone",
   e.extension AS "Extension",
   o.city AS "City",
   COALESCE(to_char(e.reportsto), 'Unknown') AS "Manager ID",
   COALESCE(
      (
         SELECT ee.firstname || ' ' || ee.lastname
         FROM dbs211_employees ee
         WHERE e.reportsto = ee.employeenumber
      ),
      'Unknown'
   ) AS "Manager Name"
FROM dbs211_employees e
   LEFT JOIN dbs211_offices o ON e.officecode = o.officecode
WHERE e.reportsto IS NULL
ORDER BY e.employeenumber;

-- Q2 SOLUTION --   
SELECT e.employeenumber AS "Employee Number",
   e.firstname || ' ' || e.lastname AS "Employee Name",
   o.phone AS "Phone",
   e.extension AS "Extension",
   o.city AS "City"
FROM dbs211_employees e
   INNER JOIN dbs211_offices o ON e.officecode = o.officecode
WHERE o.city IN (
      'NYC',
      'Tokyo',
      'Paris'
   )
ORDER BY o.city,
   e.employeenumber;
   
-- Q3 SOLUTION --
SELECT e.employeenumber AS "Employee Number",
   e.firstname || ', ' || e.lastname AS "Employee Name",
   o.phone AS "Phone",
   e.extension AS "Extension",
   o.city AS "City",
   e.reportsto AS "Manager ID",
   (
      SELECT ee.firstname || ' ' || ee.lastname
      FROM dbs211_employees ee
      WHERE e.reportsto = ee.employeenumber
   ) AS "Manager Name"
FROM dbs211_employees e
   INNER JOIN dbs211_offices o ON e.officecode = o.officecode
WHERE o.city IN (
      'NYC',
      'Tokyo',
      'Paris'
   )
ORDER BY o.city,
   e.employeenumber;


-- Q4 SOLUTION --
SELECT e.employeenumber AS "Manager ID",
   e.firstname || ' ' || e.lastname AS "Manager Name",
   o.country AS "Country",
   CASE
      WHEN e.reportsto IS NULL THEN 'Does not report to anyone'
      ELSE 'Report to ' || (
         SELECT ee.firstname || ' ' || ee.lastname || '(' || ee.jobtitle || ')'
         FROM dbs211_employees ee
         WHERE e.reportsto = ee.employeenumber
      )
   END AS "Reoprt to"
FROM dbs211_employees e
   INNER JOIN dbs211_offices o ON e.officecode = o.officecode
WHERE (
      e.reportsto = 1002
      OR e.reportsto = 1056
      OR e.reportsto IS NULL
   )
   AND e.employeenumber != 1076
ORDER BY e.employeenumber;

-- Q5 SOLUTION --
SELECT
    c.customernumber,
    c.customername,
    od.productcode,
    p.msrp AS "Old Price",
    ROUND(p.msrp * 0.90, 2) AS "New Price"
FROM
    dbs211_customers c
    JOIN dbs211_orders o ON c.customernumber = o.customernumber
    JOIN dbs211_orderdetails od ON o.ordernumber = od.ordernumber
    JOIN dbs211_products p ON od.productcode = p.productcode
WHERE
    p.productvendor = 'Exoto Designs'
    AND od.quantityordered > 55
ORDER BY
    c.customernumber, od.productcode;
    
-- Q6 SOLUTION --
SELECT
   MAX(o.priceeach) AS "Maximum Price" 
FROM
   dbs211_products p 
   JOIN
      dbs211_orderdetails o 
      ON p.productcode = o.productcode 
WHERE
   UPPER(p.productcode) = 'S10_1678';
   



