import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Interests/Domain_Auth.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:dgon/Database_Model/Domain_Database.dart' as domain;

class Select_Domain_Group extends StatefulWidget {
  const Select_Domain_Group({Key? key}) : super(key: key);

  @override
  State<Select_Domain_Group> createState() => _Select_Domain_GroupState();
}

class _Select_Domain_GroupState extends State<Select_Domain_Group> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  List<String> groupNames = [];

  List<String> groupProfile = [];

  String Sub_Group = "";

  getDetails() async {
    setState(() {
      isLoading = true;
    });
    UserDatabase userDatabase = await GetUser.getUserDetails();

    String Sub_Group = userDatabase.Sub_Group!;

    for (int i = 0; i < userDatabase.Groups!.length; i++) {
      groupNames.add(userDatabase.Groups![i]);

      domain.DomainDatabase data = await Domain_Auth.getGroupData(
          Group: userDatabase.Groups![i], Sub_category: Sub_Group);

      groupProfile.add(data.ProfileImage!);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()));
                },
              ),
              title: const Text(
                "Select Domain",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: false,
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: groupNames.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Card(
                              elevation: 15.0,
                              clipBehavior: Clip.hardEdge,
                              color: const Color.fromARGB(255, 212, 212, 212),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(groupProfile[index]),
                                ),
                                title: Text(groupNames[index]),
                                subtitle: Text(Sub_Group),
                                trailing: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                    ),
                                    onPressed: () {},
                                    child: const Text("Select"),
                                  ),
                                ),
                              )),
                        );
                      }),
                ),
              ],
            ),
          );
  }
}
