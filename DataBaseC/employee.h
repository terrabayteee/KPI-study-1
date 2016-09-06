#pragma once
#include <string>
#include <iostream>
#include <stdio.h>
using namespace std;

class Person {
	public:
		Person() {};
		Person(string _firstName, string _lastName, int _age) {
			age = _age;
			firstName = _firstName;
			lastName = _lastName;
		}

		virtual void display(string) = 0;

	protected:
		string firstName;
		string lastName;
		int age;
};

class Employee: public Person {
	public:
		Employee() {};
		Employee(string firstName, string lastName, int age, int _id) :
			Person(firstName, lastName, age),
			id(_id) {};
		Employee(const Employee &e);

		Employee& operator = (const Employee &e);

		void setSalary(int s);
		void setDepartment(string dept);
		void setId(int newID);

		int getId();
		string getDepartment();

		virtual void display(string space = "");

	protected:
		string department;
		int salary;
		int id;
};
