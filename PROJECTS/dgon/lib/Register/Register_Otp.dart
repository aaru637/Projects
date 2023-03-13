import 'package:dgon/Interests/Preferences.dart';
import 'package:dgon/Register/Register.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:dgon/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Register_Otp extends StatefulWidget {
  final String user;
  final String mobile;
  final String fullName;
  const Register_Otp(
      {Key? key,
      required this.user,
      required this.mobile,
      required this.fullName})
      : super(key: key);

  @override
  State<Register_Otp> createState() => _Register_OtpState();
}

class _Register_OtpState extends State<Register_Otp> {
  final FirebaseAuth authentication = FirebaseAuth.instance;
  String user = "";
  String mobile = "";
  String fullName = "";
  var code = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
    mobile = widget.mobile;
    fullName = widget.fullName;
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
                            verificationId: Register.verify, smsCode: code),
                      );
                      if (userCredential.additionalUserInfo!.isNewUser) {
                        bool result = await RegisterPhoneAuth.storeUser(
                            userCredential: userCredential,
                            fullName: fullName,
                            username: user,
                            mobile: mobile);
                        if (!mounted) {
                          return;
                        }
                        if (result == true) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Preferences()));
                        } else {
                          snackBar(context, "Error Occured.Try Again.");
                        }
                      } else {
                        snackBar(context,
                            "Mobile Number already Registered with us. Go and Login.");
                        Navigator.pop(context);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "invalid-verification-code") {
                        snackBar(context, "OTP is Incorrect");
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
                      Navigator.pop(context);
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
