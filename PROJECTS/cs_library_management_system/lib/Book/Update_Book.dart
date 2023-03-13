import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cs_library_management_system/Book/BookDBHelper.dart';
import 'package:cs_library_management_system/templates/BOOK.dart';

// Add Book Section
class Update_Book extends StatefulWidget {
  final String booktitle,
      authorname,
      email,
      phoneno,
      edition,
      publishedyear,
      isbnno,
      publication,
      count;
  const Update_Book(
      {Key? key,
      required this.booktitle,
      required this.authorname,
      required this.email,
      required this.phoneno,
      required this.edition,
      required this.publishedyear,
      required this.isbnno,
      required this.publication,
      required this.count})
      : super(key: key);

  @override
  State<Update_Book> createState() => _Update_BookState();
}

class _Update_BookState extends State<Update_Book> {
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

  String copyisbnno = '';

  @override
  void initState() {
    // TODO: implement initState
    bookTitle.text = widget.booktitle;
    authorName.text = widget.authorname;
    email.text = widget.email;
    phoneNo.text = widget.phoneno;
    edition.text = widget.edition;
    publishedYear.text = widget.publishedyear;
    isbnNo.text = widget.isbnno;
    publication.text = widget.publication;
    count.text = widget.count;
    copyisbnno = isbnNo.text;
    super.initState();
  }

  void clearText()
  {
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

  void customStudentToast(String message, BuildContext context)
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

  Future updateBookData(String booktitle1, String authorname1, String email1,
      String phoneno1, String edition1, String publishedyear1,
      String isbnno1, String publication1, String count1) async
  {

    final data = await BOOK(
        booktitle: booktitle1,
        authorname: authorname1,
        email: email1,
        phoneno: phoneno1,
        edition: edition1,
        publishedyear: publishedyear1,
        id: isbnno1,
        publication: publication1,
        count: count1);

    final received = await BookDBHelper.updateBookData(data, copyisbnno);

    if (received == "True")
    {
      customStudentToast(booktitle1 + " Updated SuccessFully...", context);
      Navigator.pop(context);
    }
    else
    {
      customErrorToast('Error Occured While Updating your Record. Please Try again Later...', context);
      Navigator.pop(context);
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
                // Add Book Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Update Book',
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
                        readOnly: true,
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
                          'UPDATE BOOK',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cambria',
                              letterSpacing: 1.0),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            updateBookData(
                                bookTitle.text.toUpperCase(),
                                authorName.text.toUpperCase(),
                                email.text.toUpperCase(),
                                phoneNo.text.toUpperCase(),
                                edition.text.toUpperCase(),
                                publishedYear.text.toUpperCase(),
                                isbnNo.text.toUpperCase(),
                                publication.text.toUpperCase(),
                                count.text.toUpperCase());
                            setState(() {});
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
