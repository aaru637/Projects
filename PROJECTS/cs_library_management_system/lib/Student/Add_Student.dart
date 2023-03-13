import 'package:flutter/material.dart';
import 'package:cs_library_management_system/Student/StudentDBHelper.dart';
import 'package:cs_library_management_system/templates/STUDENT.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Add_Student extends StatefulWidget {
  const Add_Student({Key? key}) : super(key: key);

  @override
  State<Add_Student> createState() => _Add_StudentState();
}

class _Add_StudentState extends State<Add_Student> {
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _confirmVisible = true;

  dynamic dateTime = DateTime(2022);

  void customStudentToast(String message, BuildContext context) {
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

  void customErrorToast(String message, BuildContext context) {
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
        backgroundColor: Colors.red,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: Duration(seconds: 5),
        context: context);
  }

  void clearText() {
    firstname.clear();
    lastname.clear();
    email.clear();
    mobile.clear();
    aadharno.clear();
    registerno.clear();
    gender.clear();
    department.clear();
    year.clear();
    dob.text = '';
    username.clear();
    password.text = '';
    confirmpassword.text = '';
  }

  String value1 = '';

  Future checkUsername(String user) async {
    String result = await StudentDBHelper.checkUsername(user);

    if (result == "True") {
      setState(() {
        value1 = 'true';
      });
      return value1.toString();
    } else if (result == 'False') {
      setState(() {
        value1 = 'false';
      });
      return value1.toString();
    } else {
      customErrorToast('Try Again Later...', context);
    }
  }

  Icon validIcon() {
    return const Icon(Icons.done_outline_rounded, color: Colors.green,);
  }

  Icon invalidIcon() {
    return const Icon(Icons.cancel, color: Colors.red,);
  }

  Future insertStudentData(
      String firstname1,
      String lastname1,
      String email1,
      String mobile1,
      String aadharno1,
      String gender1,
      String department1,
      String year1,
      String dob1,
      String registerno1,
      String username1,
      String password1) async {

    final insert = STUDENT(
        firstname: firstname1,
        lastname: lastname1,
        email: email1,
        mobile: mobile1,
        aadharno: aadharno1,
        registerno: registerno1,
        gender: gender1,
        department: department1,
        year: year1,
        dob: dob1,
        username: username1,
        password: password1,
        bookcount: '3');

    final received = await StudentDBHelper.insertStudentData(insert);
    if (received == "True") {
      customStudentToast('Registered Successfully...', context);
      clearText();
    } else if (received == 'False') {
      customErrorToast('You are already Registered....', context);
      clearText();
    } else {
      customErrorToast('Try Again Later...', context);
      clearText();
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
  TextEditingController year = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        'Add Student',
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
                      autofocus: true,
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
                      autofocus: true,
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
                    padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: registerno,
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
                    padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
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
                    padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
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
                          labelText: "DEPARTMENT"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Department';
                        }
                        return null;
                      },
                    ),
                  )),

                  // Year Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: year,
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
                          hintText: "III",
                          labelText: "Year"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Year now you Studying';
                        }
                        return null;
                      },
                    ),
                  )),

                  // Date of Birth Field
                  Flexible(
                      child: SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(80, 22, 20, 40),
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
                            return 'Please Select Your Date of Birth';
                          }
                          return null;
                        },
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
                      maxLength: 16,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      autofocus: true,
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
                          return 'Please Enter Your Last Name';
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
                          onChanged: (value) {
                            checkUsername(value);
                          },
                          maxLength: 8,
                          decoration: InputDecoration(
                            suffixIcon: value1 == "true" && value1.isNotEmpty ? validIcon() : invalidIcon(),
                            border: const OutlineInputBorder(
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

              // Fourth Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Register Button
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: ElevatedButton(
                      child: const Text(
                        'ADD STUDENT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cambria',
                            letterSpacing: 1.0),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if(value1 == "true" && value1.isNotEmpty)
                            {
                              insertStudentData(
                                  firstname.text.toUpperCase(),
                                  lastname.text.toUpperCase(),
                                  email.text.toUpperCase(),
                                  mobile.text.toUpperCase(),
                                  aadharno.text.toUpperCase(),
                                  gender.text.toUpperCase(),
                                  department.text.toUpperCase(),
                                  year.text.toUpperCase(),
                                  dob.text.toUpperCase(),
                                  registerno.text.toUpperCase(),
                                  username.text,
                                  password.text);
                            }
                          else
                            {
                              customErrorToast('Username is already registered..', context);
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
    );
  }
}
