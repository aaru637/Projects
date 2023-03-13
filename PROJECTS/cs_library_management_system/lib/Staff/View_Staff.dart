import 'package:flutter/material.dart';
import 'package:cs_library_management_system/Staff/StaffDBHelper.dart';
import 'package:cs_library_management_system/Staff/Update_Staff.dart';
import 'package:cs_library_management_system/Staff/View_Staff_Details.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cs_library_management_system/templates/searchWidget.dart';

import '../templates/STAFF.dart';

class View_Staff extends StatefulWidget {
  const View_Staff({Key? key}) : super(key: key);

  @override
  State<View_Staff> createState() => _View_StaffState();
}

class _View_StaffState extends State<View_Staff> {
  TextEditingController registerno = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<STAFF> staffs = [];
  String query = '';

  void customErrorToast(String message, BuildContext context) {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textPadding: const EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.red,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: const Duration(seconds: 5),
        context: context);
  }

  void customStaffToast(String message, BuildContext context) {
    showToast(message,
        textStyle: const TextStyle(
            fontSize: 14,
            wordSpacing: 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textPadding: const EdgeInsets.all(23),
        fullWidth: true,
        toastHorizontalMargin: 25,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.green,
        alignment: Alignment.bottomCenter,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.fade,
        duration: const Duration(seconds: 5),
        context: context);
  }

  Future<List<STAFF>> getStaffData(String query) async {
    final staff = await StaffDBHelper.getStaffData();
    return staff.map((e) => STAFF.fromJson(e)).toList();
  }

  Future init() async {
    final staffs = await getStaffData(query);
    setState(() => this.staffs = staffs);
  }

  Future deleteStaffData(String registerno1) async {
    String data = await StaffDBHelper.deleteStaffData(registerno1);

    if (data == "True") {
      customStaffToast("$registerno1 Deleted SuccessFully...", context);
    } else {
      customErrorToast(
          'Error Occured While deleting your Record. Please Try again Later...',
          context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Register No or First Name',
    onChanged: searchStaff,
  );

  Future searchStaff(String query) async {
    final staffs = await getStaffData(query);
    if (!mounted) return;
    setState(() {
      this.query = query;
      this.staffs = staffs;
    });
  }

  Widget buildStaff(STAFF staff, index) {
    if (index < staffs.length) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                  staff.firstname.toString().toUpperCase().substring(0, 1)),
            ),
            title: Text(
              staff.registerno.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Cambria'),
            ),
            subtitle: Text(
              staff.firstname.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Calibri',
                  fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => View_Staff_Details(
                        firstname: staff.firstname,
                        lastname: staff.lastname,
                        email: staff.email,
                        mobile: staff.mobile,
                        aadharno: staff.aadharno,
                        registerno: staff.registerno,
                        gender: staff.gender,
                        department: staff.department,
                        dob: staff.dob,
                        username: staff.username,
                        password: staff.password,
                        bookcount: staff.bookcount,
                      )));
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Update_Staff(
                                firstname: staff.firstname,
                                lastname: staff.lastname,
                                email: staff.email,
                                mobile: staff.mobile,
                                aadharno: staff.aadharno,
                                registerno: staff.registerno,
                                gender: staff.gender,
                                department: staff.department,
                                dob: staff.dob,
                                username: staff.username,
                                password: staff.password,
                                confirmpassword: staff.password,
                                bookcount: staff.bookcount,
                              )));
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('AlertDialog Title'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: const <Widget>[
                                  Text('Delete User'),
                                  Text(
                                      'Would you like to confirm this message?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Confirm'),
                                onPressed: () {
                                  print('Confirmed');
                                  deleteStaffData(staff.registerno);
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(231, 112, 226, 100.0),
                  Color.fromRGBO(0, 163, 255, 100.0)
                ]),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                child : Container(
                  alignment: Alignment.center,
                  child: const Text('Staff Details',
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Cambria',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                ),
              ),

              buildSearch(),

              Expanded(
                child: ListView.builder(
                    itemCount: staffs.length,
                    itemBuilder: (context, index) {
                      final staff = staffs[index];

                      return buildStaff(staff, index);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
