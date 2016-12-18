from django.http import HttpResponse
from . import models as Models
import json

def fillDataBaseFromJSON(request):
	with open('lab2lib/static/db.json') as dataFile:
		data = json.load(dataFile)
		model = Models.Index()
		for item in data:
			for element in data[item]:
				if model.fillDataBaseWithJSONFile(item, element) <= 0:
					return HttpResponse(0)
	return HttpResponse(1)

def librariers(request):
	model = Models.Librariers('librariers')
	if model.addNewLibrarier(request):
		return HttpResponse(1)
	return HttpResponse(0)

def books(request):
	model = Models.Books('books')
	if model.addNewBook(request):
		return HttpResponse(1)
	return HttpResponse(0)

def readers(request):
	model = Models.Readers('readers')
	if model.addNewReader(request):
		return HttpResponse(1)
	return HttpResponse(0)

def extradition(request):
	model = Models.Extradition('extradition')
	if model.addNewExtradition(request):
		return HttpResponse(1)
	return HttpResponse(0)