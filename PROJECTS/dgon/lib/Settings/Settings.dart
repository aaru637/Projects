import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Login/Login.dart';
import 'package:dgon/Providers/User_Provider.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Settings/Settings_Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isLoading = false;
  deleteUser() {
    setState(() {
      isLoading = true;
    });
    Settings_Auth.DeletePostFromStorage(context);
    Settings_Auth.DeleteUserPost(context);
    Settings_Auth.DeleteUserFromGroup(context);
    Settings_Auth.DeleteUserData(context);
    Settings_Auth.DeleteUser(context);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserDatabase userDatabase =
        Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.green,
        centerTitle: false,
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          const Text(
            "Settings",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              splashColor: Colors.green,
              onTap: () {},
              child: Card(
                color: Colors.white60,
                child: ListTile(
                  title: const Text("About Us"),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.error_outline,
                        color: Colors.green,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              splashColor: Colors.green,
              onTap: () {},
              child: Card(
                color: Colors.white60,
                child: ListTile(
                  title: const Text("Logout"),
                  trailing: IconButton(
                      onPressed: () {
                        if (userDatabase.Logged == "Google") {
                          googleRegister_Auth.googleSignOut(context: context);
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        } else {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        }
                      },
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: InkWell(
          //     splashColor: Colors.green,
          //     onTap: () {},
          //     child: Card(
          //       color: Colors.white60,
          //       child: ListTile(
          //         title: const Text("Delete Account"),
          //         trailing: IconButton(
          //             onPressed: () {
          //               deleteUser();
          //             },
          //             icon: const Icon(
          //               Icons.delete,
          //               color: Colors.red,
          //             )),
          //       ),
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
