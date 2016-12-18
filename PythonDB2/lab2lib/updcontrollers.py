from django.http import HttpResponse
from . import models as Models

def extradition(request):
	model = Models.Extradition('extradition')
	return HttpResponse(model.updBookInExtradition(request))