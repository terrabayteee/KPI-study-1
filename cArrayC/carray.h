#pragma once
#include <string.h>
#include <iostream>
using namespace std;

class CArray {
	/*
		The minimum number of element slots to allocate
		if a size increase is necessary
	*/
	#define GROWBY 10

	private:
		/* count elements in vector */
		int size;
		/* Array with data */
		int *vector;
		/* Max index in array */
		int count;

	public:
		/* Constructs an empty array */
		CArray(int);
		~CArray();

		/* Gets size of array */
		int getSize() const;
		/* Gets count elements of array */
		int getCount() const;

		/* Attributes */
		/* Returns the largest valid index */
		int getUpperBound() const;
		/* Determines whether the array is empty */
		bool isEmpty() const;
		/*
			Establishes the size of an empty or existing array;
			allocates memory if necessary
		*/
		void setSize(int newSize);

		/* Operations */
		/*
			Frees all unused memory above the current upper bound
			This function has no effect on the upper bound of the array
		*/
		void freeExtra();
		/* Removes all the elements from this array */
		void removeAll();
		/* Returns the value at a given index */
		int getAt(int) const;
		/* Sets the value for a given index; array not allowed to grow */
		void setAt(int n, int index);
		/*
			Adds an element to the end of the array;
			grows the array if necessary
		*/
		void add(int);
		/* Appends another array to the array; grows the array if necessary */
		void append(CArray *);
		/* Copies another array to the array; grows the array if necessary */
		void copy(CArray *);
		/* Inserts an element at a specified index */
		void insertAt(int n, int index);
		/* Removes an element at a specific index */
		void removeAt(int);
		/* Sets or gets the element at the specified index */
		int& operator [](int);
		/* Out vector to console */
		void out();
};