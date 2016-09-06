#include "carray.h"

int main() {
	CArray arr = CArray(10);
	CArray arr2 = CArray(0);
	int size = 6;

	cout << "Values after constructing an object:\n"
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;

	if (arr.isEmpty())
		cout << "Array is empty\n";
	else
		cout << "Array is not empty\n";

	arr.setSize(size);

	cout << "Values after setting size: " << size << endl
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;

	if (arr.isEmpty())
		cout << "Array is empty\n";
	else
		cout << "Array is not empty\n";

	for (int i = 1; i <= 7; i++)
		arr.add(i);

	arr.out();

	cout << "Values after adding 7 items:\n"
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;

	if (arr.isEmpty())
		cout << "Array is empty\n";
	else
		cout << "Array is not empty\n";
	
	arr.setAt(10, 2);
	arr.setAt(20, 4);
	arr.out();

	cout << "Values after setting items with indexes 2 and 4 to different values:\n"
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;

	for (int i = 0; i < 5; i++)
		arr2.setAt(i + 2, i);

	arr2.add(14);
	arr2.add(18);

	arr.out();

	arr.append(&arr2);

	arr2.out();
	arr.out();

	cout << "Values after appending 2 arrays:\n"
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;

	arr.setSize(5);
	arr.copy(&arr2);
	arr.out();

	cout << "Values after copying arr2 to arr:\n"
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;
	
	arr.insertAt(9, 3);
	arr.out();

	cout << "Values after inserting item at 3rd index:\n"
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;

	arr.removeAt(3);
	arr.out();
	
	cout << "Values after deleting item at 3rd index:\n"
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;
	
	arr.out();
	
	arr.~CArray();
	
	cout << "Values after removing all existing items:\n"
		 << "Allowed size: " << arr.getSize()
		 << "\nMax allowed index: " << arr.getUpperBound()
		 << "\nNumber of elements: " << arr.getCount() << endl;

	printf("Example of work operator []: %d\n", arr[2]);

	if (arr.isEmpty())
		cout << "Array is empty\n";
	else
		cout << "Array is not empty\n";
	
	getchar();
	return 1;
}