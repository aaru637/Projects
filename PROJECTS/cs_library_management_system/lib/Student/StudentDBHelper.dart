
import 'package:cs_library_management_system/templates/STUDENT.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../DbConnection.dart';

class StudentDBHelper {
  static Future<String> insertStudentData(STUDENT st) async {
    try {
      dynamic result =
          await DbConnection.studentCollection.insertOne(st.toJson());
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
          await DbConnection.studentCollection.findOne({"username": user});
      if (result == null) {
        return 'True';
      } else {
        return 'False';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getStudentData() async {
    try {
      final student =
          await DbConnection.studentCollection.find().toList();
      return student;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> updateStudentData(STUDENT student, String id) async {
    try {
      dynamic result =
          await DbConnection.studentCollection.findOne({"_id": id});
      result["firstname"] = student.firstname;
      result["lastname"] = student.lastname;
      result["email"] = student.email;
      result["mobile"] = student.mobile;
      result["aadharno"] = student.aadharno;
      result["_id"] = student.registerno;
      result["gender"] = student.gender;
      result["department"] = student.department;
      result["year"] = student.year;
      result["dob"] = student.dob;
      result["username"] = student.username;
      result["password"] = student.password;
      result["bookcount"] = student.bookcount;
      dynamic result1 = await DbConnection.studentCollection.save(result);
      if (result1 != null) {
        return "True";
      } else {
        return "False";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> deleteStudentData(String register) async {
    try {
      dynamic result =
      await DbConnection.studentCollection.deleteOne({"_id": register});
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
