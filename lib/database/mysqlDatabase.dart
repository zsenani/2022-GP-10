import 'dart:async';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

var conn;

class mysqlDatabase {
  static connect() async {
    var settings = new ConnectionSettings(
        host: 'eu-cdbr-west-03.cleardb.net',
        port: 3306,
        user: 'b71432b615aa7b',
        password: '4b7ac2e7',
        db: 'heroku_2c29e35e35b17ca');

    conn = await MySqlConnection.connect(settings)
        .timeout(const Duration(seconds: 900));
  }

  static Future<void> insertLab(
      String lname,
      String lpassword,
      String ldob,
      String lgender,
      String lmobileNo,
      String lemail,
      String lnationality,
      int lnationalId,
      int lhospitalID) async {
    var result = await conn.query(
        'insert into LabSpecialist (nationalId, name, password,DOB,gender,mobileNo,email,nationality,idHospital) values (?, ?, ?,?, ?, ?,?, ?, ?)',
        [
          lnationalId,
          lname,
          lpassword,
          ldob,
          lgender,
          lmobileNo,
          lemail,
          lnationality,
          lhospitalID
        ]);
    try {
      if (result.isSuccess) {
        print("Data Inserted");
      } else {
        print("Something Wrong");
      }
    } catch (e) {
      print(e.toString());
      print("");
    }
  }

  static Future<void> insertPhysician(
      String pname,
      String ppassword,
      String pdob,
      String pgender,
      String pmobileNo,
      String pemail,
      String pnationality,
      String pspecialization,
      int pnationalId,
      List<int> phospitals) async {
    var result = await conn.query(
        'insert into Physician (nationalId, name, password,DOB,gender,mobileNo,email,nationality,specialisation) values (?, ?, ?,?, ?, ?,?, ?, ?)',
        [
          pnationalId,
          pname,
          ppassword,
          pdob,
          pgender,
          pmobileNo,
          pemail,
          pnationality,
          pspecialization,
        ]);
    try {
      if (result.isSuccess) {
        print("Data Inserted");
      } else {
        print("Something Wrong");
      }
    } catch (e) {
      print(e.toString());
      print("");
    }
    print("before phospitals ");
    print(phospitals);
    var result2;
    phospitals.forEach((element) async {
      print("inside phospitals ");
      print(element);
      result2 = await conn.query(
          'insert into HospitalPhysician (idHospital, idPhysician) values (?,?)',
          [element, pnationalId]);
    });
    print("after phospitals ");
    try {
      if (result2.isSuccess) {
        print("Data Inserted");
      } else {
        print("Something Wrong");
      }
    } catch (e) {
      print(e.toString());
      print("");
    }
  }

  static Future<void> insertPatient(
    String fname,
    String fpassword,
    String fdob,
    String fgender,
    String fmobileNo,
    String femail,
    String fnationality,
    String fmaritalStatus,
    String bloodType,
    int fnationalId,
  ) async {
    var result;
    if (bloodType != 'I\'m not sure') {
      result = await conn.query(
          'insert into Patient (nationalId, name, password,DOB,gender,mobileNo,email,nationality,maritalStatus,bloodType) values (?, ?, ?,?, ?, ?,?, ?, ?,?)',
          [
            fnationalId,
            fname,
            fpassword,
            fdob,
            fgender,
            fmobileNo,
            femail,
            fnationality,
            fmaritalStatus,
            bloodType
          ]);
    } else {
      result = await conn.query(
          'insert into Patient (nationalId, name, password,DOB,gender,mobileNo,email,nationality,maritalStatus) values (?, ?, ?,?, ?, ?,?, ?, ?)',
          [
            fnationalId,
            fname,
            fpassword,
            fdob,
            fgender,
            fmobileNo,
            femail,
            fnationality,
            fmaritalStatus,
          ]);
    }
    try {
      if (result.isSuccess) {
        print("Data Inserted");
      } else {
        print("Something Wrong");
      }
    } catch (e) {
      print(e.toString());
      print("");
    }
  }

