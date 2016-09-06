#include "employee.h"

Employee::Employee(const Employee &e) {
	*this = e;
}

Employee& Employee::operator = (const Employee &e) {
	firstName = e.firstName;
	lastName = e.lastName;
	department = e.department;
	salary = e.salary;
	id = e.id;
	return *this;
}

void Employee::setSalary(int s) {
	salary = (s > 0) ? s : salary;
}

void Employee::setDepartment(string dept) {
	department = (dept != "") ? dept : department;
}

void Employee::setId(int newID) {
	id = (newID >= 0) ? newID : id;
}

int Employee::getId() {
	return id;
}

string Employee::getDepartment() {
	return department;
}

void Employee::display(string space) {
	cout << space << "Employment type: employee\n"
		<< space << "id: " << id << "\n"
		<< space << firstName << " " << lastName
		<< space << " age: " << age << " salary: " << salary << "\n"
		<< space << "department: " << department
		<< "\n\n";
}