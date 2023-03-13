
import 'package:cs_library_management_system/templates/STAFF.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../DbConnection.dart';

class StaffDBHelper {
  static Future<String> insertStaffData(STAFF st) async {
    try {
      dynamic result =
      await DbConnection.staffCollection.insertOne(st.toJson());
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
      await DbConnection.staffCollection.findOne({"username": user});
      if (result == null) {
        return 'True';
      } else {
        return 'False';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getStaffData() async {
    try {
      final staff =
      await DbConnection.staffCollection.find().toList();
      return staff;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> updateStaffData(STAFF staff, String id) async {
    try {
      dynamic result =
      await DbConnection.staffCollection.findOne({"_id": id});
      result["firstname"] = staff.firstname;
      result["lastname"] = staff.lastname;
      result["email"] = staff.email;
      result["mobile"] = staff.mobile;
      result["aadharno"] = staff.aadharno;
      result["_id"] = staff.registerno;
      result["gender"] = staff.gender;
      result["department"] = staff.department;
      result["dob"] = staff.dob;
      result["username"] = staff.username;
      result["password"] = staff.password;
      result["bookcount"] = staff.bookcount;
      dynamic result1 = await DbConnection.staffCollection.save(result);
      if (result1 != null) {
        return "True";
      } else {
        return "False";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> deleteStaffData(String register) async {
    try {
      dynamic result =
      await DbConnection.staffCollection.deleteOne({"_id": register});
      if (result.isSuccess) {
        return "True";
      } else {
        return "False";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