  static addDiagnose(sub, obj, assessment, plan, vid) async {
    var diagnose = await conn.query(
        'update Visit set subject=?, object=? , assessment=? , plan=? where idvisit =?',
        [sub, obj, assessment, plan, vid]);
  }

  static editProfile(role, name, email, phone, id) async {
    if (role.compareTo('patient') == 0) {
      if (name != "") {
        var editP = await conn
            .query('update Patient set name=? where NationalID =?', [name, id]);
      }
      if (email != "") {
        var editP = await conn.query(
            'update Patient set  email=? where NationalID =?', [email, id]);
      }
      if (phone != "") {
        var editP = await conn.query(
            'update Patient set mobileNo=? where NationalID =?', [phone, id]);
      }
    } else if (role.compareTo('Physician') == 0) {
      if (name != "") {
        var editP = await conn.query(
            'update Physician set name=? where nationalId =?', [name, id]);
      }
      if (email != "") {
        var editP = await conn.query(
            'update Physician set  email=? where nationalId =?', [email, id]);
      }
      if (phone != "") {
        var editP = await conn.query(
            'update Physician set mobileNo=? where nationalId =?', [phone, id]);
      }
    } else if (role.compareTo('Lab specialist') == 0) {
      if (name != "") {
        var editP = await conn.query(
            'update LabSpecialist set name=? where nationalId =?', [name, id]);
      }
      if (email != "") {
        var editP = await conn.query(
            'update LabSpecialist set  email=? where nationalId =?',
            [email, id]);
      }
      if (phone != "") {
        var editP = await conn.query(
            'update LabSpecialist set mobileNo=? where nationalId =?',
            [phone, id]);
      }
    }
  }

  static addMedication(name, dosage, start, end, des, vid) async {
    var medId = await conn
        .query('select idmedication from Medication where name = ?', [name]);
    for (var row in medId) {
      medId = "${row[0]}";
    }
    var add = await conn.query(
        'insert into VisitMedication (dosage, description, startDate,endDate,medicationID,visitID) values (?, ?, ?,?, ?,?)',
        [dosage, des, start, end, medId, vid]);
  }

  static addTest(List<String> name, vid, String update, int hosId) async {
    List<dynamic> testId = [];
    var count = 0;
    var TestId;
    print("hosID");
    print(hosId);
    // List<dynamic> lab = [];
    // var labs = await conn.query(
    //     'select nationalID from labspecialist where idHospital = ?', [hosId]);
    // for (var row in labs) {
    //   lab.add("${row[0]}");
    // }
    // print(lab);
    name.forEach((element) async {
      print(element);
      TestId = await conn
          .query('select idlabTest from LabTest where name = ?', [element]);
      for (var row in TestId) {
        testId.add("${row[0]}");
        count++;
        print(name.length);
        print(count);
        print("testId");
        print(testId);
        if (count == name.length) {
//addOnVisitLabTest(testId, vid, update, lab);
          addOnVisitLabTest(testId, vid, update);
        }
      }
    });
  }

  static addOnVisitLabTest(testId, vid, update) {
    var count = 0;
    testId.forEach((tstid) async {
      print(testId);
      var add = await conn.query(
          'insert into VisitLabTest(visitID, labTestID, status,isUpdated) values (?, ?, ?,?)',
          [vid, int.parse(tstid), "active", update]);
      print("add testId in visittest");
      print(int.parse(tstid));
      count++;
      print(testId.length);
      print(count);
      // if (count == testId.length) {
      //   addOnLabspecialistLabTest(testId, vid, update, lab);
      // }
    });
  }

  // static addOnLabspecialistLabTest(testId, vid, update, lab) {
  //   testId.forEach((tstid) async {
  //     lab.forEach((element) async {
  //       var add = await conn.query(
  //           'insert into labspecialistlabtest(idLabSpecialist, idLabTest) values (?,?)',
  //           [int.parse(element), int.parse(tstid)]);
  //       print(int.parse(tstid));
  //       print(int.parse(element));
  //     });
  //   });
  // }

