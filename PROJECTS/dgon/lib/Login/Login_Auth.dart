import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dgon/Database_Model/User_Database.dart' as model;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Reusable_Widgets/Reusable.dart';

class googleLogin_Auth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

//GetCurrentUser
  static User get user => firebaseAuth.currentUser!;
  static Future<bool> googleSignInUser({required BuildContext context}) async {
    bool res = false;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          user.delete();
          res = true;
        }
        return res;
      } else {
        res = false;
        return res;
      }
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.code);
    }
    return res;
  }

//SignoutGoogleUser
  static Future<void> googleSignOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      snackBar(context, e.toString());
    }
  }
}

// Phone Auth
class Phone_Auth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => firebaseAuth.currentUser!;
  //SearchUsername
  static Future<String> searchUsername(
      {required String username, required String mobile}) async {
    String flag = "false";
    try {
      final querysnap = await firestore.collection("users").get();
      for (var i = 0; i < querysnap.docs.length; i++) {
        if (username == querysnap.docs[i]['Username']) {
          if (mobile == querysnap.docs[i]["Mobile"]) {
            flag = "true";
            return flag;
          }
        } else {
          continue;
        }
      }
    } catch (e) {
      return flag;
    }
    return flag;
  }

  //GetUserdata
  static Future<model.UserDatabase> getUserDetails() async {
    User currentUser = firebaseAuth.currentUser!;
    DocumentSnapshot snapshot =
        await firestore.collection("users").doc(currentUser.uid).get();
    return model.UserDatabase.fromJson(snapshot);
  }

  static Future<String> getUserData({required String uid}) async {
    String user = "";
    final querysnap = await firestore.collection("users").get();
    String flag = "false";
    for (var i = 0; i < querysnap.docs.length; i++) {
      if (uid == querysnap.docs[i]["uid"]) {
        user = querysnap.docs[i]['username'];
        print(querysnap.docs[i]['username']);
        return user;
      } else {
        continue;
      }
    }
    return user;
  }
}
