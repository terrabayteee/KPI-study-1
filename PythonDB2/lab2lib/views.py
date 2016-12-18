from django.shortcuts import render

class View:

	template = ''
	request = None
	data = {}

	def __init__(self, tpl, req, data):
		self.template = tpl
		self.request = req
		self.data['navbar'] = getMenu()		
		self.data['table'] = data
		self.data['forms'] = []

	def renderPage(self):
		return render(self.request, self.template, self.data)

	def setForm(self, name, action, inputValues):
		self.data['forms'].append({'name': name + '_' + action, 'button': name + '_' + action, 'action': action,
									'inputs': [{'placeholder': input[0], 'name': input[1]} for input in inputValues]})

def getMenu():
	return [{'title': 'Readers', 'link': '/readers'},
			{'title': 'Librariers', 'link': '/librariers'},
			{'title': 'Books', 'link': '/books'},
			{'title': 'Extradition', 'link': '/extradition'}]