  static editHistory(type, List<String> row, pid) async {
    var data = '';
    row.forEach((element) {
      if (row.last == element) {
        data += element;
      } else {
        data += element + ',';
      }
    });
    print(data);
    var edit = await conn.query(
        'update Patient set ' + type + '=? where NationalID =?', [data, pid]);
  }

  static deleteHistory(type, List<String> row, pid) async {
    var data = row.first + ",";
    row.forEach((element) {
      if (row.first != element) {
        if (row.last == element) {
          data += element;
        } else {
          data += element + ',';
        }
      }
    });
    print(data);
    var edit = await conn.query(
        'update Patient set ' + type + '=? where NationalID =?', [data, pid]);
  }

  static checkEmailExsist(role, email) async {
    var table = "";
    if (role.compareTo('patient') == 0) {
      table = 'Patient';
    } else if (role.compareTo('Physician') == 0) {
      table = 'Physician';
    } else if (role.compareTo('Lab specialist') == 0) {
      table = 'LabSpecialist';
    }
    var s;
    var res = await conn
        .query('select email from ' + table + ' where email = ?', [email]);
    print(res);
    for (var row in res) {
      s = '${row[0]}';
    }

    if (res.isEmpty == true) {
      return null;
    } else {
      return s;
    }
  }

  static checkOldPass(role, id) async {
    var table = "";
    if (role.compareTo('patient') == 0) {
      table = 'Patient';
    } else if (role.compareTo('Physician') == 0) {
      table = 'Physician';
    } else if (role.compareTo('Lab specialist') == 0) {
      table = 'LabSpecialist';
    }
    var rr;
    rr = await conn
        .query('select password from ' + table + ' where NationalID = ?', [id]);
    String pass;
    for (var row in rr) {
      pass = '${row[0]}';
    }
    return pass;
  }

  static PatientHomeScreen(id) async {
    var patientInfo = await conn.query(
        'select NationalID,name,DOB,gender,height,weight,BloodPressure from Patient where NationalID = ?',
        [id]);
    List<String> info;
    String date;
    for (var row in patientInfo) {
      date = '${row[2]}'.substring(0, 11);
      info = [
        '${row[0]}',
        '${row[1]}',
        date,
        '${row[3]}',
        '${row[4]}',
        '${row[5]}',
        '${row[6]}'
      ];
    }
    print("inside mysql");
    print(id);
    print(info[0]);
    return info;
  }

  static PhysicianHomeScreen(id) async {
    var phyName = await conn
        .query('select name from Physician where nationalID = ?', [id]);
    String Pname;
    for (var row in phyName) {
      Pname = '${row[0]}';
    }
    return Pname;
  }

  static activeVisitDet(id, testId) async {
    List<String> details = [];
    var visitD = await conn.query(
        'select date,time,idPhysician,idPatient,idHospital from Visit where idvisit = ?',
        [id]);
    var phId, pId, hId;
    for (var row in visitD) {
      details.add('${row[0]}'.substring(0, '${row[0]}'.indexOf(" ")));
      details.add('${row[1]}');
      phId = '${row[2]}';
      pId = '${row[3]}';
      hId = '${row[4]}';
    }
    var patientInfo = await conn
        .query('select name,DOB from Patient where NationalID = ?', [pId]);
    var ageN;
    var DOB;
    for (var row in patientInfo) {
      details.add('${row[0]}');
      DOB = '${row[1]}'.split(' ')[0];
      ageN = DateTime.now().year - int.parse(DOB.substring(0, 4));
      if (int.parse(DOB.substring(5, 7)) > DateTime.now().month) {
        ageN = ageN - 1;
      } else if (int.parse(DOB.substring(5, 7)) == DateTime.now().month) {
        if (int.parse(DOB.substring(8, 10)) > DateTime.now().day) {
          ageN = ageN - 1;
        }
      }
      details.add(ageN.toString());
    }
    var phyinfo = await conn.query(
        'select name,specialisation from Physician where nationalID = ?',
        [phId]);
    for (var row in phyinfo) {
      details.add('${row[0]}');
      details.add('${row[1]}');
    }
    var visitH = await conn
        .query('select name from Hospital where idhospital = ?', [hId]);
    for (var row in visitH) {
      details.add('${row[0]}');
    }
    details.add(pId);
    return details;
  }

