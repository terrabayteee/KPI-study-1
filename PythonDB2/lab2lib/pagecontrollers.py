from . import views
from . import models as Models

def index(request):
	model = Models.Index()
	return views.View('index.html', request, model.getPageData()).renderPage()

def librariers(request):
	model = Models.Librariers('librariers')
	view = views.View('librariers.html', request, model.getPageData())
	view.setForm('librariers', 'add', [['Librarier name', 'name'], ['Librarier surname', 'surname']])
	return view.renderPage()

def readers(request):
	model = Models.Readers('readers')
	view = views.View('readers.html', request, model.getPageData())
	view.setForm('readers', 'add', [['Reader name', 'name'], ['Reader surname', 'surname']])
	return view.renderPage()

def extradition(request):
	model = Models.Extradition('`extradition`, `books`, `readers`, `librariers`, `cart`')
	view = views.View('extradition.html', request, model.getPageData())
	view.setForm('extradition', 'add', [['Reader name', 'r_name'],
										['Reader surname', 'r_surname'],
										['Librarier name', 'l_name'],
										['Librarier surname', 'l_surname'],
										['Issued date', 'date'],
										['Book', 'book[]']])
	return view.renderPage()

def books(request):
	model = Models.Books('books')
	view = views.View('books.html', request, model.getPageData())
	view.setForm('books', 'add', [['Book', 'book'], ['Books author', 'author']])
	return view.renderPage()