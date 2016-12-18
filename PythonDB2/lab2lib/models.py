from . import db
import re

class BaseModel:

	table = ''

	def __init__(self, table):
		self.table = table

	def getAllRows(self, name, head, additionHead):
		table = Table(db.select(self.table))
		return {'name': name, 'head': head + additionHead, 'table': table.getTable()}

	def deleteByID(self, table, id):
		db.delete('`' + table + '`', where = "WHERE `id` = '" + id + "'")
		return 1

	def getRowsWithWhere(self, table, where):
		res = db.select('`' + table + '`', '*', db.getWhere(where))
		if len(res) == 0:
			return []
		return res
# 
class Table:

	table = []
	dataToTable = None

	def __init__(self, data):
		self.table = []
		self.dataToTable = data

	def getTable(self):
		for item in self.dataToTable:
			self.table.append(self.getRow(item.pop('id'), item))
		return self.table

	def getRow(self, id, values):
		row = {'id': id, 'data': []}
		for key in values:
			row['data'].append({'col': key, 'val': values[key]})
		return row
# 
class Index (BaseModel):

	def __init__(self):
		pass

	def getPageData(self):
		return []

	def fillDataBaseWithJSONFile(self, table, fieldsValues):
		return db.insert('`' + table + '`', fieldsValues)
# 
class Librariers (BaseModel):

	def getPageData(self):
		return self.getAllRows('librariers', ['Name', 'Surname'], ['delete'])

	def addNewLibrarier(self, request):
		if not re.match('\w{3,10} \w{3,10}', request.GET['name'] + ' ' + request.GET['surname']):
			return False
		where  = " WHERE `name` = '" + request.GET['name'] + "' AND `surname` = '" + request.GET['surname'] + "'"
		if len(db.select(self.table, '*', where)) > 0:
			return False
		return db.insert(self.table, {'name': request.GET['name'], 'surname': request.GET['surname']})

	def delLibrarier(self, request):
		cartIDs = db.select('`extradition`', '`cart_id`', " WHERE `librarier_id` = '" + str(request.GET.get('id')) + "'")
		if cartIDs:
			for cartID in cartIDs:
				statuses = db.select('`cart`', '`status`', " WHERE `cart_id` = '" + str(cartID['id']) + "'")
				for status in statuses:
					if int(status[0]) == 0:
						return 0
				self.deleteByID('cart', db.getWhere({'cart_id': str(cartID['id'])}))
		return self.deleteByID(self.table, request.GET.get('id'))
# 
class Readers (BaseModel):

	def getPageData(self):
		return self.getAllRows('readers', ['Name', 'Surname'], ['delete'])

	def addNewReader(self, request):
		if not re.match('\w{3,10} \w{3,10}', request.GET['name'] + ' ' + request.GET['surname']):
			return False
		where  = " WHERE `name` = '" + request.GET['name'] + "' AND `surname` = '" + request.GET['surname'] + "'"
		if len(db.select(self.table, '*', where)) > 0:
			return False
		return db.insert(self.table, {'name': request.GET['name'], 'surname': request.GET['surname']})

	def delReader(self, request):
		cartIDs = db.select('`extradition`', '`cart_id`', " WHERE `reader_id` = '" + request.GET.get('id') + "'")
		if cartIDs:
			for cartID in cartIDs:
				statuses = db.select('`cart`', '`status`', " WHERE `cart_id` = '" + str(cartID['cart_id']) + "'")
				for status in statuses:
					if int(status['status']) == 0:
						return 0
				self.deleteByID('cart', db.getWhere({'cart_id': str(cartID['cart_id'])}))
		return self.deleteByID(self.table, request.GET.get('id'))

