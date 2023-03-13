import os
import random
from tkinter import *
import tkinter
from tkinter import filedialog, ttk, messagebox
from tkinter.font import Font
import PIL
from PIL import ImageTk
from messagebox import showerror, showinfo

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders
from othersDb import *

import Login_Register_Page


# ADD OTHERS CLASS
class AddOthers(Tk):
    def __init__(self):
        super(AddOthers, self).__init__()

        self.username = None
        self.home = None
        self.filename = None
        self.title("Library Management System")
        self.width_of_window = 1400
        self.height_of_window = 750
        self.screen_width = self.winfo_screenwidth()
        self.screen_height = self.winfo_screenheight()
        self.x_coordinate = int((self.screen_width / 2) - (self.width_of_window / 2))
        self.y_coordinate = int((self.screen_height / 2) - (self.height_of_window / 2))
        self.geometry(f'{self.width_of_window}x{self.height_of_window}+{self.x_coordinate}+{self.y_coordinate}')
        self.config(bg="light blue")

        # Frame
        self.frame = Frame(self, bg="light blue")
        self.frame.pack()

        # Welcome Message
        self.welcomeLabel = Label(self.frame, text="Welcome to Library Management System",
                                  font=("Times New Roman", 14, "bold"), pady=10, padx=20, background="green")
        self.welcomeLabel.grid(row=1, columnspan=4, pady=20)

        # Dashboard Frame
        self.dashFrame = Frame(self, bg="#46A094")
        self.dashFrame.pack(fill=X)

        # Dashboard Message
        self.dashBoard = Label(self.dashFrame, text="ADD A OTHER MEMBER",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="yellow", foreground="black")
        self.dashBoard.pack(anchor="center", fill=X)

        # Input Fields
        self.email = StringVar()
        self.firstName = StringVar()
        self.lastName = StringVar()
        self.mobileNo = StringVar()
        self.userName = StringVar()
        self.passWord = StringVar()
        self.confirmPassword = StringVar()
        self.aadharNo = StringVar()
        self.address = StringVar()
        self.idImage = StringVar()
        self.department = StringVar()

        # Main Frame
        self.mainFrame = Frame(self, bg="#46A094")
        self.mainFrame.pack(fill=X)

        # Email ID Input and Field
        self.emailIdLabel = Label(self.mainFrame, text="Email ID :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.emailIdLabel.grid(row=0, column=1, pady=10, padx=50)

        self.emailIdInput = Entry(self.mainFrame, textvariable=self.email, font=("Cambria", 10, "bold"))
        self.emailIdInput.grid(row=0, column=2, pady=10)

        # First Name Input and Field
        self.firstNameLabel = Label(self.mainFrame, text="First Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.firstNameLabel.grid(row=0, column=3, pady=10, padx=50)

        self.firstNameInput = Entry(self.mainFrame, textvariable=self.firstName, font=("Cambria", 10, "bold"))
        self.firstNameInput.grid(row=0, column=4, pady=10)

        # Last Name Input and Field
        self.lastNameLabel = Label(self.mainFrame, text="Last Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.lastNameLabel.grid(row=0, column=5, pady=10, padx=50)

        self.lastNameInput = Entry(self.mainFrame, textvariable=self.lastName, font=("Cambria", 10, "bold"))
        self.lastNameInput.grid(row=0, column=6, pady=10)

        # Mobile No Input and Field
        self.mobileNoLabel = Label(self.mainFrame, text="Mobile No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.mobileNoLabel.grid(row=1, column=1, pady=10, padx=50)

        self.mobileNoInput = Entry(self.mainFrame, textvariable=self.mobileNo, font=("Cambria", 10, "bold"))
        self.mobileNoInput.grid(row=1, column=2, pady=10)

        # Aadhar No Input and Field
        self.aadharNoLabel = Label(self.mainFrame, text="Aadhar No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.aadharNoLabel.grid(row=1, column=3, pady=10, padx=50)

        self.aadharNoInput = Entry(self.mainFrame, textvariable=self.aadharNo, font=("Cambria", 10, "bold"))
        self.aadharNoInput.grid(row=1, column=4, pady=10)

        # Username Input and Field
        self.userNameLabel = Label(self.mainFrame, text="Username :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.userNameLabel.grid(row=1, column=5, pady=10, padx=50)

        self.userNameInput = Entry(self.mainFrame, textvariable=self.userName, font=("Cambria", 10, "bold"))
        self.userNameInput.grid(row=1, column=6, pady=10)

        # Password Input and Field
        self.passWordLabel = Label(self.mainFrame, text="Password :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.passWordLabel.grid(row=2, column=1, pady=10, padx=50)

        self.passWordInput = Entry(self.mainFrame, textvariable=self.passWord, font=("Cambria", 10, "bold"), show="*")
        self.passWordInput.grid(row=2, column=2, pady=10)

        # Confirm Password Input and Field
        self.confirmPasswordLabel = Label(self.mainFrame, text="Confirm Password :", font=("Cambria", 10, "bold"),
                                          bg="#46A094")
        self.confirmPasswordLabel.grid(row=2, column=3, pady=10, padx=50)

        self.confirmPasswordInput = Entry(self.mainFrame, textvariable=self.confirmPassword,
                                          font=("Cambria", 10, "bold"), show="*")
        self.confirmPasswordInput.grid(row=2, column=4, pady=10)

        # Address Input and Field
        self.addressLabel = Label(self.mainFrame, text="Address :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.addressLabel.grid(row=3, column=1, pady=10, padx=50)

        self.addressInput = Text(self.mainFrame, height=6, width=40, font=("Cambria", 10, "bold"))
        self.addressInput.grid(row=3, column=2, columnspan=3, pady=10, sticky="w")

        # Id Image Input and View Button
        self.idImageInput = Entry(self.mainFrame, textvariable=self.idImage, font=("Cambria", 10, "bold"),
                                  state="readonly")
        self.idImage.set("Select Your Image")
        self.idImageInput.grid(row=2, column=5, pady=10, padx=50)

        self.idImageButton = Button(self.mainFrame, font=("Cambria", 10, "bold"), command=self.file,
                                    text="Select Image", bg="#FDD037",
                                    foreground="black", width=10)
        self.idImageButton.grid(row=2, column=6, pady=10)

        # Image View Button
        self.imageViewButton = Button(self.mainFrame, command=self.imageView, text="View Image",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.imageViewButton.grid(row=3, column=6, pady=10)

        # Back Button
        self.backButton = Button(self.mainFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=4, column=1)

        # Add Function Button
        self.addActionButton = Button(self.mainFrame, command=self.addOthersButtonClicked, text="ADD OTHERS",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.addActionButton.grid(row=4, column=4, pady=20)

        # Tree Frame.
        self.treeFrame = Frame(self)
        self.treeFrame.pack(pady=40)
        self.style = ttk.Style()
        self.style.configure("mystyle.Treeview", font=("Cambria", 8, "bold"), anchor=CENTER)
        self.style.configure("mystyle.Treeview.Heading", font=("Cambria", 10, "bold"), anchor=CENTER)

        self.tree = ttk.Treeview(self.treeFrame, columns=('1', '2', '3', '4', '5', '6'), style="mystyle.Treeview")
        self.tree.heading("1", text="First Name")
        self.tree.heading("2", text="Last Name")
        self.tree.heading("3", text="Email ID")
        self.tree.column("3", width=200)
        self.tree.heading("4", text="Mobile No")
        self.tree.heading("5", text="Aadhar No")
        self.tree.heading("6", text="Username")
        self.tree.column("6", width=130)
        self.tree['show'] = 'headings'
        self.xScrollBar = Scrollbar(self.treeFrame, orient=VERTICAL, command=self.tree.yview)
        self.xScrollBar.pack(side=RIGHT, fill=Y)
        self.tree.configure(yscrollcommand=self.xScrollBar.set)
        self.tree.pack(fill=X)

    # Convert the given image to binary data.
    def fileConverter(self):
        with open(self.filename, 'rb') as file:
            binarydata = file.read()
        return binarydata

    # Generate username from First Name, Last Name and Mobile No
    def usernamegenerator(self):
        __firstname = self.firstNameInput.get()
        __lastname = self.lastNameInput.get()
        __mobile = self.mobileNoInput.get()
        __result = ''.join(random.choices(__firstname + __lastname + __mobile, k=8))
        return __result

    # Field Validator
    @staticmethod
    def fieldValidator(email1, firstname, lastname, mobile, password, confirmpassword, aadharno, address):
        if email1 == '':
            showerror(title="Email Error", message="Email can't be Empty")
            return False

        if firstname == '':
            showerror(title="First Name Error", message="First Name can't be Empty")
            return False

        if lastname == '':
            showerror(title="Last Name Error", message="Last Name can't be Empty")
            return False

        if mobile == '':
            showerror(title="Mobile No Error", message="Mobile No can't be Empty")
            return False

        if password == '':
            showerror(title="Password Error", message="Password can't be Empty")
            return False

        if confirmpassword == '':
            showerror(title="Confirm Password Error", message="Confirm Password can't be Empty")
            return False

        if password != confirmpassword:
            showerror(title="Password MisMatch Error", message="Password and Confirm Passwords are must be same")
            return False

        if aadharno == '':
            showerror(title="Aadhar No Error", message="Aadhar No can't be Empty")
            return False

        if address == '':
            showerror(title="Address Error", message="Address can't be Empty")
            return False
        return True

    # Clear Function
    def clearAction(self):
        self.email.set("")
        self.firstName.set("")
        self.lastName.set("")
        self.mobileNo.set("")
        self.userName.set("")
        self.passWord.set("")
        self.confirmPassword.set("")
        self.aadharNo.set("")
        self.addressInput.delete(1.0, END)

    # Add Others Button Action
    def addOthersButtonClicked(self):
        __email = self.emailIdInput.get()
        __firstname = self.firstNameInput.get()
        __lastname = self.lastNameInput.get()
        __mobileno = self.mobileNoInput.get()
        __password = self.passWordInput.get()
        __confirmpassword = self.confirmPasswordInput.get()
        __address = self.addressInput.get(1.0, END)
        __aadhar = self.aadharNoInput.get()
        __username = self.userNameInput.get()
        __idImage = self.fileConverter()

        __validate = self.fieldValidator(__email, __firstname, __lastname, __mobileno, __password, __confirmpassword,
                                         __aadhar, __address)

        if __validate:
            __usernameget = self.usernamegenerator()
            self.userName.set(__usernameget)

            __insert = insert(__email, __firstname, __lastname, __mobileno, __usernameget, __password, __aadhar,
                              __address, __idImage)
            if __insert:
                showinfo(title="Register", message="Registered Successfully")

                # Mail Sending
                from_address = 'dhandapanisakthi123@gmail.com'

                message = MIMEMultipart()

                message['From'] = from_address
                message['To'] = __email
                message['Subject'] = 'CS Library Management System Librarian Registeration.'
                body = ('''
                HI. This is CS Library Management System.\n
                Welcome to Our Family.\n\n
                You Are Registered Successfully...👍👍\n
                Your Details.....\n
                Username        : {}
                Password        : {}
                First Name      : {}
                Last Name       : {}
                Mobile No       : {}
                Aadhar No       : {}\n
                            Thanks to Choose Us......✌️🙏🙏🙏'''.format(__usernameget, __password, __firstname,
                                                                        __lastname, __mobileno, __aadhar))
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
                self.tree.insert("", index="end",
                                 values=(__firstname, __lastname, __email, __mobileno, __aadhar, __username))
                self.clearAction()

            else:
                showerror(title='Error', message='Enter Correct Details for Registeration')

    def file(self):
        self.filename = filedialog.askopenfilename(initialdir="C:/Documents", title="Select Image", filetypes=(
            ("JPG Files", "*.jpg"), ("PNG Files", "*.png"), ("JPEG FIles", "*.jpeg"), ("All Files", "*.*")))
        self.idImage.set(str(os.path.basename(self.filename)))

    # Image View Button
    def imageView(self):
        global myImage
        file = PIL.Image.open(self.filename)
        resized = file.resize((35, 45))
        myImage = ImageTk.PhotoImage(resized)
        imgLabel = Label(self.mainFrame, image=myImage)
        imgLabel.grid(row=3, column=7)

    # Back Button Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()


# DELETE OTHERS CLASS
class DeleteOthers(Tk):
    def __init__(self):
        super(DeleteOthers, self).__init__()

        self.filename = None
        self.title("Library Management System")
        self.width_of_window = 1400
        self.height_of_window = 750
        self.screen_width = self.winfo_screenwidth()
        self.screen_height = self.winfo_screenheight()
        self.x_coordinate = int((self.screen_width / 2) - (self.width_of_window / 2))
        self.y_coordinate = int((self.screen_height / 2) - (self.height_of_window / 2))
        self.geometry(f'{self.width_of_window}x{self.height_of_window}+{self.x_coordinate}+{self.y_coordinate}')
        self.config(bg="light blue")

        # Frame
        self.frame = Frame(self, bg="light blue")
        self.frame.pack()

        # Welcome Message
        self.welcomeLabel = Label(self.frame, text="Welcome to Library Management System",
                                  font=("Times New Roman", 14, "bold"), pady=10, padx=20, background="green")
        self.welcomeLabel.grid(row=1, columnspan=4, pady=20)

        # Dashboard Frame
        self.dashFrame = Frame(self, bg="#46A094")
        self.dashFrame.pack(fill=X)

        # Dashboard Message
        self.dashBoard = Label(self.dashFrame, text="DELETE A OTHER MEMBER",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="yellow", foreground="black")
        self.dashBoard.pack(anchor="center", fill=X)

        # Input Fields
        self.email = StringVar()
        self.firstName = StringVar()
        self.lastName = StringVar()
        self.mobileNo = StringVar()
        self.userName = StringVar()
        self.passWord = StringVar()
        self.confirmPassword = StringVar()
        self.aadharNo = StringVar()
        self.address = StringVar()
        self.idImage = StringVar()

        # Main Frame
        self.mainFrame = Frame(self, bg="#46A094")
        self.mainFrame.pack(fill=X)

        # Email ID Input and Field
        self.emailIdLabel = Label(self.mainFrame, text="Email ID :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.emailIdLabel.grid(row=0, column=1, pady=10, padx=50)

        self.emailIdInput = Entry(self.mainFrame, textvariable=self.email, font=("Cambria", 10, "bold"))
        self.emailIdInput.grid(row=0, column=2, pady=10)

        # First Name Input and Field
        self.firstNameLabel = Label(self.mainFrame, text="First Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.firstNameLabel.grid(row=0, column=3, pady=10, padx=50)

        self.firstNameInput = Entry(self.mainFrame, textvariable=self.firstName, font=("Cambria", 10, "bold"))
        self.firstNameInput.grid(row=0, column=4, pady=10)

        # Last Name Input and Field
        self.lastNameLabel = Label(self.mainFrame, text="Last Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.lastNameLabel.grid(row=0, column=5, pady=10, padx=50)

        self.lastNameInput = Entry(self.mainFrame, textvariable=self.lastName, font=("Cambria", 10, "bold"))
        self.lastNameInput.grid(row=0, column=6, pady=10)

        # Mobile No Input and Field
        self.mobileNoLabel = Label(self.mainFrame, text="Mobile No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.mobileNoLabel.grid(row=1, column=1, pady=10, padx=50)

        self.mobileNoInput = Entry(self.mainFrame, textvariable=self.mobileNo, font=("Cambria", 10, "bold"))
        self.mobileNoInput.grid(row=1, column=2, pady=10)

        # Aadhar No Input and Field
        self.aadharNoLabel = Label(self.mainFrame, text="Aadhar No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.aadharNoLabel.grid(row=1, column=3, pady=10, padx=50)

        self.aadharNoInput = Entry(self.mainFrame, textvariable=self.aadharNo, font=("Cambria", 10, "bold"))
        self.aadharNoInput.grid(row=1, column=4, pady=10)

        # Username Input and Field
        self.userNameLabel = Label(self.mainFrame, text="Username :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.userNameLabel.grid(row=1, column=5, pady=10, padx=50)

        self.userNameInput = Entry(self.mainFrame, textvariable=self.userName, font=("Cambria", 10, "bold"))
        self.userNameInput.grid(row=1, column=6, pady=10)

        # Password Input and Field
        self.passWordLabel = Label(self.mainFrame, text="Password :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.passWordLabel.grid(row=2, column=1, pady=10, padx=50)

        self.passWordInput = Entry(self.mainFrame, textvariable=self.passWord, font=("Cambria", 10, "bold"), show="*")
        self.passWordInput.grid(row=2, column=2, pady=10)

        # Confirm Password Input and Field
        self.confirmPasswordLabel = Label(self.mainFrame, text="Confirm Password :", font=("Cambria", 10, "bold"),
                                          bg="#46A094")
        self.confirmPasswordLabel.grid(row=2, column=3, pady=10, padx=50)

        self.confirmPasswordInput = Entry(self.mainFrame, textvariable=self.confirmPassword,
                                          font=("Cambria", 10, "bold"), show="*")
        self.confirmPasswordInput.grid(row=2, column=4, pady=10)

        # Address Input and Field
        self.addressLabel = Label(self.mainFrame, text="Address :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.addressLabel.grid(row=3, column=1, pady=10, padx=50)

        self.addressInput = Text(self.mainFrame, height=6, width=40, font=("Cambria", 10, "bold"))
        self.addressInput.grid(row=3, column=2, columnspan=3, pady=10, sticky="w")

        # Id Image Input and View Button
        self.idImageInput = Entry(self.mainFrame, textvariable=self.idImage, font=("Cambria", 10, "bold"),
                                  state="readonly")
        self.idImageInput.grid(row=2, column=5, pady=10, padx=50)

        # Image View Button
        self.imageViewButton = Button(self.mainFrame, command=self.imageView, text="View Image",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.imageViewButton.grid(row=2, column=6, pady=10)

        # Back Button
        self.backButton = Button(self.mainFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=4, column=1)

        # Delete Function Button
        self.deleteActionButton = Button(self.mainFrame, command=self.deleteOthersButtonClicked, text="DELETE OTHERS",
                                         font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black")
        self.deleteActionButton.grid(row=4, column=4, pady=20)

        # Tree Frame.
        self.treeFrame = Frame(self)
        self.treeFrame.pack(pady=40)
        self.style = ttk.Style()
        self.style.configure("mystyle.Treeview", font=("Cambria", 8, "bold"), anchor=CENTER)
        self.style.configure("mystyle.Treeview.Heading", font=("Cambria", 10, "bold"), anchor=CENTER)

        self.tree = ttk.Treeview(self.treeFrame, columns=('1', '2', '3', '4', '5', '6'), style="mystyle.Treeview")
        self.tree.heading("1", text="First Name")
        self.tree.heading("2", text="Last Name")
        self.tree.heading("3", text="Email ID")
        self.tree.column("3", width=200)
        self.tree.heading("4", text="Mobile No")
        self.tree.heading("5", text="Aadhar No")
        self.tree.heading("6", text="Username")
        self.tree.column("6", width=130)
        self.tree['show'] = 'headings'
        self.xScrollBar = Scrollbar(self.treeFrame, orient=VERTICAL, command=self.tree.yview)
        self.xScrollBar.pack(side=RIGHT, fill=Y)
        self.tree.configure(yscrollcommand=self.xScrollBar.set)
        self.tree.pack(fill=X)

    def file(self):
        self.filename = filedialog.askopenfilename(initialdir="C:/Documents", title="Select Image", filetypes=(
            ("JPG Files", "*.jpg"), ("PNG Files", "*.png"), ("JPEG FIles", "*.jpeg"), ("All Files", "*.*")))
        self.idImage.set(str(os.path.basename(self.filename)))

    # Image View Button
    def imageView(self):
        global myImage
        file = PIL.Image.open(self.filename)
        resized = file.resize((35, 45))
        myImage = ImageTk.PhotoImage(resized)
        imgLabel = Label(self.mainFrame, image=myImage)
        imgLabel.grid(row=3, column=6)

    # Back Button Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()

    # Clear Function
    def clearAction(self):
        self.email.set("")
        self.firstName.set("")
        self.lastName.set("")
        self.mobileNo.set("")
        self.userName.set("")
        self.passWord.set("")
        self.confirmPassword.set("")
        self.aadharNo.set("")
        self.addressInput.delete(1.0, END)

    # Add Student Button Action
    def deleteOthersButtonClicked(self):
        try:
            __selected = self.tree.selection()[0]
            if __selected:
                __message = messagebox.askyesno("Delete?", "Are You sure to Delete?")
                if __message:
                    self.tree.delete(__selected)
        except IndexError:
            messagebox.showerror("Selection", "You are not select any items.")

    # Display Action button Clicked
    def displayActionButtonClicked(self):
        __email = self.emailIdInput.get()
        __firstname = self.firstNameInput.get()
        __lastname = self.lastNameInput.get()
        __mobile = self.mobileNoInput.get()
        __aadhar = self.aadharNoInput.get()
        __username = self.userNameInput.get()
        self.tree.insert("", index="end",
                         values=(__firstname, __lastname, __email, __mobile, __aadhar, __username))
        self.clearAction()


# SEARCH A OTHER
class SearchOthers(Tk):
    def __init__(self):
        super(SearchOthers, self).__init__()

        self.othersFrame = None
        self.register = None
        self.dept = None
        self.home = None
        self.filename = None
        self.title("Library Management System")
        self.width_of_window = 1400
        self.height_of_window = 750
        self.screen_width = self.winfo_screenwidth()
        self.screen_height = self.winfo_screenheight()
        self.x_coordinate = int((self.screen_width / 2) - (self.width_of_window / 2))
        self.y_coordinate = int((self.screen_height / 2) - (self.height_of_window / 2))
        self.geometry(f'{self.width_of_window}x{self.height_of_window}+{self.x_coordinate}+{self.y_coordinate}')
        self.config(bg="light blue")

        # Frame
        self.frame = Frame(self, bg="light blue")
        self.frame.pack()
        self.resizable(False, False)

        # Welcome Message
        self.welcomeLabel = Label(self.frame, text="Welcome to Library Management System",
                                  font=("Times New Roman", 14, "bold"), pady=10, padx=20, background="green")
        self.welcomeLabel.grid(row=1, columnspan=4, pady=10)

        # Dashboard Frame
        self.dashFrame = Frame(self, bg="#46A094")
        self.dashFrame.pack(fill=X)

        # Dashboard Message
        self.dashBoard = Label(self.dashFrame, text="SEARCH A OTHER",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="yellow", foreground="black")
        self.dashBoard.pack(fill=X, anchor=CENTER)

        # Input Fields and Labels
        self.aadharNo = StringVar()
        self.username = StringVar()

        # Main Frame
        self.mainFrame = Frame(self, bg="#46A094")
        self.mainFrame.pack(fill=Y, anchor=CENTER, pady=20)

        # Register No Input and Field
        self.aadharNoLabel = Label(self.mainFrame, text="Aadhar No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.aadharNoLabel.grid(row=1, column=7, pady=30, padx=50)

        self.aadharNoInput = Entry(self.mainFrame, textvariable=self.aadharNo, font=("Cambria", 10, "bold"))
        self.aadharNoInput.grid(row=1, column=8, pady=30)

        # Username Input and Field
        self.userNameLabel = Label(self.mainFrame, text="Username :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.userNameLabel.grid(row=1, column=9, pady=10, padx=30)

        self.userNameInput = Entry(self.mainFrame, textvariable=self.username, font=("Cambria", 10, "bold"))
        self.userNameInput.grid(row=1, column=10, pady=10, padx=30)

        # Back Button
        self.backButton = Button(self.mainFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=2, column=7, pady=10)

        # Download Button
        self.downloadButton = Button(self.mainFrame, command=self.downloadButtonClicked, text="DOWNLOAD",
                                     font=("Cambria", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.downloadButton.grid(row=2, column=9, pady=10, padx=50)

        # Search Button
        self.searchButton = Button(self.mainFrame, command=self.searchButtonClicked, text="Search",
                                   font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.searchButton.grid(row=2, column=11, pady=10, padx=40)

        # Others Frame
        self.othersFrame = Frame(self, bg="white")
        self.othersFrame.pack(fill=X, padx=30)

    # Back Button Clicked Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()

    # Download Button Clicked Action
    def downloadButtonClicked(self):
        pass

    # Search Button Clicked Action
    def searchButtonClicked(self):
        __username = "dk"
        __firstname = "Dhineshkumar"
        __lastname = "Dhandapani"
        __mail = "dhandapanisakthi123@gmail.com"
        __department = "CSE"
        __mobileno = "6374831110"
        __aadharno = "483096249638"
        __name = f'{__firstname}  {__lastname}'

        # View Details Label
        __viewDetailsLabel = Label(self.othersFrame, text="OTHER DETAIL", font=("Cambria", 15, "bold"),
                                   background="white")
        __viewDetailsLabel.grid(row=1, column=6, pady=20, columnspan=6)

        # Name Label
        __nameLabel = Label(self.othersFrame, text=__name, font=("Cambria", 15, "bold"), background="white",
                            foreground="blue")
        __nameLabel.grid(row=2, column=1, padx=50, pady=10, sticky="w")

        # Email ID Label
        __mailLabel = Label(self.othersFrame, text=__mail, font=("Cambria", 15, "bold"), background="white",
                            foreground="blue")
        __mailLabel.grid(row=3, column=1, padx=50, pady=10, sticky="w")

        # Student Image
        global myImage
        file = PIL.Image.open("background.jpg")
        resized = file.resize((600, 300))
        myImage = ImageTk.PhotoImage(resized)
        imgLabel = Label(self.othersFrame, image=myImage)
        imgLabel.grid(row=2, column=10, columnspan=5, rowspan=7, padx=230, pady=20)

        # Username Label
        __usernameLabel = Label(self.othersFrame, text=__username, font=("Cambria", 15, "bold"), background="white",
                                foreground="blue")
        __usernameLabel.grid(row=4, column=1, pady=10, sticky="w", padx=50)

        # Mobile No Label
        __mobilenoLabel = Label(self.othersFrame, text=__mobileno, font=("Cambria", 15, "bold"), background="white",
                                foreground="blue")
        __mobilenoLabel.grid(row=5, column=1, pady=10, padx=50, sticky="w")

        # Aadhar No Label
        __aadharnoLabel = Label(self.othersFrame, text=__aadharno, font=("Cambria", 15, "bold"), background="white",
                                foreground="blue")
        __aadharnoLabel.grid(row=6, column=1, pady=10, padx=50, sticky="w")

    # ID CARD Creating Function
    def IDCardManufacturing(self):
        __firstname = 'Dhineshkumar'
        __lastname = 'Dhandapani'
        __mobileno = '6374831110'
        __aadharno = '4830 9624 9638'


# EDIT OTHERS CLASS
class EditOthers(Tk):
    def __init__(self):
        super(EditOthers, self).__init__()

        self.othersFrame = None
        self.username = None
        self.home = None
        self.filename = None
        self.title("Library Management System")
        self.width_of_window = 1400
        self.height_of_window = 750
        self.screen_width = self.winfo_screenwidth()
        self.screen_height = self.winfo_screenheight()
        self.x_coordinate = int((self.screen_width / 2) - (self.width_of_window / 2))
        self.y_coordinate = int((self.screen_height / 2) - (self.height_of_window / 2))
        self.geometry(f'{self.width_of_window}x{self.height_of_window}+{self.x_coordinate}+{self.y_coordinate}')
        self.config(bg="light blue")

        # Frame
        self.frame = Frame(self, bg="light blue")
        self.frame.pack()

        # Welcome Message
        self.welcomeLabel = Label(self.frame, text="Welcome to Library Management System",
                                  font=("Times New Roman", 14, "bold"), pady=10, padx=20, background="green")
        self.welcomeLabel.grid(row=1, columnspan=4, pady=20)

        # Dashboard Frame
        self.dashFrame = Frame(self, bg="#46A094")
        self.dashFrame.pack(fill=X)

        # Dashboard Message
        self.dashBoard = Label(self.dashFrame, text="EDIT A OTHER MEMBER",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="yellow", foreground="black")
        self.dashBoard.pack(anchor="center", fill=X)

        # Input Fields
        self.email = StringVar()
        self.firstName = StringVar()
        self.lastName = StringVar()
        self.mobileNo = StringVar()
        self.userName = StringVar()
        self.passWord = StringVar()
        self.confirmPassword = StringVar()
        self.aadharNo = StringVar()
        self.address = StringVar()
        self.idImage = StringVar()
        self.department = StringVar()

        # Main Frame
        self.mainFrame = Frame(self, bg="#46A094")
        self.mainFrame.pack(fill=X)

        # Email ID Input and Field
        self.emailIdLabel = Label(self.mainFrame, text="Email ID :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.emailIdLabel.grid(row=0, column=1, pady=10, padx=50)

        self.emailIdInput = Entry(self.mainFrame, textvariable=self.email, font=("Cambria", 10, "bold"))
        self.emailIdInput.grid(row=0, column=2, pady=10)

        # First Name Input and Field
        self.firstNameLabel = Label(self.mainFrame, text="First Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.firstNameLabel.grid(row=0, column=3, pady=10, padx=50)

        self.firstNameInput = Entry(self.mainFrame, textvariable=self.firstName, font=("Cambria", 10, "bold"))
        self.firstNameInput.grid(row=0, column=4, pady=10)

        # Last Name Input and Field
        self.lastNameLabel = Label(self.mainFrame, text="Last Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.lastNameLabel.grid(row=0, column=5, pady=10, padx=50)

        self.lastNameInput = Entry(self.mainFrame, textvariable=self.lastName, font=("Cambria", 10, "bold"))
        self.lastNameInput.grid(row=0, column=6, pady=10)

        # Mobile No Input and Field
        self.mobileNoLabel = Label(self.mainFrame, text="Mobile No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.mobileNoLabel.grid(row=1, column=1, pady=10, padx=50)

        self.mobileNoInput = Entry(self.mainFrame, textvariable=self.mobileNo, font=("Cambria", 10, "bold"))
        self.mobileNoInput.grid(row=1, column=2, pady=10)

        # Aadhar No Input and Field
        self.aadharNoLabel = Label(self.mainFrame, text="Aadhar No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.aadharNoLabel.grid(row=1, column=3, pady=10, padx=50)

        self.aadharNoInput = Entry(self.mainFrame, textvariable=self.aadharNo, font=("Cambria", 10, "bold"))
        self.aadharNoInput.grid(row=1, column=4, pady=10)

        # Username Input and Field
        self.userNameLabel = Label(self.mainFrame, text="Username :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.userNameLabel.grid(row=1, column=5, pady=10, padx=50)

        self.userNameInput = Entry(self.mainFrame, textvariable=self.userName, font=("Cambria", 10, "bold"),
                                   state="readonly")
        self.userNameInput.grid(row=1, column=6, pady=10)

        # Password Input and Field
        self.passWordLabel = Label(self.mainFrame, text="Password :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.passWordLabel.grid(row=2, column=1, pady=10, padx=50)

        self.passWordInput = Entry(self.mainFrame, textvariable=self.passWord, font=("Cambria", 10, "bold"), show="*")
        self.passWordInput.grid(row=2, column=2, pady=10)

        # Confirm Password Input and Field
        self.confirmPasswordLabel = Label(self.mainFrame, text="Confirm Password :", font=("Cambria", 10, "bold"),
                                          bg="#46A094")
        self.confirmPasswordLabel.grid(row=2, column=3, pady=10, padx=50)

        self.confirmPasswordInput = Entry(self.mainFrame, textvariable=self.confirmPassword,
                                          font=("Cambria", 10, "bold"), show="*")
        self.confirmPasswordInput.grid(row=2, column=4, pady=10)

        # Address Input and Field
        self.addressLabel = Label(self.mainFrame, text="Address :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.addressLabel.grid(row=3, column=1, pady=10, padx=50)

        self.addressInput = Text(self.mainFrame, height=6, width=40, font=("Cambria", 10, "bold"))
        self.addressInput.grid(row=3, column=2, columnspan=3, pady=10, sticky="w")

        # Id Image Input and View Button
        self.idImageInput = Entry(self.mainFrame, textvariable=self.idImage, font=("Cambria", 10, "bold"),
                                  state="readonly")
        self.idImage.set("Select Your Image")
        self.idImageInput.grid(row=2, column=5, pady=10, padx=50)

        self.idImageButton = Button(self.mainFrame, font=("Cambria", 10, "bold"), command=self.file,
                                    text="Select Image", bg="#FDD037",
                                    foreground="black", width=10)
        self.idImageButton.grid(row=2, column=6, pady=10)

        # Image View Button
        self.imageViewButton = Button(self.mainFrame, command=self.imageView, text="View Image",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.imageViewButton.grid(row=3, column=6, pady=10)

        # Back Button
        self.backButton = Button(self.mainFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=4, column=1)

        # Edit Function Button
        self.editActionButton = Button(self.mainFrame, command=self.editOthersButtonClicked, text="EDIT OTHERS",
                                       font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.editActionButton.grid(row=4, column=4, pady=20)

        # Others Frame
        self.othersFrame = Frame(self, bg="white")
        self.othersFrame.pack(fill=X, padx=170, pady=10)

    # Edit Student Button Action
    def editOthersButtonClicked(self):
        __username = "dk"
        __firstname = "Dhineshkumar"
        __lastname = "Dhandapani"
        __mail = 'dhandapanisakthi123@gmail.com'
        __mobileno = "6374831110"
        __aadharno = "483096249638"
        __name = f'{__firstname}  {__lastname}'

        # View Details Label
        __viewDetailsLabel = Label(self.othersFrame, text="OTHER DETAIL", font=("Cambria", 20, "bold"),
                                   background="white")
        __viewDetailsLabel.grid(row=1, column=13, pady=10, columnspan=6)

        # Email ID Label
        __mailLabel = Label(self.othersFrame, text=__name, font=("Cambria", 10, "bold"), background="white",
                            foreground="blue")
        __mailLabel.grid(row=2, column=1, padx=50, pady=2, sticky="w")

        # Name Label
        __nameLabel = Label(self.othersFrame, text=__mail, font=("Cambria", 10, "bold"), background="white",
                            foreground="blue")
        __nameLabel.grid(row=3, column=1, padx=50, pady=2, sticky="w")

        # Student Image
        global myImage
        file = PIL.Image.open("background.jpg")
        resized = file.resize((250, 150))
        myImage = ImageTk.PhotoImage(resized)
        imgLabel = Label(self.othersFrame, image=myImage)
        imgLabel.grid(row=2, column=16, columnspan=6, rowspan=6, padx=290, pady=10)

        # Username Label
        __usernameLabel = Label(self.othersFrame, text=__username, font=("Cambria", 10, "bold"), background="white",
                                foreground="blue")
        __usernameLabel.grid(row=4, column=1, pady=2, sticky="w", padx=50)

        # Mobile No Label
        __mobilenoLabel = Label(self.othersFrame, text=__mobileno, font=("Cambria", 10, "bold"), background="white",
                                foreground="blue")
        __mobilenoLabel.grid(row=5, column=1, pady=2, padx=50, sticky="w")

        # Aadhar No Label
        __aadharnoLabel = Label(self.othersFrame, text=__aadharno, font=("Cambria", 10, "bold"), background="white",
                                foreground="blue")
        __aadharnoLabel.grid(row=6, column=1, pady=2, padx=50, sticky="w")

    def file(self):
        self.filename = filedialog.askopenfilename(initialdir="C:/Documents", title="Select Image", filetypes=(
            ("JPG Files", "*.jpg"), ("PNG Files", "*.png"), ("JPEG FIles", "*.jpeg"), ("All Files", "*.*")))
        self.idImage.set(str(os.path.basename(self.filename)))

    # Image View Button
    def imageView(self):
        global myImage
        file = PIL.Image.open(self.filename)
        resized = file.resize((35, 45))
        myImage = ImageTk.PhotoImage(resized)
        imgLabel = Label(self.mainFrame, image=myImage)
        imgLabel.grid(row=3, column=7)

    # Back Button Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()


# # Run the Program
if __name__ == '__main__':
    student = AddOthers()
    student.resizable(False, False)
    student.mainloop()
