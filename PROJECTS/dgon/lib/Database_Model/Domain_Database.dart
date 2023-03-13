import 'package:cloud_firestore/cloud_firestore.dart';

class DomainDatabase {
  final String? Name;
  final String? Genre;
  final String? Description;
  final String? uid;
  final String? ProfileImage;
  final Timestamp? DescriptionCreatedAt;
  final List? Members;
  final String? LastMessage;
  final int? MembersCount;

  const DomainDatabase({
    required this.Name,
    required this.Genre,
    required this.Description,
    required this.uid,
    required this.ProfileImage,
    required this.DescriptionCreatedAt,
    required this.Members,
    required this.LastMessage,
    required this.MembersCount,
  });

  Map<String, dynamic> toJson() => {
        "Name": Name,
        "Genre": Genre,
        "Description": Description,
        "uid": uid,
        "ProfileImage": ProfileImage,
        "DescriptionCreatedAt": DescriptionCreatedAt,
        "Members": Members,
        "LastMessage": LastMessage,
        "MembersCount": MembersCount,
      };

  factory DomainDatabase.fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return DomainDatabase(
      Name: snap['Name'],
      Genre: snap['Genre'],
      Description: snap['Description'],
      uid: snap['uid'],
      ProfileImage: snap['ProfileImage'],
      DescriptionCreatedAt: snap['DescriptionCreatedAt'],
      Members: snap['Members'],
      LastMessage: snap['LastMessage'],
      MembersCount: snap['MembersCount'],
    );
  }
}
