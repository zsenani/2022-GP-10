// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Welcome2 welcomeFromJson(String str) => Welcome2.fromJson(json.decode(str));

String welcomeToJson(Welcome2 data) => json.encode(data.toJson());

class Welcome2 {
  Welcome2({
    @required this.id,
    @required this.name,
    @required this.password,
    @required this.dob,
    @required this.gender,
    @required this.mobileNo,
    @required this.email,
    @required this.nationality,
    @required this.maritalStatus,
    this.height,
    this.weight,
    @required this.nationalId,
  });

  ObjectId id;
  String name;
  String password;
  String dob;
  String gender;
  String mobileNo;
  String email;
  String nationality;
  String maritalStatus;
  String height;
  String weight;
  String nationalId;

  factory Welcome2.fromJson(Map<String, dynamic> json) => Welcome2(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        dob: json["DOB"],
        gender: json["gender"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        nationality: json["nationality"],
        maritalStatus: json["maritalStatus"],
        height: json["height"],
        weight: json["weight"],
        nationalId: json["nationalId"],
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
        "maritalStatus": maritalStatus,
        "height": height,
        "weight": weight,
        "nationalId": nationalId,
      };
}

class Id {
  Id({
    @required this.oid,
  });

  String oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}

// class MedicalHistory {
//     MedicalHistory({
//         @required this.allergies,
//         @required this.bloodType,
//         @required this.surgicalHistory,
//         @required this.familyHistory,
//         @required this.socialHistory,
//         @required this.medicalIllnesses,
//     });

//     List<String> allergies;
//     String bloodType;
//     List<String> surgicalHistory;
//     List<String> familyHistory;
//     List<String> socialHistory;
//     List<String> medicalIllnesses;

//     factory MedicalHistory.fromJson(Map<String, dynamic> json) => MedicalHistory(
//         allergies: List<String>.from(json["allergies"].map((x) => x)),
//         bloodType: json["bloodType"],
//         surgicalHistory: List<String>.from(json["surgicalHistory"].map((x) => x)),
//         familyHistory: List<String>.from(json["familyHistory"].map((x) => x)),
//         socialHistory: List<String>.from(json["socialHistory"].map((x) => x)),
//         medicalIllnesses: List<String>.from(json["medicalIllnesses"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "allergies": List<dynamic>.from(allergies.map((x) => x)),
//         "bloodType": bloodType,
//         "surgicalHistory": List<dynamic>.from(surgicalHistory.map((x) => x)),
//         "familyHistory": List<dynamic>.from(familyHistory.map((x) => x)),
//         "socialHistory": List<dynamic>.from(socialHistory.map((x) => x)),
//         "medicalIllnesses": List<dynamic>.from(medicalIllnesses.map((x) => x)),
//     };
// }
