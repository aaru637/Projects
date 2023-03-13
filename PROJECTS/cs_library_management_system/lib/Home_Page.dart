import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cs_library_management_system/Book/Provide_Book_Staff.dart';
import 'package:cs_library_management_system/Book/Provide_Book_Student.dart';
import 'package:cs_library_management_system/Librarian/LibrarianDBHelper.dart';
import 'package:cs_library_management_system/Staff/Add_Staff.dart';
import 'package:cs_library_management_system/Librarian/Update_Librarian.dart';
import 'package:cs_library_management_system/Student/Add_Student.dart';
import 'package:cs_library_management_system/Book/Add_Book.dart';
import 'package:cs_library_management_system/main.dart';
import 'package:cs_library_management_system/Book/View_Book.dart';
import 'package:cs_library_management_system/Staff/View_Staff.dart';
import 'package:cs_library_management_system/Student/View_Student.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cs_library_management_system/templates/LIBRARIAN.dart';

class Home_Page extends StatefulWidget {
  final String username;
  final String password;
  const Home_Page({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  List<LIBRARIAN> librarian = [];

  void customLoginToast(String message, BuildContext context) {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textPadding: EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.green,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: Duration(seconds: 5),
        context: context);
  }

  int currentIndex = 2;

  dynamic getCurrentFragment() {
    switch (currentIndex) {
      case 1:
        return const Add_Book();

      case 2:
        return const View_Book();

      case 3:
        return const Provide_Book_Student();

      case 4:
        return const Provide_Book_Staff();

      case 5:
        return const Add_Student();

      case 6:
        return const View_Student();

      case 7:
        return const Add_Staff();

      case 8:
        return const View_Staff();
    }
  }

  setCurrentIndex(int Index) {
    setState(() {
      currentIndex = Index;
    });
  }

  Future<List<LIBRARIAN>> searchData() async {
    final librarian = await LibrarianDBHelper.getLibrarianData(
        widget.username);
    return librarian.map((e) => LIBRARIAN.fromJson(e)).toList();
  }

  Future init() async {
    final librarian = await searchData();
    setState(() {
      this.librarian = librarian;
      firstname.text = librarian[0].firstname;
      lastname.text = librarian[0].lastname;
      email.text = librarian[0].email;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    searchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.blue, Colors.redAccent]),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Update_Librarian(
                              firstname: librarian[0].firstname,
                              lastname: librarian[0].lastname,
                              email: librarian[0].email,
                              librarianid: librarian[0].id,
                              gender: librarian[0].gender,
                              mobile: librarian[0].mobile,
                              aadharno: librarian[0].aadharno,
                              dob: librarian[0].dob,
                              username: librarian[0].username,
                              password: librarian[0].password,
                              confirmpassword: librarian[0].password,
                            )));
              },
              icon: const Icon(Icons.person)),
        ],
        title: const Text(
          'CS LIBRARY MANAGEMENT SYSTEM',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Cambria',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      drawer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
          backgroundColor: Colors.lime,
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.blue, Colors.redAccent]),
                ),
                accountName: Text(
                  "${firstname.text} ${lastname.text}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  email.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: Text(
                    firstname.text.toString().substring(0, 1),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
                arrowColor: Colors.green,
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Text(
                  'Book Section',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              // Add Book
              ListTile(
                selected: currentIndex == 1 ? true : false,
                leading: const Icon(
                  Icons.bookmark_add_outlined,
                  color: Colors.white,
                ),
                title: const Text('Add Book'),
                textColor: Colors.white,
                onTap: () {
                  setCurrentIndex(1);
                  Navigator.pop(context);
                },
              ),

              // View Book
              ListTile(
                selected: currentIndex == 2 ? true : false,
                leading: const Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                title: const Text('View Book Details'),
                textColor: Colors.white,
                onTap: () {
                  setCurrentIndex(2);
                  Navigator.pop(context);
                },
              ),

              // Provide a Book to Student
              ListTile(
                selected: currentIndex == 3 ? true : false,
                leading: const Icon(
                  Icons.book_outlined,
                  color: Colors.white,
                ),
                title: const Text('Provide Book to Student'),
                textColor: Colors.white,
                onTap: () {
                  setCurrentIndex(3);
                  Navigator.pop(context);
                },
              ),

              // Provide a Book to Staff
              ListTile(
                selected: currentIndex == 4 ? true : false,
                leading: const Icon(
                  Icons.book_outlined,
                  color: Colors.white,
                ),
                title: const Text('Provide Book to Staff'),
                textColor: Colors.white,
                onTap: () {
                  setCurrentIndex(4);
                  Navigator.pop(context);
                },
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Text(
                  'Student Section',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              // Search Book
              ListTile(
                selected: currentIndex == 5 ? true : false,
                leading: const Icon(
                  Icons.person_add_alt,
                  color: Colors.white,
                ),
                title: const Text('Add Student'),
                textColor: Colors.white,
                onTap: () {
                  setCurrentIndex(5);
                  Navigator.pop(context);
                },
              ),

              // View Book
              ListTile(
                selected: currentIndex == 6 ? true : false,
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                title: const Text('View Student Details'),
                textColor: Colors.white,
                onTap: () {
                  setCurrentIndex(6);
                  Navigator.pop(context);
                },
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Text(
                  'Staff Section',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              // Add Staff
              ListTile(
                selected: currentIndex == 7 ? true : false,
                leading: const Icon(
                  Icons.person_add_alt,
                  color: Colors.white,
                ),
                title: const Text('Add Staff'),
                textColor: Colors.white,
                onTap: () {
                  setCurrentIndex(7);
                  Navigator.pop(context);
                },
              ),

              // Delete Student
              ListTile(
                selected: currentIndex == 8 ? true : false,
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                title: const Text('View Staff Details'),
                textColor: Colors.white,
                onTap: () {
                  setCurrentIndex(8);
                  Navigator.pop(context);
                },
              ),

              // Logout Section
              ListTile(
                leading: const Icon(
                  Icons.accessibility_sharp,
                  color: Colors.black87,
                ),
                title: const Text('Logout'),
                textColor: Colors.black87,
                onTap: () {
                  customLoginToast('Logged out Successfully....', context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login_Page()));
                },
              ),
            ],
          ),
        ),
      ),
      body: getCurrentFragment(),
    );
  }
}
