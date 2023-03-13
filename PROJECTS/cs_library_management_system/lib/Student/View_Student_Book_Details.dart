import 'package:flutter/material.dart';

class View_Student_Book_Details extends StatefulWidget {
  final String bookname, isbnno, edition, publishedyear, checkdate, renewdate;
  const View_Student_Book_Details(
      {Key? key,
      required this.bookname,
      required this.isbnno,
      required this.edition,
      required this.publishedyear,
      required this.checkdate,
      required this.renewdate})
      : super(key: key);

  @override
  State<View_Student_Book_Details> createState() =>
      _View_Student_Book_DetailsState();
}

class _View_Student_Book_DetailsState extends State<View_Student_Book_Details> {
  TextEditingController bookname = TextEditingController();
  TextEditingController isbnno = TextEditingController();
  TextEditingController edition = TextEditingController();
  TextEditingController publishedyear = TextEditingController();
  TextEditingController checkdate = TextEditingController();
  TextEditingController renewdate = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    bookname.text = "${widget.bookname}     (BOOK NAME)";
    isbnno.text = "${widget.isbnno}     (ISBN N0)";
    edition.text = "${widget.edition}     (EDITION)";
    publishedyear.text = "${widget.publishedyear}     (PUBLISHED YEAR)";
    checkdate.text = "${widget.checkdate}     (CHECK DATE)";
    renewdate.text = "${widget.renewdate}     (RENEW DATE)";
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
                          "${bookname.text} Details",
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
                        controller: bookname,
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
                        controller: isbnno,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                      ),
                    )),
                  ],
                ),
                // First Row
                Row(
                  children: [
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
                        controller: publishedyear,
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
                          controller: edition,
                          readOnly: true,
                        ),
                      ),
                    ),
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
                        controller: checkdate,
                        keyboardType: TextInputType.text,
                        readOnly: true,
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
                          controller: renewdate,
                          readOnly: true,
                        ),
                      ),
                    ),
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
