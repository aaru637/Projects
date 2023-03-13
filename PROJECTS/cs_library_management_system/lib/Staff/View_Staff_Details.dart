import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cs_library_management_system/templates/BOOKSTAFF.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../Book/BookDBHelper.dart';
import 'View_Staff_Book_Details.dart';

// View Staff Details Section
class View_Staff_Details extends StatefulWidget {
  final String firstname,
      lastname,
      email,
      mobile,
      aadharno,
      registerno,
      gender,
      department,
      dob,
      username,
      password,
  bookcount;
  const View_Staff_Details(
      {Key? key,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.mobile,
      required this.aadharno,
      required this.registerno,
      required this.gender,
      required this.department,
      required this.dob,
      required this.username,
      required this.password,
      required this.bookcount})
      : super(key: key);

  @override
  State<View_Staff_Details> createState() => _View_Staff_DetailsState();
}

class _View_Staff_DetailsState extends State<View_Staff_Details> {
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  dynamic dateTime = DateTime(2022);

  List<BOOKSTAFF> bookstaffs = [];

  void customErrorToast(String message, BuildContext context) {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textPadding: const EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.red,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: const Duration(seconds: 5),
        context: context);
  }

  void customStaffToast(String message, BuildContext context) {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textPadding: const EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.green,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: const Duration(seconds: 5),
        context: context);
  }

  Future staffRenewDate(String isbnno1) async {

    final renew = await BookDBHelper.staffRenewDate(registerno.text, isbnno1);

    if(renew == "True")
    {
      customStaffToast('Renewed Successfully', context);
    }
    else {
      customErrorToast('Error Occured in Renewing...Please Try again Later..', context);
    }
  }

  Future staffReturnBook(String isbnno2) async {

    final data = await BookDBHelper.staffReturnBook(registerno.text, isbnno2);

    if(data == "True")
    {
      customStaffToast('Book Returned Successfully...', context);
    }
    else
    {
      customErrorToast('Error Occured in Returning Book. Please Try again Later...', context);
    }

  }

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController aadharno = TextEditingController();
  TextEditingController registerno = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController bookCount = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    firstname.text = widget.firstname;
    lastname.text = widget.lastname;
    email.text = widget.email;
    mobile.text = widget.mobile;
    aadharno.text = widget.aadharno;
    registerno.text = widget.registerno;
    gender.text = widget.gender;
    department.text = widget.department;
    dob.text = widget.dob;
    username.text = widget.username;
    password.text = widget.password;
    bookCount.text = widget.bookcount;
    init();
    super.initState();
  }

  Future<List<BOOKSTAFF>> getStaffBookData(String registerno) async {
    final List bookstaffs = await BookDBHelper.getBookStaffData(registerno);
    return bookstaffs.map((json) => BOOKSTAFF.fromJson(json)).toList();
  }

  Future init() async {
    final bookstaffs = await getStaffBookData(registerno.text);
    setState(() => this.bookstaffs = bookstaffs);
  }

  Widget buildStaff(BOOKSTAFF bookstaff, index) {
    if (index < bookstaffs.length) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                  bookstaff.bookname.toString().toUpperCase().substring(0, 1)),
            ),
            title: Text(
              bookstaff.bookname.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Cambria'),
            ),
            subtitle: Text(
              bookstaff.isbnno.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Calibri',
                  fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => View_Staff_Book_Details(
                        bookname: bookstaff.bookname,
                        isbnno: bookstaff.isbnno,
                        edition: bookstaff.edition,
                        publishedyear: bookstaff.publishedyear,
                        checkdate: bookstaff.checkdate.toString(),
                        renewdate: bookstaff.renewdate.toString(),
                      )));
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        staffRenewDate(bookstaff.isbnno.toString());
                      },
                      child: const Text('RENEW'),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        staffReturnBook(bookstaff.isbnno);
                      },
                      child: const Text('RETURN'),
                    )
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(231, 112, 226, 100.0),
                Color.fromRGBO(0, 163, 255, 100.0)
              ]),
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                // Login Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text(
                          "${firstname.text} Details",
                          style: const TextStyle(
                              fontSize: 35,
                              fontFamily: 'Cambria',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),

                // First Row
                Row(
                  children: [
                    // First Name Field
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: firstname,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                          ),
                        )),

                    // Last Name Field
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: lastname,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                          ),
                        )),

                    // Email Field
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            readOnly: true,
                          ),
                        )),

                    // Mobile No Field
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: mobile,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false, signed: false),
                            readOnly: true,
                          ),
                        )),
                  ],
                ),

                // Second Row
                Row(
                  children: [
                    // Register No Field
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: registerno,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                          ),
                        )),

                    // Gender Field
                    Flexible(
                        child: SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cambria',
                                  color: Colors.black87),
                              controller: gender,
                              readOnly: true,
                            ),
                          ),
                        )),

                    // Department Field
                    Flexible(
                        child: SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cambria',
                                  color: Colors.black87),
                              controller: department,
                              readOnly: true,
                            ),
                          ),
                        )),

                    // Date of Birth Field
                    Flexible(
                        child: SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cambria',
                                  color: Colors.black87),
                              controller: dob,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_month)),
                            ),
                          ),
                        )),
                  ],
                ),

                // Third Row
                Row(
                  children: [
                    // Aadhar No Field
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: aadharno,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false, signed: false),
                            autofocus: true,
                            readOnly: true,
                          ),
                        )),

                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: username,
                            readOnly: true,
                          ),
                        )),

                    // Password Field
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cambria',
                              color: Colors.black87),
                          controller: password,
                          readOnly: true,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _passwordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cambria',
                              color: Colors.black87),
                          controller: bookCount,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.all(30),
                  child: const Text('BOOK DETAILS'),),

                Expanded(
                  child: ListView.builder(
                      itemCount: bookstaffs.length,
                      itemBuilder: (context, index) {
                        final staff = bookstaffs[index];

                        return buildStaff(staff, index);
                      }),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
