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
        .query('select password from ' + table + ' where nationalID = ?', [id]);
    return rr;
  }

  static resetPassword(role, id, pass, type) async {
    var r;
    if (type == 'nationalID') {
      if (role.compareTo('patient') == 0)
        r = await conn.query(
            'update Patient set password=? where nationalID =?', [pass, id]);
      else if (role.compareTo('Physician') == 0)
        r = await conn.query(
            'update Physician set password=? where nationalID =?', [pass, id]);
      else if (role.compareTo('Lab specialist') == 0)
        r = await conn.query(
            'update LabSpecialist set password=? where nationalID =?',
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
          'select * from ' + table + ' where  nationalID = ?', [controler]);
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

    for (var row in userPassword) {
      userPassword = '${row[0]}';
    }
    print(userPassword);
    if (userPassword != null) {
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