  static preVisitDet(id) async {
    List<String> details = [];
    var visitD = await conn.query(
        'select date,time,idPhysician,idPatient,idHospital from Visit where idvisit = ?',
        [id]);
    var phId, pId, hId;
    for (var row in visitD) {
      details.add('${row[0]}'.substring(0, '${row[0]}'.indexOf(" ")));
      details.add('${row[1]}');
      phId = '${row[2]}';
      pId = '${row[3]}';
      hId = '${row[4]}';
    }
    var patientInfo = await conn
        .query('select name,DOB from Patient where NationalID = ?', [pId]);
    var ageN;
    var DOB;
    for (var row in patientInfo) {
      details.add('${row[0]}');
      DOB = '${row[1]}'.split(' ')[0];
      ageN = DateTime.now().year - int.parse(DOB.substring(0, 4));
      if (int.parse(DOB.substring(5, 7)) > DateTime.now().month) {
        ageN = ageN - 1;
      } else if (int.parse(DOB.substring(5, 7)) == DateTime.now().month) {
        if (int.parse(DOB.substring(8, 10)) > DateTime.now().day) {
          ageN = ageN - 1;
        }
      }
      details.add(ageN.toString());
    }
    var phyinfo = await conn.query(
        'select name,specialisation from Physician where nationalID = ?',
        [phId]);
    for (var row in phyinfo) {
      details.add('${row[0]}');
      details.add('${row[1]}');
    }
    var visitH = await conn
        .query('select name from Hospital where idhospital = ?', [hId]);
    for (var row in visitH) {
      details.add('${row[0]}');
    }
    details.add(pId);
    return details;
  }

  static PhysicianActiveVisit(id) async {
    List<List<String>> visitUp = [];
    List<List<String>> info = [];

    var phyVisit = await conn.query(
        'select idvisit,date,time,idHospital,idPatient from Visit where idPhysician = ? order by date ASC',
        [id]);

    for (int g = 0; g < phyVisit.length; g++) {
      for (var row in phyVisit) {
        info.add([
          '${row[0]}',
          '${row[1]}'.substring(0, 11),
          '${row[2]}',
          '${row[3]}',
          '${row[4]}' //patientId
        ]);
      }
      // print(i++);
      print("info list date,idHospital,idPatient");
      // print(patientP.length);
      print(info);
    }
    for (int g = 0; g < phyVisit.length; g++) {
      var dateP = info[g][1] + "00:00:00";
      DateTime dt1 = DateTime.parse(dateP);
      print("todaytime");
      DateTime todayDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      print(dt1);

      if (dt1.compareTo(todayDate) > 0 ||
          (dt1.year == todayDate.year &&
              dt1.month == todayDate.month &&
              dt1.day == todayDate.day)) {
        List<String> oneRow = [];
        oneRow.add(info[g][0]);
        oneRow.add(info[g][1]);
        // oneRow.add(info[g][2]);
        var visitH = await conn.query(
            'select name from Hospital where idhospital = ?', [info[g][3]]);
        for (var row in visitH) {
          oneRow.add('${row[0]}');
        }

        var visitP = await conn.query(
            'select name,gender,DOB,height,weight,BloodPressure from Patient where NationalID = ?',
            [info[g][4]]);
        for (var row in visitP) {
          oneRow.add('${row[0]}');
          oneRow.add('${row[1]}');
          oneRow.add('${row[2]}');
          oneRow.add('${row[3]}');
          oneRow.add('${row[4]}');
          oneRow.add('${row[5]}');
        }
        oneRow.add(info[g][4]);
        oneRow.add(info[g][2]); //visit date
        oneRow.add(info[g][3]);
        print("hospital id ''''''''");
        print(info[g][3]);
        print("oneRow ---------------");
        print(oneRow);
        visitUp.add(oneRow);
        print(visitUp);
      }
    }
    return visitUp;
  }

