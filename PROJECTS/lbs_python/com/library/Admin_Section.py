import os
import tkinter
from tkinter import *
from tkinter import filedialog
from tkinter.messagebox import showerror
import PIL
from PIL import ImageTk
import Login_Register_Page


# Admin Section
class EditAdmin(Tk):
    def __init__(self):
        super(EditAdmin, self).__init__()
        # Frame
        self.filename = None
        self.reg = None
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
        self.app1 = None
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
        self.admin = Label(self.belowTitleFrame, text="Edit Admin", fg="Blue", bg="#46A094",
                           font=("Roboto", 20, "bold"), anchor=CENTER)
        self.admin.grid(row=0, columnspan=6, padx=270, pady=20)

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

        # Back button
        self.backButton = Button(self.belowTitleFrame, text="<<Back", bg="#FDD037", font=("Roboto", 10, "bold"),
                                 fg="red", command=self.backButtonClicked, width=8,
                                 activebackground="green", activeforeground="blue")
        self.backButton.grid(row=9, column=0, pady=50)

        # Update Button Button
        self.updateButton = Button(self.belowTitleFrame, text="Edit", bg="#FDD037",
                                   font=("Roboto", 10, "bold"),
                                   fg='red', width=8, command=self.updateButtonClicked,
                                   activebackground="green", activeforeground="blue")
        self.updateButton.grid(row=9, column=3, pady=15)

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

    # Back Button Click Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()

    # Update Button Click Action
    def updateButtonClicked(self):
        if self.firstNameInput.get() == '':
            showerror(title="First Name Error", message="First Name can't be Empty.")
            self.firstNameInput.focus()

        if self.lastNameInput.get() == '':
            showerror(title="Last Name Error", message="Last Name can't be Empty.")
            self.lastNameInput.focus()

        if self.mobileInput.get() == '0':
            showerror(title="Mobile No Error", message="Mobile No can't be Empty.")
            self.mobileInput.focus()

        if self.aadharInput.get() == '0':
            showerror(title="Aadhar No Error", message="Aadhar No can't be Empty.")
            self.aadharInput.focus()

        if self.librarianIdInput.get() == '':
            showerror(title="Librarian ID Error", message="Librarian ID can't be Empty.")
            self.librarianIdInput.focus()

        if self.usernameInput.get() == '':
            showerror(title="Username Error", message="Username can't be Empty.")
            self.usernameInput.focus()

        if self.passwordInput.get() == '':
            showerror(title="Password Error", message="Password can't be Empty.")
            self.passwordInput.focus()

        if self.confirmPasswordInput.get() == '':
            showerror(title="Confirm Password Error", message="Confirm Password can't be Empty.")
            self.confirmPasswordInput.focus()

        self.destroy()
        Login_Register_Page.HomePage()


# View Admin Details Class
class ViewAdminDetails(Tk):
    def __init__(self):
        super(ViewAdminDetails, self).__init__()
        # Frame
        self.filename = None
        self.reg = None
        self.title("Library Management System")
        self.width_of_window = 700
        self.height_of_window = 620
        self.screen_width = self.winfo_screenwidth()
        self.screen_height = self.winfo_screenheight()
        self.x_coordinate = int((self.screen_width / 2) - (self.width_of_window / 2))
        self.y_coordinate = int((self.screen_height / 2) - (self.height_of_window / 2))
        self.geometry(f'{self.width_of_window}x{self.height_of_window}+{self.x_coordinate}+{self.y_coordinate}')
        self.configure(bg="light blue")

        # Title frame
        self.frame = Frame(self, bg="#78A6C8")
        self.frame.pack(side=TOP, fill=X)
        self.label = Label(self.frame, text="Library Management System", fg="#41436A",
                           font=("Cambria", 15, "bold", "underline"))
        self.label.grid(row=0, columnspan=6, padx=220, pady=20)

        # Below Title Frame
        self.belowTitleFrame = Frame(self, bg="#46A094")
        self.belowTitleFrame.pack(anchor=CENTER, fill=X)
        self.admin = Label(self.belowTitleFrame, text="Admin Profile", fg="Blue", bg="#46A094",
                           font=("Roboto", 20, "bold"), anchor=CENTER)
        self.admin.grid(row=0, columnspan=6, padx=270, pady=20)

        # Student Frame
        self.studentFrame = Frame(self, bg="white")
        self.studentFrame.pack(fill=X, padx=30, pady=30)

        __username = "dk"
        __librarianID = "613520104008"
        __firstname = "Dhineshkumar"
        __lastname = "Dhandapani"
        __mail = "dhandapanisakthi123@gmail.com"
        __department = "CSE"
        __mobileno = "6374831110"
        __aadharno = "483096249638"
        __name = f'{__firstname}  {__lastname}'

        # Name Label
        __nameLabel = Label(self.studentFrame, text=__name, font=("Cambria", 12, "bold"), background="white",
                            foreground="blue")
        __nameLabel.grid(row=2, column=1, padx=50, pady=10, sticky="w")

        # Email ID Label
        __mailLabel = Label(self.studentFrame, text=__mail, font=("Cambria", 12, "bold"), background="white",
                            foreground="blue")
        __mailLabel.grid(row=3, column=1, padx=50, pady=10, sticky="w")

        # Register No Label
        __librarianIDLabel = Label(self.studentFrame, text=__librarianID, font=("Cambria", 12, "bold"),
                                   background="white", foreground="blue")
        __librarianIDLabel.grid(row=4, column=1, pady=10, padx=50, sticky="w")

        # Student Image
        global myImage
        file = PIL.Image.open("background.jpg")
        resized = file.resize((150, 270))
        myImage = ImageTk.PhotoImage(resized)
        imgLabel = Label(self.studentFrame, image=myImage)
        imgLabel.grid(row=3, column=4, columnspan=5, rowspan=6, padx=60)

        # Username Label
        __usernameLabel = Label(self.studentFrame, text=__username, font=("Cambria", 12, "bold"), background="white",
                                foreground="blue")
        __usernameLabel.grid(row=5, column=1, pady=10, sticky="w", padx=50)

        # Mobile No Label
        __mobilenoLabel = Label(self.studentFrame, text=__mobileno, font=("Cambria", 12, "bold"), background="white",
                                foreground="blue")
        __mobilenoLabel.grid(row=6, column=1, pady=10, padx=50, sticky="w")

        # Aadhar No Label
        __aadharnoLabel = Label(self.studentFrame, text=__aadharno, font=("Cambria", 12, "bold"), background="white",
                                foreground="blue")
        __aadharnoLabel.grid(row=7, column=1, pady=10, padx=50, sticky="w")

        # Department Label
        __departmentLabel = Label(self.studentFrame, text=__department, font=("Cambria", 12, "bold"),
                                  background="white", foreground="blue")
        __departmentLabel.grid(row=8, column=1, pady=10, padx=50, sticky="w")

        # Back Button
        self.backButton = Button(self.studentFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=9, column=1, pady=10)

# Back Button Clicked Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()


# Run the Program
if __name__ == "__main__":
    admin = ViewAdminDetails()
    admin.resizable(False, False)
    admin.mainloop()
