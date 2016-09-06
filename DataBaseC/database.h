#pragma once
#include "manager.h"
#include <vector>
#include <string>
#include <iostream>
#include <typeinfo>
#include <sstream>
#include <string>
#include <fstream>

class DataBase{

	public:
		DataBase() {};
		~DataBase() {};

		bool loadFromFile(const string file);
		void arrangeSubordinates();
		Person* hireEmployee(Person *p);
		void displayDepartmentEmployees(string department);
		bool fireEmployee(int id);
		void displayAll();

	private:
		vector<Person*> employees;
};