from django.conf.urls import url
from . import pagecontrollers
from . import delcontrollers
from . import addcontrollers
from . import updcontrollers

urlpatterns = [

    url(r'update', updcontrollers.extradition),    

    url(r'librariers-del', delcontrollers.librariers),
    url(r'readers-del', delcontrollers.readers),
    url(r'books-del', delcontrollers.books),
    url(r'extradition-del', delcontrollers.extradition),

    url(r'^librariers-add', addcontrollers.librariers),
    url(r'^books-add', addcontrollers.books),
    url(r'readers-add', addcontrollers.readers),
    url(r'extradition-add', addcontrollers.extradition),
    url(r'^fill-db-from-json', addcontrollers.fillDataBaseFromJSON),

    url(r'^$', pagecontrollers.index),
    url(r'librariers', pagecontrollers.librariers),
    url(r'readers', pagecontrollers.readers),
    url(r'extradition', pagecontrollers.extradition),
    url(r'books', pagecontrollers.books)

]
