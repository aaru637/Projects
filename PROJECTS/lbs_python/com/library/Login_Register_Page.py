from email import message
import os.path
from random import Random
from tkinter import filedialog
from tkinter import *
from tkinter.messagebox import showerror, showinfo
from turtle import title
import PIL
from PIL import ImageTk, Image
import Staff_Section
import Student_Section
import Others_Section
import Admin_Section
import Book_Section
from adminDb import *
import random

from email import encoders
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText


# Login Page
class LoginPage(Tk):
    def __init__(self):
        # Main Window
        super(LoginPage, self).__init__()
        self.HOME = None
        self.reg = None
        self.title("Library Management System")
        self.width_of_window = 700
        self.height_of_window = 340
        self.screen_width = self.winfo_screenwidth()
        self.screen_height = self.winfo_screenheight()
        self.x_coordinate = int((self.screen_width / 2) - (self.width_of_window / 2))
        self.y_coordinate = int((self.screen_height / 2) - (self.height_of_window / 2))
        self.geometry(f'{self.width_of_window}x{self.height_of_window}+{self.x_coordinate}+{self.y_coordinate}')

        self.config(bg="light blue")

        # data declaration
        self.userName = StringVar()
        self.passWord = StringVar()

        # Title frame
        self.frame = Frame(self, bg="#78A6C8")
        self.frame.pack(side=TOP, fill=X)
        self.label = Label(self.frame, text="Library Management System", fg="#41436A",
                           font=("Cambria", 15, "bold", "underline"))
        self.label.grid(row=0, columnspan=6, padx=220, pady=20)

        # Below Title Frame
        self.belowTitleFrame = Frame(self, bg="#46A094")
        self.belowTitleFrame.pack(side=TOP, fill=X)
        self.admin = Label(self.belowTitleFrame, text="Admin Login", fg="Blue", bg="white",
                           font=("Roboto", 20, "bold"))
        self.admin.grid(row=0, columnspan=6, padx=250, pady=20)

        # First Name Field and Label
        self.usernameLabel = Label(self.belowTitleFrame, text="Username : ", bg="#46A094",
                                   font=("Calibri", 12, "bold"))
        self.usernameLabel.grid(row=1, column=2, ipady=30)

        self.usernameInput = Entry(self.belowTitleFrame, textvariable=self.userName,
                                   font=("Calibri", 12, "bold"), width=20)
        self.usernameInput.grid(row=1, column=3)
        self.usernameInput.focus()

        # Password Field and Label
        self.passwordLabel = Label(self.belowTitleFrame, text="Password : ", bg="#46A094",
                                   font=("Calibri", 12, "bold"))
        self.passwordLabel.grid(row=2, column=2)

        self.passwordInput = Entry(self.belowTitleFrame, textvariable=self.passWord,
                                   font=("Calibri", 12, "bold"), width=20, show="*")
        self.passwordInput.grid(row=2, column=3)

        # login button
        self.loginButton = Button(self.belowTitleFrame, text="Login", bg="#FDD037", font=("Roboto", 10, "bold"),
                                  fg="red", command=self.loginButtonClicked, width=8, activebackground="green",
                                  activeforeground="blue")
        self.loginButton.grid(row=4, column=1, pady=30)

        # Register Button
        self.registerButton = Button(self.belowTitleFrame, text="Register", bg="#FDD037",
                                     font=("Roboto", 10, "bold"),
                                     fg="red", width=8, command=self.registerButtonClicked,
                                     activebackground="green", activeforeground="blue")
        self.registerButton.grid(row=4, column=4, pady=15)

    # login button action
    def loginButtonClicked(self):
        __username = self.usernameInput.get()
        __password = self.passwordInput.get()
        if __username == '':
            showerror(title="Username Error", message="Username can't be Empty.")

        if __password == '':
            showerror(title="Password Error", message="Password can't be Empty.")

        __search = search(__username, __password)
        if __search == "U":
            showerror(title="Username Error", message="Invalid Username")
        if __search == 'P':
            showerror(title="Password Error", message="Invalid Password")
        if __search == 'True':
            self.destroy()
            HomePage()

    # Register Button Action
    def registerButtonClicked(self):
        self.destroy()
        RegisterPage()


