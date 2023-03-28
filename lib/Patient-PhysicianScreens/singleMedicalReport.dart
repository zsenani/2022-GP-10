import '../Utiils/colors.dart';
import '../Utiils/common_widgets.dart';
import '../Utiils/text_font_family.dart';
import '../database/mysqlDatabase.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int idddd;
bool _loading = true;
String Page;

class singleMedicalReport extends StatefulWidget {
  final int ind;
  singleMedicalReport({Key key, @required this.ind, String page})
      : super(key: key) {
    Page = page;
  }

  @override
  State<singleMedicalReport> createState() => _singleMedicalReportState();
}

class _singleMedicalReportState extends State<singleMedicalReport> {
  String role = Get.arguments;
  // print(role);
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMedicalRepot(widget.ind);
    });
    _loading = true;
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  int arraylength = 0;

  int isFilled = 0;

  bool empty = false;

  int setlength;

  var results;

  List<Map> toDayList = [];

  List<Map> drName = [];

  List<Map> hospitalname = [];

  getMedicalRepot(idvisit) async {
    results =
        await conn.query('select * from Visit where idvisit=?', [idvisit]);
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

      _loading = false;
    });
    print(toDayList);
    print(drName);
    print(hospitalname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: _loading == true
          ? loadingPage()
          : Stack(
              children: [
                //Image
                DoctorHeader(context),

                //Doctor Detail
                DoctorDetailsContainer(),
              ],
            ),
    );
  }

  Widget DoctorHeader(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30),
        height: 340,
        width: Get.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(178, 224, 222, 1),
              Color.fromRGBO(19, 156, 140, 1)
            ],
            radius: 0.75,
            focal: Alignment(0.7, -0.7),
            tileMode: TileMode.clamp,
          ),
        ),
        child: Container(
          child: Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: Container(
                    height: 40,
                    width: 40,
                    child: const Center(
                      child:
                          Icon(Icons.arrow_back, color: ColorResources.white),
                    ),
                  ),
                ),
              ),
              //SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 70,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dr. " + drName[0]['name'],
                        style: TextStyle(
                          fontFamily: TextFontFamily.AVENIR_LT_PRO_ROMAN,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                        text: hospitalname[0]['name'],
                        style: TextStyle(
                          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                          fontSize: 18,
                          color: ColorResources.white,
                        ),
                      )),
                      RichText(
                        text: TextSpan(
                          text: "Date: " +
                              toDayList[0]['date'].substring(
                                  0, toDayList[0]['date'].indexOf(' ')) +
                              " Time: " +
                              toDayList[0]['time'],
                          style: TextStyle(
                            fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                            fontSize: 18,
                            color: ColorResources.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),

              InkWell(
                onTap: () {
                  ///////////////////////////////
                  if (role == 'patient' || Page == 'prePhysician') {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
                child: Padding(
                  /////////////////////////////////////
                  padding: const EdgeInsets.only(right: 5, bottom: 180),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: const Center(
                      // heightFactor: 100,
                      child: Icon(Icons.home_outlined,
                          color: ColorResources.white),
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ));
  }

  Widget DoctorDetailsContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 210),
      child: Container(
        height: 950,
        width: Get.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: ColorResources.white,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 10,
              left: 24,
              right: 24,
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: heavyText("Subject",
                              const Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(
                              toDayList[0]['subject'] != "null"
                                  ? toDayList[0]['subject']
                                  : '',
                              const Color.fromARGB(212, 0, 0, 0),
                              16),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: mediumText("Object",
                              const Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(
                              toDayList[0]['object'] != "null"
                                  ? toDayList[0]['object']
                                      .replaceAll("[", "")
                                      .replaceAll("]", "")
                                  : '',
                              const Color.fromARGB(212, 0, 0, 0),
                              16),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: mediumText("Assessment",
                              const Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(
                              toDayList[0]['assessment'] != 'null'
                                  ? toDayList[0]['assessment']
                                  : '',
                              const Color.fromARGB(212, 0, 0, 0),
                              16),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: mediumText(
                              "Plan", const Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(
                              toDayList[0]['plan'] != "null"
                                  ? toDayList[0]['plan']
                                  : '',
                              const Color.fromARGB(212, 0, 0, 0),
                              16),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
