import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:dgon/Storage/Upload_Post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateProfileAuth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static User get user => firebaseAuth.currentUser!;
//UpdateProfileDetails
  static Future<bool> UpdateProfile(String Fullname, String Bio,
      String Username, Uint8List? ProfileImage) async {
    bool res = false;
    try {
      String PhotoUrl = await StorageMethods.uploadProfile(
          "UserProfile", ProfileImage!, false);
      await firestore.collection("users").doc(user.uid).update({
        "FullName": Fullname,
        "Bio": Bio,
        "Username": Username,
        "PhotoUrl": PhotoUrl
      });
      QuerySnapshot snapshot = await firestore.collection("posts").get();
      var snap;
      for (int i = 0; i < snapshot.docs.length; i++) {
        QuerySnapshot snap = await firestore
            .collection("posts")
            .doc(snapshot.docs[i].id)
            .collection("comments")
            .get();
        if (user.uid == snapshot.docs[i]['uid']) {
          await firestore
              .collection("posts")
              .doc(snapshot.docs[i].id)
              .update({"ProfileImage": PhotoUrl});
        } else {
          print("Error");
        }
        for (int j = 0; j < snap.docs.length; j++) {
          if (user.uid == snap.docs[j]['uid']) {
            await firestore
                .collection("posts")
                .doc(snapshot.docs[i].id)
                .collection("comments")
                .doc(snap.docs[j].id)
                .update({"ProfileImage": PhotoUrl});
          }
        }
      }
      res = true;
      return res;
    } catch (e) {
      print(e.toString());
      res = false;
    }

    return res;
  }

  static Future<bool> UpdateWithoutProfile(
      String Fullname, String Bio, String Username) async {
    bool res = false;
    try {
      await firestore.collection("users").doc(user.uid).update({
        "FullName": Fullname,
        "Bio": Bio,
        "Username": Username,
      });
      res = true;
      return res;
    } catch (e) {
      res = false;
    }

    return res;
  }
}
