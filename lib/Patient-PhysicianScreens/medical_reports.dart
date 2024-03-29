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
    results = await conn.query(
        'select * from Visit where idPatient=? and assessment is Not null and date<? ORDER BY date DESC, time DESC',
        [idpatient, DateTime.now().toUtc()]);
    print("################33333");
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
        "date": "${row[4]}",
        "idHospital": "${row[2]}",
        "idPhysician": "${row[3]}",
        "idPatient": "${row[5]}",
        "subject": "${row[6]}",
        "object": "${row[7]}",
        "assessment": "${row[8]}",
        "plan": "${row[9]}",
        "Department": "${row[10]}",
      };
      print('row2');
      print("${row[2]}");
      print('row3');
      print("${row[3]}");
      if (isFilled != arraylength) {
        doctor = await conn.query(
            'select name from Physician where nationalID=?', ['${row[3]}']);
        print(doctor.length);
        for (var d in doctor) {
          nameD = {"name": "${d[0]}"};
          drName.add(nameD);
        }

        hospital = await conn.query(
            'select name from Hospital where idhospital=?', ['${row[2]}']);
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
    print('1111111111111111111111111111');
    print(toDayList);
    print('2222222222222222222222');
    print(drName);
    print("333333333333333333");
    print(hospitalname);
  }

  @override
  Widget build(BuildContext context) {
    return toDayList.isEmpty != true && arraylength != 0
        ? Scaffold(
            backgroundColor: ColorResources.whiteF6F,
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    HeaderWidget(),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          itemCount: arraylength,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 15, right: 15),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 45,
                                                width: 40,
                                                child: Image.asset(
                                                  Images.medical2,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: heavyText(
                                                        "Dr. " +
                                                            drName[index]
                                                                ['name'],
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
                                                        color: ColorResources
                                                            .grey777,
                                                      ),
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Date: " +
                                                          toDayList[index]
                                                                  ['date']
                                                              .substring(
                                                                  0,
                                                                  toDayList[index]
                                                                          [
                                                                          'date']
                                                                      .indexOf(
                                                                          ' ')),
                                                      style: TextStyle(
                                                        fontFamily: TextFontFamily
                                                            .AVENIR_LT_PRO_BOOK,
                                                        fontSize: 14,
                                                        color: ColorResources
                                                            .greyA0A,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            'assets/images/right-arrow.png',
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.centerRight,
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
                      const SizedBox(
                        height: 40,
                      ),
                      HeaderWidget(),
                      const SizedBox(height: 230),
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
                                  const SizedBox(height: 20),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            //Get.to(HomeScreen());
            toDayList.clear();
            Navigator.of(context).pop();
          },
          child: const SizedBox(
            height: 40,
            width: 40,
            child: Center(
              child: Icon(Icons.arrow_back, color: ColorResources.grey777),
            ),
          ),
        ),
        Flexible(
          flex: 10,
          child: HeaderName(),
        ),
        if (role != "patient")
          InkWell(
            onTap: () {
              Get.to(HomeScreen(id: idPhysician));
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 10, left: 28, bottom: 10),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child:
                      Icon(Icons.home_outlined, color: ColorResources.grey777),
                ),
              ),
            ),
          ),
        if (role == "patient") const SizedBox(width: 60),
      ],
    );
  }

  Widget HeaderName() {
    return Stack(
      children: [
        Container(
          height: 80,
          width: Get.width,
          padding: const EdgeInsets.only(top: 25, left: 43),
          child: heavyText("Medical Reports", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