  static PhysicianPrevVisit(id) async {
    List<List<String>> visitPre = [];
    List<List<String>> info = [];

    var phyVisit = await conn.query(
        'select idvisit,date,time,idHospital,idPatient from Visit where idPhysician = ? order by date DESC',
        [id]);

    for (int g = 0; g < phyVisit.length; g++) {
      for (var row in phyVisit) {
        info.add([
          '${row[0]}',
          '${row[1]}'.substring(0, 11),
          '${row[2]}',
          '${row[3]}',
          '${row[4]}' //patientId
        ]);
      }
      print("info list date,idHospital,idPatient");
      print(info);
    }
    for (int g = 0; g < phyVisit.length; g++) {
      var dateP = info[g][1] + "00:00:00";
      DateTime dt1 = DateTime.parse(dateP);
      print("todaytime");
      DateTime todayDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      print(dt1);

      if (dt1.compareTo(todayDate) < 0) {
        List<String> oneRow = [];
        oneRow.add(info[g][0]);
        oneRow.add(info[g][1]);

        var visitH = await conn.query(
            'select name from Hospital where idhospital = ?', [info[g][3]]);
        for (var row in visitH) {
          oneRow.add('${row[0]}');
        }

        var visitP = await conn.query(
            'select name,gender,DOB,height,weight,BloodPressure from Patient where NationalID = ?',
            [info[g][4]]);
        for (var row in visitP) {
          oneRow.add('${row[0]}');
          oneRow.add('${row[1]}');
          oneRow.add('${row[2]}');
          oneRow.add('${row[3]}');
          oneRow.add('${row[4]}');
          oneRow.add('${row[5]}');
        }
        oneRow.add(info[g][4]);
        oneRow.add(info[g][2]); //visit date
        print("oneRow ---------------");
        print(oneRow);
        visitPre.add(oneRow);
        print(visitPre);
      }
    }
    return visitPre;
  }

  static labSpecHomeScreen(id) async {
    List<String> info = [];
    var labInfo = await conn.query(
        'select name,idHospital from LabSpecialist where nationalID = ?', [id]);
    String Pname;
    String hospitalID;
    for (var row in labInfo) {
      info.add('${row[0]}');
      hospitalID = '${row[1]}';
    }
    var labHos = await conn
        .query('select name from Hospital where idhospital = ?', [hospitalID]);

    for (var row in labHos) {
      info.add('${row[0]}');
    }
    print(info);
    return info;
  }

  static labTestnames(visitid) async {
    List<String> testId = [];
    List<String> testNames = [];
    List<String> testNU = [];
    List<String> testUpd = [];

    var testsID = await conn.query(
        'select labTestID,isUpdated from VisitLabTest where visitID = ?',
        [visitid]); //here check
    for (var row in testsID) {
      testId.add('${row[0]}');
      testUpd.add('${row[1]}');
    }
    print(testId);
    var ind = 1;
    for (int i = 0; i < testId.length; i++) {
      var testsNam = await conn.query(
          'select name from LabTest where idlabTest = ?',
          [testId[i]]); //here check
      for (var row in testsNam) {
        testNames.add('${row[0]}');
      }
    }
    print("testNames:");
    print(testNames);
    for (int j = 0; j < testNames.length; j++) {
      testNU.add(testNames[j]);
      testNU.add(testUpd[j]);
    }
    print(testNU);
    print("testId list:");
    print(testId);
    return testNU;
  }

