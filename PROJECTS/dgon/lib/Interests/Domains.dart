import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Interests/Domain_Auth.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:dgon/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dgon/Database_Model/Domain_Database.dart' as domain;

class Domains extends StatefulWidget {
  final String Category;
  final String Sub_Category;
  const Domains({Key? key, required this.Category, required this.Sub_Category})
      : super(key: key);

  @override
  State<Domains> createState() => _DomainsState();
}

class _DomainsState extends State<Domains> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  String username = "";

  List<String> values = [];
  Future<int> getCount() async {
    UserDatabase user = await GetUser.getUserDetails();
    return user.GroupCount!;
  }

  int count = 4;

  List<String> Selected = [];
  Future<void> getData() async {
    values = await Domain_Auth.getDomainData(
        Category: widget.Category,
        Sub_Category: widget.Sub_Category,
        context: context);
    for (int i = 0; i < values.length; i++) {
      Selected.add("true");
    }
    setState(() {
      this.values = values;
    });
  }

  Widget Builder() {
    return Expanded(
      child: StreamBuilder(
          stream: firestore
              .collection("groups")
              .doc(widget.Category)
              .collection(widget.Sub_Category)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Card(
                        elevation: 15.0,
                        clipBehavior: Clip.hardEdge,
                        color: const Color.fromARGB(255, 212, 212, 212),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]["ProfileImage"]),
                          ),
                          title: Text(snapshot.data!.docs[index]["Name"]),
                          subtitle: Text(widget.Sub_Category),
                          trailing: Container(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Selected[index] == "true"
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              onPressed: () async {
                                if (Selected[index] == "true") {
                                  bool status =
                                      await Domain_Auth.updateGroupData(
                                    Group: snapshot.data!.docs[index]["Name"],
                                    index: index,
                                    Category: widget.Category,
                                    Sub_Category: widget.Sub_Category,
                                  );
                                  if (status) {
                                    setState(() {
                                      Selected[index] = "false";
                                    });
                                  } else {
                                    snackBar(context,
                                        "Your Group Count Limit was exceeded");
                                  }
                                } else {
                                  bool status =
                                      await Domain_Auth.deleteGroupData(
                                    Group: snapshot.data!.docs[index]["Name"],
                                    index: index,
                                    Category: widget.Category,
                                    Sub_Category: widget.Sub_Category,
                                  );
                                  if (status) {
                                    setState(() {
                                      Selected[index] = "true";
                                    });
                                  } else {
                                    snackBar(
                                        context, "Error Occured. Try Again");
                                  }
                                }
                              },
                              child: Selected[index] == "true"
                                  ? Text("Join")
                                  : Text("Joined"),
                            ),
                          ),
                        )),
                  );
                });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                top: 20, left: MediaQuery.of(context).size.width / 20),
            child: const Text(
              "Select Your Domain",
              style: TextStyle(
                fontSize: 26,
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                top: 20, left: MediaQuery.of(context).size.width / 18),
            child: const Text(
              "Click Join to Start Conversation.",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A8A8A),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                top: 20, left: MediaQuery.of(context).size.width / 18),
            child: const Text(
              "You may join Maximum 4 Domains in a Genre.",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                color: Color(0xFF3C79F5),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Builder(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 20,
        onPressed: () async {
          count = await getCount();
          print("Count = $count");
          if (count == 4) {
            snackBar(context, "Join Atleast One Domain to Continue.");
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Home()));
          }
        },
        label: const Text(
          "Complete",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
