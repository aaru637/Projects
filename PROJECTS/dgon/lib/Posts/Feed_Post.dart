import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Login/Login.dart';
import 'package:dgon/Posts/PostCard.dart';
import 'package:dgon/Providers/User_Provider.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Settings/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed_Post extends StatefulWidget {
  const Feed_Post({Key? key}) : super(key: key);

  @override
  State<Feed_Post> createState() => _Feed_PostState();
}

class _Feed_PostState extends State<Feed_Post> {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  addData() async {
    setState(() {
      isLoading = true;
    });
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;

  // Future<void> getCount() async {
  //   UserDatabase user1 = await GetUser.getUserDetails();
  //   if (user1.GroupCount! == 4) {
  //     await firebaseAuth.currentUser!.delete();
  //     await firestore.collection("users").doc(user1.uid).delete();
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const Login()));
  //   }
  // }

  List<String> groupNames = [];

  Future<void> getDetails() async {
    setState(() {
      isLoading = true;
    });
    UserDatabase userDatabase = await GetUser.getUserDetails();

    for (int i = 0; i < userDatabase.Groups!.length; i++) {
      groupNames.add(userDatabase.Groups![i]);
    }

    setState(() {
      groupNames;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
    // getCount();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: false,
              title: const Text("Dgon"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Setting()));
                  },
                )
              ],
            ),
            body: StreamBuilder(
              stream: firestore
                  .collection("posts")
                  .where(
                    'GroupName',
                    whereIn: groupNames,
                  )
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text("No Post Found"),
                    );
                  }
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        PostCard(snap: snapshot.data!.docs[index].data()));
              },
            ),
            backgroundColor: Colors.black12,
          );
  }
}
