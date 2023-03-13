import 'package:flutter/material.dart';

// View Book Details Section
class View_Book_Details extends StatefulWidget {
  final String booktitle,
  authorname,
  email,
  phoneno,
  edition,
  publishedyear,
  isbnno,
  publication,
  count;
  const View_Book_Details({Key? key, required this.booktitle,
    required this.authorname,
    required this.email,
    required this.phoneno,
  required this.edition,
  required this.publishedyear,
  required this.isbnno,
  required this.publication,
  required this.count}) : super(key: key);

  @override
  State<View_Book_Details> createState() => _View_Book_DetailsState();
}

class _View_Book_DetailsState extends State<View_Book_Details> {
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
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text(
                          '${bookTitle.text.toUpperCase()} Details',
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
                        readOnly: true,
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
                        readOnly: true,
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        readOnly: true,
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
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_month),
                          ),
                        ),
                      ),
                    ),
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
                        readOnly: true,
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
                        keyboardType: TextInputType.text,
                        readOnly: true,
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
                        keyboardType: TextInputType.number,
                        readOnly: true,
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
