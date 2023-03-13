import 'package:flutter/material.dart';
import 'package:cs_library_management_system/Staff/StaffDBHelper.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../templates/STAFF.dart';

class Update_Staff extends StatefulWidget {
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
      confirmpassword,
  bookcount;
  const Update_Staff(
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
      required this.confirmpassword,
      required this.bookcount})
      : super(key: key);

  @override
  State<Update_Staff> createState() => _Update_StaffState();
}

class _Update_StaffState extends State<Update_Staff> {
  @override
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _confirmVisible = true;

  dynamic genderChoice;
  dynamic departmentChoice;
  List genders = ["Male", "Female", "Others"];
  List departments = [
    'CIVIL',
    'CSE',
    'ECE',
    'EEE',
    'MECH',
    'SPORTS',
    'ENGLISH',
    'MATHS',
    'PHYSICS',
    'CHEMISTRY'
  ];

  dynamic dateTime = DateTime(2022);

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
  TextEditingController bookcount = TextEditingController();

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
    confirmpassword.text = widget.confirmpassword;
    bookcount.text = widget.bookcount;
    super.initState();
  }

  void customStaffToast(String message, BuildContext context)
  {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
        textPadding: EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.green,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: Duration(seconds: 5),
        context: context
    );
  }

  void customErrorToast(String message, BuildContext context)
  {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
        textPadding: EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.red,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: Duration(seconds: 5),
        context: context
    );
  }

  void clearText()
  {
    firstname.clear();
    lastname.clear();
    email.clear();
    mobile.clear();
    aadharno.clear();
    registerno.clear();
    gender.clear();
    department.clear();
    dob.text = '';
    username.clear();
    password.text = '';
    confirmpassword.text = '';
    bookcount.clear();
  }


  Future updateStaffData(String firstname1, String lastname1, String email1,
      String mobile1, String aadharno1, String gender1, String department1, String dob1, String registerno1, String username1,
      String password1, String bookcount1)
  async {
    final staff =  STAFF(
        firstname: firstname1,
        lastname: lastname1,
        email: email1,
        mobile: mobile1,
        aadharno: aadharno1,
        registerno: registerno1,
        gender: gender1,
        department: department1,
        dob: dob1,
        username: username1,
        password: password1,
        bookcount: bookcount1);

    final received = await StaffDBHelper.updateStaffData(staff, registerno1);

    if (received == "True") {
      customStaffToast("$firstname1 Updated SuccessFully...", context);
      Navigator.pop(context);
    } else if (received == 'False') {
      customErrorToast('Error Occured While Updating your Record. Please Try again Later...', context);
      clearText();
    } else {
      customErrorToast('Try Again Later...', context);
      clearText();
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
            child: ListView(
              children: <Widget>[
                // Login Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Update Staff',
                          style: TextStyle(
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
                        maxLength: 30,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Dhineshkumar",
                            labelText: "First Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your First Name';
                          }
                          return null;
                        },
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
                        maxLength: 30,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Dhandapani",
                            labelText: "Last Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Last Name';
                          }
                          return null;
                        },
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
                        maxLength: 35,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "abc@gmail.com",
                            labelText: "Email ID"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Email';
                          }
                          return null;
                        },
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
                        maxLength: 10,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "1234567890",
                            labelText: "Mobile No"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Mobile No';
                          }
                          return null;
                        },
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
                      padding: const EdgeInsets.all(40),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cambria',
                            color: Colors.black87),
                        controller: registerno,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        maxLength: 20,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "613520104008",
                            labelText: "Register No"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Register No';
                          }
                          return null;
                        },
                      ),
                    )),

                    // Gender Field
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: gender,
                            keyboardType: TextInputType.text,
                            maxLength: 20,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black87,
                                      width: 10,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                hintText: "Male",
                                labelText: "Gender"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Gender';
                              }
                              return null;
                            },
                          ),
                        )),

                    // Department Field
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                color: Colors.black87),
                            controller: department,
                            keyboardType: TextInputType.text,
                            maxLength: 20,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black87,
                                      width: 10,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                hintText: "CSE",
                                labelText: "Department"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Department';
                              }
                              return null;
                            },
                          ),
                        )),

                    // Date of Birth Field
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 18, 40, 40),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cambria',
                            color: Colors.black87),
                        controller: dob,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_month),
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: dateTime,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now());

                                if (newDate != null) {
                                  setState(() {
                                    dateTime = newDate;
                                    dob.text =
                                        ("${dateTime.year}-${dateTime.month}-${dateTime.day}");
                                  });
                                }
                              },
                            ),
                            hintText: "2002-12-12",
                            labelText: "Date of Birth"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Date of Birth';
                          }
                          return null;
                        },
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
                        maxLength: 16,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "123456789101",
                            labelText: "Aadhar No"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Aadhar No';
                          }
                          return null;
                        },
                      ),
                    )),

                    // Username Field
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
                            maxLength: 8,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                    width: 10,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              hintText: "dk12345r",
                              labelText: "Username",),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Username';
                              }
                              return null;
                            },
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
                        maxLength: 16,
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
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: "Password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          return null;
                        },
                      ),
                    )),

                    // Confirm Password Field
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cambria',
                            color: Colors.black87),
                        controller: confirmpassword,
                        maxLength: 16,
                        obscureText: _confirmVisible,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmVisible = !_confirmVisible;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: "Confirm password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Confirm Password';
                          } else if (password.text != confirmpassword.text) {
                            return "Password and Confirm Password was not same";
                          }
                          return null;
                        },
                      ),
                    )),
                  ],
                ),

                // Book Count Field
                  Padding(
                      padding: const EdgeInsets.all(40),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cambria',
                            color: Colors.black87),
                        controller: bookcount,
                        maxLength: 2,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            hintText: "3",
                            labelText: "Book Count"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Book Count is less than 4';
                          }
                          else if(int.parse(value) > 3)
                            {
                              return 'Only 3 Books will be allot to One Student..';
                            }
                          else
                            {
                              return null;
                            }
                        },
                      ),
                    ),

                // Fourth Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Add Staff Button
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: ElevatedButton(
                        child: const Text(
                          'UPDATE STAFF',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cambria',
                              letterSpacing: 1.0),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if(username.text == widget.username)
                              {
                                updateStaffData(firstname.text.toUpperCase(),
                                    lastname.text.toUpperCase(),
                                    email.text.toUpperCase(),
                                    mobile.text,
                                    aadharno.text,
                                    gender.text.toUpperCase(),
                                    department.text.toUpperCase(),
                                    dob.text,
                                    registerno.text,
                                    username.text,
                                    password.text,
                                    bookcount.text);
                              }
                            else
                              {
                                customErrorToast('Username is already registered...', context);
                              }
                          }
                        },
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
