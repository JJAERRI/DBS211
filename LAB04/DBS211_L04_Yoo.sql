-- ***********************
-- Name: Chaerin Yoo
-- ID: 102998234
-- Date: The current date
-- Purpose: Lab 04 DBS211
-- ***********************

SET AUTOCOMMIT ON;

--1.	Create a new empty table employee2 the same as table employees.  Use a single statement to create the table and insert the data at the same time.
CREATE TABLE employee2 AS
SELECT * FROM DBS211_employees;

--2.	Modify table employee2 and add a new column username to this table. The value of this column is not required and does not have to be unique.
ALTER TABLE employee2 ADD (username VARCHAR2(50));

--3.	Delete all the data in the employee2 table
DELETE FROM employee2;

--4.	Re-insert all data from the employees table into your new table employee2 using a single statement. 
INSERT INTO employee2 AS
SELECT * FROM dbs211_employees;

--5.	Create a statement that will insert yourself as an employee into employee2.  
--a.	Use a unique employee number of your choice (Hint: Find the highest value of the employee number in the dbs211_employees table, increase the value by one and use it as your employee number.)
--To find the highest value of the employee number you can sort the rows in the descending order. The first row will then contain the highest value.
--Or, you can run the following statement (Do not include this statement in your submission.)
--This statement returns the maximum value of the employee number in table dbs211_employees.
--b.	Use your school email address
--c.	Your extension is ¡®x2222¡¯
--d.	Your job title will be ¡°Cashier¡±
--e.	Office code will be 4
--f.	You will report to employee 1088
--g.	You do not have any username

INSERT INTO employee2 (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES ((SELECT MAX(employeeNumber) + 1 FROM dbs211_employees), 'Yoo', 'Chaerin', 'x2222', 'cyoo10@myseneca.ca', 4, 1088, 'Cashier');

--6.	Create a query that displays your, and only your, employee data.
SELECT * FROM employee2
WHERE email = 'cyoo10@myseneca.ca';


--7.	Create a statement to update your job title to ¡°Head Cashier¡±.
--Hint: Be careful. You may update other rows or all rows in the employee table. You only need to update one row which belongs to you and update your job title. Make sure that your query updates only one employee using a WHERE clause.
UPDATE employee2
SET jobTitle = 'Head Cashier'
WHERE jobTitle = 'Cashier';

--8.	Create a statement to insert another fictional employee into employee2.  This employee will be a ¡°Cashier¡± and will report to you.  Make up fake data for the other fields. The fake employee does not have any username.
INSERT INTO employee2 (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES ((SELECT MAX(employeeNumber) + 1 FROM employee2), 'Holland', 'Tom', 'x3333', 'tom@myseneca.ca', 4, (SELECT employeeNumber FROM employee2 WHERE email = 'cyoo10@myseneca.ca'), 'Head Cashier');

--9.	Create a statement to delete yourself from employee2.  Did it work?  If not, why?
DELETE FROM employee2
WHERE email = 'cyoo10@myseneca.ca';
-- If it didn't work, it could be because of referential integrity constraints or because there are employees reporting to me.

--10.	Create a statement to delete the fake employee from employee2 and then rerun the statement to delete yourself.  Did it work? Explain why?
DELETE FROM employee2
WHERE email = 'tom@myseneca.ca';

DELETE FROM employee2
WHERE email = 'cyoo10@myseneca.ca';
-- After deleting the fake employee, I should be able to delete myself since no other employee reports to me now.

--11.	Create a single statement that will insert both yourself and the fake employee at the same time.  This time you and the fake employee will report to 1088.
INSERT ALL
INTO employee2 (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) VALUES ((SELECT MAX(employeeNumber) + 1 FROM employees),  'Yoo', 'Chaerin', 'x2222', 'cyoo10@myseneca.ca', 4, 1088, 'Cashier')
INTO employee2 (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) VALUES ((SELECT MAX(employeeNumber) + 2 FROM employees), 'Holland', 'Tom', 'x3333', 'tom@myseneca.ca', 4, 1088, 'Cashier')
SELECT * FROM DUAL;

--12.	Create a single statement to delete both yourself and the fake employee from employee2.
DELETE FROM employee2
WHERE email IN ('cyoo10@myseneca.ca', 'tom@myseneca.ca');

--13.	In table employee2, generate the email address for column username for each student by concatenating the first character of employee¡¯s first name and the employee¡¯s last name. For instance, the username of employee Peter Stone will be pstone. NOTE: the username is in all lower case letters.  
UPDATE employee2
SET username = LOWER(SUBSTR(firstName, 1, 1) || lastName);

--14.	In table employee2, remove all employees with office code 4. 
DELETE FROM employee2
WHERE officeCode = 4;

--15.	Drop table employee2. 
DROP TABLE employee2;
