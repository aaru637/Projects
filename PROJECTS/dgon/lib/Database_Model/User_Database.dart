import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase {
  final String? FullName;
  final String? Username;
  final String? Mobile;
  final String? Email;
  final String? Logged;
  final String? uid;
  final String? PhotoUrl;
  final List? Groups;
  final String? Sub_Group;
  final int? GroupCount;
  final String? Bio;

  const UserDatabase({
    required this.FullName,
    required this.Username,
    required this.Mobile,
    required this.Email,
    required this.Logged,
    required this.uid,
    required this.PhotoUrl,
    required this.Groups,
    required this.Sub_Group,
    required this.GroupCount,
    required this.Bio,
  });

  Map<String, dynamic> toJson() => {
        "FullName": FullName,
        "Username": Username,
        "Mobile": Mobile,
        "Email": Email,
        "Logged": Logged,
        "uid": uid,
        "PhotoUrl": PhotoUrl,
        "Groups": Groups,
        "Sub_Group": Sub_Group,
        "GroupCount": GroupCount,
        "Bio": Bio,
      };

  static UserDatabase fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserDatabase(
        FullName: snap['FullName'],
        Username: snap['Username'],
        Mobile: snap['Mobile'],
        Email: snap['Email'],
        Logged: snap['Logged'],
        uid: snap['uid'],
        PhotoUrl: snap['PhotoUrl'],
        Groups: snap['Groups'],
        Sub_Group: snap['Sub_Group'],
        GroupCount: snap['GroupCount'],
        Bio: snap['Bio']);
  }
}
