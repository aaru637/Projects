import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserDatabase? _user;
  UserDatabase get getUser => _user!;
  Future<void> refreshUser() async {
    UserDatabase user = await GetUser.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
