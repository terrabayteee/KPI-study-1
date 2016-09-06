#include "database.h"

bool DataBase::loadFromFile(const string file) {
	ifstream inFile(file);
	if (inFile.fail())
		return false;
	string line = "";
	while (getline(inFile, line)) {
		stringstream strStr(line);
		string tmp = "";
		int employeeType, employeeID, employeeAge, employeeSalary;
		string employeeName, employeeSername, employeeDepartment;
			
		getline(strStr, tmp, ';');
		employeeType = stoi(tmp);
		getline(strStr, tmp, ';');
		employeeID = stoi(tmp);
		getline(strStr, employeeName, ';');
		getline(strStr, employeeSername, ';');
		getline(strStr, tmp, ';');
		employeeAge = stoi(tmp);
		getline(strStr, employeeDepartment, ';');
		getline(strStr, tmp, ';');
		employeeSalary = stoi(tmp);

		if (employeeType == 1) {
			Manager *manager = new Manager(employeeName, employeeSername, employeeAge, employeeID);
			manager->setSalary(employeeSalary);
			manager->setDepartment(employeeDepartment);
			hireEmployee(manager);
		}
		else if (employeeType == 0) {
			Employee *emploee = new Employee(employeeName, employeeSername, employeeAge, employeeID);
			emploee->setSalary(employeeSalary);
			emploee->setDepartment(employeeDepartment);
			hireEmployee(emploee);
		}
		else
			return false;
	}
	return true;
}

void DataBase::arrangeSubordinates() {
	vector<Person *>::iterator itr, it = itr = employees.begin();
	while (it != employees.end()) {
		if (typeid(**it) == typeid(Manager)) {
			string str = dynamic_cast<Manager *>(*it)->getDepartment();
			while (itr != employees.end()) {
				string str1 = dynamic_cast<Employee *>(*itr)->getDepartment();
				if (typeid(**itr) != typeid(Manager) && str1 == str)
					dynamic_cast<Manager *>(*it)->addSubordinate(*itr);
				itr++;
			}
		}
		it++;
	}
}

Person* DataBase::hireEmployee(Person *p) {
	if (p != NULL) {
		bool foundFlag = false;
		vector<Person *>::iterator it = employees.begin();
		while (it != employees.end()) {
			if (*it == p) {
				foundFlag = true;
				break;
			}
			it++;
		}
		if (!foundFlag)
			employees.push_back(p);
	}
	return p;
}

void DataBase::displayDepartmentEmployees(string department) {
	std::vector<Person *>::iterator it = employees.begin();
	while (it != employees.end()) {
		if (dynamic_cast<Employee*>(*it)->getDepartment() == department){
			dynamic_cast<Employee*>(*it)->display();
			cout << "\n";
		}
		it++;
	}
}

bool DataBase::fireEmployee(int id) {
	vector<Person *>::iterator it = employees.begin();
	bool removedFlag = false;
	while (it != employees.end()) {
		if (dynamic_cast<Employee*>(*it)->getId() == id){
			it = employees.erase(it);
			removedFlag = true;
		}
		if (typeid(**it) == typeid(Manager))
			dynamic_cast<Manager *>(*it)->deleteSubordinatedEmployee(id);
		it++;
	}
	return removedFlag;
}

void DataBase::displayAll() {
	vector<Person *>::iterator it = employees.begin();
	while (it != employees.end()) {
		(*it)->display("");
		it++;
		cout << "\n";
	}
}