import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Groups_Messages/Messages_Page.dart';
import 'package:dgon/Login/Login_Auth.dart';
import 'package:dgon/Posts/Add_Post.dart';
import 'package:dgon/Posts/Feed_Post.dart';
import 'package:dgon/Posts/Select_Domain.dart';
import 'package:dgon/Profile/Profile_Details.dart';
import 'package:dgon/Providers/User_Provider.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:dgon/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => firebaseAuth.currentUser!;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    page = 0;
  }

  late PageController pageController;
  void navigationTapped(int _page) {
    pageController.jumpToPage(_page);
  }

  void pageChanged(int _page) {
    setState(() {
      page = _page;
    });
  }

  int page = 0;
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UserDatabase user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        onPageChanged: pageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Feed_Post(),
          const Messages_Page(),
          const Select_Domain(),
          // const Center(child: Text("Notifications")),
          Profile_Details(
            uid: user.uid,
          ),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        border: const Border(),
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: page == 0 ? Colors.blue : Colors.grey,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: page == 1 ? Colors.blue : Colors.grey,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: page == 2 ? Colors.blue : Colors.grey,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.favorite,
          //     color: page == 3 ? Colors.blue : Colors.grey,
          //   ),
          //   backgroundColor: Theme.of(context).primaryColor,
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: page == 3 ? Colors.blue : Colors.grey,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
