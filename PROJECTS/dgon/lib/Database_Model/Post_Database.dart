import 'package:cloud_firestore/cloud_firestore.dart';

class PostDatabase {
  final String? PostID;
  final String? uid;
  final String? Username;
  final String? GroupName;
  final String? ProfileImage;
  final String? PostUrl;
  final DateTime? DatePublished;
  final String? Description;
  final List? Likes;

  const PostDatabase(
      {required this.PostID,
      required this.uid,
      required this.Username,
      required this.GroupName,
      required this.ProfileImage,
      required this.PostUrl,
      required this.DatePublished,
      required this.Description,
      required this.Likes});

  Map<String, dynamic> toJson() => {
        "PostID": PostID,
        "uid": uid,
        "Username": Username,
        "GroupName": GroupName,
        "ProfileImage": ProfileImage,
        "PostUrl": PostUrl,
        "DatePublished": DatePublished,
        "Description": Description,
        "Likes": Likes,
      };

  factory PostDatabase.fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PostDatabase(
        PostID: snap['PostId'],
        uid: snap['uid'],
        Username: snap['Username'],
        GroupName: snap['GroupName'],
        ProfileImage: snap['ProfileImage'],
        PostUrl: snap['PostUrl'],
        DatePublished: snap['DatePublished'],
        Description: snap['Description'],
        Likes: snap['Likes']);
  }
}
