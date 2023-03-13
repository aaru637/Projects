
class STAFF {
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String aadharno;
  final String registerno;
  final String gender;
  final String department;
  final String dob;
  final String username;
  final String password;
  final String bookcount;

  const STAFF({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobile,
    required this.aadharno,
    required this.registerno,
    required this.gender,
    required this.department,
    required this.dob,
    required this.username,
    required this.password,
    required this.bookcount,
  });

  factory STAFF.fromJson(Map<String, dynamic> json) => STAFF(
    firstname: json['firstname'],
    lastname: json['lastname'],
    email: json['email'],
    mobile: json['mobile'],
    aadharno: json['aadharno'],
    registerno: json['_id'],
    gender: json['gender'],
    department: json['department'],
    dob: json['dob'],
    username: json['username'],
    password: json['password'],
    bookcount: json['bookcount'],
  );

  Map<String, dynamic> toJson() => {
    "firstname" : firstname,
    "lastname" : lastname,
    "email" : email,
    "mobile" : mobile,
    "aadharno" : aadharno,
    "_id" : registerno,
    "gender" : gender,
    "department" : department,
    "dob" : dob,
    "username" : username,
    "password" : password,
    "bookcount" : bookcount,
  };
}
