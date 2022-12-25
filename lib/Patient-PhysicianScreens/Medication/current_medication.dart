import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/images.dart';
import 'package:flutter/material.dart';
import '../../database/mysqlDatabase.dart';
import 'medication_list.dart';
import '/../Utiils/text_font_family.dart';
import '/../main.dart';

class currentMedication extends StatefulWidget {
  @override
  State<currentMedication> createState() => _currentMedicationState();
}

class _currentMedicationState extends State<currentMedication> {
  int arraylength = 0;
  int isFilled = 0;
  bool load = false;
  bool empty = false;
  int setlength = 0;
  var resultspre;
  List<Map> toDayList = [];
  List<Map> drName = [];
  List<Map> hospitalname = [];
  List<Map> medicationList = [];
  List<Map> medicationname = [];
  List<Map> sortedList = [];

  var currentday = DateTime.now();
  String current;
  getCurrentMedication() async {
    resultspre = await conn.query(
        'select * from Visit where idPatient=? and idvisit IN(select visitID from VisitMedication where endDate >?)',
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
            'select * from VisitMedication where visitID=? and endDate >?',
            ['${row[0]}', DateTime.now().toUtc()]);
        print('@@@@@@@@@medication visit');
        print(medicaton);
        print(medicaton.length);
        for (var m in medicaton) {
          Med = {
            "visitID": "${m[0]}",
            "medicationID": "${m[1]}",
            "dosage": "${m[2]}",
            "description": "${m[3]}",
            "startDate": "${m[4]}",
            "endDate": "${m[5]}"
          };
          doctor = await conn.query(
              'select name from Physician where nationalID=?', ['${row[4]}']);
          print("%%%%%%%%%% doctor name");
          print(doctor);
          print(doctor.length);
          for (var d in doctor) {
            nameD = {"name": "${d[0]}"};
            drName.add(nameD);
          }

          hospital = await conn.query(
              'select name from Hospital where idhospital=?', ['${row[3]}']);
          print('^^^^^^^^6hospital name');
          print(hospital);
          print(hospital.length);
          for (var h in hospital) {
            nameH = {"name": "${h[0]}"};
            hospitalname.add(nameH);
          }
          medname = await conn.query(
              'select name from Medication where idmedication=?', ['${m[1]}']);
          print("medication name");
          print(medname);
          print(medname.length);
          for (var mn in medname) {
            nameM = {"name": "${mn[0]}"};
            medicationname.add(nameM);
          }
          print(medicationname);
          medicationList.add(Med);
          setlength += 1;
        }
        isFilled = isFilled + 1;
      }
      toDayList.add(day);
    }

    medicationList.sort((a, b) {
      return DateTime.parse(a['endDate'])
          .toUtc()
          .compareTo(DateTime.parse(b['endDate']).toUtc());
      //convert Date string to DateTime and compare
      ////softing on DateTime order (Ascending order by DOB date string)
    });
    print("sssssssssssssssssssssssssssssssssssssssss");
    print(medicationList);
    setState(() {
      arraylength = medicationList.length;
      load = true;
      sortedList = medicationList;
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
    getCurrentMedication();
    medicationList.length < toDayList.length ? load = false : load = true;
    return arraylength != 0
        ? Scaffold(
            backgroundColor: ColorResources.whiteF7F,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: load ? 0 : medicationList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Container(
                          height: 122,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorResources.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        toDayList[index]["image"],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
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
                                              text: hospitalname[index]["name"],
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
                                      SizedBox(height: 3),
                                      RichText(
                                        text: TextSpan(
                                          text: drName[index]["name"],
                                          style: TextStyle(
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_ROMAN,
                                            fontSize: 10,
                                            color: ColorResources.greyA0A,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      mediumText(medicationname[index]["name"],
                                          ColorResources.green009, 20),
                                      SizedBox(height: 4),
                                      romanText(
                                          "Dosage: " +
                                              medicationList[index]["dosage"],
                                          ColorResources.grey777,
                                          12),
                                      SizedBox(height: 3),
                                      romanText(
                                          "Start date: " +
                                              medicationList[index]["startDate"]
                                                  .substring(
                                                      0,
                                                      medicationList[index]
                                                              ["startDate"]
                                                          .indexOf(' ')) +
                                              "    End date: " +
                                              medicationList[index]["endDate"]
                                                  .substring(
                                                      0,
                                                      medicationList[index]
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
                        SizedBox(height: 20),
                        romanText("There is no medication",
                            ColorResources.grey777, 18, TextAlign.center),
                      ],
                    ),
                  )
                : loadingPage(),
          );
  }
}
