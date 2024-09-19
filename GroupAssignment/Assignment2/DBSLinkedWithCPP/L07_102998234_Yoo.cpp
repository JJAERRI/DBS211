#include <iostream>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

// Function to print the report of employees working in San Francisco
void printEmployeeReport(Connection* conn) {
    // SQL statement to select employees working in San Francisco
    Statement* stmt = conn->createStatement(
        "SELECT e.EMPLOYEENUMBER, e.FIRSTNAME, e.LASTNAME, e.EXTENSION, o.PHONE "
        "FROM DBS211_EMPLOYEES e "
        "JOIN DBS211_OFFICES o ON e.OFFICECODE = o.OFFICECODE "
        "WHERE o.CITY = 'San Francisco' "
        "ORDER BY e.EMPLOYEENUMBER"
    );
    ResultSet* rs = stmt->executeQuery();

    // Print the report header
    cout << "---------------- Report 1 (Employee Report) ----------------\n";
    cout << "Employee ID | First Name | Last Name | Phone | Extension\n";
    cout << "-----------------------------------------------------------\n";

    // Print the result set
    while (rs->next()) {
        cout << rs->getInt(1) << " | " << rs->getString(2) << " | " << rs->getString(3)
            << " | " << rs->getString(5) << " | " << rs->getString(4) << endl;
    }

    conn->terminateStatement(stmt);
}

// Function to print the report of managers
void printManagerReport(Connection* conn) {
    // SQL statement to select employees with job title containing 'Manager'
    Statement* stmt = conn->createStatement(
        "SELECT e.EMPLOYEENUMBER, e.FIRSTNAME, e.LASTNAME, e.EXTENSION, o.PHONE "
        "FROM DBS211_EMPLOYEES e "
        "JOIN DBS211_OFFICES o ON e.OFFICECODE = o.OFFICECODE "
        "WHERE e.JOBTITLE LIKE '%Manager%' "
        "ORDER BY e.EMPLOYEENUMBER"
    );
    ResultSet* rs = stmt->executeQuery();

    // Print the report header
    cout << "---------------- Report 2 (Manager Report) ----------------\n";
    cout << "Employee ID | First Name | Last Name | Phone | Extension\n";
    cout << "-----------------------------------------------------------\n";

    // Print the result set
    while (rs->next()) {
        cout << rs->getInt(1) << " | " << rs->getString(2) << " | " << rs->getString(3)
            << " | " << rs->getString(5) << " | " << rs->getString(4) << endl;
    }

    conn->terminateStatement(stmt);
}

int main() {
    /* OCCI Variables */
    Environment* env = nullptr; // OCCI environment object
    Connection* conn = nullptr; // OCCI connection object
    /* Used Variables */
    string user = "DBS211_242NCC14"; // Replace with my actual username
    string pass = "20010904"; // Replace with my actual password
    string constr = "myoracle12c.senecacollege.ca:1521/oracle12c"; // Connection string

    try {
        // Create OCCI environment
        env = Environment::createEnvironment(Environment::DEFAULT);
        // Create connection to the database
        conn = env->createConnection(user, pass, constr);

        // Generate and print Employee Report
        printEmployeeReport(conn);

        // Generate and print Manager Report
        printManagerReport(conn);

        // Terminate the connection and environment
        env->terminateConnection(conn);
        Environment::terminateEnvironment(env);
    }
    catch (SQLException& sqlExcp) {
        // Handle SQL exceptions
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
    return 0;
}
