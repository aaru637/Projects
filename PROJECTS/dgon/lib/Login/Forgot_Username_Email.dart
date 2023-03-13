import 'package:dgon/Login/Login.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Forgot_Username_Email extends StatefulWidget {
  final String user;
  final String mobile;
  const Forgot_Username_Email(
      {Key? key, required this.user, required this.mobile})
      : super(key: key);

  @override
  State<Forgot_Username_Email> createState() => _Forgot_Username_EmailState();
}

class _Forgot_Username_EmailState extends State<Forgot_Username_Email> {
  final FirebaseAuth authentication = FirebaseAuth.instance;
  String user = "";
  TextEditingController email = TextEditingController();
  var code = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.17,
        ),
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                // Image View
                Image.asset(
                  "assets/images/mobile_otp.jpg",
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),

                const SizedBox(
                  height: 30,
                ),

                // Phone Verification
                Container(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: const Text(
                      "Forgot Username",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Arial"),
                    )),

                const SizedBox(
                  height: 20,
                ),

                // Sub Text
                Container(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: const Text(
                      "Please Enter an email that is available to you, we will send your username to your email.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontFamily: "Cambria",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),

                const SizedBox(
                  height: 30,
                ),

                // Email Field
                Container(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: TextFormField(
                    style: const TextStyle(
                      fontFamily: 'Cambria',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: email,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      suffixIcon: const Icon(
                        Icons.mail,
                        color: Colors.green,
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: const Color(0xFF978383).withOpacity(0.9)),
                      filled: true,
                      fillColor: const Color(0xFFF1ECEC),
                    ),
                    validator: (user) {
                      if (user == null || user.isEmpty) {
                        return "Please Enter Your Email";
                      } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                          .hasMatch(user)) {
                        return "It is not a valid Email...";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // Send Email Button

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () async {
                    String username = "dgon4945@gmail.com";
                    String password = "kbhglowdzcylowid";
                    final smtpServer = gmail(username, password);
                    final message = Message()
                      ..from = Address(username)
                      ..recipients.add(email.text)
                      ..subject = "Forgot Username"
                      ..html =
                          "<p>Your Username is ${widget.user} and Your Mobile Number is ${widget.mobile}</p><h3> Thanks for Connecting With Us!<h3><p>Don't Reply to this Email</p>";
                    if (!mounted) {
                      return;
                    }
                    try {
                      final sendReport = await send(message, smtpServer);

                      snackBar(context, "Email Sent. Check Your Mail.");
                      print(widget.user);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    } on MailerException catch (e) {
                      snackBar(context, e.message);
                    }
                  },
                  child: const Text(
                    "Send Email",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cambria',
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