# Register Page
class RegisterPage(Tk):
    def __init__(self):
        super(RegisterPage, self).__init__()
        # Frame
        self.filename = None
        self.title("Library Management System")
        self.width_of_window = 700
        self.height_of_window = 590
        self.screen_width = self.winfo_screenwidth()
        self.screen_height = self.winfo_screenheight()
        self.x_coordinate = int((self.screen_width / 2) - (self.width_of_window / 2))
        self.y_coordinate = int((self.screen_height / 2) - (self.height_of_window / 2))
        self.geometry(f'{self.width_of_window}x{self.height_of_window}+{self.x_coordinate}+{self.y_coordinate}')
        self.configure(bg="light blue")

        # data declaration
        self.email = StringVar()
        self.firstName = StringVar()
        self.lastName = StringVar()
        self.mobile = StringVar()
        self.aadhar_No = StringVar()
        self.librarian_Id = StringVar()
        self.username = StringVar()
        self.password = StringVar()
        self.confirmPassword = StringVar()
        self.imageFile = StringVar()

        # Title frame
        self.frame = Frame(self, bg="#78A6C8")
        self.frame.pack(side=TOP, fill=X)
        self.label = Label(self.frame, text="Library Management System", fg="#41436A",
                           font=("Cambria", 15, "bold", "underline"))
        self.label.grid(row=0, columnspan=6, padx=220, pady=20)

        # Below Title Frame
        self.belowTitleFrame = Frame(self, bg="#46A094")
        self.belowTitleFrame.pack(anchor=CENTER, fill=X)
        self.admin = Label(self.belowTitleFrame, text="Admin Registration", fg="Blue", bg="#46A094",
                           font=("Roboto", 20, "bold"))
        self.admin.grid(row=0, columnspan=6, padx=220, pady=20)

        # First Name Field and Label
        self.firstNameLabel = Label(self.belowTitleFrame, text="First Name : ", bg="#46A094",
                                    font=("Calibri", 12, "bold"))
        self.firstNameLabel.grid(row=1, column=0, ipadx=2, ipady=30)

        self.firstNameInput = Entry(self.belowTitleFrame, textvariable=self.firstName,
                                    font=("Calibri", 12, "bold"), width=20)
        self.firstNameInput.grid(row=1, column=1, ipadx=2)
        self.firstNameInput.focus()

        # Last Name Field and Label
        self.lastNameLabel = Label(self.belowTitleFrame, text="Last Name : ", bg="#46A094",
                                   font=("Calibri", 12, "bold"))
        self.lastNameLabel.grid(row=1, column=2, ipadx=10)

        self.lastNameInput = Entry(self.belowTitleFrame, textvariable=self.lastName,
                                   font=("Calibri", 12, "bold"), width=20)
        self.lastNameInput.grid(row=1, column=3, ipadx=2)

        # Email Field and Label
        self.emailLabel = Label(self.belowTitleFrame, text="Email ID : ", bg="#46A094", font=("Calibri", 12, "bold"))
        self.emailLabel.grid(row=2, column=0, ipadx=2)

        self.emailInput = Entry(self.belowTitleFrame, textvariable=self.email, font=("Calibri", 12, "bold"), width=20)
        self.emailInput.grid(row=2, column=1, ipadx=2)

        # mobile no Field and Label
        self.mobileLabel = Label(self.belowTitleFrame, text="Mobile No : ", bg="#46A094",
                                 font=("Calibri", 12, "bold"))
        self.mobileLabel.grid(row=2, column=2, ipadx=2)

        self.mobileInput = Entry(self.belowTitleFrame, textvariable=self.mobile, font=("Calibri", 12, "bold"),
                                 width=20)
        self.mobileInput.grid(row=2, column=3, ipadx=2)

        # Aadhar No Field and Label
        self.aadharLabel = Label(self.belowTitleFrame, text="Aadhar No : ", bg="#46A094",
                                 font=("Calibri", 12, "bold"))
        self.aadharLabel.grid(row=3, column=0, ipadx=10)

        self.aadharInput = Entry(self.belowTitleFrame, textvariable=self.aadhar_No,
                                 font=("Calibri", 12, "bold"), width=20)
        self.aadharInput.grid(row=3, column=1, ipadx=2)

        # Librarian ID Field and Label
        self.librarianIdLabel = Label(self.belowTitleFrame, text="Librarian ID : ", bg="#46A094",
                                      font=("Calibri", 12, "bold"))
        self.librarianIdLabel.grid(row=3, column=2, ipadx=2, ipady=30)

        self.librarianIdInput = Entry(self.belowTitleFrame, textvariable=self.librarian_Id,
                                      font=("Calibri", 12, "bold"), width=20)
        self.librarianIdInput.grid(row=3, column=3, ipadx=2)

        # Username Field and Label
        self.usernameLabel = Label(self.belowTitleFrame, text="Username : ", bg="#46A094",
                                   font=("Calibri", 12, "bold"))
        self.usernameLabel.grid(row=4, column=0, ipadx=10)

        self.usernameInput = Entry(self.belowTitleFrame, textvariable=self.username,
                                   font=("Calibri", 12, "bold"), width=20, state=DISABLED)
        self.usernameInput.grid(row=4, column=1, ipadx=2)

        # New Password Field and Label
        self.passwordLabel = Label(self.belowTitleFrame, text="New Password : ", bg="#46A094",
                                   font=("Calibri", 12, "bold"))
        self.passwordLabel.grid(row=4, column=2, ipadx=2)

        self.passwordInput = Entry(self.belowTitleFrame, textvariable=self.password,
                                   font=("Calibri", 12, "bold"), width=20, show="*")
        self.passwordInput.grid(row=4, column=3, ipadx=2)

        # Confirm Password Field and Label
        self.confirmPasswordLabel = Label(self.belowTitleFrame, text="Confirm Password : ", bg="#46A094",
                                          font=("Calibri", 12, "bold"))
        self.confirmPasswordLabel.grid(row=5, column=0, ipadx=10)

        self.confirmPasswordInput = Entry(self.belowTitleFrame, textvariable=self.confirmPassword,
                                          font=("Calibri", 12, "bold"), width=20, show="*")
        self.confirmPasswordInput.grid(row=5, column=1, ipadx=2)

        # Image File Field and Label
        self.imageFileInput = Entry(self.belowTitleFrame, bg="white", textvariable=self.imageFile, fg="black",
                                    font=("Calibri", 7, "bold"), width=20, state="readonly")
        self.imageFile.set("Select Your Image")
        self.imageFileInput.grid(row=5, column=2, pady=30)

        self.imageFileButton = Button(self.belowTitleFrame, command=self.file, text="Select Your Image",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black")
        self.imageFileButton.grid(row=5, column=3)

        # Image View Button
        self.imageViewButton = Button(self.belowTitleFrame, command=self.imageView, text="View Image",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black")
        self.imageViewButton.grid(row=6, column=2)

        # login button
        self.backButton = Button(self.belowTitleFrame, text="<<Back", bg="#FDD037", font=("Roboto", 10, "bold"),
                                 fg="red", command=self.backButtonClicked, width=8,
                                 activebackground="green", activeforeground="blue")
        self.backButton.grid(row=9, column=0, pady=50)

        # Register Button
        self.registerButton = Button(self.belowTitleFrame, text="Register", bg="#FDD037",
                                     font=("Roboto", 10, "bold"),
                                     fg='red', width=8, command=self.registerButtonClicked,
                                     activebackground="green", activeforeground="blue")
        self.registerButton.grid(row=9, column=3, pady=50)

    # File Chooser
    def file(self):
        self.filename = filedialog.askopenfilename(initialdir="C:/Documents", title="Select Image", filetypes=(
            ("JPG Files", "*.jpg"), ("PNG Files", "*.png"), ("JPEG FIles", "*.jpeg"), ("All Files", "*.*")))
        self.imageFile.set(str(os.path.basename(self.filename)))

    # Image View Button
    def imageView(self):
        global myImage
        file = PIL.Image.open(self.filename)
        resized = file.resize((35, 45))
        myImage = ImageTk.PhotoImage(resized)
        imgLabel = Label(self.belowTitleFrame, image=myImage)
        imgLabel.grid(row=6, column=3)

    # Convert the given image to binary data.
    def fileConverter(self):
        with open(self.filename, 'rb') as file:
            binarydata = file.read()
        return binarydata

    # Generate username from First Name, Last Name and Mobile No
    def usernamegenerator(self):
        __firstname = self.firstNameInput.get()
        __lastname = self.lastNameInput.get()
        __mobile = self.mobileInput.get()
        __result = ''.join(random.choices(__firstname + __lastname + __mobile , k=8))
        return __result

    # Back Button Click Action
    def backButtonClicked(self):
        self.destroy()
        LoginPage()

    # Register Button Click Action
    def registerButtonClicked(self):
        __email = self.emailInput.get()
        __firstName = self.firstNameInput.get()
        __lastName = self.lastNameInput.get()
        __mobile = self.mobileInput.get()
        __aadharNo = self.aadharInput.get()
        __password = self.passwordInput.get()
        __confirmPassword = self.confirmPasswordInput.get()
        __librarianId = self.librarianIdInput.get()
        __idImage = self.fileConverter()

        if __email == '':
            showerror(title="Email Error", message="Email can't be Empty")
            self.emailInput.focus()

        if __firstName == '':
            showerror(title="First Name Error", message="First Name can't be Empty.")
            self.firstNameInput.focus()

        if __lastName == '':
            showerror(title="Last Name Error", message="Last Name can't be Empty.")
            self.lastNameInput.focus()

        if __mobile == '':
            showerror(title="Mobile No Error", message="Mobile No can't be Empty.")
            self.mobileInput.focus()

        if __aadharNo == '':
            showerror(title="Aadhar No Error", message="Aadhar No can't be Empty.")
            self.aadharInput.focus()

        if __librarianId == '':
            showerror(title="Librarian ID Error", message="Librarian ID can't be Empty.")
            self.librarianIdInput.focus()

        if __password == '':
            showerror(title="Password Error", message="Password can't be Empty.")
            self.passwordInput.focus()

        if __confirmPassword == '':
            showerror(title="Confirm Password Error", message="Confirm Password can't be Empty.")
            self.confirmPasswordInput.focus()

        if __password != __confirmPassword:
            showerror(title="Password MisMatch", message="Password and Confirm Password does not match.")

        __usernameget = self.usernamegenerator()
        self.username.set(__usernameget)

        __insert = insert(__email, __firstName, __lastName, __mobile, __aadharNo, __librarianId, __usernameget, __password, __idImage)
        if __insert:
            showinfo(title="Register", message="Registered Successfully")

            # Mail Sending
            from_address = 'dhandapanisakthi123@gmail.com'

            message = MIMEMultipart()

            message['From'] = from_address
            message['To'] = __email
            message['Subject'] = 'CS Library Management System Librarian Registeration.'
            body = ('''HI. This is CS Library Management System.\n
            Welcome to Our Family.\n\n
            You Are Registered Successfully...👍👍\n
            Your Details.....\n
            Username        : {}
            Password        : {}
            First Name      : {}
            Last Name       : {}
            Mobile No       : {}
            Aadhar No       : {}
            Librarian ID    : {}\n
                        Thanks to Choose Us......✌️🙏🙏🙏'''.format(__usernameget, __password, __firstName, __lastName, __mobile, __aadharNo, __librarianId))
            message.attach(MIMEText(body, 'plain'))

            filename = self.filename
            attachment = open(filename, 'rb')

            p = MIMEBase('application', 'octet-stream')
            p.set_payload((attachment).read())
            encoders.encode_base64(p)
            p.add_header('Content-Disposition', 'attachment; filename= %s' % filename)
            message.attach(p)

            s = smtplib.SMTP('smtp.gmail.com', 587)
            s.starttls()
            s.login(from_address, 'qaunvbdchweoraeu')
            text = message.as_string()
            s.sendmail(from_address, __email, text)
            s.quit()

            # Destroying current page.
            self.destroy()
            LoginPage()
        else:
            showerror(title="Register", message="You already have an account, Please Login.")

# Home Page
class HomePage(Tk):
    def __init__(self):
        super(HomePage, self).__init__()

        # Main Window
        self.home = None
        self.title("Library Management System")
        self.width_of_window = 1200
        self.height_of_window = 700
        self.screen_width = self.winfo_screenwidth()
        self.screen_height = self.winfo_screenheight()
        self.x_coordinate = int((self.screen_width / 2) - (self.width_of_window / 2))
        self.y_coordinate = int((self.screen_height / 2) - (self.height_of_window / 2))
        self.geometry(f'{self.width_of_window}x{self.height_of_window}+{self.x_coordinate}+{self.y_coordinate}')
        self.configure(bg="light blue")
        self.resizable(False, False)

        # Frame
        self.frame = Frame(self, bg="light blue")
        self.frame.pack()

        # Welcome Message
        self.welcomeLabel = Label(self.frame, text="Welcome to Library Management System",
                                  font=("Times New Roman", 14, "bold"), pady=10, padx=20)
        self.welcomeLabel.grid(row=1, columnspan=4, pady=10)

        # Dashboard Frame
        self.dashFrame = Frame(self, bg="blue")
        self.dashFrame.pack(fill=X)

        # Dashboard Message
        self.dashBoard = Label(self.dashFrame, text="DASHBOARD",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="blue", foreground="white")
        self.dashBoard.pack(anchor="center")

        # Main Frame
        self.mainFrame = Frame(self)
        self.mainFrame.pack()

        global myImage
        self.file = PIL.Image.open('background.jpg')
        self.resized = self.file.resize((1200, 600))
        self.myImage = ImageTk.PhotoImage(self.resized)
        self.imgLabel = Label(self.mainFrame, image=self.myImage)
        self.imgLabel.pack()

        # Books Frame
        self.bookFrame = Frame(self, bg="white", borderwidth=3)
        self.bookFrame.place(x=30, y=250)

        # Book Section
        self.bookSection = Label(self.bookFrame, text="BOOK SECTION", font=("Cambria", 14, "bold"), foreground="blue",
                                 bg="white")
        self.bookSection.grid(row=0, columnspan=3, pady=10)

        # Add Book Button
        self.addBookButton = Button(self.bookFrame, text="Add", font=("Times New Roman", 12, "bold"),
                                    foreground="black", width=10, background="pink", activebackground="green",
                                    borderwidth=2, command=self.addBookButtonClicked)
        self.addBookButton.grid(row=1, column=0, pady=30, padx=10)

        # Delete Book Button
        self.deleteBookButton = Button(self.bookFrame, text="Delete", font=("Times New Roman", 12, "bold"),
                                       foreground="black", width=10, background="pink", activebackground="green",
                                       borderwidth=2, command=self.deleteBookButtonClicked)
        self.deleteBookButton.grid(row=1, column=2, pady=30, padx=20)

        # Search Book Button
        self.searchBookButton = Button(self.bookFrame, text="Search", font=("Times New Roman", 12, "bold"),
                                       foreground="black", width=10, background="pink", activebackground="green",
                                       borderwidth=2, command=self.searchBookButtonClicked)
        self.searchBookButton.grid(row=2, column=0, pady=30, padx=10)

        # Reserve Book Button
        self.reserveBookButton = Button(self.bookFrame, text="Reserve", font=("Times New Roman", 12, "bold"),
                                        foreground="black", width=10, background="pink", activebackground="green",
                                        borderwidth=2, command=self.reserveBookButtonClicked)
        self.reserveBookButton.grid(row=2, column=2, pady=30, padx=20)

        # Renew Book Button
        self.renewBookButton = Button(self.bookFrame, text="Renew", font=("Times New Roman", 12, "bold"),
                                      foreground="black", width=10, background="pink", activebackground="green",
                                      borderwidth=2, command=self.renewBookButtonClicked)
        self.renewBookButton.grid(row=3, column=0, pady=30, padx=10)

        # Update Book Button
        self.updateBookButton = Button(self.bookFrame, text="Update", font=("Times New Roman", 12, "bold"),
                                       foreground="black", width=10, background="pink", activebackground="green",
                                       borderwidth=2, command=self.updateBookButtonClicked)
        self.updateBookButton.grid(row=3, column=2, pady=30, padx=20)

        # Request Details Button
        self.requestDetailsButton = Button(self.bookFrame, text="Request Details", font=("Times New Roman", 12, "bold"),
                                           foreground="black", width=15, background="pink", activebackground="green",
                                           borderwidth=2, command=self.requestDetailsButtonClicked)
        self.requestDetailsButton.grid(row=4, column=0, pady=30, padx=20)

        # Fine Management Button
        self.fineManageButton = Button(self.bookFrame, text="Fine Details", font=("Times New Roman", 12, "bold"),
                                       foreground="black", width=10, background="pink", activebackground="green",
                                       borderwidth=2, command=self.fineManagementButtonClicked)
        self.fineManageButton.grid(row=4, column=2, pady=30, padx=20)

        # Students Frame
        self.studentFrame = Frame(self, bg="white", borderwidth=3)
        self.studentFrame.place(x=430, y=250)

        # Section
        self.studentSection = Label(self.studentFrame, text="STUDENT SECTION", font=("Cambria", 14, "bold"),
                                    foreground="blue",
                                    bg="white")
        self.studentSection.grid(row=0, columnspan=3, pady=10)

        # Add Student Button
        self.addStudentButton = Button(self.studentFrame, text="Add", font=("Times New Roman", 12, "bold"),
                                       foreground="black", width=10, background="pink", activebackground="green",
                                       borderwidth=2, command=self.addStudentButtonClicked)
        self.addStudentButton.grid(row=1, column=0, pady=10, padx=10)

        # Delete Student Button
        self.deleteStudentButton = Button(self.studentFrame, text="Delete",
                                          font=("Times New Roman", 12, "bold"),
                                          foreground="black", width=10, background="pink", activebackground="green",
                                          borderwidth=2, command=self.deleteStudentButtonClicked)
        self.deleteStudentButton.grid(row=1, column=1, pady=10, padx=10)

        # Edit Student Button
        self.editStudentButton = Button(self.studentFrame, text="Edit",
                                        font=("Times New Roman", 12, "bold"),
                                        foreground="black", width=10, background="pink", activebackground="green",
                                        borderwidth=2, command=self.editStudentButtonClicked)
        self.editStudentButton.grid(row=2, column=0, pady=10, padx=10)

        # Search Student Button
        self.searchStudentButton = Button(self.studentFrame, text="Search", font=("Times New Roman", 12, "bold"),
                                          foreground="black", width=10, background="pink", activebackground="green",
                                          borderwidth=2, command=self.searchStudentButtonClicked)
        self.searchStudentButton.grid(row=2, column=1, padx=10, pady=20)

        # Staffs Frame
        self.staffFrame = Frame(self, bg="white", borderwidth=3)
        self.staffFrame.place(x=430, y=495)

        # Section
        self.staffSection = Label(self.staffFrame, text="STAFF SECTION", font=("Cambria", 14, "bold"),
                                  foreground="blue",
                                  bg="white")
        self.staffSection.grid(row=0, columnspan=3, pady=10)

        # Add Staff Button
        self.addStaffButton = Button(self.staffFrame, text="Add", font=("Times New Roman", 12, "bold"),
                                     foreground="black", width=10, background="pink", activebackground="green",
                                     borderwidth=2, command=self.addStaffButtonClicked)
        self.addStaffButton.grid(row=1, column=0, pady=10, padx=10)

        # Delete Staff Button
        self.deleteStaffButton = Button(self.staffFrame, text="Delete",
                                        font=("Times New Roman", 12, "bold"),
                                        foreground="black", width=10, background="pink", activebackground="green",
                                        borderwidth=2, command=self.deleteStaffButtonClicked)
        self.deleteStaffButton.grid(row=1, column=1, pady=10, padx=10)

        # Edit Staff Button
        self.editStaffButton = Button(self.staffFrame, text="Edit",
                                      font=("Times New Roman", 12, "bold"),
                                      foreground="black", width=10, background="pink", activebackground="green",
                                      borderwidth=2, command=self.editStaffButtonClicked)
        self.editStaffButton.grid(row=2, column=0, pady=10, padx=10)

        # Search Staff Button
        self.searchStaffButton = Button(self.staffFrame, text="Search", font=("Times New Roman", 12, "bold"),
                                        foreground="black", width=10, background="pink", activebackground="green",
                                        borderwidth=2, command=self.searchStaffButtonClicked)
        self.searchStaffButton.grid(row=2, column=1, padx=10, pady=20)

        # Admin Frame
        self.adminFrame = Frame(self, bg="white", borderwidth=3)
        self.adminFrame.place(x=730, y=250)

        # Section
        self.adminSection = Label(self.adminFrame, text="ADMIN SECTION", font=("Cambria", 14, "bold"),
                                  foreground="blue",
                                  bg="white")
        self.adminSection.grid(row=0, columnspan=3, pady=10)

        # Admin Profile Edit Button
        self.editProfileButton = Button(self.adminFrame, text="Edit", font=("Times New Roman", 12, "bold"),
                                        foreground="black", width=10, background="pink", activebackground="green",
                                        borderwidth=2, command=self.editAdminSection)
        self.editProfileButton.grid(row=1, column=0, pady=10, padx=10)

        # Admin Profile View Button
        self.viewProfileButton = Button(self.adminFrame, text="View",
                                        font=("Times New Roman", 12, "bold"),
                                        foreground="black", width=10, background="pink", activebackground="green",
                                        borderwidth=2, command=self.viewProfileButtonClicked)
        self.viewProfileButton.grid(row=1, column=1, pady=10, padx=10)

        # Logout Button
        self.logoutButton = Button(self.adminFrame, text="Logout", font=("Times New Roman", 12, "bold"),
                                   foreground="black", width=10, background="pink", activebackground="green",
                                   borderwidth=2, command=self.logoutButtonClicked)
        self.logoutButton.grid(row=2, columnspan=3, pady=20, padx=10)

        # Others Frame
        self.othersFrame = Frame(self, bg="white", borderwidth=3)
        self.othersFrame.place(x=730, y=495)

        # Section
        self.othersSection = Label(self.othersFrame, text="OTHERS SECTION", font=("Cambria", 14, "bold"),
                                   foreground="blue",
                                   bg="white")
        self.othersSection.grid(row=0, columnspan=3, pady=10)

        # Add Others Button
        self.addOthersButton = Button(self.othersFrame, text="Add", font=("Times New Roman", 12, "bold"),
                                      foreground="black", width=10, background="pink", activebackground="green",
                                      borderwidth=2, command=self.addOthersButtonClicked)
        self.addOthersButton.grid(row=1, column=0, pady=10, padx=10)

        # Delete Others Button
        self.deleteOthersButton = Button(self.othersFrame, text="Delete",
                                         font=("Times New Roman", 12, "bold"),
                                         foreground="black", width=10, background="pink", activebackground="green",
                                         borderwidth=2, command=self.deleteOthersButtonClicked)
        self.deleteOthersButton.grid(row=1, column=1, pady=10, padx=10)

        # Edit Others Button
        self.editOthersButton = Button(self.othersFrame, text="Edit",
                                       font=("Times New Roman", 12, "bold"),
                                       foreground="black", width=10, background="pink", activebackground="green",
                                       borderwidth=2, command=self.editOthersButtonClicked)
        self.editOthersButton.grid(row=2, column=0, pady=10, padx=10)

        # Search Others Button
        self.searchOthersButton = Button(self.othersFrame, text="Search", font=("Times New Roman", 12, "bold"),
                                         foreground="black", width=10, background="pink", activebackground="green",
                                         borderwidth=2, command=self.searchOthersButtonClicked)
        self.searchOthersButton.grid(row=2, column=1, padx=10, pady=20)

    # Add Book Button Clicked Action
    def addBookButtonClicked(self):
        self.destroy()
        Book_Section.AddBook()

    # Delete Book Button Clicked Action
    def deleteBookButtonClicked(self):
        self.destroy()
        Book_Section.DeleteBook()

    # Search Book Button Clicked Action
    def searchBookButtonClicked(self):
        self.destroy()
        Book_Section.SearchBook()

    # Reserve Book Button Clicked Action
    def reserveBookButtonClicked(self):
        self.destroy()
        Book_Section.ReserveBook()

    # Renew Book Button Clicked Action
    def renewBookButtonClicked(self):
        self.destroy()

    # Update Book Button Clicked Action
    def updateBookButtonClicked(self):
        self.destroy()

    # Request Details Button Clicked Action
    def requestDetailsButtonClicked(self):
        self.destroy()

    # Fine Management Button Clicked Action
    def fineManagementButtonClicked(self):
        self.destroy()

    # Logout Function
    def logoutButtonClicked(self):
        self.destroy()
        LoginPage().mainloop()

    # Add Student Button Clicked Action
    def addStudentButtonClicked(self):
        self.destroy()
        Student_Section.AddStudent()

    # Delete Student Button Clicked Action
    def deleteStudentButtonClicked(self):
        self.destroy()
        Student_Section.DeleteStudent()

    # Search Student Button Clicked Action
    def searchStudentButtonClicked(self):
        self.destroy()
        Student_Section.SearchStudent()

    # Edit Student Button Clicked Action
    def editStudentButtonClicked(self):
        self.destroy()
        Student_Section.EditStudent()

    # Add Staff Button Clicked Action
    def addStaffButtonClicked(self):
        self.destroy()
        Staff_Section.AddStaff()

    # Delete Staff Button Clicked Action
    def deleteStaffButtonClicked(self):
        self.destroy()
        Staff_Section.DeleteStaff()

    # Search Staff Button Clicked Action
    def searchStaffButtonClicked(self):
        self.destroy()
        Staff_Section.SearchStaff()

    # Edit Staff Button Clicked Action
    def editStaffButtonClicked(self):
        self.destroy()
        Staff_Section.EditStaff()

    # Add Others Button Clicked Action
    def addOthersButtonClicked(self):
        self.destroy()
        Others_Section.AddOthers()

    # Delete Others Button Clicked Action
    def deleteOthersButtonClicked(self):
        self.destroy()
        Others_Section.DeleteOthers()

    # Edit Others Button Clicked Action
    def editOthersButtonClicked(self):
        self.destroy()
        Others_Section.EditOthers()

    # Search Others Button Clicked
    def searchOthersButtonClicked(self):
        self.destroy()
        Others_Section.SearchOthers()

    # Edit Admin Section
    def editAdminSection(self):
        self.destroy()
        Admin_Section.EditAdmin()

    # View Profile Admin Section
    def viewProfileButtonClicked(self):
        self.destroy()
        Admin_Section.ViewAdminDetails()


# Run the Program
if __name__ == "__main__":
    app = LoginPage()
    app.resizable(False, False)
    app.mainloop()
