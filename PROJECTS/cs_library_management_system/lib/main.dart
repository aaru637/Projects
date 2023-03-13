import 'package:flutter/material.dart';
import 'package:cs_library_management_system/DbConnection.dart';
import 'package:cs_library_management_system/Librarian/LibrarianDBHelper.dart';
import 'package:cs_library_management_system/Librarian/Register_Page.dart';
import 'package:cs_library_management_system/Home_Page.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbConnection.connect();
  runApp(const MaterialApp(
    home: Login_Page(),
  ));
}

class Login_Page extends StatelessWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CS LIBRARY MANAGEMENT SYSTEM',
            style: TextStyle(fontSize: 20, fontFamily: 'Cambria'),
          ),
          centerTitle: true,
          toolbarHeight: 70,
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(244, 214, 0, 100.0),
                    Color.fromRGBO(20, 255, 0, 100.0)
                  ]),
            ),
            child: const MYLOGINFORM(),
          ),
        ),
      ),
    );
  }
}

class MYLOGINFORM extends StatefulWidget {
  const MYLOGINFORM({Key? key}) : super(key: key);

  @override
  State<MYLOGINFORM> createState() => _MYLOGINFORMState();
}

class _MYLOGINFORMState extends State<MYLOGINFORM> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

  void customLoginToast(String message, BuildContext context) {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textPadding: EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.green,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: Duration(seconds: 5),
        context: context);
  }

  void customErrorToast(String message, BuildContext context) {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textPadding: EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.red,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: Duration(seconds: 5),
        context: context);
  }

  void navigator(String user, String pass) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home_Page(
                  username: user,
                  password: pass,
                  // username: "dk1234",
                  // password: 'Dhinesh@638',
                )));
  }

  Future searchData(String username, String password) async {
    String dataReceived =
        await LibrarianDBHelper.searchData(username, password);
    if (dataReceived == 'Both valid') {
      customLoginToast('Logged In Successfully....', context);
      navigator(username, password);
    } else if (dataReceived == "Both invalid") {
      customErrorToast(
          "You are Not Registered. Please Register your Account", context);
      userNameController.clear();
      passwordController.clear();
    } else if (dataReceived == "User valid") {
      userNameController.clear();
      passwordController.clear();
      customErrorToast('Password is incorrect', context);
    } else {
      userNameController.clear();
      passwordController.clear();
      customErrorToast('Try again Later...', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                // Login Header
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Cambria',
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // Username Field
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 40, 50, 40),
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cambria',
                        color: Colors.black87),
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    maxLength: 8,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: "Username",
                        labelText: "Username"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Username';
                      }
                      return null;
                    },
                  ),
                ),

                // Password Field
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 40),
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cambria',
                        color: Colors.black87),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    autofocus: true,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black87,
                              width: 10,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "Password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                  ),
                ),

                // Forgot Password Button
                // Container(
                //   padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                //   alignment: Alignment.center,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: const Text(
                //       'Forgot Password',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontFamily: 'Cambria',
                //           letterSpacing: 1.0),
                //     ),
                //   ),
                // ),

                // Login Button
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 40),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cambria',
                          letterSpacing: 1.0),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        searchData(
                            userNameController.text, passwordController.text);
                      }
                    },
                  ),
                ),
                // Register Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Does not have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cambria',
                            letterSpacing: 1.0)),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register_Page()));
                        },
                        child: const Text('Click Here',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cambria',
                                letterSpacing: 1.0)))
                  ],
                )
              ],
            )));
  }
}
