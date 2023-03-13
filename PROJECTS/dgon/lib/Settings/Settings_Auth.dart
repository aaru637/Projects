import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/Post_Database.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Interests/Domain_Auth.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:dgon/Database_Model/Domain_Database.dart' as domain;

class Settings_Auth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static User get getUser => firebaseAuth.currentUser!;
// DeleteUserData
  static DeleteUserData(BuildContext context) async {
    try {
      await firestore.collection("users").doc(getUser.uid).delete();
    } catch (e) {
      snackBar(context, e.toString());
      print(e.toString());
    }
  }

  //Deleteuser

  static DeleteUser(BuildContext context) async {
    try {
      await firebaseAuth.currentUser!.delete();
    } catch (e) {
      snackBar(context, e.toString());
      print(e.toString());
    }
  }

  //DeleteUserFromGroup
  static DeleteUserFromGroup(BuildContext context) async {
    try {
      UserDatabase user = await GetUser.getUserDetails();
      List<String> groups = [];
      String Sub_Group = user.Sub_Group!;

      for (int i = 0; i < user.Groups!.length; i++) {
        groups.add(user.Groups![i]);
      }
      for (int i = 0; i < groups.length; i++) {
        domain.DomainDatabase database = await Domain_Auth.getGroupData(
            Group: groups[i], Sub_category: Sub_Group);
        int count = database.MembersCount!;
        await firestore
            .collection("groups")
            .doc("Entertainment")
            .collection(Sub_Group)
            .doc(groups[i])
            .update({
          "Members": FieldValue.arrayRemove([user.uid!]),
          "MembersCount": count - 1
        });
        var snap = await firestore
            .collection("groups")
            .doc("Entertainment")
            .collection(Sub_Group)
            .doc(groups[i])
            .collection("chats")
            .get();
        for (int j = 0; j < snap.docs.length; j++) {
          if (getUser.uid == snap.docs[j]['SenderID']) {
            await firestore
                .collection("groups")
                .doc("Entertainment")
                .collection(Sub_Group)
                .doc(groups[i])
                .collection("chats")
                .doc(snap.docs[j].id)
                .delete();
          }
        }
      }
    } catch (e) {
      snackBar(context, e.toString());
      print("From Group" + e.toString());
    }
  }

  //DeleteUserPost

  static DeleteUserPost(BuildContext context) async {
    try {
      var snap = await firestore.collection("posts").get();
      for (int i = 0; i < snap.docs.length; i++) {
        var snaps =
            await firestore.collection("posts").doc(snap.docs[i].id).get();

        for (int j = 0; j < snaps['Likes'.length]; j++) {
          if (getUser.uid == snaps['Likes'][j]) {
            await firestore.collection("posts").doc(snap.docs[i].id).update({
              "Likes": FieldValue.arrayRemove([getUser.uid])
            });
          }
        }
        var snaps1 = await firestore
            .collection("posts")
            .doc(snap.docs[i].id)
            .collection("comments")
            .get();
        for (int j = 0; j < snaps1.docs.length; j++) {
          var snaps2 = await firestore
              .collection("posts")
              .doc(snap.docs[i].id)
              .collection("comments")
              .doc(snaps1.docs[j].id)
              .get();
          for (int k = 0; k < snaps2['Likes'.length]; k++) {
            if (getUser.uid == snaps2['Likes'][k]) {
              await firestore
                  .collection("posts")
                  .doc(snap.docs[i].id)
                  .collection("comments")
                  .doc(snaps1.docs[j].id)
                  .update({
                "Likes": FieldValue.arrayRemove([getUser.uid])
              });
            }
          }
        }
      }
    } catch (e) {
      snackBar(context, e.toString());
      print("From Post" + e.toString());
    }
  }

  //DeletePostFromStorage
  static DeletePostFromStorage(BuildContext context) async {
    try {
      var data = await storage.ref("posts").getMetadata();
      if (data.name == getUser.uid) {
        await storage.ref("posts").child("posts").child(getUser.uid).delete();
      }
      var data1 = await storage.ref("UserProfile").getMetadata();
      if (data1.name == getUser.uid) {
        await storage
            .ref("UserProfile")
            .child("UserProfile")
            .child(getUser.uid)
            .delete();
      }
    } catch (e) {
      snackBar(context, e.toString());
      print("From Storage" + e.toString());
    }
  }
}
