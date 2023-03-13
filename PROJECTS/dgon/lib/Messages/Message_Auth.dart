import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/Domain_Database.dart';
import 'package:dgon/Database_Model/Message_Database.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Message_Auth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => firebaseAuth.currentUser!;

  //SendMessages
  static SendMessages(
      String Groupname,
      String SenderID,
      String Sender,
      String MessageType,
      String Message,
      String Genre,
      BuildContext context) async {
    try {
      String ChatID = const Uuid().v1();
      MessageDatabase messageDatabase = MessageDatabase(
          MessageID: ChatID,
          GroupName: Groupname,
          SenderID: SenderID,
          Sender: Sender,
          MessageType: MessageType,
          Message: Message,
          Sent: DateTime.now());
      await firestore
          .collection("groups")
          .doc("Entertainment")
          .collection(Genre)
          .doc(Groupname)
          .collection("chats")
          .doc(ChatID)
          .set(messageDatabase.toJson());
      await firestore
          .collection("groups")
          .doc("Entertainment")
          .collection(Genre)
          .doc(Groupname)
          .update(
        {"LastMessage": Message, "LastDate": DateTime.now()},
      );
    } catch (e) {
      snackBar(context, e.toString());
    }
  }

  //SendMessages

  static DeleteMessages(String Groupname, String ChatID, String Genre,
      BuildContext context) async {
    try {
      await firestore
          .collection("groups")
          .doc("Entertainment")
          .collection(Genre)
          .doc(Groupname)
          .collection("chats")
          .doc(ChatID)
          .delete();
    } catch (e) {
      snackBar(context, e.toString());
    }
  }
}
