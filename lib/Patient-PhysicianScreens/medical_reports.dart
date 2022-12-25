import 'package:get/get_connect/http/src/utils/utils.dart';

import './singleMedicalReport.dart';
import '../Utiils/colors.dart';
import '../Utiils/common_widgets.dart';
import '../Utiils/images.dart';
import '../Utiils/text_font_family.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/mysqlDatabase.dart';
import 'home_screen.dart';

String idpatient;

class MedicalReports extends StatefulWidget {
  MedicalReports({Key key, String id}) : super(key: key) {
    idpatient = id;
  }
  @override
  State<MedicalReports> createState() => MedicalReportsState();
}

int arraylength = 0;
int isFilled = 0;
bool empty = false;
int setlength;
var results;
List<Map> toDayList = [];
List<Map> drName = [];
List<Map> hospitalname = [];

class MedicalReportsState extends State<MedicalReports> {
  String role = Get.arguments;

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMedicalRepot();
    });
  }

  getMedicalRepot() async {
    results =
        await conn.query('select * from Visit where idPatient=?', [idpatient]);
    print(results);
    arraylength = results.length;
    setlength = results.length;
    print(arraylength);
    arraylength == 0 ? empty = true : empty = false;
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
    for (var row in results) {
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
      arraylength = setlength;
    });
    print(toDayList);
    print(drName);
    print(hospitalname);
  }

  @override
  Widget build(BuildContext context) {
    //if (toDayList.isEmpty == true) aa();
    // else
    //   setState(() {
    //     arraylength = setlength;
    //   });
    // ;

    print(toDayList);
    print(drName);
    print(hospitalname);
    return toDayList.isEmpty != true && arraylength != 0
        ? Scaffold(
            backgroundColor: ColorResources.whiteF6F,
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            //Get.to(HomeScreen());
                            toDayList.clear();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40,
                            width: 20,
                            decoration: BoxDecoration(
                              color: ColorResources.whiteF6F,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorResources.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Icon(Icons.arrow_back,
                                  color: ColorResources.grey777),
                            ),
                          ),
                        ),
                        HeaderWidget(),
                        if (role != "patient")
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 0, left: 20),
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Center(
                                  child: Icon(Icons.home_outlined,
                                      color: ColorResources.grey777),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          itemCount: arraylength,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                      singleMedicalReport(
                                          ind: int.parse(
                                              toDayList[index]['idvisit'])),
                                      arguments: role);
                                },
                                child: Container(
                                  height: 90,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    color: ColorResources.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: ColorResources.greyA0A
                                          .withOpacity(0.1),
                                      width: 4,
                                    ),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 7),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            width: 40,
                                            child: Image.asset(
                                              Images.medical2,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: heavyText(
                                                    drName[index]['name'],
                                                    //dr.name
                                                    //getCareList[index]["text2"],
                                                    ColorResources.green009,
                                                    20,
                                                    TextAlign.left),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: hospitalname[index]
                                                      ['name'],
                                                  //hospital name
                                                  style: TextStyle(
                                                    fontFamily: TextFontFamily
                                                        .AVENIR_LT_PRO_BOOK,
                                                    fontSize: 14,
                                                    color:
                                                        ColorResources.grey777,
                                                  ),
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: "Date: " +
                                                      toDayList[index]['date']
                                                          .substring(
                                                              0,
                                                              toDayList[index]
                                                                      ['date']
                                                                  .indexOf(
                                                                      ' ')),
                                                  style: TextStyle(
                                                    fontFamily: TextFontFamily
                                                        .AVENIR_LT_PRO_BOOK,
                                                    fontSize: 14,
                                                    color:
                                                        ColorResources.greyA0A,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: ColorResources.whiteF6F,
            body: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              //Get.to(HomeScreen());
                              toDayList.clear();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 40,
                              width: 20,
                              decoration: BoxDecoration(
                                color: ColorResources.whiteF6F,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: ColorResources.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.arrow_back,
                                    color: ColorResources.grey777),
                              ),
                            ),
                          ),
                          HeaderWidget(),
                        ],
                      ),
                      SizedBox(height: 230),
                      empty
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
                                      Images.noVisit,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  romanText(
                                      "There is no medical report",
                                      ColorResources.grey777,
                                      18,
                                      TextAlign.center),
                                ],
                              ),
                            )
                          : loadingPage(),
                    ]))));
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  Widget HeaderWidget() {
    return Stack(
      children: [
        Container(
          height: 50,
          width: 350,
          padding: EdgeInsets.only(top: 8, left: 40),
          child: heavyText("Medical Reports", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
