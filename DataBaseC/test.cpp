#define _CRT_SECURE_NO_WARNINGS
#include "database.h"

using namespace std;

int main(){
	DataBase db;

	int LoadRes = db.loadFromFile("file.csv");

	db.displayAll();
	db.arrangeSubordinates();
	cout << "After arranging\n";
	db.displayAll();

	cout << "Fire id 3\n";
	db.fireEmployee(3);
	db.displayAll();

	cout << "All employees of 'IT' department\n";
	db.displayDepartmentEmployees("IT");

	system("pause");
	return 0;
}