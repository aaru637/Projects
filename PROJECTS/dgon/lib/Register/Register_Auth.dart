import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Reusable_Widgets/Reusable.dart';

//GoogleSignUpClass
class googleRegister_Auth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

//GetCurrentUser
  static User get user => firebaseAuth.currentUser!;
// GoogleSignUp User
  static Future<bool> googleSignUpUser(
      {required String username, required BuildContext context}) async {
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
          model.UserDatabase user = model.UserDatabase(
              FullName: userCredential.user!.displayName,
              Username: username,
              Mobile: userCredential.user!.phoneNumber ?? " ",
              Email: userCredential.user!.email,
              Logged: "Google",
              uid: userCredential.user!.uid,
              PhotoUrl: userCredential.user!.photoURL ?? " ",
              Groups: [],
              Sub_Group: "",
              GroupCount: 4,
              Bio: "");
          await firestore
              .collection("users")
              .doc(userCredential.user!.uid)
              .set(user.toJson());
          res = true;
          return res;
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

//SignOutUser
  static Future<void> googleSignOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      snackBar(context, e.toString());
    }
  }

//SearchUsername
  static Future<String> searchUsername(String username) async {
    String flag = "false";
    try {
      QuerySnapshot querysnap = await firestore.collection("users").get();
      if (querysnap.docs.isEmpty) {
        flag = "false";
        return flag;
      } else {
        for (var i = 0; i < querysnap.docs.length; i++) {
          if (username == querysnap.docs[i]['Username']) {
            flag = "true";
            return flag;
          } else {
            continue;
          }
        }
        return flag;
      }
    } catch (e) {
      return flag;
    }
  }

  //GetUserDetails

}

// FacebookSignUpClass
// class facebookRegister_Auth {
//   static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   static FirebaseFirestore firestore = FirebaseFirestore.instance;

//   //GetCurrentUser
//   static User get user => firebaseAuth.currentUser!;

// //UserSignUp
//   static Future<bool> facebookSignUp(
//       {required String username, required BuildContext context}) async {
//     bool res = false;
//     try {
//       final LoginResult result =
//           await FacebookAuth.instance.login(permissions: [
//         'email',
//         'public_profile',
//       ]);
//       print(result.status.toString());
//       switch (result.status) {
//         case LoginStatus.success:
//           final AuthCredential facebookCredential =
//               FacebookAuthProvider.credential(result.accessToken!.token);
//           final userCredential =
//               await firebaseAuth.signInWithCredential(facebookCredential);
//           User? user = userCredential.user;
//           if (user != null) {
//             if (userCredential.additionalUserInfo!.isNewUser) {
//               res = true;
//               firestore.collection("users").doc(username).set({
//                 'FullName': userCredential.user!.displayName,
//                 'email': userCredential.user!.email,
//                 'uid': userCredential.user!.uid,
//                 'username': username,
//                 "provider": userCredential.user!.providerData,
//               });
//             } else {
//               res = false;
//               return res;
//             }
//           }
//           break;
//         case LoginStatus.cancelled:
//           // snackBar(context, LoginStatus.values.toString());
//           return res;
//         case LoginStatus.failed:
//           snackBar(context, LoginStatus.values.toString());
//           return res;
//         default:
//           return res;
//       }
//     } on FirebaseAuthException catch (e) {
//       snackBar(context, e.message!);
//     }
//     return res;
//   }

//   //SignOutUser

//   static Future<void> facebookSignOut({required BuildContext context}) async {
//     try {
//       await FacebookAuth.instance.logOut();
//     } catch (e) {
//       snackBar(context, e.toString());
//     }
//   }
// }

// PhoneAuth
class RegisterPhoneAuth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => firebaseAuth.currentUser!;

//StoreUserData

  static Future<bool> storeUser(
      {required UserCredential userCredential,
      required String fullName,
      required String username,
      required String mobile}) async {
    bool res = false;
    User? user;

    try {
      user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          res = true;
          model.UserDatabase user = model.UserDatabase(
              FullName: fullName,
              Username: username,
              Mobile: userCredential.user!.phoneNumber,
              Email: userCredential.user!.email ?? " ",
              Logged: "Phone",
              uid: userCredential.user!.uid,
              PhotoUrl: userCredential.user!.photoURL ?? " ",
              Groups: [],
              Sub_Group: "",
              GroupCount: 4,
              Bio: "");
          await firestore
              .collection("users")
              .doc(userCredential.user!.uid)
              .set(user.toJson());
          res = true;
          return res;
        }
        return res;
      } else {
        res = false;
        return res;
      }
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //GetUserDetails

}

class GetUser {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<model.UserDatabase> getUserDetails() async {
    User currentUser = firebaseAuth.currentUser!;
    DocumentSnapshot snapshot =
        await firestore.collection("users").doc(currentUser.uid).get();
    return model.UserDatabase.fromJson(snapshot);
  }
}
