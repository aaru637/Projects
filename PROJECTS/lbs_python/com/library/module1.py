from email import encoders
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText

from_address = 'dhandapanisakthi123@gmail.com'
to_address = 'dhineshkumardhandapani40@gmail.com'

message = MIMEMultipart()

message['From'] = from_address
message['To'] = to_address
message['Subject'] = 'CS Library Management System Librarian Registeration.'
body = 'HI. I\'m Dhineshkumar D. How are You? I\'m Fine.'
message.attach(MIMEText(body, 'plain'))

filename = 'idCard.pdf'
attachment = open('idCard.pdf', 'rb')

p = MIMEBase('application', 'octet-stream')
p.set_payload((attachment).read())
encoders.encode_base64(p)
p.add_header('Content-Disposition', 'attachment; filename= %s' % filename)
message.attach(p)

s = smtplib.SMTP('smtp.gmail.com', 587)
s.starttls()
s.login(from_address, 'qaunvbdchweoraeu')
text = message.as_string()
s.sendmail(from_address, to_address, text)
s.quit()