from django.db import models
from django.core.exceptions import ObjectDoesNotExist

class Librariers (models.Model):

	id = models.IntegerField(primary_key = True)
	name = models.CharField(max_length = 100)
	surname = models.CharField(max_length = 100)

	def add(self, data):
		librarier = Librariers(name = data['name'], surname = data['surname'])
		librarier.save()
		return Librariers.objects.latest('id')

class Books (models.Model):
	
	id = models.IntegerField(primary_key = True)
	book = models.CharField(max_length = 100)
	author = models.CharField(max_length = 100)

	def add(self, data):
		book = Books(book = data['book'], author = data['author'])
		book.save()
		return Books.objects.latest('id')
	
class Readers (models.Model):

	id = models.IntegerField(primary_key = True)
	name = models.CharField(max_length = 100)
	surname = models.CharField(max_length = 100)

	def add(self, data):
		reader = Readers(name = data['name'], surname = data['surname'])
		reader.save()
		return Readers.objects.latest('id')

class Extradition (models.Model):

	id = models.IntegerField(primary_key = True)
	reader = models.ForeignKey(Readers, on_delete = models.CASCADE)
	librarier = models.ForeignKey(Librariers, on_delete = models.CASCADE)
	issued_date = models.CharField(max_length = 100)

class Cart (models.Model):

	id = models.IntegerField(primary_key = True)
	cart = models.ForeignKey(Extradition, on_delete = models.CASCADE)
	book = models.ForeignKey(Books, on_delete = models.CASCADE)
	status = models.IntegerField(default = 0)

	def add(self, data):
		try:
			books = []
			for book in data.getlist('book[]'):
				books.append(Books.objects.get(book = book))
			if len(books) == 0:
				return False
			librarier = Librariers.objects.get(name = data['l_name'], surname = data['l_surname'])
			reader = Readers.objects.get(name = data['r_name'], surname = data['r_surname'])
			extradition = Extradition(reader = reader, librarier = librarier, issued_date = data['date'])
			extradition.save()
			for book in books:
				Cart(cart_id = Extradition.objects.latest('id').id, book = book).save()
			return Cart.objects.latest('id')
		except ObjectDoesNotExist:
			return False