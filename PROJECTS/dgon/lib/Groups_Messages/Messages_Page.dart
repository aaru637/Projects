// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Interests/Domain_Auth.dart';
import 'package:dgon/Groups_Messages/Chat_Page.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dgon/Database_Model/Domain_Database.dart' as domain;
import 'package:intl/intl.dart';

class Messages_Page extends StatefulWidget {
  const Messages_Page({Key? key}) : super(key: key);

  @override
  State<Messages_Page> createState() => _Messages_PageState();
}

class _Messages_PageState extends State<Messages_Page> {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => firebaseAuth.currentUser!;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: firestore.collection("users").doc(user.uid).snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return StreamBuilder(
                    stream: firestore
                        .collection("groups")
                        .doc("Entertainment")
                        .collection(snapshot.data!['Sub_Group'])
                        .doc(snapshot.data!['Groups'][index])
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot1) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Chat_Page(
                                        snap: snapshot1.data,
                                      ),
                                    ),
                                  ),
                                  splashColor: Colors.green,
                                  child: Card(
                                    color: Colors.grey.shade300,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  snapshot1
                                                      .data!['ProfileImage']),
                                              radius: 20,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Text(
                                                    snapshot1.data!['Name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        letterSpacing: 0.2,
                                                        wordSpacing: 1.5,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  child: Text(
                                                    snapshot1
                                                        .data!['LastMessage'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors
                                                            .grey.shade900),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  (DateTime.now().difference(
                                                                  snapshot1
                                                                      .data![
                                                                          'LastDate']
                                                                      .toDate()))
                                                              .inMinutes >
                                                          59
                                                      ? "${(DateTime.now().difference(snapshot1.data!['LastDate'].toDate())).inHours} Hours ago"
                                                      : "${(DateTime.now().difference(snapshot1.data!['LastDate'].toDate())).inMinutes} Minutes Ago",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      letterSpacing: -0.2,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Colors.grey.shade900),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                // Container(
                                                //   width: 18,
                                                //   height: 18,
                                                //   decoration:
                                                //       const BoxDecoration(
                                                //     color: Colors.blue,
                                                //     shape: BoxShape.circle,
                                                //   ),
                                                //   child: const Center(
                                                //     child: Text(
                                                //       "1",
                                                //       style: TextStyle(
                                                //           fontSize: 10,
                                                //           color: Colors.white),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                      }
                    },
                  );
                }
              },
              itemCount: snapshot.data!['Groups'].length,
            );
          }
        },
      ),
    );
  }
}
