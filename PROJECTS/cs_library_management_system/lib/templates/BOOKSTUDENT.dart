import 'package:mongo_dart/mongo_dart.dart';

class BOOKSTUDENT
{
  final String bookname;
  final String isbnno;
  final ObjectId id;
  final String edition;
  final String publishedyear;
  final String checkdate;
  final String renewdate;
  final String registerno;

  const BOOKSTUDENT({
    required this.bookname,
    required this.isbnno,
    required this.edition,
    required this.id,
    required this.publishedyear,
    required this.checkdate,
    required this.renewdate,
    required this.registerno,
});

  factory BOOKSTUDENT.fromJson(Map<String, dynamic> json) =>
      BOOKSTUDENT(
        bookname: json['bookname'],
        isbnno: json['isbnno'],
        id: json['_id'],
        edition: json['edition'],
        publishedyear: json['publishedyear'],
        checkdate: json['checkdate'],
        renewdate: json['renewdate'],
        registerno: json['registerno']
      );

  Map<String, dynamic> toJson() => {
    "bookname" : bookname,
    "isbnno" : isbnno,
    "_id" : id,
    "edition" : edition,
    "publishedyear" : publishedyear,
    "checkdate" : checkdate,
    "renewdate" : renewdate,
    "registerno" : registerno,
  };
}