  static labTestReq(type, hosID) async {
    List<List<String>> testPre = [];
    List<List<String>> testActive = [];
    List<String> idLabTest = [];
    List<List<String>> LabTest = [];
    ////
    List<String> idVisit = [];
    List<String> idVisit2 = [];
    List<String> distinctVisit = [];
    List<List<String>> testReqInfo = [];

    var labtest = await conn.query('select visitID from visitlabtest');
    print("visit id :::::");

    for (var row in labtest) {
      idVisit.add('${row[0]}');
    }
    for (int i = 0; i < idVisit.length; i++) {
      var labtestH = await conn.query(
          'select idvisit from visit where idHospital = ? and idvisit = ?',
          [hosID, idVisit[i]]);
    }
    for (var row in labtest) {
      idVisit2.add('${row[0]}');
    }
    distinctVisit = idVisit2.toSet().toList();
    print(distinctVisit);

    for (int i = 0; i < distinctVisit.length; i++) {
      var tInfo = await conn.query(
          'select labTestID,status,result,isUpdated from visitlabtest where visitID = ?',
          [distinctVisit[i]]);

      for (var row in tInfo) {
        testReqInfo.add([
          distinctVisit[i],
          '${row[0]}',
          '${row[1]}',
          '${row[2]}',
          '${row[3]}'
        ]);
      } //visitLabTest

      for (int g = 0; g < testReqInfo.length; g++) {
        List<String> activ = [];
        List<String> prev = [];
        if (testReqInfo[g][2] == "active") {
          activ.add(testReqInfo[g][0]);
          activ.add(testReqInfo[g][1]);
          activ.add(testReqInfo[g][2]);
          activ.add(testReqInfo[g][3]);
          activ.add(testReqInfo[g][4]);
          var patientid = await conn.query(
              'select idPatient from Visit where idvisit = ?',
              [testReqInfo[g][0]]);
          var patiId;
          var patiN;
          for (var row in patientid) {
            patiId = '${row[0]}';
          }
          var pN = await conn
              .query('select name from Patient where NationalID = ?', [patiId]);
          for (var row in pN) {
            patiN = '${row[0]}';
          }
          activ.add(patiN);
          //////////cady
          activ.add(patiId);
          // physican id and name
          var phyid = await conn.query(
              'select idPhysician from Visit where idvisit = ?',
              [testReqInfo[g][0]]);
          var phyId;
          var phyName;
          for (var row in phyid) {
            phyId = '${row[0]}';
          }
          var phyN = await conn.query(
              'select name from Physician where NationalID = ?', [phyId]);
          for (var row in phyN) {
            phyName = '${row[0]}';
          }
          activ.add(phyName);

          for (int j = g + 1; j < testReqInfo.length; j++) {
            if (testReqInfo[g][0] == testReqInfo[j][0] &&
                testReqInfo[j][2] == "active") {
              activ.add(testReqInfo[j][0]);
              activ.add(testReqInfo[j][1]);
              activ.add(testReqInfo[j][2]);
              activ.add(testReqInfo[j][3]);
              activ.add(testReqInfo[j][4]);
              testReqInfo.removeAt(j--);
            }
          }

          print(activ);
          testActive.add(activ);
        } else if (testReqInfo[g][2] == "done") {
          prev.add(testReqInfo[g][0]);
          prev.add(testReqInfo[g][1]);
          prev.add(testReqInfo[g][2]);
          prev.add(testReqInfo[g][3]);
          var patientid = await conn.query(
              'select idPatient from Visit where idvisit = ?',
              [testReqInfo[g][0]]);
          var patiId;
          var patiN;
          for (var row in patientid) {
            patiId = '${row[0]}';
          }
          var pN = await conn
              .query('select name from Patient where NationalID = ?', [patiId]);
          for (var row in pN) {
            patiN = '${row[0]}';
          }
          prev.add(patiN);
          //////cady
          prev.add(patiId);
          // physican id and name
          var phyid = await conn.query(
              'select idPhysician from Visit where idvisit = ?',
              [testReqInfo[g][0]]);
          var phyId;
          var phyName;
          for (var row in phyid) {
            phyId = '${row[0]}';
          }
          var phyN = await conn.query(
              'select name from Physician where NationalID = ?', [phyId]);
          for (var row in phyN) {
            phyName = '${row[0]}';
          }
          prev.add(phyName);
          for (int j = g + 1; j < testReqInfo.length; j++) {
            if (testReqInfo[g][0] == testReqInfo[j][0] &&
                testReqInfo[j][2] == "done") {
              prev.add(testReqInfo[j][0]);
              prev.add(testReqInfo[j][1]);
              prev.add(testReqInfo[j][2]);
              prev.add(testReqInfo[j][3]);
              testReqInfo.removeAt(j--);
            }
          }

          print(prev);
          testPre.add(prev);
        }
      }

      print("results Pre:");
      print(testPre);

      if (type == "Pre") {
        print("resultsPre:");
        print(testPre);
        return testPre;
      } else if (type == "active") {
        print("active test:");
        print(testActive);
        return testActive;
      }
    }
  }

