class LIBRARIAN
{
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String aadharno;
  final String id;
  final String gender;
  final String dob;
  final String username;
  final String password;

  const LIBRARIAN({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobile,
    required this.aadharno,
    required this.id,
    required this.gender,
    required this.dob,
    required this.username,
    required this.password,
});

  factory LIBRARIAN.fromJson(Map<String, dynamic> json) => LIBRARIAN(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      mobile: json['mobile'],
      aadharno: json['aadharno'],
      gender: json['gender'],
      dob: json['dob'],
      id: json['_id'],
      username: json['username'],
      password: json['password']);

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "mobile": mobile,
    "aadharno": aadharno,
    "gender": gender,
    "dob": dob,
    "_id": id,
    "username": username,
    "password": password,
  };
}