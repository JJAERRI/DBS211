-- ***********************
-- Name: Chaerin Yoo
-- ID: 102998234
-- Date: 2024-07-10
-- Purpose: Lab 07 DBS211
-- ***********************

-- PartA 1--
1. SET TRANSACTION READ WRITE;
2. INSERT INTO table_name (column1, column2) VALUES (value1, value2);
3. UPDATE table_name SET column1 = value1 WHERE condition;
4. DELETE FROM table_name WHERE condition;

-- PartA 2--
CREATE TABLE newEmployees AS SELECT * FROM employees WHERE 1=0;

-- PartA 3--
SET AUTOCOMMIT OFF;
SET TRANSACTION READ WRITE;

-- PartA 4--
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (100, 'Ralph', 'Patel', 'rpatel@mail.com', '22333', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 1);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (101, 'Betty', 'Denis', 'bdenis@mail.com', '33444', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 4);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (102, 'Ben', 'Biri', 'bbirir@mail.com', '44555', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 2);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (103, 'Chad', 'Newman', 'cnewman@mail.com', '66777', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 3);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (104, 'Audrey', 'Ropeburn', 'aropebur@mail.com', '77888', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 1);


-- PartA 5--
SELECT * FROM newEmployees;
--  How many rows are selected? 5

-- PartA 6--;
ROLLBACK;
SELECT * FROM newEmployees;
-- How many rows are selected? 0

-- PartA 7--
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (100, 'Ralph', 'Patel', 'rpatel@mail.com', '22333', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 1);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (101, 'Betty', 'Denis', 'bdenis@mail.com', '33444', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 4);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (102, 'Ben', 'Biri', 'bbirir@mail.com', '44555', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 2);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (103, 'Chad', 'Newman', 'cnewman@mail.com', '66777', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 3);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (104, 'Audrey', 'Ropeburn', 'aropebur@mail.com', '77888', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 1);

COMMIT;
SELECT * FROM newEmployees;
--How many rows are selected? 5


-- PartA 8--
UPDATE newEmployees SET JOB_ID = 'unknown';
SELECT * FROM newEmployees;


-- PartA 9--


-- PartA 10--
ROLLBACK;
SELECT * FROM newEmployees WHERE JOB_ID = 'unknown';
--How many rows are still updated? 0
-- Was the rollback command effective? YES
-- What was the difference between the result of the rollback execution from Task 6 and the result of the rollback execution of this task?
-- Answer: Task 6 rollback reverted the entire transaction, removing all rows. This task rollback reverted the update only, no rows were set to 'unknown'.


-- PartA 11--
DELETE FROM newEmployees WHERE employee_ID IN (100, 101);

-- PartA 12--
CREATE VIEW vwNewEmps AS SELECT * FROM newEmployees ORDER BY last_name, first_name;

-- PartA 13--
ROLLBACK;
SELECT * FROM newEmployees;
-- How many employees are now in the newEmployees table? 5
-- Was the rollback effective and why? Yes, because the deletion was undone


-- PartA 14--
SET TRANSACTION READ WRITE;
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (100, 'Ralph', 'Patel', 'rpatel@mail.com', '22333', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 1);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (101, 'Betty', 'Denis', 'bdenis@mail.com', '33444', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 4);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (102, 'Ben', 'Biri', 'bbirir@mail.com', '44555', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 2);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (103, 'Chad', 'Newman', 'cnewman@mail.com', '66777', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 3);
INSERT INTO newEmployees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES (104, 'Audrey', 'Ropeburn', 'aropebur@mail.com', '77888', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Sales Rep', NULL, NULL, NULL, 1);


-- PartA 15--
SAVEPOINT insertion;

-- PartA 16--
UPDATE newEmployees SET job_id = 'unknown';
SELECT * FROM newEmployees;

-- PartA 17--
ROLLBACK TO insertion;
SELECT * FROM newEmployees;

-- PartA 18--
ROLLBACK;
SELECT * FROM newEmployees;
--Describe: No rows will be present as the entire transactions is rolled back.

-------------------------------------------

--PartB 1--
REVOKE ALL ON newEmployees FROM PUBLIC;

--PartB 2--
GRANT SELECT ON newEmployees TO classmate_login;

--PartB 3--
GRANT INSERT, UPDATE, DELETE ON newEmployees TO classmate_login;

--PartB 4--
REVOKE ALL ON newEmployees FROM classmate_login;

-----------------------------------

--PartC--
DROP VIEW vwNewEmps;
DROP TABLE newEmployees;


