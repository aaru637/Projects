import mysql.connector

connection = mysql.connector.connect(host="192.168.43.62", user="Library", password="Library@123", auth_plugin="mysql_native_password", database="libraryManagementSystem")

# Insert a data into db
def insert(email, firstName, lastName, mobile, aadharNo, librarianId, username, password, idImage):
    try:
        res = connection.cursor()
        sql = 'insert into librarian values (%s, %s, %s, %s, %s, %s, %s, %s, %s)'
        data = (librarianId, firstName, lastName, username, password, idImage, mobile, aadharNo, email)
        res.execute(sql, data)
        connection.commit()
        return True
    except BaseException():
        return False

# search a data into database username and password.
def search(username, password):
    try:
        __usernames = []
        __passwords = []
        res = connection.cursor()
        sql = 'select username, password from librarian'
        res.execute(sql)
        record = res.fetchall()
        for data in record:
            __usernames.append(data[0])
            __passwords.append(data[1])
        print(__usernames)
        print(__passwords)
        if username in __usernames:
            if password in __passwords:
                return 'True'
            else:
                return 'P'
        else:
            return 'U'
    except BaseException:
        return False