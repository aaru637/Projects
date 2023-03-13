import 'package:dgon/Login/Forgot_Username_Otp.dart';
import 'package:dgon/Login/Login_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:dgon/Screens/Home.dart';
import 'package:dgon/Register/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dgon/main.dart';
import 'Login_Otp.dart';

class Login extends StatefulWidget {
  static String verify = "";
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                ),
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Welcome Back 👋",
                            style: TextStyle(
                              fontSize: 38,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        // Image View
                        Image.asset(
                          "assets/images/sign.jpg",
                          width: 150,
                          height: 150,
                          fit: BoxFit.fill,
                        ),

                        const SizedBox(
                          height: 35,
                        ),

                        // Username Field
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
                            controller: username,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              suffixIcon: const Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                              labelText: "Username",
                              labelStyle: TextStyle(
                                  color:
                                      const Color(0xFF978383).withOpacity(0.9)),
                              filled: true,
                              fillColor: const Color(0xFFF1ECEC),
                            ),
                            validator: (user) {
                              if (user == null || user.isEmpty) {
                                return "Please Enter Your username";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // Mobile Field
                        Container(
                          margin: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 60,
                                child: TextFormField(
                                  readOnly: true,
                                  style: const TextStyle(
                                    fontFamily: 'Cambria',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF1ECEC),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            width: 0, style: BorderStyle.none)),
                                  ),
                                  controller: countrycode,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.only(top: 15),
                                child: TextFormField(
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF1ECEC),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            width: 0, style: BorderStyle.none)),
                                    suffixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                    hintText: "Phone no",
                                    hintStyle: TextStyle(
                                        color: const Color(0xFF978383)
                                            .withOpacity(0.9)),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Cambria',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLength: 10,
                                  controller: mobile,
                                  keyboardType: TextInputType.phone,
                                  validator: (phonev) {
                                    if (phonev == null || phonev.isEmpty) {
                                      return "Please Enter Your Phone No";
                                    } else if (phonev.length != 10) {
                                      return "It's not a valid Mobile Number";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              )),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () async {
                              if (mobile.text.isNotEmpty &&
                                  countrycode.text.isNotEmpty) {
                                setState(() => isLoading = true);
                                try {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                      phoneNumber:
                                          countrycode.text + mobile.text,
                                      timeout: const Duration(seconds: 30),
                                      verificationCompleted:
                                          (PhoneAuthCredential
                                              credential) async {
                                        snackBar(context, "Auth Completed");
                                        await FirebaseAuth.instance
                                            .signInWithCredential(credential);
                                      },
                                      verificationFailed:
                                          (FirebaseAuthException e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snackBar(context, e.message!);
                                      },
                                      codeSent: (String verificationId,
                                          int? resendToken) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snackBar(context, "Code Sent!");
                                        Login.verify = verificationId;
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Forgot_Username_Otp(
                                                      mobile: countrycode.text +
                                                          mobile.text,
                                                    )));
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snackBar(context, "TimeOut!");
                                      });
                                } on FirebaseAuthException catch (e) {
                                  snackBar(context, e.code);
                                }
                              } else {
                                snackBar(context,
                                    "Please Enter Your Mobile Number.");
                              }
                            },
                            child: const Text(
                              "Forgot Username?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Cambria",
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blue),
                            ),
                          ),
                        ),

                        // Sign In Button

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              String result = await Phone_Auth.searchUsername(
                                  username: username.text,
                                  mobile: countrycode.text + mobile.text);
                              if (result == "true") {
                                setState(() => isLoading = true);
                                try {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                      phoneNumber:
                                          countrycode.text + mobile.text,
                                      timeout: const Duration(seconds: 30),
                                      verificationCompleted:
                                          (PhoneAuthCredential
                                              credential) async {
                                        snackBar(context, "Auth Completed");
                                        await FirebaseAuth.instance
                                            .signInWithCredential(credential);
                                      },
                                      verificationFailed:
                                          (FirebaseAuthException e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snackBar(context, e.message!);
                                      },
                                      codeSent: (String verificationId,
                                          int? resendToken) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snackBar(context, "Code Sent!");
                                        Login.verify = verificationId;
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                                builder: (context) => Login_Otp(
                                                      user: username.text,
                                                    )));
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snackBar(context, "TimeOut!");
                                      });
                                } on FirebaseAuthException catch (e) {
                                  snackBar(context, e.code);
                                }
                              } else {
                                snackBar(context,
                                    "You are not registered with us...");
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                fontSize: 20),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // Sign in with google and facebook line

                        const Text(
                          "Sign In using on the following Method",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Cambria',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),

                        // Social Media Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google Icon
                            Container(
                              padding: EdgeInsets.only(
                                top: 20,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  bool res = await googleLogin_Auth
                                      .googleSignInUser(context: context);
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (!mounted) {
                                    return;
                                  }
                                  if (res == false) {
                                    setState(() => isLoading = false);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Home()));
                                    snackBar(context,
                                        "Logged in as ${googleLogin_Auth.user.email}");
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    snackBar(context,
                                        "You are not registered with us.");
                                    googleLogin_Auth.googleSignOut(
                                        context: context);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape:
                                      const CircleBorder(side: BorderSide.none),
                                ),
                                child: Image.asset(
                                  "assets/images/google_logo.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),

                            // // Facebook Icon
                            // Container(
                            //   padding: EdgeInsets.only(
                            //     top: 20,
                            //     left: ((MediaQuery.of(context).size.width)) / 8,
                            //   ),
                            //   child: ElevatedButton(
                            //     onPressed: () {
                            //       print("Facebook");
                            //     },
                            //     style: ElevatedButton.styleFrom(
                            //       primary: Colors.white,
                            //       shape:
                            //           const CircleBorder(side: BorderSide.none),
                            //     ),
                            //     child: Image.asset(
                            //       "assets/images/facebook_logo.png",
                            //       width: 40,
                            //       height: 40,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Register Button
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Cambria",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              TextButton(
                                child: const Text(
                                  "Click Here",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Cambria",
                                      fontSize: 20,
                                      color: Colors.blue),
                                ),
                                onPressed: () {
                                  print("Register Button");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
