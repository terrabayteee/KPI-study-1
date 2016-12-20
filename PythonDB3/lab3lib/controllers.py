from .views import View
from django.http import HttpResponse, HttpResponseRedirect
from .models import *

class AbstractController:

	table = ''
	model = ''

	def add(self, request):
		if self.model().add(request.GET):
			return HttpResponse(1)
		return HttpResponse(0)

	def get(self, request):
		return View(self.table + '.html', request, self.model.objects.all()).renderPage()

	def delete(self, request):
		self.model.objects.filter(id = request.GET['id']).delete()
		return HttpResponseRedirect('/' + self.table + '/')

class IndexController (AbstractController):

	def get(self, request):
		return View('index.html', request, []).renderPage()

class LibrariersController (AbstractController):

	def __init__(self):
		self.table = 'librariers'
		self.model = Librariers

class BooksController (AbstractController):

	def __init__(self):
		self.table = 'books'
		self.model = Books
	
class ReadersController (AbstractController):

	def __init__(self):
		self.table = 'readers'
		self.model = Readers

class ExtraditionController (AbstractController):

	def __init__(self):
		self.table = 'extradition'
		self.model = Cart

	def get(self, request):
		extr = self.model.objects.all(); id = -1; i = 0; count = len(extr); tmp = []
		for	row in extr:
			if id != row.cart_id:
				id = row.cart_id
				if i < count:
					tmp.append([cart for cart in extr[i:] if cart.cart_id == row.cart_id])
			i += 1
		return View(self.table + '.html', request, tmp).renderPage()

	def update(self, request):
		self.model.objects.filter(cart = request.GET['cart'][0], book = request.GET['book'][0]).update(status = 1)
		return HttpResponseRedirect('/' + self.table + '/')

	def delete(self, request):
		self.model.objects.filter(cart_id = request.GET['id']).delete()
		return HttpResponseRedirect('/' + self.table + '/')