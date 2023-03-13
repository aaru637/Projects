import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Interests/Domain_Auth.dart';
import 'package:dgon/Posts/Comment_Screen.dart';
import 'package:dgon/Profile/Profile_Details.dart';
import 'package:dgon/Providers/User_Provider.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int CommentLength = 0;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => firebaseAuth.currentUser!;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
    // getSaved();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await firestore
          .collection("posts")
          .doc(widget.snap['PostID'])
          .collection("comments")
          .get();
      CommentLength = snap.docs.length;
    } catch (e) {
      snackBar(context, e.toString());
    }
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  // List<String> saved = [];
  // Future<void> getSaved() async {
  //   setState(() {});
  //   UserDatabase userDatabase = await GetUser.getUserDetails();
  //   int length = userDatabase.Saved!.length;
  //   for (int i = 0; i < length; i++) {
  //     saved.add(userDatabase.Saved![i]);
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final UserDatabase user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(right: 0),
          child: Row(
            children: [
              widget.snap['ProfileImage'] == ""
                  ? InkWell(
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile_icon.png"),
                        radius: 16,
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Profile_Details(uid: widget.snap['uid']))),
                    )
                  : InkWell(
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.snap['ProfileImage']),
                        radius: 16,
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Profile_Details(uid: widget.snap['uid']))),
                    ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: ListTile(
                    title: InkWell(
                      child: Text(widget.snap['Username']),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Profile_Details(uid: widget.snap['uid']))),
                    ),
                    subtitle: Text(widget.snap['GroupName']),
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     showDialog(
              //         context: context,
              //         builder: (context) => Dialog(
              //               child: ListView(
              //                 padding: const EdgeInsets.symmetric(vertical: 10),
              //                 shrinkWrap: true,
              //                 children: ['Delete']
              //                     .map(
              //                       (e) => InkWell(
              //                         child: Container(
              //                           padding: const EdgeInsets.symmetric(
              //                               vertical: 12),
              //                           child: Text(e),
              //                         ),
              //                       ),
              //                     )
              //                     .toList(),
              //               ),
              //             ));
              //   },
              //   icon: const Icon(Icons.more_vert),
              // ),
            ],
          ),
        ), //ImageSection
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.39,
            width: double.infinity,
            child: Image.network(
              widget.snap['PostUrl'],
              fit: BoxFit.fill,
            ),
          ),
        ),

        Row(
          children: [
            IconButton(
              onPressed: () async {
                await Domain_Auth.LikePost(
                    widget.snap['PostID'], user.uid!, widget.snap['Likes']);
              },
              icon: widget.snap['Likes'].contains(user.uid)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                    ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommentScreen(
                        snap: widget.snap,
                      ))),
              icon: const Icon(
                Icons.comment_outlined,
              ),
            ),
            // Expanded(
            //     child: Align(
            //   alignment: Alignment.bottomRight,
            //   child: IconButton(
            //     onPressed: () async {
            //       getSaved();
            //       await Domain_Auth.SavePost(
            //           widget.snap['PostID'], user.uid!, saved);
            //       getSaved();
            //     },
            //     icon: saved.isEmpty
            //         ? const Icon(Icons.bookmark_border)
            //         : saved.contains(widget.snap['PostID'])
            //             ? const Icon(
            //                 Icons.bookmark,
            //                 color: Colors.red,
            //               )
            //             : const Icon(Icons.bookmark_border),
            //   ),
            // ))
          ],
        ),
        //Description
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                child: Text("${widget.snap['Likes'].length} Likes"),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "${widget.snap['Username']} ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.snap['Description'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentScreen(
                          snap: widget.snap,
                        ))),
                child: Text(
                  "View all ${CommentLength} Comments",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMd()
                      .format(widget.snap['DatePublished'].toDate()),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