  static PatientPrevVisit(id) async {
    var index = 0;
    var date;
    List<List<String>> resultsPre = [];
    var patientP = await conn.query(
        'select idvisit,date,idHospital,idPhysician,Department from Visit where idPatient = ? order by date DESC',
        [id]);
    List<List<String>> info = [];

    print("query");
    print(patientP);
    int i = 1;
    for (int g = 0; g < patientP.length; g++) {
      for (var row in patientP) {
        info.add([
          '${row[0]}',
          '${row[1]}'.substring(0, 11),
          '${row[2]}',
          '${row[3]}',
          '${row[4]}'
        ]);
      }
    }
    for (int g = 0; g < patientP.length; g++) {
      var dateP = info[g][1] + "00:00:00";
      DateTime dt1 = DateTime.parse(dateP);
      DateTime todayDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      if (dt1.compareTo(todayDate) < 0) {
        List<String> oneRow = [];
        oneRow.add(info[g][1]);
        oneRow.add(info[g][4]);
        var physicianP = await conn.query(
            'select name,specialisation from Physician where nationalID = ?',
            [info[g][3]]);
        for (var row in physicianP) {
          oneRow.add('${row[0]}'); //physician name
          oneRow.add('${row[1]}'); //physician spec
        }

        var visitH = await conn.query(
            'select name from Hospital where idhospital = ?', [info[g][2]]);
        for (var row in visitH) {
          oneRow.add('${row[0]}'); //hospital name
        }
        print("oneRow ---------------");
        print(oneRow);
        resultsPre.add(oneRow);
        print(resultsPre);
      }
    }
    return resultsPre;
  }

  static PatientActiveVisit(id) async {
    List<List<String>> resultsUp = [];
    var index = 0;
    var date;
    var patientP = await conn.query(
        'select idvisit,date,idHospital,idPhysician,Department from Visit where idPatient = ? order by date ASC',
        [id]);
    List<List<String>> info = [];

    print("query");
    print(patientP);
    int i = 1;
    for (int g = 0; g < patientP.length; g++) {
      for (var row in patientP) {
        info.add([
          '${row[0]}',
          '${row[1]}'.substring(0, 11),
          '${row[2]}',
          '${row[3]}',
          '${row[4]}'
        ]);
      }
    }
    for (int g = 0; g < patientP.length; g++) {
      var dateP = info[g][1] + "00:00:00";
      DateTime dt1 = DateTime.parse(dateP);
      DateTime todayDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      if (dt1.compareTo(todayDate) > 0 ||
          (dt1.year == todayDate.year &&
              dt1.month == todayDate.month &&
              dt1.day == todayDate.day)) {
        List<String> oneRow = [];
        oneRow.add(info[g][1]);
        oneRow.add(info[g][4]);
        var physicianP = await conn.query(
            'select name,specialisation from Physician where nationalID = ?',
            [info[g][3]]);
        for (var row in physicianP) {
          oneRow.add('${row[0]}');
          oneRow.add('${row[1]}');
        }

        var visitH = await conn.query(
            'select name from Hospital where idhospital = ?', [info[g][2]]);
        for (var row in visitH) {
          oneRow.add('${row[0]}');
        }
        print("oneRow ---------------");
        print(oneRow);
        resultsUp.add(oneRow);
        print(resultsUp);
      }
    }
    return resultsUp;
  }

