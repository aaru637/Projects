import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Groups_Messages/Group_Details.dart';
import 'package:dgon/Messages/Message_Auth.dart';
import 'package:dgon/Profile/Profile_Details.dart';
import 'package:dgon/Providers/User_Provider.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Chat_Page extends StatefulWidget {
  final snap;
  const Chat_Page({Key? key, this.snap}) : super(key: key);

  @override
  State<Chat_Page> createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {
  late var snap;

  TextEditingController messageController = TextEditingController();
  ScrollController controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    snap = widget.snap;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Group_Details(
                        snap: snap,
                      ))),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.snap['ProfileImage']),
                radius: 18,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Group_Details(
                        snap: snap,
                      ))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.snap['Name'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ))
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("groups")
                    .doc("Entertainment")
                    .collection(widget.snap['Genre'])
                    .doc(widget.snap['Name'])
                    .collection("chats")
                    .orderBy("Sent", descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No Messages Found..."),
                    );
                  } else {
                    return ListView.builder(
                      reverse: true,
                      controller: controller,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Align(
                          heightFactor: 1.4,
                          alignment: snapshot.data!.docs[index]["SenderID"] ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.topLeft,
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4, bottom: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profile_Details(
                                                    uid: FirebaseAuth.instance
                                                        .currentUser!.uid))),
                                    child: Text(
                                      snapshot.data!.docs[index]['Sender'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: snapshot.data!.docs[index]
                                                      ["SenderID"] ==
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                              ? Colors.green
                                              : Colors.blue),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      AlertDialog(
                                        actions: [
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Message_Auth.DeleteMessages(
                                                      snapshot.data!.docs[index]
                                                          ['GroupName'],
                                                      snapshot.data!.docs[index]
                                                          ['MessageID'],
                                                      widget.snap['Genre'],
                                                      context);
                                                },
                                                child: Text("Delete"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancel"),
                                              )
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    child: Text(
                                        "${snapshot.data!.docs[index]['Message']}"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  }
                },
              ),
            ),
            Bottom(context),
          ],
        ),
      ),
    );
  }

  Widget Bottom(BuildContext context) {
    final UserDatabase userDatabase =
        Provider.of<UserProvider>(context).getUser;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(50)),
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: "Type Your Message Here...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(right: 30),
            child: InkWell(
              onTap: () {
                if (messageController.text.isNotEmpty) {
                  Message_Auth.SendMessages(
                      widget.snap['Name'],
                      FirebaseAuth.instance.currentUser!.uid,
                      userDatabase.Username!,
                      "text",
                      messageController.text,
                      widget.snap['Genre'],
                      context);
                  FocusScope.of(context).unfocus();
                  messageController.clear();

                  controller.jumpTo(controller.position.maxScrollExtent);
                } else {
                  FocusScope.of(context).unfocus();
                  snackBar(context, "Server Error. Try Again Later.");
                }
              },
              child: Image.asset(
                "assets/images/sent.png",
                fit: BoxFit.fill,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
