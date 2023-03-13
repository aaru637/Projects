import time
from Login_Register_Page import *

root = Tk()
root.title("Library Management System")
width_of_window = 427
height_of_window = 250
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
x_coordinate = int((screen_width / 2) - (width_of_window / 2))
y_coordinate = int((screen_height / 2) - (height_of_window / 2))
root.geometry(f'{width_of_window}x{height_of_window}+{x_coordinate}+{y_coordinate}')
root.resizable(False, False)

root.overrideredirect()


# Go to Login Register Page
def login_page():
    app1 = LoginPage()
    app1.mainloop()


Frame(root, bg="#272727", width=427, height=250).place(x=0, y=0)
label = Label(root, text="Library Management System", fg="white", bg="#272727")
label.configure(font=("Calibri", 18, "bold"))
label.place(x=80, y=90)

label1 = Label(root, text="Loading...", fg="white", bg="#272727")
label1.configure(font=("cambria", 8, "bold"))
label1.place(x=10, y=215)

image_a = ImageTk.PhotoImage(Image.open('ellipseBlack.png'))
image_b = ImageTk.PhotoImage(Image.open('ellipseWhite.png'))
for i in range(3):
    l1 = Label(root, image=image_a, border=0, relief=SUNKEN)
    l1.place(x=170, y=145)
    l2 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l2.place(x=190, y=145)
    l3 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l3.place(x=210, y=145)
    l4 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l4.place(x=230, y=145)
    root.update_idletasks()
    time.sleep(0.3)

    l1 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l1.place(x=170, y=145)
    l2 = Label(root, image=image_a, border=0, relief=SUNKEN)
    l2.place(x=190, y=145)
    l3 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l3.place(x=210, y=145)
    l4 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l4.place(x=230, y=145)
    root.update_idletasks()
    time.sleep(0.3)

    l1 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l1.place(x=170, y=145)
    l2 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l2.place(x=190, y=145)
    l3 = Label(root, image=image_a, border=0, relief=SUNKEN)
    l3.place(x=210, y=145)
    l4 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l4.place(x=230, y=145)
    root.update_idletasks()
    time.sleep(0.3)

    l1 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l1.place(x=170, y=145)
    l2 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l2.place(x=190, y=145)
    l3 = Label(root, image=image_b, border=0, relief=SUNKEN)
    l3.place(x=210, y=145)
    l4 = Label(root, image=image_a, border=0, relief=SUNKEN)
    l4.place(x=230, y=145)
    root.update_idletasks()
    time.sleep(0.3)
root.destroy()
login_page()

# Main Program
root.mainloop()
