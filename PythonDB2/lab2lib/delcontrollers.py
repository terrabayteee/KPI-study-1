from django.http import HttpResponse
from . import models as Models

def librariers(request):
	model = Models.Librariers('librariers')
	return HttpResponse(model.delLibrarier(request))

def readers(request):
	model = Models.Readers('readers')
	return HttpResponse(model.delReader(request))

def extradition(request):
	model = Models.Extradition('cart')
	return HttpResponse(model.delExtradition(request))

def books(request):
	model = Models.Books('books')
	return HttpResponse(model.delBook(request))