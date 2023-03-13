

class BOOK {
  final String booktitle;
  final String authorname;
  final String email;
  final String phoneno;
  final String edition;
  final String publishedyear;
  final String id;
  final String publication;
  final String count;

  const BOOK({
    required this.booktitle,
    required this.authorname,
    required this.email,
    required this.phoneno,
    required this.edition,
    required this.publishedyear,
    required this.id,
    required this.publication,
    required this.count,
  });
  factory BOOK.fromJson(Map<String, dynamic> json) => BOOK(
    booktitle: json['booktitle'],
    authorname: json['authorname'],
    email: json['email'],
    phoneno: json['phoneno'],
    edition: json['edition'],
    publishedyear: json['publishedyear'],
    id: json['_id'],
    publication: json['publication'],
    count: json['count'],
  );

  Map<String, dynamic> toJson() => {
    "booktitle" : booktitle,
    "authorname" : authorname,
    "email" : email,
    "phoneno" : phoneno,
    "edition" : edition,
    "publishedyear" : publishedyear,
    "_id" : id,
    "publication" : publication,
    "count" : count,
  };
}