  static resetPassword(role, id, pass, type) async {
    var r;
    if (type == 'nationalID') {
      if (role.compareTo('patient') == 0) {
        r = await conn.query(
            'update Patient set password=? where NationalID =?', [pass, id]);
      } else if (role.compareTo('Physician') == 0) {
        r = await conn.query(
            'update Physician set password=? where NationalID =?', [pass, id]);
      } else if (role.compareTo('Lab specialist') == 0) {
        r = await conn.query(
            'update LabSpecialist set password=? where NationalID =?',
            [pass, id]);
      }

      print(r.affectedRows);
      print("nationaid");
    } else if (type == 'email') {
      if (role.compareTo('patient') == 0) {
        r = await conn
            .query('update Patient set password=? where email =?', [pass, id]);
      } else if (role.compareTo('Physician') == 0) {
        r = await conn.query(
            'update Physician set password=? where email =?', [pass, id]);
      } else if (role.compareTo('Lab specialist') == 0) {
        r = await conn.query(
            'update LabSpecialist set password=? where email =?', [pass, id]);
      }
      print(id);
      print(r.affectedRows);
      print("email");
    }
  }

  static Future<bool> checkExisting(controler, role, type) async {
    var table = '';
    var result;
    if (role.compareTo('patient') == 0) {
      table = 'Patient';
    } else if (role.compareTo('Physician') == 0) {
      table = 'Physician';
    } else if (role.compareTo('Lab specialist') == 0) {
      table = 'LabSpecialist';
    }
    if (role == "hospital") {
      return false;
    }
    if (type == 'email') {
      var rr = await conn
          .query('select * from ' + table + ' where email = ?', [controler]);
      if (rr.length != 0) {
        return true;
      } else {
        return false;
      }
    } else if (type == 'ID') {
      var rr = await conn.query(
          'select * from ' + table + ' where  NationalID = ?', [controler]);
      if (rr.length != 0) {
        return true;
      } else {
        return false;
      }
    }
  }

  static AuthlogIn(
      String role, int idController, String passwordController) async {
    //connect with table
    print(role);
    print(idController);
    print(passwordController);
    var table = "";
    if (role.compareTo('patient') == 0) {
      table = 'Patient';
    } else if (role.compareTo('Physician') == 0) {
      table = 'Physician';
    } else if (role.compareTo('Lab specialist') == 0) {
      table = 'LabSpecialist';
    }
    var userPassword;

    userPassword = await conn.query(
        'select password from ' + table + ' where nationalId=?',
        [idController]);

    //find user
    print('11');
    print(userPassword);
    for (var row in userPassword) {
      userPassword = '${row[0]}';
    }
    print('22');
    print(userPassword);

    if (userPassword.isEmpty != true) {
      print('33');
      var isCorrect = new DBCrypt().checkpw(passwordController, userPassword);
      print(isCorrect);
      if (isCorrect) {
        return false;
      } else {
        print('Sorry user name or password not correct');
      }
      return true;
    } else {
      print('the user not exisit');
    }
    return true;
  }

  static getEmail(role, id) async {
    var table = "";
    if (role.compareTo('patient') == 0) {
      table = 'Patient';
    } else if (role.compareTo('Physician') == 0) {
      table = 'Physician';
    } else if (role.compareTo('Lab specialist') == 0) {
      table = 'LabSpecialist';
    }
    var email = await conn
        .query('select email from ' + table + ' where nationalId=?', [id]);
    for (var row in email) {
      email = '${row[0]}';
    }
    return email;
  }

  static PhyContInfo(id) async {
    print("id+++++++++++==");
    print(id);
    List<String> stringList = [];
    for (int i = 0; i < id.length; i++) {
      stringList.add(id[i].toString());
    }
    print("gggfjfjfjfjfjjfjfjjfjfjf");
    print(stringList.runtimeType);
    print(stringList);
    List<List<String>> contactInfo = [];

    for (int i = 0; i < id.length; i++) {
      List<String> oneRow = [];
      var PhyIn = await conn.query(
          'select name,email,mobileNo from Physician where nationalId=?',
          [int.parse(stringList[i])]);
      print(stringList[i]);
      for (var row in PhyIn) {
        oneRow.clear();
        oneRow.add('${row[0]}');
        oneRow.add('${row[1]}');
        oneRow.add('${row[2]}');
        print(oneRow);
        contactInfo.add(oneRow);
        print("kkkkkkkkkk");
        print(contactInfo);
      }
    }

    print("contactInfo================");
    print(contactInfo);
    return contactInfo;
  }
}
