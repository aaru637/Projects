import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentDatabase {
  final String? CommentID;
  final String? PostID;
  final String? uid;
  final String? Username;
  final String? Comment;
  final String? ProfileImage;
  final DateTime? DatePublished;
  final List? Likes;

  const CommentDatabase({
    required this.CommentID,
    required this.PostID,
    required this.uid,
    required this.Username,
    required this.Comment,
    required this.ProfileImage,
    required this.DatePublished,
    required this.Likes,
  });

  Map<String, dynamic> toJson() => {
        "CommentID": CommentID,
        "PostID": PostID,
        "uid": uid,
        "Username": Username,
        "Comment": Comment,
        "ProfileImage": ProfileImage,
        "DatePublished": DatePublished,
        "Likes": Likes,
      };

  factory CommentDatabase.fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return CommentDatabase(
        CommentID: snap['CommentID'],
        PostID: snap['PostID'],
        uid: snap['uid'],
        Username: snap['Username'],
        Comment: snap['Comment'],
        ProfileImage: snap['ProfileImage'],
        DatePublished: snap['DatePublished'],
        Likes: snap['Likes']);
  }
}
