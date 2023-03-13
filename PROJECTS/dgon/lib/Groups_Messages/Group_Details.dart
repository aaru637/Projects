import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/Domain_Database.dart';
import 'package:dgon/Profile/Profile_Details.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class Group_Details extends StatefulWidget {
  final snap;
  const Group_Details({
    Key? key,
    this.snap,
  }) : super(key: key);

  @override
  State<Group_Details> createState() => _Group_DetailsState();
}

class _Group_DetailsState extends State<Group_Details> {
  bool isLoading = false;
  List<String> members = [];
  getMembers() async {
    setState(() {
      isLoading = true;
    });
    var snap = await FirebaseFirestore.instance
        .collection("groups")
        .doc("Entertainment")
        .collection(widget.snap['Genre'])
        .doc(widget.snap['Name'])
        .get();
    DomainDatabase database = DomainDatabase.fromJson(snap);
    print(database.Members);
    for (int i = 0; i < database.Members!.length; i++) {
      members.add(database.Members![i]);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor:
          const Color.fromARGB(255, 186, 223, 187).withOpacity(0.97),
      body: Column(
        children: [
          Center(
            child: Stack(children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['ProfileImage']),
                  radius: 70,
                ),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Text(
              widget.snap['Name'],
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                  wordSpacing: 1.5,
                  fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Text(
              widget.snap['Genre'],
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                  wordSpacing: 1.5,
                  fontSize: 15),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                snackBar(context, "Description Cannot Modify by Users.");
              },
              child: Card(
                  child: ListTile(
                title: Text(
                  widget.snap['Description'],
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                    "Created at ${DateFormat.yMMMd().format(widget.snap['DescriptionCreatedAt'].toDate()).toString()}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500)),
              )),
            ),
          ),
          const Divider(
            thickness: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "${widget.snap['MembersCount']} Members",
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                  wordSpacing: 1.5,
                  fontSize: 15),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where("uid", whereIn: members)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        return isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Card(
                                          color: const Color.fromARGB(
                                                  255, 186, 223, 187)
                                              .withOpacity(0.6),
                                          elevation: 5,
                                          clipBehavior: Clip.none,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                height: 20,
                                              ),
                                              snapshot.hasData
                                                  ? snapshot.data!.docs[index]
                                                              ['PhotoUrl'] ==
                                                          ""
                                                      ? InkWell(
                                                          child:
                                                              const CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    "assets/images/profile_icon.png"),
                                                            radius: 16,
                                                          ),
                                                          onTap: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Profile_Details(
                                                                      uid: snapshot
                                                                          .data!
                                                                          .docs[index]['uid']),
                                                            ),
                                                          ),
                                                        )
                                                      : InkWell(
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'PhotoUrl']),
                                                            radius: 16,
                                                          ),
                                                          onTap: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Profile_Details(
                                                                      uid: snapshot
                                                                          .data!
                                                                          .docs[index]['uid']),
                                                            ),
                                                          ),
                                                        )
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile_Details(
                                                            uid: snapshot.data!
                                                                    .docs[index]
                                                                ['uid']),
                                                  ),
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['FullName'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        letterSpacing: 0.2,
                                                        wordSpacing: 1.5,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                },
                                itemCount: snapshot.data!.size,
                              );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
