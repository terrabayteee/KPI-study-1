#include "carray.h"

CArray::CArray(int count) {
	this->count = count;
	size = count * sizeof(int);
	vector = new int[count];
}

CArray::~CArray() {
	removeAll();
}

int CArray::getSize() const {
	return size;
}

int CArray::getCount() const {
	return count;
}

bool CArray::isEmpty() const {
	return (count == 0) ? true : false;
}

int CArray::getUpperBound() const {
	return count - 1;
}

int CArray::getAt(int index) const {
	if (index < count)
		return vector[index];
}

void CArray::setAt(int n, int index) {
	if (index >= 0 && index <= count)
		vector[index] = n;
}

void CArray::setSize(int newSize) {
	if (size != newSize * sizeof(int)) {
		vector = (int *)realloc(vector, newSize * sizeof(int));
		size = newSize * sizeof(int);
	}
}

void CArray::freeExtra()
{
	for (int i = count; i < size; i++)
		vector[i] = NULL;
	vector = (int*)realloc(vector, count*sizeof(int));
	size = count;
}

void CArray::removeAll() {
	size = 0;
	count = 0;
	delete[] vector;
}

void CArray::append(CArray *carray) {
	for (int i = 0; i < carray->getCount(); i++)
		this->add(carray->getAt(i));
}

void CArray::add(int number) {
	if (count == size)
		size += GROWBY;
	vector[count] = number;
	count++;
}

void CArray::out() {
	if (!isEmpty()) {
		cout << "vector: ";
		for (int i = 0; i < size; i++)
			cout << "  " << vector[i];
		cout << "\n";
	}
	else
		cout << "This array is empty\n";
}

void CArray::removeAt(int index) {
	for (int i = index; i < this->count; i++)
		vector[i] = vector[i + 1];
	count--;
}

void CArray::insertAt(int n, int index) {
	if (index >= 0) {
		if (index > size)
			this->setAt(n, index);
		else
			if (index <= count - 1) {
				if (count + 1 > size)
					size += GROWBY;
				for (int i = count - 1; i >= index; i--)
					vector[i + 1] = vector[i];
				vector[index] = n;
				count++;
			}
	}
}

void CArray::copy(CArray *carray) {
	this->setSize(carray->getSize());
	for (int i = 0; i < carray->getCount(); i++)
		this->setAt(carray->getAt(i), i);
}

int& CArray::operator[](int index) {
	return vector[index];
}