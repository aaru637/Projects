import 'package:flutter/material.dart';
import 'package:cs_library_management_system/Book/Checkout_Staff.dart';
import 'package:cs_library_management_system/Book/View_Book_Details.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cs_library_management_system/templates/BOOK.dart';
import 'package:cs_library_management_system/templates/searchWidget.dart';

import 'BookDBHelper.dart';

class Provide_Book_Staff extends StatefulWidget {
  const Provide_Book_Staff({Key? key}) : super(key: key);

  @override
  State<Provide_Book_Staff> createState() => _Provide_Book_StaffState();
}

class _Provide_Book_StaffState extends State<Provide_Book_Staff> {
  TextEditingController bookname = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<BOOK> books = [];
  String query = '';

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

  void customBookToast(String message, BuildContext context) {
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

  Future<List<BOOK>> getBookData(String query) async {
    final List books = await BookDBHelper.getBookData();
    return books.map((json) => BOOK.fromJson(json)).where((book) {
      final isbn = book.id.toUpperCase();
      final name = book.authorname.toUpperCase();
      final title = book.booktitle.toUpperCase();
      final search = query.toUpperCase();

      return isbn.contains(search) ||
          name.contains(search) ||
          title.contains(search);
    }).toList();
  }

  Future init() async {
    final books = await getBookData(query);
    setState(() => this.books = books);
  }

  Future deleteBookData(String isbnno1) async {

    String data = await BookDBHelper.deleteBookData(isbnno1);

    if (data == "True") {
      customBookToast("$isbnno1 Deleted SuccessFully...", context);
    } else {
      customErrorToast(
          'Error Occured While deleting your Record. Please Try again Later...',
          context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Book Title or Author Name or ISBN No',
    onChanged: searchBook,
  );

  Future searchBook(String query) async {
    final books = await getBookData(query);
    if (!mounted) return;
    setState(() {
      this.query = query;
      this.books = books;
    });
  }

  Widget buildBook(BOOK book, index) {
    if (index < books.length) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              child:
              Text(book.booktitle.toString().toUpperCase().substring(0, 1)),
            ),
            title: Text(
              book.booktitle.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Cambria'),
            ),
            subtitle: Text(
              book.authorname.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Calibri',
                  fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => View_Book_Details(
                        booktitle: book.booktitle,
                        authorname: book.authorname,
                        email: book.email,
                        phoneno: book.phoneno,
                        edition: book.edition,
                        publishedyear: book.publishedyear,
                        isbnno: book.id,
                        publication: book.publication,
                        count: book.count,
                      )));
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    child: const Text('CHECK OUT'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Checkout_Staff(
                                booktitle: book.booktitle,
                                authorname: book.authorname,
                                email: book.email,
                                phoneno: book.phoneno,
                                edition: book.edition,
                                publishedyear: book.publishedyear,
                                isbnno: book.id,
                                publication: book.publication,
                                count: book.count,
                              )));
                    },
                  ),
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
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(231, 112, 226, 100.0),
                  Color.fromRGBO(0, 163, 255, 100.0)
                ]),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text('Book Details',
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Cambria',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                ),
              ),
              buildSearch(),
              Expanded(
                child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];

                      return buildBook(book, index);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
