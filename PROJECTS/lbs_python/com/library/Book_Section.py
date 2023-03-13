import os
from tkinter import *
import tkinter
from tkinter import filedialog, ttk
from tkinter.font import Font
from fpdf import FPDF

import PIL
import messagebox
from PIL import ImageTk
import Login_Register_Page


# ADD BOOK CLASS
class AddBook(Tk):
    def __init__(self):
        super(AddBook, self).__init__()

        self.imgLabel = None
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
        self.dashBoard = Label(self.dashFrame, text="ADD A BOOK",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="yellow", foreground="black")
        self.dashBoard.pack(anchor="center", fill=X)

        # Input Fields
        self.email = StringVar()
        self.bookTitle = StringVar()
        self.authorName = StringVar()
        self.phoneNo = StringVar()
        self.edition = StringVar()
        self.publisher = StringVar()
        self.publishedYear = StringVar()
        self.isbnNo = StringVar()
        self.address = StringVar()
        self.website = StringVar()
        self.bookImage = StringVar()

        # Main Frame
        self.mainFrame = Frame(self, bg="#46A094")
        self.mainFrame.pack(fill=X)

        # Email ID Input and Field
        self.emailIdLabel = Label(self.mainFrame, text="Email ID :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.emailIdLabel.grid(row=0, column=1, pady=10, padx=50)

        self.emailIdInput = Entry(self.mainFrame, textvariable=self.email, font=("Cambria", 10, "bold"))
        self.emailIdInput.grid(row=0, column=2, pady=10)

        # Book Title Input and Field
        self.bookTitleLabel = Label(self.mainFrame, text="Book Title :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.bookTitleLabel.grid(row=0, column=3, pady=10, padx=50)

        self.bookTitleInput = Entry(self.mainFrame, textvariable=self.bookTitle, font=("Cambria", 10, "bold"))
        self.bookTitleInput.grid(row=0, column=4, pady=10)

        # Author Name Input and Field
        self.authorNameLabel = Label(self.mainFrame, text="Author Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.authorNameLabel.grid(row=0, column=5, pady=10, padx=50)

        self.authorNameInput = Entry(self.mainFrame, textvariable=self.authorName, font=("Cambria", 10, "bold"))
        self.authorNameInput.grid(row=0, column=6, pady=10)

        # Phone No Input and Field
        self.phoneNoLable = Label(self.mainFrame, text="Phone No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.phoneNoLable.grid(row=1, column=1, pady=10, padx=50)

        self.phoneNoInput = Entry(self.mainFrame, textvariable=self.phoneNo, font=("Cambria", 10, "bold"))
        self.phoneNoInput.grid(row=1, column=2, pady=10)

        # Edition No Input and Field
        self.editionLabel = Label(self.mainFrame, text="Edition No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.editionLabel.grid(row=1, column=3, pady=10, padx=50)

        self.editionInput = Entry(self.mainFrame, textvariable=self.edition, font=("Cambria", 10, "bold"))
        self.editionInput.grid(row=1, column=4, pady=10)

        # Publisher Input and Field
        self.publisherLabel = Label(self.mainFrame, text="Publisher Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.publisherLabel.grid(row=1, column=5, pady=10, padx=50)

        self.publisherInput = Entry(self.mainFrame, textvariable=self.publisher, font=("Cambria", 10, "bold"))
        self.publisherInput.grid(row=1, column=6, pady=10)

        # Published Year Input and Field
        self.publishedYearLabel = Label(self.mainFrame, text="Published Year :", font=("Cambria", 10, "bold"),
                                        bg="#46A094")
        self.publishedYearLabel.grid(row=2, column=1, pady=10, padx=50)

        self.publishedYearInput = Entry(self.mainFrame, textvariable=self.publishedYear, font=("Cambria", 10, "bold"))
        self.publishedYearInput.grid(row=2, column=2, pady=10)

        # ISBN No Input and Field
        self.isbnNoLabel = Label(self.mainFrame, text="ISBN No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.isbnNoLabel.grid(row=2, column=3, pady=10, padx=50)

        self.isbnNoInput = Entry(self.mainFrame, textvariable=self.isbnNo, font=("Cambria", 10, "bold"))
        self.isbnNoInput.grid(row=2, column=4, pady=10)

        # Website Input and Field
        self.websiteLabel = Label(self.mainFrame, text="Website :", font=("Cambria", 10, "bold"),
                                  bg="#46A094")
        self.websiteLabel.grid(row=2, column=5, pady=10, padx=50)

        self.websiteInput = Entry(self.mainFrame, textvariable=self.website,
                                  font=("Cambria", 10, "bold"))
        self.websiteInput.grid(row=2, column=6, pady=10)

        # Address Input and Field
        self.addressLabel = Label(self.mainFrame, text="Address :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.addressLabel.grid(row=3, column=1, pady=10, padx=50)

        self.addressInput = Text(self.mainFrame, height=6, width=40, font=("Cambria", 10, "bold"))
        self.addressInput.grid(row=3, column=2, columnspan=3, pady=10, sticky="w")

        # Book Image Input and View Button
        self.bookImageInput = Entry(self.mainFrame, textvariable=self.bookImage, font=("Cambria", 10, "bold"),
                                    state="readonly")
        self.bookImage.set("Select Book Image")
        self.bookImageInput.grid(row=3, column=4, pady=10, padx=50)

        self.bookImageButton = Button(self.mainFrame, font=("Cambria", 10, "bold"), command=self.file,
                                      text="Select Image", bg="#FDD037",
                                      foreground="black", width=10)
        self.bookImageButton.grid(row=3, column=5, pady=10)

        # Add Function Button
        self.addActionButton = Button(self.mainFrame, command=self.addStudentButtonClicked, text="ADD BOOK",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.addActionButton.grid(row=5, column=4, pady=20)

        # Image View Button
        self.imageViewButton = Button(self.mainFrame, command=self.imageView, text="View Image",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.imageViewButton.grid(row=3, column=6, pady=10)

        # Back Button
        self.backButton = Button(self.mainFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=5, column=1)

        # Tree Frame.
        self.treeFrame = Frame(self)
        self.treeFrame.pack(pady=40)
        self.style = ttk.Style()
        self.style.configure("mystyle.Treeview", font=("Cambria", 8, "bold"), anchor=CENTER)
        self.style.configure("mystyle.Treeview.Heading", font=("Cambria", 10, "bold"), anchor=CENTER)

        self.tree = ttk.Treeview(self.treeFrame, columns=("1", "2", "3", "4", "5", "6", "7", "8"),
                                 style="mystyle.Treeview")
        self.tree.heading("1", text="Book Title")
        self.tree.column("1", width=200)
        self.tree.heading("2", text="Author")
        self.tree.heading("3", text="Publisher")
        self.tree.heading("4", text="Website")
        self.tree.column("4", width=200)
        self.tree.heading("5", text="Published Year")
        self.tree.column("5", width=50)
        self.tree.heading("6", text="ISBN No")
        self.tree.heading("7", text="Edition")
        self.tree.column("7", width=130)
        self.tree.heading("8", text="Phone No")
        self.tree.column("8", width=80)
        self.tree['show'] = 'headings'
        self.xScrollBar = Scrollbar(self.treeFrame, orient=VERTICAL, command=self.tree.yview)
        self.xScrollBar.pack(side=RIGHT, fill=Y)
        self.tree.configure(yscrollcommand=self.xScrollBar.set)
        self.tree.pack(fill=X)

    def file(self):
        self.filename = filedialog.askopenfilename(initialdir="C:/Documents", title="Select Image", filetypes=(
            ("JPG Files", "*.jpg"), ("PNG Files", "*.png"), ("JPEG FIles", "*.jpeg"), ("All Files", "*.*")))
        self.bookImage.set(str(os.path.basename(self.filename)))

    # Image View Button
    def imageView(self):
        global myImage
        file = PIL.Image.open(self.filename)
        resized = file.resize((35, 45))
        myImage = ImageTk.PhotoImage(resized)
        self.imgLabel = Label(self.mainFrame, image=myImage)
        self.imgLabel.grid(row=4, column=6)

    # Clear Function
    def clearAction(self):
        global myImage
        self.email.set("")
        self.bookTitle.set("")
        self.authorName.set("")
        self.phoneNo.set("")
        self.edition.set("")
        self.publisher.set("")
        self.publishedYear.set("")
        self.isbnNo.set("")
        self.bookImage.set("")
        self.website.set("")
        self.addressInput.delete(1.0, END)

    # Back Button Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()

    # Add Student Button Action
    def addStudentButtonClicked(self):
        __bookTitle = self.bookTitleInput.get()
        __authorName = self.authorNameInput.get()
        __edition = self.editionInput.get()
        __publisher = self.publisherInput.get()
        __publishedYear = self.publishedYearInput.get()
        __isbnNo = self.isbnNoInput.get()
        __website = self.websiteInput.get()
        __phoneNo = self.phoneNoInput.get()
        self.tree.insert("", index="end",
                         values=(
                             __bookTitle, __authorName, __publisher, __website, __publishedYear, __isbnNo, __edition,
                             __phoneNo))
        self.clearAction()


# DELETE BOOK CLASS
class DeleteBook(Tk):
    def __init__(self):
        super(DeleteBook, self).__init__()

        self.imgLabel = None
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
        self.dashBoard = Label(self.dashFrame, text="DELETE A BOOK",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="yellow", foreground="black")
        self.dashBoard.pack(anchor="center", fill=X)

        # Input Fields
        self.email = StringVar()
        self.bookTitle = StringVar()
        self.authorName = StringVar()
        self.phoneNo = StringVar()
        self.edition = StringVar()
        self.publisher = StringVar()
        self.publishedYear = StringVar()
        self.isbnNo = StringVar()
        self.address = StringVar()
        self.website = StringVar()
        self.bookImage = StringVar()

        # Main Frame
        self.mainFrame = Frame(self, bg="#46A094")
        self.mainFrame.pack(fill=X)

        # Email ID Input and Field
        self.emailIdLabel = Label(self.mainFrame, text="Email ID :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.emailIdLabel.grid(row=0, column=1, pady=10, padx=50)

        self.emailIdInput = Entry(self.mainFrame, textvariable=self.email, font=("Cambria", 10, "bold"))
        self.emailIdInput.grid(row=0, column=2, pady=10)

        # Book Title Input and Field
        self.bookTitleLabel = Label(self.mainFrame, text="Book Title :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.bookTitleLabel.grid(row=0, column=3, pady=10, padx=50)

        self.bookTitleInput = Entry(self.mainFrame, textvariable=self.bookTitle, font=("Cambria", 10, "bold"))
        self.bookTitleInput.grid(row=0, column=4, pady=10)

        # Author Name Input and Field
        self.authorNameLabel = Label(self.mainFrame, text="Author Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.authorNameLabel.grid(row=0, column=5, pady=10, padx=50)

        self.authorNameInput = Entry(self.mainFrame, textvariable=self.authorName, font=("Cambria", 10, "bold"))
        self.authorNameInput.grid(row=0, column=6, pady=10)

        # Phone No Input and Field
        self.phoneNoLable = Label(self.mainFrame, text="Phone No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.phoneNoLable.grid(row=1, column=1, pady=10, padx=50)

        self.phoneNoInput = Entry(self.mainFrame, textvariable=self.phoneNo, font=("Cambria", 10, "bold"))
        self.phoneNoInput.grid(row=1, column=2, pady=10)

        # Edition No Input and Field
        self.editionLabel = Label(self.mainFrame, text="Edition No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.editionLabel.grid(row=1, column=3, pady=10, padx=50)

        self.editionInput = Entry(self.mainFrame, textvariable=self.edition, font=("Cambria", 10, "bold"))
        self.editionInput.grid(row=1, column=4, pady=10)

        # Publisher Input and Field
        self.publisherLabel = Label(self.mainFrame, text="Publisher Name :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.publisherLabel.grid(row=1, column=5, pady=10, padx=50)

        self.publisherInput = Entry(self.mainFrame, textvariable=self.publisher, font=("Cambria", 10, "bold"))
        self.publisherInput.grid(row=1, column=6, pady=10)

        # Published Year Input and Field
        self.publishedYearLabel = Label(self.mainFrame, text="Published Year :", font=("Cambria", 10, "bold"),
                                        bg="#46A094")
        self.publishedYearLabel.grid(row=2, column=1, pady=10, padx=50)

        self.publishedYearInput = Entry(self.mainFrame, textvariable=self.publishedYear, font=("Cambria", 10, "bold"))
        self.publishedYearInput.grid(row=2, column=2, pady=10)

        # ISBN No Input and Field
        self.isbnNoLabel = Label(self.mainFrame, text="ISBN No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.isbnNoLabel.grid(row=2, column=3, pady=10, padx=50)

        self.isbnNoInput = Entry(self.mainFrame, textvariable=self.isbnNo, font=("Cambria", 10, "bold"))
        self.isbnNoInput.grid(row=2, column=4, pady=10)

        # Website Input and Field
        self.websiteLabel = Label(self.mainFrame, text="Website :", font=("Cambria", 10, "bold"),
                                  bg="#46A094")
        self.websiteLabel.grid(row=2, column=5, pady=10, padx=50)

        self.websiteInput = Entry(self.mainFrame, textvariable=self.website,
                                  font=("Cambria", 10, "bold"))
        self.websiteInput.grid(row=2, column=6, pady=10)

        # Address Input and Field
        self.addressLabel = Label(self.mainFrame, text="Address :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.addressLabel.grid(row=3, column=1, pady=10, padx=50)

        self.addressInput = Text(self.mainFrame, height=6, width=40, font=("Cambria", 10, "bold"))
        self.addressInput.grid(row=3, column=2, columnspan=3, pady=10, sticky="w")

        # Book Image Input and View Button
        self.bookImageInput = Entry(self.mainFrame, textvariable=self.bookImage, font=("Cambria", 10, "bold"),
                                    state="readonly")
        self.bookImage.set("Select Book Image")
        self.bookImageInput.grid(row=3, column=4, pady=10, padx=50)

        # Add Function Button
        self.addActionButton = Button(self.mainFrame, command=self.deleteBookButtonClicked, text="DELETE BOOK",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.addActionButton.grid(row=5, column=4, pady=20)

        # Image View Button
        self.imageViewButton = Button(self.mainFrame, command=self.imageView, text="View Image",
                                      font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.imageViewButton.grid(row=3, column=6, pady=10)

        # Back Button
        self.backButton = Button(self.mainFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=5, column=1)

        # Display Function Button
        self.displayActionButton = Button(self.mainFrame, command=self.displayActionButtonClicked, text="DISPLAY",
                                          font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.displayActionButton.grid(row=5, column=5, pady=20)

        # Tree Frame.
        self.treeFrame = Frame(self)
        self.treeFrame.pack(pady=40)
        self.style = ttk.Style()
        self.style.configure("mystyle.Treeview", font=("Cambria", 8, "bold"), anchor=CENTER)
        self.style.configure("mystyle.Treeview.Heading", font=("Cambria", 10, "bold"), anchor=CENTER)

        self.tree = ttk.Treeview(self.treeFrame, columns=("1", "2", "3", "4", "5", "6", "7", "8"),
                                 style="mystyle.Treeview")
        self.tree.heading("1", text="Book Title")
        self.tree.column("1", width=200)
        self.tree.heading("2", text="Author")
        self.tree.heading("3", text="Publisher")
        self.tree.heading("4", text="Website")
        self.tree.column("4", width=200)
        self.tree.heading("5", text="Published Year")
        self.tree.column("5", width=50)
        self.tree.heading("6", text="ISBN No")
        self.tree.heading("7", text="Edition")
        self.tree.column("7", width=130)
        self.tree.heading("8", text="Phone No")
        self.tree.column("8", width=80)
        self.tree['show'] = 'headings'
        self.tree.insert("", index="end",
                         values=("6122374", "dsfgdg", "gdsfds", "sdgfsdg", "fbsdfg", "bdsfdsgf", "fgsdg", "CSE"))
        self.xScrollBar = Scrollbar(self.treeFrame, orient=VERTICAL, command=self.tree.yview)
        self.xScrollBar.pack(side=RIGHT, fill=Y)
        self.tree.configure(yscrollcommand=self.xScrollBar.set)
        self.tree.pack(fill=X)

    def file(self):
        self.filename = filedialog.askopenfilename(initialdir="C:/Documents", title="Select Image", filetypes=(
            ("JPG Files", "*.jpg"), ("PNG Files", "*.png"), ("JPEG FIles", "*.jpeg"), ("All Files", "*.*")))
        self.bookImage.set(str(os.path.basename(self.filename)))

    # Image View Button
    def imageView(self):
        global myImage
        file = PIL.Image.open(self.filename)
        resized = file.resize((35, 45))
        myImage = ImageTk.PhotoImage(resized)
        self.imgLabel = Label(self.mainFrame, image=myImage)
        self.imgLabel.grid(row=4, column=6)

    # Clear Function
    def clearAction(self):
        global myImage
        self.email.set("")
        self.bookTitle.set("")
        self.authorName.set("")
        self.phoneNo.set("")
        self.edition.set("")
        self.publisher.set("")
        self.publishedYear.set("")
        self.isbnNo.set("")
        self.bookImage.set("")
        self.website.set("")
        self.addressInput.delete(1.0, END)

    # Back Button Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()

    # Add Student Button Action
    def deleteBookButtonClicked(self):
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
        __bookTitle = self.bookTitleInput.get()
        __authorName = self.authorNameInput.get()
        __edition = self.editionInput.get()
        __publisher = self.publisherInput.get()
        __publishedYear = self.publishedYearInput.get()
        __isbnNo = self.isbnNoInput.get()
        __website = self.websiteInput.get()
        __phoneNo = self.phoneNoInput.get()
        self.tree.insert("", index="end",
                         values=(
                             __bookTitle, __authorName, __publisher, __website, __publishedYear, __isbnNo, __edition,
                             __phoneNo))
        self.clearAction()


# SEARCH A BOOK
class SearchBook(Tk):
    def __init__(self):
        super(SearchBook, self).__init__()

        self.bookFrame = None
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
        self.welcomeLabel.grid(row=1, columnspan=4, pady=10)

        # Dashboard Frame
        self.dashFrame = Frame(self, bg="#46A094")
        self.dashFrame.pack(fill=X)

        # Dashboard Message
        self.dashBoard = Label(self.dashFrame, text="SEARCH A BOOK",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="yellow", foreground="black")
        self.dashBoard.pack(fill=X, anchor=CENTER)

        # Input Fields and Labels
        self.bookTitle = StringVar()
        self.isbnNo = StringVar()

        # Main Frame
        self.mainFrame = Frame(self, bg="#46A094")
        self.mainFrame.pack(fill=Y, anchor=CENTER, pady=20)

        # Register No Input and Field
        self.bookTitleLabel = Label(self.mainFrame, text="Book Title :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.bookTitleLabel.grid(row=1, column=7, pady=30, padx=20)

        self.bookTitleInput = Entry(self.mainFrame, textvariable=self.bookTitle, font=("Cambria", 10, "bold"))
        self.bookTitleInput.grid(row=1, column=8, pady=30)

        # ISBN No Input and Field
        self.isbnNoLabel = Label(self.mainFrame, text="ISBN No :", font=("Cambria", 10, "bold"), bg="#46A094")
        self.isbnNoLabel.grid(row=1, column=12, pady=10, padx=20)

        self.isbnNoInput = Entry(self.mainFrame, textvariable=self.isbnNo, font=("Cambria", 10, "bold"))
        self.isbnNoInput.grid(row=1, column=13, pady=10)

        # Back Button
        self.backButton = Button(self.mainFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=2, column=8, pady=10)

        # Search Button
        self.searchButton = Button(self.mainFrame, command=self.searchButtonClicked, text="Search",
                                   font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.searchButton.grid(row=2, column=11, pady=10, padx=140, columnspan=8)

        # Book Frame
        self.bookFrame = Frame(self, bg="white")
        self.bookFrame.pack(fill=X, padx=30)

    # Back Button Clicked Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()

    # Search Button Clicked Action
    def searchButtonClicked(self):
        __isbnNo = "12345678"
        __bookTitle = "DATA COMMUNICATIONS AND NETWORKING"
        __mail = "dhandapanisakthi123@gmail.com"
        __authorName = "Dhineshkumar"
        __publisher = "Dhandapani"
        __publishedYear = "2013"
        __phoneno = "6374831110"
        __ebsite = "alonevibes.web.app"

        # View Details Label
        __viewDetailsLabel = Label(self.bookFrame, text="BOOK DETAIL", font=("Cambria", 15, "bold"),
                                   background="white")
        __viewDetailsLabel.grid(row=1, column=6, pady=20, columnspan=6)

        # Book Title Label
        __bookTitleLabel = Label(self.bookFrame, text=__bookTitle, font=("Cambria", 15, "bold"), background="white",
                                 foreground="blue")
        __bookTitleLabel.grid(row=2, column=1, padx=50, pady=10, sticky="w")

        # ISBN No ID Label
        __isbnNoLabel = Label(self.bookFrame, text=__isbnNo, font=("Cambria", 15, "bold"), background="white",
                              foreground="blue")
        __isbnNoLabel.grid(row=3, column=1, padx=50, pady=10, sticky="w")

        # Email ID Label
        __mailLabel = Label(self.bookFrame, text=__mail, font=("Cambria", 15, "bold"),
                            background="white", foreground="blue")
        __mailLabel.grid(row=4, column=1, pady=10, padx=50, sticky="w")

        # Book Image
        global myImage
        file = PIL.Image.open("background.jpg")
        resized = file.resize((500, 300))
        myImage = ImageTk.PhotoImage(resized)
        imgLabel = Label(self.bookFrame, image=myImage)
        imgLabel.grid(row=2, column=10, columnspan=6, rowspan=7, padx=230)

        # isbnNo Label
        __authorNameLabel = Label(self.bookFrame, text=__authorName, font=("Cambria", 15, "bold"), background="white",
                                  foreground="blue")
        __authorNameLabel.grid(row=5, column=1, pady=10, sticky="w", padx=50)

        # Phone No Label
        __phonenoLabel = Label(self.bookFrame, text=__phoneno, font=("Cambria", 15, "bold"), background="white",
                               foreground="blue")
        __phonenoLabel.grid(row=6, column=1, pady=10, padx=50, sticky="w")

        # Publisher Label
        __publisherLabel = Label(self.bookFrame, text=__publisher, font=("Cambria", 15, "bold"), background="white",
                                 foreground="blue")
        __publisherLabel.grid(row=7, column=1, pady=10, padx=50, sticky="w")

        # Department Label
        __publishedYearLabel = Label(self.bookFrame, text=__publishedYear, font=("Cambria", 15, "bold"),
                                     background="white", foreground="blue")
        __publishedYearLabel.grid(row=8, column=1, pady=10, padx=50, sticky="w")


# RESERVE A BOOK
class ReserveBook(Tk):
    def __init__(self):
        super(ReserveBook, self).__init__()

        self.addressInput = None
        self.tree = None
        self.style = None
        self.treeFrame = None
        self.imgLabel = None
        self.xScrollBar = None
        self.bookFrame = None
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
        self.welcomeLabel.grid(row=1, columnspan=4, pady=10)

        # Dashboard Frame
        self.dashFrame = Frame(self, bg="#46A094")
        self.dashFrame.pack(fill=X)

        # Dashboard Message
        self.dashBoard = Label(self.dashFrame, text="RESERVE A BOOK",
                               font=("Times New Roman", 25, "bold"), pady=10, padx=20, bg="yellow", foreground="black")
        self.dashBoard.pack(fill=X, anchor=CENTER)

        # Main Frame
        self.mainFrame = Frame(self, bg="light blue")
        self.mainFrame.pack(fill=Y, anchor=CENTER, pady=20)

        # Input Fields
        self.selection = IntVar()
        self.registerno = StringVar()
        self.password = StringVar()
        self.staffno = StringVar()
        self.aadharno = StringVar()

        # Input Fields
        self.email = StringVar()
        self.bookTitle = StringVar()
        self.authorName = StringVar()
        self.phoneNo = StringVar()
        self.edition = StringVar()
        self.publisher = StringVar()
        self.publishedYear = StringVar()
        self.isbnNo = StringVar()
        self.address = StringVar()
        self.website = StringVar()
        self.bookImage = StringVar()

        # Radio Button Fields
        self.studentRadioButton = Radiobutton(self.mainFrame, command=self.sel, text="Student",
                                              variable=self.selection, value=1, state=NORMAL,
                                              font=("Cambria", 15, "bold"), background="light blue", cursor="hand2")
        self.studentRadioButton.select()
        self.studentRadioButton.grid(row=1, column=2, padx=140)

        self.staffRadioButton = Radiobutton(self.mainFrame, command=self.sel, text="Staff",
                                            variable=self.selection, value=2, font=("Cambria", 15, "bold"),
                                            background="light blue", cursor="hand2")
        self.staffRadioButton.grid(row=1, column=4)

        self.othersRadioButton = Radiobutton(self.mainFrame, command=self.sel, text="Others",
                                             variable=self.selection, value=3, font=("Cambria", 15, "bold"),
                                             background="light blue", cursor="hand2")
        self.othersRadioButton.grid(row=1, column=6, padx=140)

        # Common Frame
        self.commonFrame = Frame(self, background="light blue")
        self.commonFrame.pack(anchor=CENTER)

        # Reserve Button
        self.searchButton = Button(self.mainFrame, command=self.searchButtonClicked, text="Search",
                                   font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.searchButton.grid(row=2, column=4, pady=30, padx=140)

        # Book Frame
        self.bookFrame = Frame(self, bg="light blue")
        self.bookFrame.pack(fill=X, padx=30)

    # Get Value Button Action
    def sel(self):
        if self.selection.get() == 1:
            self.studentRadioButtonClicked()
        elif self.selection.get() == 2:
            self.staffRadioButtonClicked()
        elif self.selection.get() == 3:
            self.othersRadioButtonClicked()

    # Back Button Clicked Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()

        # Search Button Clicked Action

    def searchButtonClicked(self):
        # Email ID Input and Field
        self.emailIdLabel = Label(self.bookFrame, text="Email ID :", font=("Cambria", 10, "bold"), bg="light blue")
        self.emailIdLabel.grid(row=0, column=1, pady=10, padx=50)

        self.emailIdInput = Entry(self.bookFrame, textvariable=self.email, font=("Cambria", 10, "bold"))
        self.emailIdInput.grid(row=0, column=2, pady=10)

        # Book Title Input and Field
        self.bookTitleLabel = Label(self.bookFrame, text="Book Title :", font=("Cambria", 10, "bold"), bg="light blue")
        self.bookTitleLabel.grid(row=0, column=3, pady=10, padx=50)

        self.bookTitleInput = Entry(self.bookFrame, textvariable=self.bookTitle, font=("Cambria", 10, "bold"))
        self.bookTitleInput.grid(row=0, column=4, pady=10)

        # Author Name Input and Field
        self.authorNameLabel = Label(self.bookFrame, text="Author Name :", font=("Cambria", 10, "bold"),
                                     bg="light blue")
        self.authorNameLabel.grid(row=0, column=5, pady=10, padx=50)

        self.authorNameInput = Entry(self.bookFrame, textvariable=self.authorName, font=("Cambria", 10, "bold"))
        self.authorNameInput.grid(row=0, column=6, pady=10)

        # Phone No Input and Field
        self.phoneNoLable = Label(self.bookFrame, text="Phone No :", font=("Cambria", 10, "bold"), bg="light blue")
        self.phoneNoLable.grid(row=1, column=1, pady=10, padx=50)

        self.phoneNoInput = Entry(self.bookFrame, textvariable=self.phoneNo, font=("Cambria", 10, "bold"))
        self.phoneNoInput.grid(row=1, column=2, pady=10)

        # Edition No Input and Field
        self.editionLabel = Label(self.bookFrame, text="Edition No :", font=("Cambria", 10, "bold"), bg="light blue")
        self.editionLabel.grid(row=1, column=3, pady=10, padx=50)

        self.editionInput = Entry(self.bookFrame, textvariable=self.edition, font=("Cambria", 10, "bold"))
        self.editionInput.grid(row=1, column=4, pady=10)

        # Publisher Input and Field
        self.publisherLabel = Label(self.bookFrame, text="Publisher Name :", font=("Cambria", 10, "bold"),
                                    bg="light blue")
        self.publisherLabel.grid(row=1, column=5, pady=10, padx=50)

        self.publisherInput = Entry(self.bookFrame, textvariable=self.publisher, font=("Cambria", 10, "bold"))
        self.publisherInput.grid(row=1, column=6, pady=10)

        # Published Year Input and Field
        self.publishedYearLabel = Label(self.bookFrame, text="Published Year :", font=("Cambria", 10, "bold"),
                                        bg="light blue")
        self.publishedYearLabel.grid(row=2, column=1, pady=10, padx=50)

        self.publishedYearInput = Entry(self.bookFrame, textvariable=self.publishedYear, font=("Cambria", 10, "bold"))
        self.publishedYearInput.grid(row=2, column=2, pady=10)

        # ISBN No Input and Field
        self.isbnNoLabel = Label(self.bookFrame, text="ISBN No :", font=("Cambria", 10, "bold"), bg="light blue")
        self.isbnNoLabel.grid(row=2, column=3, pady=10, padx=50)

        self.isbnNoInput = Entry(self.bookFrame, textvariable=self.isbnNo, font=("Cambria", 10, "bold"))
        self.isbnNoInput.grid(row=2, column=4, pady=10)

        # Website Input and Field
        self.websiteLabel = Label(self.bookFrame, text="Website :", font=("Cambria", 10, "bold"),
                                  bg="light blue")
        self.websiteLabel.grid(row=2, column=5, pady=10, padx=50)

        self.websiteInput = Entry(self.bookFrame, textvariable=self.website,
                                  font=("Cambria", 10, "bold"))
        self.websiteInput.grid(row=2, column=6, pady=10)

        # Address Input and Field
        self.addressLabel = Label(self.bookFrame, text="Address :", font=("Cambria", 10, "bold"), bg="light blue")
        self.addressLabel.grid(row=3, column=1, pady=10, padx=50)

        self.addressInput = Text(self.bookFrame, height=6, width=40, font=("Cambria", 10, "bold"))
        self.addressInput.grid(row=3, column=2, columnspan=3, pady=10, sticky="w")

        # Book Image Input and View Button
        self.bookImageInput = Entry(self.bookFrame, textvariable=self.bookImage, font=("Cambria", 10, "bold"),
                                    state="readonly")
        self.bookImageInput.grid(row=3, column=4, pady=10, padx=50)

        # Reserve Book Function Button
        self.reserveActionButton = Button(self.bookFrame, command=self.reserveBookButtonClicked, text="RESERVE BOOK",
                                          font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=15)
        self.reserveActionButton.grid(row=5, column=4, pady=20)

        # Display Function Button
        self.displayActionButton = Button(self.bookFrame, command=self.displayImageButtonClicked, text="DISPLAY IMAGE",
                                          font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=15)
        self.displayActionButton.grid(row=5, column=5, pady=20)

        # Back Button
        self.backButton = Button(self.bookFrame, command=self.backButtonClicked, text="<<Back",
                                 font=("Calibri", 10, "bold"), bg="#FDD037", foreground="black", width=10)
        self.backButton.grid(row=5, column=1)

    def file(self):
        self.filename = filedialog.askopenfilename(initialdir="C:/Documents", title="Select Image", filetypes=(
            ("JPG Files", "*.jpg"), ("PNG Files", "*.png"), ("JPEG FIles", "*.jpeg"), ("All Files", "*.*")))
        self.bookImage.set(str(os.path.basename(self.filename)))

    # Image View Button
    def imageView(self):
        global myImage
        self.fileName = 'background.jpg'
        file = PIL.Image.open('background.jpg')
        resized = file.resize((35, 45))
        myImage = ImageTk.PhotoImage(resized)
        self.bookImage.set(self.fileName)
        self.imgLabel = Label(self.bookFrame, image=myImage)
        self.imgLabel.grid(row=3, column=5)

    # Clear Function
    def clearAction(self):
        self.email.set("")
        self.bookTitle.set("")
        self.authorName.set("")
        self.phoneNo.set("")
        self.edition.set("")
        self.publisher.set("")
        self.publishedYear.set("")
        self.isbnNo.set("")
        self.bookImage.set("")
        self.website.set("")
        self.addressInput.delete(1.0, END)

    # Back Button Action
    def backButtonClicked(self):
        self.destroy()
        Login_Register_Page.HomePage()

    # Reserve Book Button Action
    def reserveBookButtonClicked(self):
        pass
        self.clearAction()

    # Student Radio Button Clicked Action
    def studentRadioButtonClicked(self):
        # Student Frame Details
        __frameNameLabel = Label(self.commonFrame, text="STUDENT", font=("Cambria", 10, "bold"),
                                 background="light blue", width=15)
        __frameNameLabel.grid(row=1, column=10, padx=20, pady=10)

        # Register No Input and Field
        __registernoLabel = Label(self.commonFrame, text="Register No : ", font=("Cambria", 10, "bold"),
                                  background="light blue", width=15)
        __registernoLabel.grid(row=2, column=7, pady=30, padx=20)

        __registernoInput = Entry(self.commonFrame, textvariable=self.registerno, font=("Cambria", 10, "bold"))
        __registernoInput.grid(row=2, column=8, pady=30)

        # Password Input and Field
        __passwordLabel = Label(self.commonFrame, text="Password : ", font=("Cambria", 10, "bold"),
                                background="light blue", width=15)
        __passwordLabel.grid(row=2, column=12, pady=10, padx=20)

        __passwordInput = Entry(self.commonFrame, textvariable=self.password, font=("Cambria", 10, "bold"))
        __passwordInput.grid(row=2, column=13, pady=10)

    # Staff Radio Button Clicked Action
    def staffRadioButtonClicked(self):
        # Staff Frame Details
        __frameNameLabel = Label(self.commonFrame, text="STAFFS", font=("Cambria", 10, "bold"), background="light blue",
                                 width=15)
        __frameNameLabel.grid(row=1, column=10, padx=20, pady=10)

        # Register No Input and Field
        __staffnoLabel = Label(self.commonFrame, text="Staff No : ", font=("Cambria", 10, "bold"),
                               background="light blue", width=15)
        __staffnoLabel.grid(row=2, column=7, pady=30, padx=20)

        __staffnoInput = Entry(self.commonFrame, textvariable=self.staffno, font=("Cambria", 10, "bold"))
        __staffnoInput.grid(row=2, column=8, pady=30)

        # Password Input and Field
        __passwordLabel = Label(self.commonFrame, text="Password : ", font=("Cambria", 10, "bold"),
                                background="light blue")
        __passwordLabel.grid(row=2, column=12, pady=10, padx=20)

        __passwordInput = Entry(self.commonFrame, textvariable=self.password, font=("Cambria", 10, "bold"))
        __passwordInput.grid(row=2, column=13, pady=10)

    # Others Radio Button Clicked Action
    def othersRadioButtonClicked(self):
        # Others Frames Details
        __frameNameLabel = Label(self.commonFrame, text="OTHRES", font=("Cambria", 10, "bold"), background="light blue",
                                 width=15)
        __frameNameLabel.grid(row=1, column=10, padx=20, pady=10)

        # Aadhar No Input and Field
        __aadharnoLabel = Label(self.commonFrame, text="Aadhar No :", font=("Cambria", 10, "bold"),
                                background="light blue", width=15)
        __aadharnoLabel.grid(row=2, column=7, pady=30, padx=20)

        __aadharnoInput = Entry(self.commonFrame, textvariable=self.aadharno, font=("Cambria", 10, "bold"))
        __aadharnoInput.grid(row=2, column=8, pady=30)

        # Password Input and Field
        __passwordLabel = Label(self.commonFrame, text="Password :", font=("Cambria", 10, "bold"),
                                background="light blue", width=15)
        __passwordLabel.grid(row=2, column=12, pady=10, padx=20)

        __passwordInput = Entry(self.commonFrame, textvariable=self.password, font=("Cambria", 10, "bold"))
        __passwordInput.grid(row=2, column=13, pady=10)

    # Display Book Image Button Clicked Action
    def displayImageButtonClicked(self):
        self.imageView()


# Run the Program
if __name__ == '__main__':
    student = ReserveBook()
    student.resizable(False, False)
    student.mainloop()
