// DBS211NCC - GroupProject(Milestone2)
// Group Number: 6
// Student Name: Chaerin Yoo, Jisoo Park, Ahram Lee
// Student ID: Chaerin Yoo(102998234), Jisoo Park(126427236), Ahram Lee(133849232)
// Date: 2024-07-30

#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <occi.h>
#include <string.h>
#include <cstring>
using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

// Employee struct to store employee details
struct Employee
{
    int employeeNumber;
    char lastName[50];
    char firstName[50];
    char extension[10];
    char email[100];
    char officecode[10];
    int reportsTo;
    char jobTitle[50];
};

// Function prototypes
int getInt(const char* prompt);
int findEmployee(Connection* conn, int employeeNumber, struct Employee* emp);
void getEmployee(Employee* emp);
void insertEmployee(Connection* conn, struct Employee emp);
void displayEmployee(Connection* conn, struct Employee emp);
int menu();
void displayAllEmployees(Connection* conn);
void deleteEmployee(Connection* conn, int employeeNumber);
void updateEmployee(Connection* conn, int employeeNumber);

int main(void)
{
    int number = 0;
    bool check = true;
    /* OCCI Variables */
    Environment* env = nullptr;
    Connection* conn = nullptr;
    /* Used Variables */
    string user = "DBS211_242NCC14"; // Chaerin's User ID
    string pass = "20010904"; // Chaerin's Password
    string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";

    try {
        env = Environment::createEnvironment(Environment::DEFAULT);
        conn = env->createConnection(user, pass, constr);
        while (check)
        {
            number = menu(); // Display menu and get user choice
            int employeeNum;
            switch (number)
            {
            case 1:
                employeeNum = getInt("Enter Employee Number: ");
                Employee emp1;
                if (findEmployee(conn, employeeNum, &emp1))
                {
                    displayEmployee(conn, emp1); // Display employee details
                }
                else
                    cout << "Employee " << employeeNum << " does not exist." << endl << endl;
                break;
            case 2:
                displayAllEmployees(conn); // Display all employees
                cout << endl;
                break;
            case 3:
                Employee temp;
                getEmployee(&temp); // Get new employee details
                insertEmployee(conn, temp); // Insert new employee
                break;
            case 4:
                employeeNum = getInt("Enter Employee Number: ");
                updateEmployee(conn, employeeNum); // Update employee details
                break;
            case 5:
                employeeNum = getInt("Enter Employee Number: ");
                deleteEmployee(conn, employeeNum); // Delete employee
                break;
            default:
                cout << "Exiting..." << endl;
                check = false;
                break;
            }
        }
        env->terminateConnection(conn);
        Environment::terminateEnvironment(env);
    }
    catch (SQLException& sqlExcp) {
        cout << "error";
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }

    return 0;
}

// Function to get an integer input with validation
int getInt(const char* prompt)
{
    int val;
    int flag = 0;
    if (prompt)
        cout << prompt;
    do {
        cin >> val;
        if (cin.fail())
        {
            cout << "Bad integer value, try again: ";
            cin.clear();
            while (cin.get() != '\n');
        }
        else if (cin.get() != '\n')
        {
            cout << "Enter only an integer, try again: ";
            while (cin.get() != '\n');
        }
        else flag = 1;

    } while (flag == 0);
    return val;
}

// Function to display menu and get user choice
int menu()
{
    int choice = 0;
    cout << "********************* HR Menu *********************" << endl;
    cout << "1) Find Employee" << endl;
    cout << "2) Employees Report" << endl;
    cout << "3) Add Employee" << endl;
    cout << "4) Update Employee" << endl;
    cout << "5) Remove Employee" << endl;
    cout << "0) Exit" << endl;
    cout << "Enter an option (0-5): ";

    int number = 0;
    bool check = true;
    char letter = 'X';

    while (check) {
        cin >> number;
        letter = cin.get();
        if (cin.fail()) {
            cout << "Bad integer value, try again: ";
            cin.clear();
            cin.ignore(1000, '\n');
        }
        else if (letter != '\n') {
            cout << "Enter only an integer, try again: ";
            cin.clear();
            cin.ignore(1000, '\n');
        }
        else if (0 > number || number > 5) {
            cout << "Enter an option (0-5): ";
        }
        else {
            check = false;
        }
    }
    return number;
}

// Function to display all employees
void displayAllEmployees(Connection* conn)
{
    Statement* stmt = nullptr;
    stmt = conn->createStatement();

    ResultSet* rs = nullptr;
    rs = stmt->executeQuery("SELECT e.employeenumber AS ID, e.firstname || ' ' || e.lastname AS \"Employee Name\", e.email, o.phone, e.extension, d.firstname || ' ' || d.lastname AS \"Manager Name\" FROM dbs211_employees e JOIN dbs211_offices o ON e.officecode = o.officecode Left OUTER JOIN dbs211_employees d ON e.reportsto = d.employeenumber ORDER BY e.employeenumber");

    if (!rs->next())
    {
        cout << "ResultSet is empty." << endl;
    }
    else {
        cout << "------   ---------------    ---------------------------------  ----------------  ---------   -----------------" << endl;
        cout << "ID       Employee Name      Email                              Phone             Extension   Manager          " << endl;
        cout << "-----    ---------------    ---------------------------------  ----------------  ---------   -----------------" << endl;
        do {
            int id = rs->getInt(1);
            string name = rs->getString(2);
            string email = rs->getString(3);
            string phone = rs->getString(4);
            string extension = rs->getString(5);
            string managerName = rs->getString(6);

            cout.setf(ios::left);
            cout.width(9);
            cout << id;
            cout.unsetf(ios::left);

            cout.setf(ios::left);
            cout.width(19);
            cout << name;
            cout.unsetf(ios::left);

            cout.setf(ios::left);
            cout.width(35);
            cout << email;
            cout.unsetf(ios::left);

            cout.setf(ios::left);
            cout.width(18);
            cout << phone;
            cout.unsetf(ios::left);

            cout.setf(ios::left);
            cout.width(12);
            cout << extension;
            cout.unsetf(ios::left);

            cout << managerName << endl;
        } while (rs->next());
    }
}

