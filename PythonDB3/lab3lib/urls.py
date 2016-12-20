from django.conf.urls import url
from .controllers import * 

urlpatterns = [

	url(r'^$', IndexController().get),	

	url(r'extradition-update', ExtraditionController().update),

	url(r'librariers-add', LibrariersController().add),
	url(r'books-add', BooksController().add),
	url(r'readers-add', ReadersController().add),
	url(r'extradition-add', ExtraditionController().add),

	url(r'librariers-del', LibrariersController().delete),
	url(r'readers-del', ReadersController().delete),
	url(r'books-del', BooksController().delete),
	url(r'extradition-del', ExtraditionController().delete),

	url(r'books', BooksController().get),
	url(r'librariers', LibrariersController().get),
	url(r'readers', ReadersController().get),
	url(r'extradition', ExtraditionController().get)

]
