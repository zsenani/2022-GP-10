import 'package:get/get.dart';
import 'package:medcore/LabScreens/showLabResult.dart';

import '../../database/mysqlDatabase.dart';
import './lab_tests.dart';

import '/../Utiils/colors.dart';
import '/../Utiils/common_widgets.dart';
import '/../Utiils/images.dart';
import '/../Utiils/text_font_family.dart';
import '/../main.dart';
import 'package:flutter/material.dart';

import 'datePicker.dart';

class ActiveReq extends StatefulWidget {
  @override
  State<ActiveReq> createState() => _ActiveReqState();
}

class _ActiveReqState extends State<ActiveReq> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      aa();
    });
  }

  int arraylength = 0;
  int isFilled = 0;
  bool load = false;
  int setlength;
  var resultsActive;
  List<Map> toDayList = [];
  List<Map> drName = [];
  List<Map> hospitalname = [];

  aa() async {
    resultsActive = await conn.query(
        'select * from Visit where idPatient=? and idvisit IN(select visitID from VisitLabTest where status =?)',
        [idp, 'active']);
    print(resultsActive);
    arraylength = resultsActive.length;
    //setlength = resultsActive.length;
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
    for (var row in resultsActive) {
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
        "image": Images.blood_test,
      };

      if (isFilled != arraylength) {
        doctor = await conn.query(
            'select name from Physician where nationalID=?', ['${row[4]}']);
        print(doctor.length);
        for (var d in doctor) {
          nameD = {"name": "${d[0]}"};
          drName.add(nameD);
        }

        hospital = await conn.query(
            'select name from Hospital where idhospital=?', ['${row[3]}']);
        print(hospital.length);
        for (var h in hospital) {
          nameH = {"name": "${h[0]}"};
          hospitalname.add(nameH);
        }

        isFilled = isFilled + 1;
      }
      toDayList.add(day);
    }
    setState(() {
      // arraylength = setlength;
      load = true;
    });
    print(toDayList);
    print(drName);
    print(hospitalname);
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
    return toDayList.isNotEmpty
        ? Scaffold(
            backgroundColor: ColorResources.whiteF7F,
            body: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 0),
                        height: Get.height - 250,
                        child: SingleChildScrollView(
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
                                  itemCount: arraylength,
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: Container(
                                      height: 90,
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
                                                      Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  radius: 20,
                                                  backgroundImage: AssetImage(
                                                    toDayList[index]["image"],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      mediumText(
                                                          drName[index]["name"],
                                                          ColorResources
                                                              .green009,
                                                          20),
                                                      SizedBox(height: 2),
                                                      romanText(
                                                          hospitalname[index]
                                                              ["name"],
                                                          ColorResources
                                                              .grey777,
                                                          12),
                                                      SizedBox(height: 4),
                                                      romanText(
                                                          toDayList[index]
                                                                  ["date"]
                                                              .substring(
                                                                  0,
                                                                  toDayList[index]
                                                                          [
                                                                          "date"]
                                                                      .indexOf(
                                                                          ' ')),
                                                          ColorResources
                                                              .grey777,
                                                          12),
                                                    ],
                                                  ),
                                                  Button(() {
                                                    roleHome == 'patient'
                                                        ? Get.to(
                                                            showlabResult(
                                                                vid: toDayList[
                                                                        index]
                                                                    ["idvisit"],
                                                                id: idp
                                                                    .toString(),
                                                                role:
                                                                    'patient'),
                                                            arguments: 'active')
                                                        : Get.to(
                                                            showlabResult(
                                                                vid: toDayList[
                                                                        index]
                                                                    ["idvisit"],
                                                                id: idPhysician,
                                                                role:
                                                                    'physician'),
                                                            arguments:
                                                                'active');
                                                  },
                                                      "View",
                                                      Color.fromRGBO(
                                                          241, 94, 34, 0.7),
                                                      //ColorResources.green009,
                                                      ColorResources.white),
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
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 320, bottom: 0, right: 0),
                        child: InkWell(
                          onTap: () {
                            _startAdd2(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: ColorResources.green009,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: ColorResources.green009,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Icon(Icons.filter_alt,
                                  color: ColorResources.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ]))
        : Scaffold(
            backgroundColor: ColorResources.whiteF7F,
            body: load
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
                            Images.report2,
                            color: ColorResources.greyA0A,
                            alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(height: 20),
                        romanText("There is no test request",
                            ColorResources.grey777, 18, TextAlign.center),
                      ],
                    ),
                  )
                : loadingPage());
  }

  void _startAdd2(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: DatePicker(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
