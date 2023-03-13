import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer';

const String MONGO_CONN_URL =
    "mongodb+srv://DhineshSiva:Dhinesh123@dk.imbe4ez.mongodb.net/lbs?retryWrites=true&w=majority";
const String LIBRARIAN_COLLECTION = "librarian";
const String BOOK_COLLECTION = "book";
const String STUDENT_COLLECTION = "student";
const String STAFF_COLLECTION = "staff";
const String BOOK_STUDENT_COLLECTION = "bookstudent";
const String BOOK_STAFF_COLLECTION = "bookstaff";

const user = 'DhineshSiva';
const password = 'Dhinesh123';


class DbConnection{
  static dynamic db, librarianCollection, bookCollection, studentCollection, staffCollection, bookStudentCollection, bookStaffCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    librarianCollection = db.collection(LIBRARIAN_COLLECTION);
    bookCollection = db.collection(BOOK_COLLECTION);
    studentCollection = db.collection(STUDENT_COLLECTION);
    staffCollection = db.collection(STAFF_COLLECTION);
    bookStudentCollection = db.collection(BOOK_STUDENT_COLLECTION);
    bookStaffCollection = db.collection(BOOK_STAFF_COLLECTION);
  }
}