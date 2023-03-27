import '../../database/mysqlDatabase.dart';
import '/../Utiils/colors.dart';
import '/../Utiils/common_widgets.dart';
import '/../Utiils/images.dart';
import '/../Utiils/text_font_family.dart';
import '/../main.dart';
import 'package:flutter/material.dart';

import 'medication_list.dart';

class PastMedication extends StatefulWidget {
  @override
  State<PastMedication> createState() => _PastMedicationState();
}

class _PastMedicationState extends State<PastMedication> {
  int arraylength = 0;
  int isFilled = 0;
  bool load = false;
  bool empty = false;
  int setlength = 0;
  var resultspre;
  List<Map> toDayList = [];

  List<Map> glopalMedication = [];
  var currentday = DateTime.now();
  String current;
  getPastMedication() async {
    resultspre = await conn.query(
        'select * from Visit where idPatient=? and idvisit IN(select visitID from VisitMedication where endDate <?)',
        [idp, DateTime.now().toUtc()]);
    print("#########all visit have end medication");
    print(resultspre);
    arraylength = resultspre.length;
    arraylength == 0 ? empty = true : empty = false;
    print(arraylength);
    Map day = {
      "idvisit": "",
      "time": "",
      "date": "",
      "idHospital": "",
      "idPhysician": "",
      "idPatient": "",
      "subject": "",
      "object": "",
      "assessment": "",
      "plan": "",
      "Department": "",
    };
    Map nameD = {"name": ""};
    var doctor;
    Map nameH = {"Hospitalname": ""};
    var hospital;
    Map Med = {
      "visitID": "",
      "medicationID": "",
      "dosage": "",
      "description": "",
      "startDate": "",
      "endDate": ""
    };
    var medicaton;
    Map nameM = {"medname": ""};
    var medname;
    for (var row in resultspre) {
      day = {
        "idvisit": "${row[0]}",
        "time": "${row[1]}",
        "date": "${row[2]}",
        "idHospital": "${row[3]}",
        "idPhysician": "${row[4]}",
        "idPatient": "${row[5]}",
        "subject": "${row[6]}",
        "object": "${row[7]}",
        "assessment": "${row[8]}",
        "plan": "${row[9]}",
        "Department": "${row[10]}",
        "image": Images.pills2,
      };

      if (isFilled != arraylength) {
        medicaton = await conn.query(
            'select * from VisitMedication where visitID=? and endDate <?',
            ['${row[0]}', DateTime.now().toUtc()]);
        print('@@@@@@@@@medication visit');
        print(medicaton);
        print(medicaton.length);
        for (var m in medicaton) {
          Map global = {};
          Med = {
            "visitID": "${m[0]}",
            "medicationID": "${m[1]}",
            "dosage": "${m[2]}",
            "description": "${m[3]}",
            "startDate": "${m[4]}",
            "endDate": "${m[5]}"
          };
          global["visitID"] = Med["visitID"];
          global["medicationID"] = Med["medicationID"];
          global["dosage"] = Med["dosage"];
          global["description"] = Med["description"];
          global["startDate"] = Med["startDate"];
          global["endDate"] = Med["endDate"];
          doctor = await conn.query(
              'select name from Physician where nationalID=?', ['${row[4]}']);
          print("%%%%%%%%%% doctor name");
          print(doctor);
          print(doctor.length);
          for (var d in doctor) {
            nameD = {"name": "${d[0]}"};
          }
          global["drname"] = nameD["name"];
          hospital = await conn.query(
              'select name from Hospital where idhospital=?', ['${row[3]}']);
          print('^^^^^^^^6hospital name');
          print(hospital);
          print(hospital.length);
          for (var h in hospital) {
            nameH = {"name": "${h[0]}"};
          }
          global["hospitalname"] = nameH["name"];
          medname = await conn.query(
              'select name from Medication where idmedication=?', ['${m[1]}']);
          print("medication name");
          print(medname);
          print(medname.length);
          for (var mn in medname) {
            nameM = {"name": "${mn[0]}"};
          }
          global["medicationname"] = nameM["name"];
          glopalMedication.add(global);
          print('gloooooooooooooooooobal');
          print(global);

          setlength += 1;
        }
        isFilled = isFilled + 1;
      }
      toDayList.add(day);
    }
    glopalMedication.sort((a, b) => (DateTime.parse(b['endDate']).toUtc())
        .compareTo(DateTime.parse(a['endDate']).toUtc()));

    setState(() {
      arraylength = glopalMedication.length;
      load = true;
    });
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getPastMedication();
    glopalMedication.length < toDayList.length ? load = false : load = true;
    return arraylength != 0
        ? Scaffold(
            backgroundColor: ColorResources.whiteF7F,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: load ? 0 : glopalMedication.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          //height: 122,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorResources.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        toDayList[index]["image"],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: glopalMedication[index]
                                                  ["hospitalname"],
                                              style: TextStyle(
                                                fontFamily: TextFontFamily
                                                    .AVENIR_LT_PRO_ROMAN,
                                                fontSize: 10,
                                                color: ColorResources.greyA0A,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      RichText(
                                        text: TextSpan(
                                          text: "Dr. " +
                                              glopalMedication[index]["drname"],
                                          style: TextStyle(
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_ROMAN,
                                            fontSize: 10,
                                            color: ColorResources.greyA0A,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      mediumText(
                                          glopalMedication[index]
                                              ["medicationname"],
                                          ColorResources.green009,
                                          20),
                                      const SizedBox(height: 4),
                                      romanText(
                                          "Dosage: " +
                                              glopalMedication[index]["dosage"],
                                          ColorResources.grey777,
                                          12),
                                      if (glopalMedication[index]
                                              ["description"] !=
                                          null)
                                        const SizedBox(height: 4),
                                      if (glopalMedication[index]
                                              ["description"] !=
                                          null)
                                        romanText(
                                            "Description: " +
                                                glopalMedication[index]
                                                    ["description"],
                                            ColorResources.grey777,
                                            12),
                                      const SizedBox(height: 4),
                                      romanText(
                                          "Start date: " +
                                              glopalMedication[index]
                                                      ["startDate"]
                                                  .substring(
                                                      0,
                                                      glopalMedication[index]
                                                              ["startDate"]
                                                          .indexOf(' ')) +
                                              "    End date: " +
                                              glopalMedication[index]["endDate"]
                                                  .substring(
                                                      0,
                                                      glopalMedication[index]
                                                              ["endDate"]
                                                          .indexOf(' ')),
                                          ColorResources.grey777,
                                          12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: ColorResources.whiteF7F,
            body: empty
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: Image.asset(
                            Images.prescription2,
                            color: ColorResources.greyA0A,
                            alignment: Alignment.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        romanText("There is no medication",
                            ColorResources.grey777, 18, TextAlign.center),
                      ],
                    ),
                  )
                : loadingPage());
  }
}
