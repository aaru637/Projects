import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/Post_Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //AddImageTostorage
  static Future<String> uploadPost(
      String child, Uint8List file, bool isPost) async {
    Reference ref = storage
        .ref()
        .child("posts")
        .child(child)
        .child(firebaseAuth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  static Future<String> uploadProfile(
      String child, Uint8List file, bool isPost) async {
    Reference ref = storage
        .ref()
        .child("UserProfile")
        .child(child)
        .child(firebaseAuth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }
}

class UploadPost {
  static Future<String> post1(String Description, String uid, String Username,
      String ProfileImage, Uint8List files, String GroupName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String res = "Some error Occured";
    try {
      String PostID = const Uuid().v1();
      String photUrl = await StorageMethods.uploadPost('posts', files, true);
      PostDatabase post = PostDatabase(
          uid: uid,
          PostID: PostID,
          Username: Username,
          GroupName: GroupName,
          ProfileImage: ProfileImage,
          PostUrl: photUrl,
          DatePublished: DateTime.now(),
          Description: Description,
          Likes: []);
      await firestore.collection("posts").doc(PostID).set(post.toJson());
      res = "Success";
      return res;
    } catch (e) {
      return res;
    }
  }
}
