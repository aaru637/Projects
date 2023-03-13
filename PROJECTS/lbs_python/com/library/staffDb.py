import mysql.connector

connection = mysql.connector.connect(host="192.168.43.62", user="Library", password="Library@123",
                                     auth_plugin="mysql_native_password", database="libraryManagementSystem")


# Insert a data into db
def insert(email, firstName, lastName, mobile, username, password, aadharNo, address, staffNo, idImage, department):
    try:
        res = connection.cursor()
        sql = 'insert into staff values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
        data = (email, firstName, lastName, mobile, username, password, aadharNo, address, staffNo, idImage, department)
        res.execute(sql, data)
        connection.commit()
        return True
    except BaseException():
        return False
