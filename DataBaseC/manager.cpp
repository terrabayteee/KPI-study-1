#include "manager.h"

Manager::Manager(const Manager &m) {
	*this = m;
}

Manager& Manager::operator = (const Manager &m) {
	lastName = m.lastName;
	firstName = m.firstName;
	department = m.department;
	salary = m.salary;
	id = m.id;
	return *this;	
}

void Manager::display(string s) {
	cout << "Employment type: manager\n"
		<< "id: " << id << "\n"
		<< firstName << " " << lastName << " "
		<< "age: " << age << " salary: " << salary
		<< "department: " << department
		<< "\n\n";
	displaySubordinates();
}

void Manager::displaySubordinates() {
	cout << "Subordinates:" << endl;
	if (subordinates.size() != 0) {
		list<Person *>::iterator it = subordinates.begin();
		while (it != subordinates.end()) {
			(*it)->display("    ");
			it++;
		}
	}
	else
		cout << "\t none\n\n\n";
}

bool Manager::deleteSubordinatedEmployee(int id){
	std::list<Person*>::iterator it = subordinates.begin();
	bool removeFlag = false;
	while (it != subordinates.end()) {
		if (dynamic_cast<Employee*>(*it)->getId() == id){
			it = subordinates.erase(it);
			removeFlag = true;
			if (it == subordinates.end())
				break;
		}
		it++;
	}
	return removeFlag;
}

Person* Manager::addSubordinate(Person * p) {
	if (p != NULL) {
		subordinates.push_back(p);
		subordinates.unique();
		return p;
	}
	return NULL;
}