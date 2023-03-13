import 'package:cs_library_management_system/templates/LIBRARIAN.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../DbConnection.dart';

List<LIBRARIAN> librarian = [];

class LibrarianDBHelper {
  static Future<String> insertLibrarianData(LIBRARIAN lm) async {
    try {
      dynamic result =
          await DbConnection.librarianCollection.insertOne(lm.toJson());
      if (result.isSuccess) {
        return "True";
      } else {
        return "False";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> checkUsername(String user) async {
    try {
      dynamic result =
          await DbConnection.librarianCollection.findOne({"username": user});
      if (result == null) {
        return 'True';
      } else {
        return 'False';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> searchData(String user, String pass) async {
    try {
      dynamic result1 =
          await DbConnection.librarianCollection.findOne({'username': user});
      if (result1 != null) {

        if (pass == result1['password']) {
          return "Both valid";
        } else {
          return "User valid";
        }
      } else {
        return "Both invalid";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getLibrarianData(
      String user) async {
    try
        {
          final librarian =
          await DbConnection.librarianCollection.find({"username": user}).toList();
          return librarian;
        }
        catch(e)
    {
      return Future.error(e);
    }
  }

  static Future<String> updateLibrarianData(LIBRARIAN librarian , String id) async {
    try {
      dynamic result = await DbConnection.librarianCollection.findOne(
          {"_id": id});
      result["firstname"] = librarian.firstname;
      result["lastname"] = librarian.lastname;
      result["email"] = librarian.email;
      result["mobile"] = librarian.mobile;
      result["aadharno"] = librarian.aadharno;
      result["gender"] = librarian.gender;
      result["dob"] = librarian.dob;
      result["_id"] = librarian.id;
      result["username"] = librarian.username;
      result["password"] = librarian.password;
      dynamic result1 = await DbConnection.librarianCollection.save(result);
      if (result1 != null) {
        return "True";
      } else {
        return "False";
      }
    }
    catch (e) {
      return e.toString();
    }
  }
}
