import 'package:dgon/Interests/Preferences.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Register/Register_Otp.dart';
import 'package:dgon/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Reusable_Widgets/Reusable.dart';
import '../Login/Login_Otp.dart';

class Register extends StatefulWidget {
  static String verify = "";
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController countrycode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }

  bool isLoading = false;
  late User? user;
  IconData icon = Icons.done_outline_rounded;
  var count = 1;

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
                  backgroundColor: Colors.transparent,
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
                        const Text(
                          "Create Account 🔥",
                          style: TextStyle(
                            fontSize: 38,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        // Image View
                        Image.asset(
                          "assets/images/sign.jpg",
                          width: 90,
                          height: 90,
                          fit: BoxFit.fill,
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        // Full Name Field
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
                            controller: fullname,
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
                              labelText: "Full Name",
                              labelStyle: TextStyle(
                                  color:
                                      const Color(0xFF978383).withOpacity(0.9)),
                              filled: true,
                              fillColor: const Color(0xFFF1ECEC),
                            ),
                            validator: (user) {
                              if (user == null || user.isEmpty) {
                                return "Please Enter Your Full Name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 20,
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
                            onChanged: (value) async {
                              if (value.length > 8) {
                                String result = await googleRegister_Auth
                                    .searchUsername(value);
                                if (!mounted) {
                                  return;
                                }
                                setState(() {
                                  icon = Icons.cancel;
                                  count = 1;
                                });
                                if (result == "true") {
                                  if (!mounted) {
                                    return;
                                  }
                                  setState(() {
                                    icon = Icons.cancel;
                                    count = 1;
                                    snackBar(
                                        context, "Username already exists");
                                  });
                                } else {
                                  setState(() {
                                    icon = Icons.done_outline_rounded;
                                    count = 0;
                                  });
                                }
                              } else {
                                setState(() {
                                  icon = Icons.cancel;
                                  count = 1;
                                });
                              }
                            },
                            controller: username,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              suffixIcon: Icon(
                                icon,
                                color: icon == Icons.cancel
                                    ? Colors.red
                                    : Colors.green,
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
                              } else if (user.length < 8) {
                                return "Username must be greater than 8 Characters";
                              }
                              {
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
                                width: 50,
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

                        // Sign Up Button

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (count == 0) {
                                if (!mounted) {
                                  return;
                                }
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
                                        if (!mounted) {
                                          return;
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snackBar(context, e.message!);
                                      },
                                      codeSent: (String verificationId,
                                          int? resendToken) {
                                        if (!mounted) {
                                          return;
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snackBar(context, "Code Sent!");
                                        Register.verify = verificationId;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register_Otp(
                                                      user: username.text,
                                                      mobile: countrycode.text +
                                                          mobile.text,
                                                      fullName:
                                                          fullname.text.trim(),
                                                    )));
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {
                                        if (!mounted) {
                                          return;
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                      });
                                  if (!mounted) {
                                    return;
                                  }
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  snackBar(context, e.code);
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                snackBar(context, "Username Already Exists");
                              }
                            } else {
                              if (!mounted) {
                                return;
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                fontSize: 20),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // Sign Up with google and facebook line

                        const Text(
                          "Sign Up using on the following Method",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Cambria',
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFB2B2B2),
                          ),
                        ),

                        // Social Media Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google Icon
                            Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (username.text.isEmpty) {
                                    snackBar(
                                        context, "Username Must Be Entered");
                                  } else {
                                    if (!mounted) {
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                    bool res = await googleRegister_Auth
                                        .googleSignUpUser(
                                            username: username.text,
                                            context: context);
                                    if (!mounted) {
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (res == true) {
                                      setState(() => isLoading = false);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Preferences()));
                                    } else {
                                      if (!mounted) {
                                        return;
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                      snackBar(context,
                                          "Account Already Exists. Go and Login.");
                                      googleRegister_Auth.googleSignOut(
                                          context: context);
                                    }
                                    if (!mounted) {
                                      return;
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
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
                            //     onPressed: () async {
                            //       if (username.text.isEmpty) {
                            //         snackBar(
                            //             context, "Username Must Be Entered");
                            //       } else {
                            //         setState(() {
                            //           isLoading = true;
                            //         });
                            //         bool res = await facebookRegister_Auth
                            //             .facebookSignUp(
                            //                 context: context,
                            //                 username: username.text);
                            //         setState(() {
                            //           isLoading = false;
                            //         });
                            //         if (res == true) {
                            //           setState(() => isLoading = false);
                            //           Navigator.of(context).pushReplacement(
                            //               MaterialPageRoute(
                            //                   builder: (context) => Home(
                            //                       user: facebookRegister_Auth
                            //                           .user)));
                            //           snackBar(context,
                            //               "Logged in as ${facebookRegister_Auth.user.email}");
                            //         } else {
                            //           setState(() {
                            //             isLoading = false;
                            //           });
                            //           snackBar(context,
                            //               "Account Already Exists. Go and Login.");
                            //           facebookRegister_Auth.facebookSignOut(
                            //               context: context);
                            //         }
                            //         setState(() {
                            //           isLoading = false;
                            //         });
                            //       }
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

                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),

                        // Register Button
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
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
                                  Navigator.pop(context);
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
