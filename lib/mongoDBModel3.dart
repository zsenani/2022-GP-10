// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Welcome3 welcomeFromJson(String str) => Welcome3.fromJson(json.decode(str));

String welcomeToJson(Welcome3 data) => json.encode(data.toJson());

class Welcome3 {
  Welcome3({
    @required this.id,
    @required this.name,
    @required this.password,
    @required this.dob,
    @required this.gender,
    @required this.mobileNo,
    @required this.email,
    @required this.nationality,
    @required this.nationalId,
    @required this.hospital,
  });

  ObjectId id;
  String name;
  String password;
  String dob;
  String gender;
  String mobileNo;
  String email;
  String nationality;
  String nationalId;
  String hospital;
  factory Welcome3.fromJson(Map<String, dynamic> json) => Welcome3(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        dob: json["DOB"],
        gender: json["gender"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        nationality: json["nationality"],
        nationalId: json["nationalId"],
        hospital: json["hospital"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "password": password,
        "DOB": dob,
        "gender": gender,
        "mobileNo": mobileNo,
        "email": email,
        "nationality": nationality,
        "nationalId": nationalId,
        "hospital": hospital,
      };
}
