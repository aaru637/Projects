import 'package:dgon/Login/Forgot_Username_Email.dart';
import 'package:dgon/Login/Login.dart';
import 'package:dgon/Login/Login_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Forgot_Username_Otp extends StatefulWidget {
  final String mobile;
  const Forgot_Username_Otp({Key? key, required this.mobile}) : super(key: key);

  @override
  State<Forgot_Username_Otp> createState() => _Forgot_Username_OtpState();
}

class _Forgot_Username_OtpState extends State<Forgot_Username_Otp> {
  final FirebaseAuth authentication = FirebaseAuth.instance;
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
                      "Phone Verification",
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
                      "We need to verify your phone no before getting Started!",
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

                // OTP Field

                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Pinput(
                    // defaultPinTheme: defaultPinTheme,
                    // focusedPinTheme: focusedPinTheme,
                    // submittedPinTheme: submittedPinTheme,
                    onChanged: (value) {
                      setState(() {
                        code = value;
                        print("PinPut Code : ${code}");
                      });
                    },
                    length: 6,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // Sign In Button

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () async {
                    try {
                      UserCredential userCredential =
                          await authentication.signInWithCredential(
                        PhoneAuthProvider.credential(
                            verificationId: Login.verify, smsCode: code),
                      );
                      if (userCredential.additionalUserInfo!.isNewUser) {
                        snackBar(context, "You are not registered with us");
                      } else {
                        String username1 = await Phone_Auth.getUserData(
                            uid: userCredential.user!.uid);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Forgot_Username_Email(
                                user: username1, mobile: widget.mobile)));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "invalid-verification-code") {
                        snackBar(context, "OTP is Incorrect");
                      } else {
                        snackBar(context, e.code);
                      }
                    }
                  },
                  child: const Text(
                    "Verify Phone Number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cambria',
                        fontSize: 20),
                  ),
                ),

                // Edit Phone Field
                Container(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: TextButton(
                    child: const Text(
                      "Edit Phone Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Cambria",
                          fontSize: 16,
                          color: Colors.green),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
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
