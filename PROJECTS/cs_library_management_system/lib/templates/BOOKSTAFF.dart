
import 'package:mongo_dart/mongo_dart.dart';

class BOOKSTAFF {
  final String bookname;
  final String isbnno;
  final ObjectId id;
  final String edition;
  final String publishedyear;
  final String checkdate;
  final String renewdate;
  final String registerno;

  const BOOKSTAFF({
    required this.bookname,
    required this.isbnno,
    required this.id,
    required this.edition,
    required this.publishedyear,
    required this.checkdate,
    required this.renewdate,
    required this.registerno,
  });

  factory BOOKSTAFF.fromJson(Map<String, dynamic> json) => BOOKSTAFF(
      bookname: json['booktitle'],
      isbnno: json['isbnno'],
      id: json['_id'],
      edition: json['edition'],
      publishedyear: json['publishedyear'],
      checkdate: json['checkdate'],
      renewdate: json['renewdate'],
      registerno: json["registerno"]);

  Map<String, dynamic> toJson() => {
        "booktitle": bookname,
        "isbnno": isbnno,
    "_id" : id,
        "edition": edition,
        "publishedyear": publishedyear,
        "checkdate": checkdate,
        "renewdate": renewdate,
        "registerno": registerno,
      };
}
