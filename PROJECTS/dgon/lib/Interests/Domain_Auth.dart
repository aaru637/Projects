import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/Comment_Database.dart' as comment;
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dgon/Database_Model/Domain_Database.dart' as domain;
import 'package:dgon/Register/Register_Auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Domain_Auth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
//GetDomainData
  static Future<List<String>> getDomainData(
      {required String Category,
      required String Sub_Category,
      required BuildContext context}) async {
    List<String> needs = [];
    try {
      QuerySnapshot snapshot = await firestore
          .collection("groups")
          .doc(Category)
          .collection(Sub_Category)
          .get();
      for (int i = 0; i < snapshot.docs.length; i++) {
        needs.add(snapshot.docs[i].id);
      }
      return needs;
    } catch (e) {
      snackBar(context, e.toString());
    }
    return needs;
  }

  //GetDomainDataFully

  static Future<domain.DomainDatabase> getGroupData(
      {required String Group, required String Sub_category}) async {
    DocumentSnapshot snapshot = await firestore
        .collection("groups")
        .doc("Entertainment")
        .collection(Sub_category)
        .doc(Group)
        .get();
    return domain.DomainDatabase.fromJson(snapshot);
  }

//UpdateGroupData
  static updateGroupData(
      {required String Group,
      required int index,
      required String Category,
      required String Sub_Category}) async {
    UserDatabase user = await GetUser.getUserDetails();
    User currentUser = firebaseAuth.currentUser!;
    int groupCount = user.GroupCount!;
    if (groupCount > 4) {
      return false;
    } else {
      await firestore.collection("users").doc(currentUser.uid).update({
        "Groups": FieldValue.arrayUnion([Group]),
        "GroupCount": groupCount - 1,
        "Sub_Group": Sub_Category
      });
      domain.DomainDatabase database =
          await getGroupData(Group: Group, Sub_category: Sub_Category);
      int count = database.MembersCount!;
      await firestore
          .collection("groups")
          .doc(Category)
          .collection(Sub_Category)
          .doc(Group)
          .update({
        "Members": FieldValue.arrayUnion([currentUser.uid]),
        "MembersCount": count + 1
      });
      return true;
    }
  }

  //UpdateGroupData
  static deleteGroupData({
    required String Group,
    required int index,
    required String Category,
    required String Sub_Category,
  }) async {
    UserDatabase user = await GetUser.getUserDetails();
    User currentUser = firebaseAuth.currentUser!;
    int groupCount = user.GroupCount!;
    if (groupCount == 4) {
      await firestore
          .collection("users")
          .doc(currentUser.uid)
          .update({"Sub_Group": ""});
      return false;
    } else {
      await firestore.collection("users").doc(currentUser.uid).update({
        "Groups": FieldValue.arrayRemove([Group])
      });
      await firestore
          .collection("users")
          .doc(currentUser.uid)
          .update({"GroupCount": groupCount + 1});
      domain.DomainDatabase database =
          await getGroupData(Group: Group, Sub_category: Sub_Category);
      int count = database.MembersCount!;
      await firestore
          .collection("groups")
          .doc(Category)
          .collection(Sub_Category)
          .doc(Group)
          .update({
        "Members": FieldValue.arrayRemove([currentUser.uid]),
        "MembersCount": count - 1
      });
      return true;
    }
  }

//AddLikes
  static Future<void> LikePost(String PostID, String uid, List Likes) async {
    try {
      if (Likes.contains(uid)) {
        await firestore.collection("posts").doc(PostID).update({
          "Likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await firestore.collection("posts").doc(PostID).update({
          "Likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }

  //PostComments
  static Future<bool> PostComment(String PostID, String Comment, String uid,
      String Username, String ProfileImage) async {
    bool res = false;
    try {
      if (Comment.isNotEmpty) {
        String CommentId = const Uuid().v1();
        res = true;
        comment.CommentDatabase commentDatabase = comment.CommentDatabase(
          CommentID: CommentId,
          PostID: PostID,
          uid: uid,
          Username: Username,
          Comment: Comment,
          ProfileImage: ProfileImage,
          DatePublished: DateTime.now(),
          Likes: [],
        );
        await firestore
            .collection("posts")
            .doc(PostID)
            .collection("comments")
            .doc(CommentId)
            .set(commentDatabase.toJson());
        return res;
      } else {
        print("Empty");
        res = false;
        return res;
      }
    } catch (e) {}
    return res;
  }

  //AddLikes

  static Future<void> LikeComment(
      String PostID, String CommentID, String uid, List Likes) async {
    try {
      if (Likes.contains(uid)) {
        await firestore
            .collection("posts")
            .doc(PostID)
            .collection("comments")
            .doc(CommentID)
            .update({
          "Likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await firestore
            .collection("posts")
            .doc(PostID)
            .collection("comments")
            .doc(CommentID)
            .update({
          "Likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }
  //SavedList

  static Future<void> SavePost(String PostID, String uid, List Saved) async {
    try {
      if (Saved.contains(PostID)) {
        await firestore.collection("users").doc(uid).update({
          "Saved": FieldValue.arrayRemove([PostID])
        });
      } else {
        await firestore.collection("users").doc(uid).update({
          "Saved": FieldValue.arrayUnion([PostID])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
