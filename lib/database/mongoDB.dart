import 'dart:developer';
import 'dart:ffi';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/MongoDBModel.dart';
import 'package:medcore/database/constant.dart';
import 'package:medcore/mongoDBModel2.dart';
import 'package:mongo_dart/mongo_dart.dart';
// import 'package:mongo_dart/mongo_dart.dart';
// import 'package:objectid/objectid.dart';
// import 'package:objectid/objectid.dart';
import '../LabScreens/lab_home_screen.dart';
import '../Patient-PhysicianScreens/home_screen.dart';
import '../Patient-PhysicianScreens/patient_home_screen.dart';
import '../mongoDBModel3.dart';

var db;
ObjectId hID;
List<ObjectId> hosArray = new List<ObjectId>();

class DBConnection {
  static var userCollection1, userCollection2, userCollection3, userCollection4;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    userCollection1 = db.collection(COLLECTION_PHYSICIAN);
    userCollection2 = db.collection(COLLECTION_PATIENT);
    userCollection3 = db.collection(COLLECTION_LAB);
    userCollection4 = db.collection(COLLECTION_HOSPITAL);
  }

  static Future<String> insertPhysician(Welcome data, hosID, nationalID) async {
    var result = await userCollection1.insertOne(data.toJson());
    // var len = hosID.length;
    // String k = hosID.join();
    var f = 0;
    print(hosID.length);
    hosArray.forEach((element) {
      if (f < hosID.length) {
        print(element);
        userCollection4.update({
          "_id": element,
        }, {
          "\$push": {
            "Physician": {
              "id": nationalID,
            }
          }
        });
        f = f + 1;
      }
    });

    try {
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong";
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  static Future<String> insertPatient(Welcome2 data) async {
    var result = await userCollection2.insertOne(data.toJson());

    try {
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong";
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  static update(role, email, pass) async {
    var table = "";
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    var collection = db.collection(table);
    var u = await collection.findOne({"email": email});
    u["password"] = pass;
    await collection.save(u);
  }

  static resetPassword(role, id, pass) async {
    var table = "";
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    var collection = db.collection(table);
    var u = await collection.findOne({"nationalId": id});
    u["password"] = pass;
    await collection.save(u);
  }

  static checkEmailExsist(role, email) async {
    var table = "";
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    var collection = db.collection(table);
    var u = await collection.findOne({"email": email});
    print(u);

    if (u == null)
      return null;
    else
      return u["email"];
  }

  static Future<bool> checkExisting(controler, role, type) async {
    var table = '';
    var result;
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    if (role == "hospital") {
      return false;
    }
    var collection = db.collection(table);
    if (type == 'email') {
      result = await collection.findOne({"email": controler});
      print("result email:" + result.toString());
      if (result.toString() != "null") {
        print("result1 email" + result.toString());
        return true;
      } else {
        print("result2 email" + result.toString());
        return false;
      }
    } else if (type == 'ID') {
      result = await collection.findOne({"nationalId": controler});
      print("result:" + result.toString());
      if (result.toString() != "null") {
        print("result1" + result.toString());
        return true;
      } else {
        print("result2" + result.toString());
        return false;
      }
    }
  }

  static checkOldPass(role, id) async {
    var table = "";
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    var collection = db.collection(table);
    var u = await collection.findOne({"nationalId": id});
    return u["password"];
  }

  static Future<String> insertLab(Welcome3 data, nationalId) async {
    var result = await userCollection3.insertOne(data.toJson());
    userCollection4.update({
      "_id": hid
    }, {
      "\$push": {
        "LabSpecialist": {
          "id": nationalId,
        }
      }
    });
    try {
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong";
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  static AuthlogIn(
      String role, String idController, String passwordController) async {
    //connect with table
    print(role);
    print(idController);
    print(passwordController);
    var table = "";
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    var collection = db.collection(table);
    var user = await collection.findOne({"nationalId": idController});

    //find user
    print(user);
    if (user != null) {
      var userPassword = user['password'];
      var isCorrect = new DBCrypt().checkpw(passwordController, userPassword);
      print(await user);
      print(isCorrect);
      if (isCorrect) {
        return false;
        // if (role.compareTo('Patient') == 0)
        //   Get.to(PatientHomeScreen(), arguments: 'patient');
        // else if (role.compareTo('Physician') == 0)
        //   Get.to(HomeScreen());
        // else if (role.compareTo('Lab specialist') == 0) Get.to(LabHomePage1());
      } else
        print('Sorry user name or password not correct');
      return true;
    } else
      print('the user not exisit');
    return true;
  }

  static getEmail(role, id) async {
    var table = "";
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    var collection = db.collection(table);
    var u = await collection.findOne({"nationalId": id});
    return u["email"];
  }
}

ObjectId hid;
