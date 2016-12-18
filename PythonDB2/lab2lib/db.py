import MySQLdb as mdb
import MySQLdb.cursors

def getConnect():
	return mdb.connect(host = '127.0.0.1', user = 'root', passwd = '', db = 'lab2library', cursorclass = MySQLdb.cursors.DictCursor)

def insert(table, fieldsValues):
	colnames = ''; colValues = ''
	for key in fieldsValues:
		colnames += '`' + key + '`, '
		colValues += "'" + fieldsValues[key] + "', "
	connect = getConnect()
	cursor = connect.cursor()
	# print('INSERT INTO ' + table + ' (' + colnames[:-2] + ') VALUES (' + colValues[:-2] + ')')
	cursor.execute('SET NAMES `utf8`')
	cursor.execute('INSERT INTO ' + table + ' (' + colnames[:-2] + ') VALUES (' + colValues[:-2] + ')')
	cursor.close()
	closeConnection(connect)
	return cursor.lastrowid

def getWhere(whereParams):
	whereStr = ' WHERE '
	for key in whereParams:
		whereStr += '`' + key + '`' + " = '" + whereParams[key] + "' AND "
	return whereStr[:-4]

def select(table, fields = '*', where = '', group = ''):
	connect = getConnect()
	cursor = connect.cursor()
	cursor.execute('SET NAMES `utf8`')
	# print('SELECT ' + fields + ' FROM ' + table + where + group)
	cursor.execute('SELECT ' + fields + ' FROM ' + table + where + group)
	res = cursor.fetchall()
	cursor.close()
	closeConnection(connect)
	return res

def update(table, fieldsValues, where = ''):
	newValues = ''
	for key in fieldsValues:
		newValues += '`' + key + '`' + " = '" + fieldsValues[key] + "', "
	connect = getConnect()
	cursor = connect.cursor()
	cursor.execute('SET NAMES `utf8`')
	# print('UPDATE ' + table + ' SET ' + newValues[:-2] + where)
	cursor.execute('UPDATE ' + table + ' SET ' + newValues[:-2] + where)
	cursor.close()
	closeConnection(connect)

def delete(table, where = ''):
	connect = getConnect()
	cursor = connect.cursor()
	cursor.execute('SET NAMES `utf8`')
	# print('DELETE FROM ' + table + where)
	cursor.execute('DELETE FROM ' + table + where)
	cursor.close()
	closeConnection(connect)

def closeConnection(connection):
	connection.close()