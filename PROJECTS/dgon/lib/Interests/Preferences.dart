import 'package:chips_choice/chips_choice.dart';
import 'package:dgon/Interests/Domains.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Preferences extends StatefulWidget {
  const Preferences({
    Key? key,
  }) : super(key: key);

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => FirebaseAuth.instance.currentUser!;
  List<String> category = [
    'Entertainment',
  ];
  List<String> sub_category = ['Sports', 'Cinema'];
  dynamic tags;
  dynamic tag;
  String Category = "";
  String Sub_Category = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: 20, left: MediaQuery.of(context).size.width / 20),
              child: const Text(
                "Welcome Dhineshkumar 👍",
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
                "Select One Category to Continue",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8A8A8A),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: 20, left: MediaQuery.of(context).size.width / 20),
              child: const Text(
                "Category",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Category
            ChipsChoice<int>.single(
              padding: const EdgeInsets.all(20),
              spacing: 20,
              wrapped: true,
              value: tag,
              onChanged: (val) => setState(() {
                tag = val;
                Category = category[tag];
              }),
              choiceItems: C2Choice.listFrom<int, String>(
                source: category,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              choiceCheckmark: true,
              choiceStyle: C2ChipStyle.filled(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 10, bottom: 10),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                height: 50,
                color: Colors.grey,
                borderWidth: 2,
                borderStyle: BorderStyle.solid,
                checkmarkColor: Colors.green,
                selectedStyle: const C2ChipStyle(
                  backgroundColor: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: 20, left: MediaQuery.of(context).size.width / 20),
              child: const Text(
                "Sub  Category",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ChipsChoice<int>.single(
              padding: const EdgeInsets.all(20),
              spacing: 40,
              wrapped: true,
              value: tags,
              onChanged: (val) => setState(() {
                tags = val;
                Sub_Category = sub_category[tags];
              }),
              choiceItems: C2Choice.listFrom<int, String>(
                source: sub_category,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              choiceCheckmark: true,
              choiceStyle: C2ChipStyle.filled(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.grey,
                height: 50,
                borderWidth: 2,
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 10, bottom: 10),
                borderStyle: BorderStyle.solid,
                selectedStyle: const C2ChipStyle(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 20,
          onPressed: () {
            if (Category.isNotEmpty && Sub_Category.isNotEmpty) {
              snackBar(context, "Thank you.");
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      Domains(Category: Category, Sub_Category: Sub_Category)));
            } else {
              snackBar(context,
                  "Please Select one Category and Sub Category to Continue.");
            }
          },
          label: const Text(
            "Next",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