// Function to get new employee details
void getEmployee(Employee* emp)
{
    char office[10] = "1";
    int report = 1002;
    cout << endl << "-------------- New Employee Information -------------" << endl;
    cout << "Employee Number: ";
    cin >> emp->employeeNumber;
    cout << "Last Name: ";
    cin >> emp->lastName;
    cout << "First Name: ";
    cin >> emp->firstName;
    cout << "Extension: ";
    cin >> emp->extension;
    cout << "Email: ";
    cin >> emp->email;
    cout << "Office Code: 1" << endl;
    strncpy(emp->officecode, office, 9);
    cout << "Manager ID: 1002" << endl;
    emp->reportsTo = report;
    cout << "Job Title: ";
    cin >> emp->jobTitle;
    cout << endl;
}

// Function to find an employee by employee number
int findEmployee(Connection* conn, int employeeNumber, Employee* emp)
{
    int res = 0;
    Statement* stmt = conn->createStatement();
    stmt->setSQL("SELECT * FROM dbs211_employees where employeenumber=:1");
    stmt->setInt(1, employeeNumber);
    ResultSet* rs = stmt->executeQuery();
    if (rs->next())
    {
        res = 1;
        if (emp)
        {
            emp->employeeNumber = rs->getInt(1);
            strncpy_s(emp->lastName, rs->getString(2).c_str(), 49);
            strncpy_s(emp->firstName, rs->getString(3).c_str(), 49);
            strncpy_s(emp->extension, rs->getString(4).c_str(), 9);
            strncpy_s(emp->email, rs->getString(5).c_str(), 99);
            strncpy_s(emp->officecode, rs->getString(6).c_str(), 9);
            emp->reportsTo = rs->getInt(7);
            strncpy_s(emp->jobTitle, rs->getString(8).c_str(), 49);
        }
    }
    conn->terminateStatement(stmt);
    return res;
}

// Function to display employee details
void displayEmployee(Connection* conn, Employee ep)
{
    cout << endl << "-------------- Employee Information -------------" << endl;
    cout << "Employee Number: " << ep.employeeNumber << endl;
    cout << "Last Name: " << ep.lastName << endl;
    cout << "First Name: " << ep.firstName << endl;
    cout << "Extension: " << ep.extension << endl;
    cout << "Email: " << ep.email << endl;
    cout << "Office Code: " << ep.officecode << endl;
    cout << "Manager ID: " << ep.reportsTo << endl;
    cout << "Job Title: " << ep.jobTitle << endl << endl;
}

// Function to insert a new employee into the database
void insertEmployee(Connection* conn, struct Employee emp)
{
    if (findEmployee(conn, emp.employeeNumber, nullptr))
    {
        cout << "An employee with the same employee number exists." << endl << endl;
    }
    else
    {
        Statement* stmt = conn->createStatement();
        stmt->setSQL("INSERT INTO dbs211_employees(employeenumber, lastname, firstname, extension, email, officecode, reportsto, jobtitle) VALUES(:1, :2, :3, :4, :5, :6, :7, :8)");
        stmt->setInt(1, emp.employeeNumber);
        stmt->setString(2, emp.lastName);
        stmt->setString(3, emp.firstName);
        stmt->setString(4, emp.extension);
        stmt->setString(5, emp.email);
        stmt->setString(6, emp.officecode);
        stmt->setInt(7, emp.reportsTo);
        stmt->setString(8, emp.jobTitle);
        stmt->executeUpdate();
        cout << "The new employee is added successfully." << endl << endl;
        conn->commit();
        conn->terminateStatement(stmt);
    }
}

// Function to delete an employee from the database
void deleteEmployee(Connection* conn, int employeeNumber)
{
    if (!findEmployee(conn, employeeNumber, nullptr))
    {
        cout << "The employee with ID " << employeeNumber << " does not exist." << endl;
    }
    else
    {
        Statement* stmt = conn->createStatement();
        stmt->setSQL("DELETE FROM dbs211_employees WHERE employeenumber = :1");
        stmt->setInt(1, employeeNumber);
        stmt->executeUpdate();
        cout << "The employee with ID " << employeeNumber << " is deleted successfully." << endl << endl;
        conn->commit();
        conn->terminateStatement(stmt);
    }
}

// Function to update employee details
void updateEmployee(Connection* conn, int employeeNumber)
{
    Employee emp;

    if (findEmployee(conn, employeeNumber, &emp)) {
        cout << "Last Name: " << emp.lastName << endl;
        cout << "First Name: " << emp.firstName << endl;
        cout << "Extension: ";

        cin >> emp.extension;

        Statement* stmt = conn->createStatement();

        stmt->setSQL("UPDATE dbs211_employees SET EXTENSION = :1 where employeenumber = :2");

        stmt->setString(1, emp.extension);
        stmt->setInt(2, emp.employeeNumber);

        stmt->executeUpdate();

        cout << "The employee's extension is updated successfully." << endl << endl;
        conn->commit();
        conn->terminateStatement(stmt);
    }
    else cout << "The employee with ID " << employeeNumber << " does not exist." << endl << endl;
}
