import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cs_library_management_system/Book/BookDBHelper.dart';
import 'package:cs_library_management_system/templates/BOOK.dart';

// Add Book Section
class Add_Book extends StatefulWidget {
  const Add_Book({Key? key}) : super(key: key);

  @override
  State<Add_Book> createState() => _Add_BookState();
}

class _Add_BookState extends State<Add_Book> {
  final formKey = GlobalKey<FormState>();

  dynamic dateTime = DateTime(2022);

  TextEditingController bookTitle = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController edition = TextEditingController();
  TextEditingController publishedYear = TextEditingController();
  TextEditingController isbnNo = TextEditingController();
  TextEditingController publication = TextEditingController();
  TextEditingController count = TextEditingController();

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
    bookTitle.clear();
    authorName.clear();
    email.clear();
    phoneNo.clear();
    edition.clear();
    publishedYear.clear();
    isbnNo.clear();
    publication.clear();
    count.clear();
  }

  Future insertBookData(
      String booktitle,
      String authorname,
      String email1,
      String phoneno,
      String edition,
      String publishedyear,
      String isbnno,
      String publication,
      String count) async {

    final data = BOOK(
        booktitle: booktitle,
        authorname: authorname,
        email: email1,
        phoneno: phoneno,
        edition: edition,
        publishedyear: publishedyear,
        id: isbnno,
        publication: publication,
        count: count);
    String result = await BookDBHelper.insertBookData(data);

    if (result == "True") {
      customStudentToast('Registered Successfully...', context);
      clearText();
    } else if (result == 'False') {
      customErrorToast('Book is already Registered....', context);
      clearText();
    } else {
      customErrorToast('Try Again Later...', context);
      clearText();
    }
  }

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
              // Add Book Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        'Add Book',
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
                  // Book Title Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: bookTitle,
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
                          hintText: "Java The Complete Reference",
                          labelText: "Book Title"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Book Title';
                        }
                        return null;
                      },
                    ),
                  )),

                  // Author Name Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: authorName,
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
                          labelText: "Author Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Author Name';
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
                          return 'Please Enter Book Email';
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
                  // Phone No Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: phoneNo,
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
                          labelText: "Phone No"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Phone No';
                        }
                        return null;
                      },
                    ),
                  )),

                  // Edition Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: edition,
                      maxLength: 10,
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
                          hintText: "First",
                          labelText: "Edition"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Edition of a Book';
                        }
                        return null;
                      },
                    ),
                  )),

                  // Published Year Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: publishedYear,
                      keyboardType: TextInputType.text,
                      maxLength: 20,
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
                                  publishedYear.text = ("${dateTime.year}");
                                });
                              }
                            },
                          ),
                          hintText: "2022",
                          labelText: "Published Year"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Published Year';
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
                  // ISBN No Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: isbnNo,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      maxLength: 13,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black87,
                                width: 10,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: "123456789012",
                          labelText: "ISBN No"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter ISBN No';
                        }
                        return null;
                      },
                    ),
                  )),

                  // Publication Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: publication,
                      maxLength: 16,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black87,
                                width: 10,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: "Oracle",
                          labelText: "Publication"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Publication';
                        }
                        return null;
                      },
                    ),
                  )),

                  // Count Field
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          color: Colors.black87),
                      controller: count,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
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
                          return 'Please Enter Count of the Book';
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
                  // ADD BOOK Button
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: ElevatedButton(
                      child: const Text(
                        'ADD BOOK',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cambria',
                            letterSpacing: 1.0),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          insertBookData(bookTitle.text.toUpperCase(),
                              authorName.text.toUpperCase(),
                              email.text.toUpperCase(),
                              phoneNo.text.toUpperCase(),
                              edition.text.toUpperCase(),
                              publishedYear.text.toUpperCase(),
                              isbnNo.text.toUpperCase(),
                              publication.text.toUpperCase(),
                              count.text.toUpperCase());
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