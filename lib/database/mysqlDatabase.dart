import 'dart:async';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:mysql1/mysql1.dart';

var conn;

class mysqlDatabase {
  static connect() async {
    var settings = new ConnectionSettings(
        host: 'mysql-99256-0.cloudclusters.net',
        port: 10003,
        user: 'admin',
        password: 'LSszwXSR',
        db: 'medcore');
    conn = await MySqlConnection.connect(settings);
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
    var f = 0;
    var result2;
    phospitals.forEach((element) async {
      if (f < phospitals.length) {
        print(element);
        result2 = await conn.query(
            'insert into HospitalPhysician (idHospital, idPhysician) values (?,?)',
            [element, pnationalId]);
        f = f + 1;
      }
    });

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
    int fnationalId,
  ) async {
    var result = await conn.query(
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
          fmaritalStatus
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

  static checkEmailExsist(role, email) async {
    var table = "";
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    var s;
    var res = await conn
        .query('select email from ' + table + ' where email = ?', [email]);
    print(res);
    for (var row in res) {
      s = '${row[0]}';
    }

    if (res.isEmpty == true)
      return null;
    else
      return s;
  }

  static checkOldPass(role, id) async {
    var table = "";
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';

    var rr = await conn
        .query('select password from ' + table + ' where NationalID = ?', [id]);
    return rr;
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

  static PhysicianVisit(id, type) async {
    List<List<String>> visitPre = [];
    List<List<String>> visitUp = [];
    List<List<String>> info = [];

    var phyVisit = await conn.query(
        'select idvisit,date,time,idHospital,idPatient from Visit where idPhysician = ?',
        [id]);

    for (int g = 0; g < phyVisit.length; g++) {
      for (var row in phyVisit) {
        info.add([
          '${row[0]}',
          '${row[1]}'.substring(0, 11),
          '${row[2]}',
          '${row[3]}',
          '${row[4]}'
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
      if (dt1.isBefore(DateTime.now())) {
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
        print("oneRow ---------------");
        print(oneRow);
        visitPre.add(oneRow);
        print(visitPre);
      } else {
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
        print("oneRow ---------------");
        print(oneRow);
        visitUp.add(oneRow);
        print(visitUp);
      }
    }
    if (type == "Pre") {
      print("resultsPre:");
      print(visitPre);
      return visitPre;
    } else if (type == "Up") {
      print("resultsUp:");
      print(visitUp);
      return visitUp;
    }
  }

  static PatientVisit(id, type) async {
    var index = 0;
    print("inside patient method in mysql");
    print(id);
    var date;
    List<List<String>> resultsPre = [];
    List<List<String>> resultsUp = [];
    var patientP = await conn.query(
        'select idvisit,date,idHospital,idPhysician,Department from Visit where idPatient = ?',
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
      print(i++);
      print("length");
      print(patientP.length);
      print(info);
    }

    print(info);

    for (int g = 0; g < patientP.length; g++) {
      var dateP = info[g][1] + "00:00:00";
      DateTime dt1 = DateTime.parse(dateP);
      if (dt1.isBefore(DateTime.now())) {
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
      } else {
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

    print("inside mysql results:");
    if (type == "Pre") {
      print("resultsPre:");
      print(resultsPre);
      return resultsPre;
    } else if (type == "Up") {
      print("resultsUp:");
      print(resultsUp);
      return resultsUp;
    }
  }

  static resetPassword(role, id, pass, type) async {
    var r;
    if (type == 'nationalID') {
      if (role.compareTo('patient') == 0)
        r = await conn.query(
            'update Patient set password=? where NationalID =?', [pass, id]);
      else if (role.compareTo('Physician') == 0)
        r = await conn.query(
            'update Physician set password=? where NationalID =?', [pass, id]);
      else if (role.compareTo('Lab specialist') == 0)
        r = await conn.query(
            'update LabSpecialist set password=? where NationalID =?',
            [pass, id]);

      print(r.affectedRows);
      print("nationaid");
    } else if (type == 'email') {
      if (role.compareTo('patient') == 0)
        r = await conn
            .query('update Patient set password=? where email =?', [pass, id]);
      else if (role.compareTo('Physician') == 0)
        r = await conn.query(
            'update Physician set password=? where email =?', [pass, id]);
      else if (role.compareTo('Lab specialist') == 0)
        r = await conn.query(
            'update LabSpecialist set password=? where email =?', [pass, id]);
      print(id);
      print(r.affectedRows);
      print("email");
    }
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
    if (role.compareTo('patient') == 0)
      table = 'Patient';
    else if (role.compareTo('Physician') == 0)
      table = 'Physician';
    else if (role.compareTo('Lab specialist') == 0) table = 'LabSpecialist';
    var userPassword = await conn.query(
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
    var email = await conn
        .query('select email from ' + table + ' where nationalId=?', [id]);
    for (var row in email) {
      email = '${row[0]}';
    }
    return email;
  }
}
