import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cs_library_management_system/Book/BookDBHelper.dart';
import 'package:cs_library_management_system/templates/BOOKSTAFF.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

// Add Book Section
class Checkout_Staff extends StatefulWidget {
  final String booktitle,
      authorname,
      email,
      phoneno,
      edition,
      publishedyear,
      isbnno,
      publication,
      count;
  const Checkout_Staff(
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
  State<Checkout_Staff> createState() => _Checkout_StaffState();
}

class _Checkout_StaffState extends State<Checkout_Staff> {
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
  TextEditingController registerno = TextEditingController();

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
        duration: const Duration(seconds: 5),
        context: context
    );
  }

  Future checkOutBookStaffData(String booktitle1, String edition1, String publishedyear1,
      String isbnno1, String registerno1) async
  {
    await BookDBHelper.bookCountUpdate(isbnno1);
    await BookDBHelper.staffcountreduce(registerno1);
    var checkdate = DateTime.now();
    var renewdate = checkdate.add(const Duration(days: 30));

    final checkout = BOOKSTAFF(
        bookname: booktitle1,
        isbnno: isbnno1,
        id: m.ObjectId(),
        edition: edition1,
        publishedyear: publishedyear1,
        checkdate: checkdate.toString(),
        renewdate: renewdate.toString(),
        registerno: registerno1);

    final result = await BookDBHelper.CheckoutStaffBook(checkout);
    if (result == "True") {
      customStudentToast('Checked Out Successfully...', context);
      clearText();
    } else if (result == 'False') {
      customErrorToast('Book is already Checked Out ....', context);
      clearText();
    } else {
      customErrorToast('Try Again Later...', context);
      print(result);
      print("checkoutstaff");
      clearText();
    }
  }

  Future bookCountUpdate(String isbnno3) async {
    final data = await BookDBHelper.bookCountUpdate(isbnno3);

    if(data == "True")
    {
      staffCountUpdate(registerno.text.toUpperCase());
      print("True in bookcount");
    }
    else if(data == "False")
    {
      customErrorToast('Book is not available...', context);
      print("False in bookcount");
    }
    else
    {
      customErrorToast("Try again Later...", context);
      print("bookcount");
    }
  }

  Future staffCountUpdate(String register) async {

    final data = await BookDBHelper.staffCountUpdate(register);
    if(data == "True")
      {
        checkOutBookStaffData(bookTitle.text.toUpperCase(),
            edition.text.toUpperCase(),
            publishedYear.text.toUpperCase(),
            isbnNo.text.toUpperCase(),
            registerno.text.toUpperCase());
      }
    else if(data == "False")
      {
        customErrorToast('You are already borrow limited books. So You can\'t borrow...', context);
      }
    else
      {
        customErrorToast("Staff Not Found...", context);
        print("staff");
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
                          'Check Out Book',
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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

                Padding(
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
                              'CHECK OUT',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cambria',
                                  letterSpacing: 1.0),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('AlertDialog Title'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Text('Would you like to Checkout ' +
                                                (bookTitle.text) + " to " + (registerno.text.toUpperCase()) + ' ?'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Confirm'),
                                          onPressed: () {
                                            bookCountUpdate(isbnNo.text.toUpperCase());
                                            Navigator.pop(context);
                                            print('Confirmed');

                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
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
