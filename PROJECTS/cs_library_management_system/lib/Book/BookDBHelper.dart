import 'package:flutter/material.dart';
import 'package:cs_library_management_system/templates/BOOKSTAFF.dart';
import 'package:cs_library_management_system/templates/BOOKSTUDENT.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../DbConnection.dart';
import '../templates/BOOK.dart';

class BookDBHelper {
  static Future<String> insertBookData(BOOK bk) async {
    try {
      dynamic result = await DbConnection.bookCollection.insertOne(bk.toJson());
      if (result.isSuccess) {
        return "True";
      } else {
        return "False";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getBookData() async {
    try {
      final data = await DbConnection.bookCollection.find().toList();
      return data;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> deleteBookData(String isbnno) async {
    try {
      dynamic result =
          await DbConnection.bookCollection.deleteOne({"_id": isbnno});
      await DbConnection.bookStudentCollection.deleteMany({"_id" : isbnno});
      await DbConnection.bookStaffCollection.deleteMany({"_id" : isbnno});
      if (result.isSuccess) {
        return "True";
      } else {
        return "False";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> updateBookData(BOOK book, String isbnno) async {
    try {
      dynamic result =
          await DbConnection.bookCollection.findOne({"_id": isbnno});
      result["booktitle"] = book.booktitle;
      result["authorname"] = book.authorname;
      result["email"] = book.email;
      result["phoneno"] = book.phoneno;
      result["edition"] = book.edition;
      result["publishedyear"] = book.publishedyear;
      result["_id"] = book.id;
      result["publication"] = book.publication;
      result["count"] = book.count;
      dynamic result1 = await DbConnection.bookCollection.save(result);
      if (result1 != null) {
        return "True";
      } else {
        return "False";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> bookCountUpdate(String isbnno) async {
    try
    {
      dynamic result = await DbConnection.bookCollection.findOne({"_id" : isbnno});
      var count = int.parse(result['count']);
      if(count >= 1)
      {
        return "True";
      }
      else
      {
        return "False";
      }
    }
    catch(e)
    {
      return e.toString();
    }
  }

  static Future<void> bookcountreduce(String isbnno) async {
    try
    {
      dynamic result = await DbConnection.bookCollection.findOne({"_id" : isbnno});
      var count = int.parse(result['count']);
      count--;
      result["count"] = count.toString();
      await DbConnection.bookCollection.save(result);
    }
    catch(e) {}
  }

  static Future<void> bookcountincrease(String isbnno) async {
    try
    {
      dynamic result = await DbConnection.bookCollection.findOne({"_id" : isbnno});
      var count = int.parse(result['count']);
      count++;
      result["count"] = count.toString();
      await DbConnection.bookCollection.save(result);
    }
    catch(e) {}
  }

  // Staff Book Data
  static Future<String> CheckoutStaffBook(BOOKSTAFF bookstaff) async {
    try
        {
          dynamic result = await DbConnection.bookStaffCollection.insertOne(bookstaff.toJson());
          if (result.isSuccess) {
            return "True";
          } else {
            return "False";
          }
        }
        catch(e)
    {
      return e.toString();
    }
  }



  static Future<String> staffCountUpdate(String registerno) async {
    try
        {
          dynamic result = await DbConnection.staffCollection.findOne({"_id" : registerno});
          var count = int.parse(result['bookcount']);
          if(count <= 3 && count >= 1)
          {
            return "True";
          }
          else
          {
            return "False";
          }
        }
        catch(e)
    {
      return e.toString();
    }
  }

  static Future<void> staffcountreduce(String registerno) async {
    try
    {
      dynamic result = await DbConnection.staffCollection.findOne({"_id" : registerno});
      var count = int.parse(result['bookcount']);
        count--;
        result["bookcount"] = count.toString();
        await DbConnection.staffCollection.save(result);
    }
    catch(e) {}
  }

  static Future<void> staffcountincrease(String registerno) async {
    try
    {
      dynamic result = await DbConnection.staffCollection.findOne({"_id" : registerno});
      var count = int.parse(result['bookcount']);
      count++;
      result["bookcount"] = count.toString();
      await DbConnection.staffCollection.save(result);
    }
    catch(e) {}
  }

  static Future<List<Map<String, dynamic>>> getBookStaffData(String registerno) async {
    try {
      final staff =
      await DbConnection.bookStaffCollection.find({"registerno" : registerno}).toList();
      return staff;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> staffRenewDate(String registerno, String isbnno) async {
    try
    {
      dynamic result = await DbConnection.bookStaffCollection.findOne(where.eq('registerno', registerno).eq('isbnno', isbnno));
      result['renewdate'] = DateTime.now().add(const Duration(days: 30)).toString();
      dynamic result2 = await DbConnection.bookStaffCollection.save(result);
      if(result2 != null)
      {
        return "True";
      }
      else
      {
        return "False";
      }
    }

    catch(e)
    {
      return e.toString();
    }
  }

  static Future<String> staffReturnBook(String registerno, String isbnno) async {
    try
    {
      dynamic result = await DbConnection.bookStaffCollection.deleteOne(where.eq('registerno', registerno).eq('isbnno', isbnno));
      staffcountincrease(registerno);
      bookcountincrease(isbnno);
      if (result.isSuccess) {
        return "True";
      } else {
        return "False";
      }
    }
    catch(e)
    {
      return e.toString();
    }
  }

  // Book Student Methods

  static Future<String> CheckoutStudentBook(BOOKSTUDENT bookstudent) async {
    try
    {
      dynamic result = await DbConnection.bookStudentCollection.insertOne(bookstudent.toJson());
      if (result.isSuccess) {
        return "True";
      } else {
        return "False";
      }
    }
    catch(e)
    {
      return e.toString();
    }
  }

  static Future<String> studentCountUpdate(String registerno) async {
    try
    {
      dynamic result = await DbConnection.studentCollection.findOne({"_id" : registerno});
      var count = int.parse(result['bookcount']);
      if(count <= 3 && count >= 1)
      {
        return "True";
      }
      else
      {
        return "False";
      }
    }
    catch(e)
    {
      return e.toString();
    }
  }

  static Future<void> studentcountreduce(String registerno) async {
    try
    {
      dynamic result = await DbConnection.studentCollection.findOne({"_id" : registerno});
      var count = int.parse(result['bookcount']);
      count--;
      result["bookcount"] = count.toString();
      await DbConnection.studentCollection.save(result);
    }
    catch(e) {}
  }

  static Future<void> studentcountincrease(String registerno) async {
    try
    {
      dynamic result = await DbConnection.studentCollection.findOne({"_id" : registerno});
      var count = int.parse(result['bookcount']);
      count++;
      result["bookcount"] = count.toString();
      await DbConnection.studentCollection.save(result);
    }
    catch(e) {}
  }

  static Future<List<Map<String, dynamic>>> getBookStudentData(String registerno) async {
    try {
      final student =
      await DbConnection.bookStudentCollection.find({"registerno" : registerno}).toList();
      return student;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> studentRenewDate(String registerno, String isbnno) async {
    try
        {
          dynamic result = await DbConnection.bookStudentCollection.findOne(where.eq('registerno', registerno).eq('isbnno', isbnno));
          result['renewdate'] = DateTime.now().add(const Duration(days: 30)).toString();
          dynamic result2 = await DbConnection.bookStudentCollection.save(result);
          if(result2 != null)
          {
            return "True";
          }
          else
          {
            return "False";
          }
        }

        catch(e)
    {
      return e.toString();
    }
  }

  static Future<String> studentReturnBook(String registerno, String isbnno) async {
    try
        {
          dynamic result = await DbConnection.bookStudentCollection.deleteOne(where.eq('registerno', registerno).eq('isbnno', isbnno));
          studentcountincrease(registerno);
          bookcountincrease(isbnno);
          if (result.isSuccess) {
            return "True";
          } else {
            return "False";
          }
        }
        catch(e)
    {
      return e.toString();
    }
  }
}