# 
class Books (BaseModel):

	def getPageData(self):
		return self.getAllRows('books', ['Book', 'Author'], ['delete'])

	def addNewBook(self, request):
		print(request.GET)
		where  = " WHERE `book` = '" + request.GET['book'] + "' AND `author` = '" + request.GET['author'] + "'"
		if len(db.select(self.table, '*', where)) > 0:
			return False
		return db.insert(self.table, {'book': request.GET['book'], 'author': request.GET['author']})

	def delBook(self, request):
		statuses = db.select('`cart`', '`status`', " WHERE `book_id` = '" + request.GET.get('id') + "'")
		for status in statuses:
			if int(status['status']) == 0:
				return 0
		return self.deleteByID(self.table, request.GET.get('id'))
# 
class Extradition (BaseModel):

	def getExtradition(self, carts):
		extr = {'extr': carts[0]['id'], 'books': []}
		for cart in carts:
			extr['books'].append(
				{'cart': cart['cart_id'], 'book': cart['books.id'], 'status': cart['status'], 'data': {
					'bookdata': ' '.join(('"' + cart['book']  + '"', cart['author'])),
					'reader': ' '.join((cart['name'], cart['surname'])),
					'librarier': ' '.join((cart['librariers.name'], cart['librariers.surname'])),
					'issueddate': cart['issued_date']}})
		return extr

	def getPageData(self): 
		fields = ' '.join(('`extradition`.`id`, `cart`.`cart_id`, `book`, `author`, `readers`.`name`, `readers`.`surname`, ',
						   '`librariers`.`name`, `librariers`.`surname`, `issued_date`, `status`, `books`.`id`'))
		where = ' '.join(('`extradition`.`reader_id` = `readers`.`id` AND',
						  '`extradition`.`librarier_id` = `librariers`.`id` AND',
						  '`extradition`.`cart_id` = `cart`.`cart_id` AND',
						  '`cart`.`book_id` = `books`.`id`'))
		dbRes = db.select(self.table, fields, 'WHERE ' + where); i = 0; count = len(dbRes); extraditions = []; cartID = -1
		for extr in dbRes:
			if cartID != extr['cart_id']:
				cartID = extr['cart_id']
				if i < count:
					carts = [cart for cart in dbRes[i:] if cart['cart_id'] == extr['cart_id']]
					extraditions.append(self.getExtradition(carts))
			i += 1
		return {'name': 'extradition',
				'head': ['book/author', 'readers name/surname', 'librariers name/surname', 'issued date', 'change status'],
				'extr': extraditions}

	def addNewExtradition(self, request):
		reader = self.getRowsWithWhere('readers', {'name': request.GET['r_name'], 'surname': request.GET['r_surname']})
		librarier = self.getRowsWithWhere('librariers', {'name': request.GET['l_name'], 'surname': request.GET['l_surname']})
		if len(reader) == 0 or len(librarier) == 0:
			return False
		books = request.GET.getlist('book[]'); booksIDs = []
		for book in books:
			if book != '':
				_book = self.getRowsWithWhere('books', {'book': book})
				if len(_book) == 0:
					return False
				booksIDs.append(_book[0]['id'])
		cartID = str(int(db.select('cart', 'max(`cart_id`) as `max`')[0]['max']) + 1)
		for bookID in booksIDs:
			db.insert('cart', {'cart_id': cartID,'book_id': str(bookID)})
		return db.insert(self.table, {
			'cart_id': cartID,
			'reader_id': str(reader[0]['id']),
			'librarier_id': str(librarier[0]['id']),
			'issued_date': str(request.GET['date'])})

	def updBookInExtradition(self, request):
		db.update('`cart`', {'status': '1'}, db.getWhere({'cart_id': str(request.GET['cart'][0]), 'book_id': str(request.GET['book'][0])}))
		return 1
		
	def delExtradition(self, request):
		if len(self.getRowsWithWhere('cart', {'cart_id': str(request.GET['cart'][0]), 'status': '0'})) > 0:
			return 0
		db.delete(self.table, db.getWhere({'cart_id': str(request.GET['cart'][0])}))
		return 1
