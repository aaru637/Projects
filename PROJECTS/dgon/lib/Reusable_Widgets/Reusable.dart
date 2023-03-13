import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void snackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<FirebaseApp> initialize() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}
