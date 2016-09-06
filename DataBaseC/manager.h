#pragma once
#include "employee.h"
#include <list>

class Manager: public Employee {
	public:
		Manager() {};
		Manager(string firstName, string lastName, int age, int id):
			Employee(firstName, lastName, age, id) {};
		Manager(const Manager &m);

		Manager& operator = (const Manager &m);

		virtual void display(string s);
		void displaySubordinates();

		bool deleteSubordinatedEmployee(int id);

		Person* addSubordinate(Person *p);

	private:
		list<Person*> subordinates;
};
