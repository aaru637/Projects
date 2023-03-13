# import mysql.connector
#
# connection = mysql.connector.connect(host="localhost", user='root', password='Dhinesh@638',
#                                      database='libraryManagementSystem', auth_plugin='caching_sha2_password')
#
# if connection:
#     print('Connected')
# else:
#     print('Disconnected')
# # Insert a data into db
# def insert(email, firstName, lastName, mobile, username, password, aadharNo, address, idImage):
#     try:
#         res = connection.cursor()
#         sql = 'insert into others values (%s, %s, %s, %s, %s, %s, %s, %s, %s)'
#         data = (email, firstName, lastName, mobile, username, password, aadharNo, address, idImage)
#         res.execute(sql, data)
#         connection.commit()
#         return True
#     except BaseException():
#         return False

from kivy.app import App
from kivy.uix.button import Button


class TestApp(App):
    def build(self):
        return Button(text='Hello World')


TestApp().run()
