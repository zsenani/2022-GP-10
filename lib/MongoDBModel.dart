<<<<<<< HEAD
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
/////Physician//////
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.id,
    this.name,
    this.password,
    this.dob,
    this.gender,
    this.mobileNo,
    this.email,
    this.nationality,
    this.specialization,
    // this.visit,
    this.nationalId,
    this.hospitals,
  });

  ObjectId id;
  String name;
  String password;
  String dob;
  String gender;
  String mobileNo;
  String email;
  String nationality;
  String specialization;
//  List<String> visit;
  String nationalId;
  List<String> hospitals;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        dob: json["DOB"],
        gender: json["gender"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        nationality: json["nationality"],
        specialization: json["specialization"],
        //  visit: List<String>.from(json["Visit"].map((x) => x)),
        nationalId: json["nationalId"],
        hospitals: List<String>.from(json["hospitals"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "name": name,
        "password": password,
        "DOB": dob,
        "gender": gender,
        "mobileNo": mobileNo,
        "email": email,
        "nationality": nationality,
        "specialization": specialization,
        //  "Visit": List<dynamic>.from(visit.map((x) => x)),
        "nationalId": nationalId,
        "hospitals": List<dynamic>.from(hospitals.map((x) => x)),
      };
}

class Id {
  Id({
    this.oid,
  });

  String oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}
=======
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
/////Physician//////
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.id,
    this.name,
    this.password,
    this.dob,
    this.gender,
    this.mobileNo,
    this.email,
    this.nationality,
    this.specialization,
    // this.visit,
    this.nationalId,
    this.hospitals,
  });

  ObjectId id;
  String name;
  String password;
  String dob;
  String gender;
  String mobileNo;
  String email;
  String nationality;
  String specialization;
//  List<String> visit;
  String nationalId;
  List<String> hospitals;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        dob: json["DOB"],
        gender: json["gender"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        nationality: json["nationality"],
        specialization: json["specialization"],
        //  visit: List<String>.from(json["Visit"].map((x) => x)),
        nationalId: json["nationalId"],
        hospitals: List<String>.from(json["hospitals"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "name": name,
        "password": password,
        "DOB": dob,
        "gender": gender,
        "mobileNo": mobileNo,
        "email": email,
        "nationality": nationality,
        "specialization": specialization,
        //  "Visit": List<dynamic>.from(visit.map((x) => x)),
        "nationalId": nationalId,
        "hospitals": List<dynamic>.from(hospitals.map((x) => x)),
      };
}

class Id {
  Id({
    this.oid,
  });

  String oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
