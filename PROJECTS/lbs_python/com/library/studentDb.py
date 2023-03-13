import mysql.connector
from tabulate import tabulate

connection = mysql.connector.connect(host="192.168.43.62", user="Library", password="Library@123",
                                     auth_plugin="mysql_native_password", database="libraryManagementSystem")


# Insert a data into db
# def insert(email, firstName, lastName, mobile, username, password, aadharNo, address, registerNo, idImage, department):
#     try:
#         res = connection.cursor()
#         sql = 'insert into student values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
#         data = (email, firstName, lastName, mobile, username, password, aadharNo, address, registerNo, idImage, department)
#         res.execute(sql, data)
#         connection.commit()
#         return True
#     except BaseException():
#         return False


# search a data into database username and password.
def search(username, register):
    try:
        res = connection.cursor()
        sql = 'select * from student where userName = %s and registerNo = %s'
        res.execute(sql, (username, register))
        record = res.fetchall()
        print(tabulate(record))
    except BaseException:
        return False


search('d04sih4n', '613520104009')
