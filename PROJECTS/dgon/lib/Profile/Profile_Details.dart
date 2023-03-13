import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Login/Login.dart';
import 'package:dgon/Posts/PostCard.dart';
import 'package:dgon/Posts/View_Post.dart';
import 'package:dgon/Profile/Edit_Profile.dart';
import 'package:dgon/Profile/Follow_Button.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile_Details extends StatefulWidget {
  final String uid;
  const Profile_Details({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile_Details> createState() => _Profile_DetailsState();
}

class _Profile_DetailsState extends State<Profile_Details> {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => firebaseAuth.currentUser!;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  bool isYou = false;
  bool isLoading = false;

  var userData = {};

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var user1 = await firestore.collection("users").doc(widget.uid).get();
      userData = user1.data()!;
      var post =
          firestore.collection("posts").where('uid', isEqualTo: user.uid);
      if (!mounted) {
        return;
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      snackBar(context, e.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPost() async {
    setState(() {
      isLoading = true;
    });
    var snap =
        firestore.collection("posts").where("uid", isEqualTo: widget.uid).get();
    setState(() {
      isLoading = false;
    });
    return snap;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                userData['Username'],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.green,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userData['PhotoUrl'] == ""
                              ? const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(
                                      "assets/images/profile_icon.png"),
                                  radius: 45,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                    userData['PhotoUrl'],
                                  ),
                                  radius: 45,
                                ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      child: Text(
                                        userData['FullName'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      user.uid == widget.uid
                                          ? Follow_Button(
                                              text: "Edit Profile",
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              borderColor: Colors.green,
                                              function: () =>
                                                  Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Edit_Profile(
                                                    snap: userData,
                                                    isYou: true,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Follow_Button(
                                              text: "View Profile",
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              borderColor: Colors.green,
                                              function: () =>
                                                  Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Edit_Profile(
                                                    snap: userData,
                                                    isYou: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['Username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          userData['Bio'],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: getPost(),
                  builder: ((context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: ((context, index) {
                        DocumentSnapshot snap = snapshot.data!.docs[index];
                        return Container(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => View_Post(
                                  snap: snapshot.data!.docs[index].data(),
                                ),
                              ),
                            ),
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Image(
                                    image: NetworkImage(
                                      snap['PostUrl'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ],
            ),
          );
  }
}
