import 'package:medcore/Patient-PhysicianScreens/Lab/add_request.dart';
import 'package:medcore/Patient-PhysicianScreens/Lab/lab_tests.dart';
import 'package:medcore/Patient-PhysicianScreens/Medication/medication_list.dart';
import 'package:medcore/Patient-PhysicianScreens/active_visit.dart';
import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/medicalHistory/medical_history.dart';
import 'package:medcore/Patient-PhysicianScreens/medical_reports.dart';
import 'package:medcore/Patient-PhysicianScreens/write_diagnose.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/mysqlDatabase.dart';
import 'patient_home_screen.dart';

String patientId = "";
String patientName = "";
String patientGender = "";
var patientDob;
String patientHeight = "";
String patientWeight = "";
String patientBloodP = "";
String hospitalName = "";
String visitDate = "";
String visitTime = "";
String visitId = '';

class UpCommingVisitScreen extends StatefulWidget {
  UpCommingVisitScreen(
      {Key key,
      String patientID,
      String patientN,
      String patientG,
      String patientAge,
      String patientH,
      String patientW,
      String patientB,
      String hospitalN,
      String visitD,
      String visitT,
      String vid})
      : super(key: key) {
    patientId = patientID;
    patientName = patientN;
    patientGender = patientG;
    patientDob = DateTime.now().year - int.parse(patientAge.substring(0, 4));
    patientHeight = patientH;
    patientWeight = patientW;
    patientBloodP = patientB;
    hospitalName = hospitalN;
    visitDate = visitD;
    visitTime = visitT;
    visitId = vid;
  }
  @override
  State<UpCommingVisitScreen> createState() => _UpCommingVisitScreenState();
}

class _UpCommingVisitScreenState extends State<UpCommingVisitScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   getData();
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  void getData() async {
    var user = await conn.query(
        'select name,gender,bloodType,nationalID,DOB,nationality,maritalStatus from Patient where nationalId=?',
        [int.parse(patientId)]);
    for (var row in user) {
      setState(() {
        name = '${row[0]}';
        gender = '${row[1]}';
        bloodType = '${row[2]}';
        nationalID = '${row[3]}';
        DOB = '${row[4]}'.split(' ')[0];
        nationality = '${row[5]}'.split(' ')[1];
        maritalStatus = '${row[6]}';
        // age = '${row[7]}';
        age = DateTime.now().year - int.parse(DOB.substring(0, 4));
        if (int.parse(DOB.substring(5, 7)) >= DateTime.now().month) {
          if (int.parse(DOB.substring(8, 10)) > DateTime.now().day)
            age = age - 1;
        }
      });
    }

    var info = await conn.query(
        'select allergies,socialHistory,familyHistory,surgicalHistory,medicalIllnesses from Patient where nationalId=?',
        [int.parse(patientId)]);
    for (var row in info) {
      setState(() {
        allergies = '${row[0]}';
        socialHistory = '${row[1]}';
        familyHistory = '${row[2]}';
        surgicalHistory = '${row[3]}';
        medicalIllnesses = '${row[4]}';
      });
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  final List<Map> specialistList = [
    {
      "image": Images.history,
      "text1": "Medical History",
      "caller": MedicalHistory(id: patientId),
    },
    {
      "image": Images.report,
      "text1": "Medical Report",
      "caller": MedicalReports(id: patientId),
    },
    {
      "image": Images.labTest,
      "text1": "Lab Results",
      "caller": labTests(
          id: patientId, idPhy: physicianId, r: 'physician', vid: visitId),
    },
    {
      "image": Images.list,
      "text1": "Medication List",
      "caller": MedicationList(
        id: patientId,
        vid: visitId,
        Role: 'UPphysician',
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    print(visitId);
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HeaderWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: heavyText("Patient Files", ColorResources.grey777, 18),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              width: Get.width,
              child: Specialist(),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: heavyText("Services", ColorResources.grey777, 18),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Get.to(TestRequest(vid: visitId));
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: heavyText(
                          "Request a Lab Test", ColorResources.white, 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Get.to(writeDiagnose(
                      id: int.parse(visitId),
                    ));
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: heavyText(
                          "Write a Diagnosis", ColorResources.white, 18),
                    ),
                  ),
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }

  Widget HeaderWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 320,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(240),
              bottomRight: Radius.circular(240),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorResources.green.withOpacity(0.2),
                ColorResources.lightBlue.withOpacity(0.2),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      child: const Icon(Icons.arrow_back,
                          color: ColorResources.grey777),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heavyText(hospitalName, ColorResources.green, 20,
                              TextAlign.center),
                          const SizedBox(height: 0.5),
                          bookText("Date: " + visitDate, ColorResources.grey777,
                              20, TextAlign.center),
                          const SizedBox(height: 0.5),
                          bookText("Time: " + visitTime, ColorResources.orange,
                              20, TextAlign.center),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            left: 0.5,
            right: 0.5,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  height: 150,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorResources.whiteF6F,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorResources.grey9AA.withOpacity(0.25),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: heavyText("Patient Name: " + patientName,
                            ColorResources.grey777, 16),
                      ),
                      const SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: heavyText("Patient ID: " + patientId,
                            ColorResources.grey777, 16),
                      ),
                      const SizedBox(height: 2),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: heavyText(patientGender + ", $patientDob y",
                              ColorResources.grey777, 16)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                              image: AssetImage(Images.height),
                              width: 20,
                              height: 20),
                          mediumText("Hieght:", ColorResources.grey777, 12),
                          SizedBox(
                            width: 28,
                            child: romanText(patientHeight,
                                ColorResources.grey777, 12, TextAlign.center),
                          ),
                          const SizedBox(width: 12),
                          const Image(
                            image: AssetImage(Images.weight),
                            width: 17,
                            height: 17,
                          ),
                          const SizedBox(width: 1),
                          mediumText("Weight:", ColorResources.grey777, 12),
                          SizedBox(
                            width: 28,
                            child: romanText(patientWeight,
                                ColorResources.grey777, 12, TextAlign.center),
                          ),
                          const SizedBox(width: 12),
                          const Image(
                            image: AssetImage(Images.pressurIcon),
                            width: 20,
                            height: 20,
                          ),
                          mediumText(
                              "Blood pressure:", ColorResources.grey777, 12),
                          SizedBox(
                            width: 28,
                            child: romanText(patientBloodP,
                                ColorResources.grey777, 12, TextAlign.center),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }

  Widget Specialist() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        itemCount: specialistList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 24, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
              onTap: () {
                Get.to(specialistList[index]["caller"],
                    arguments: "UPphysician");
              },
              child: Container(
                height: 145,
                width: 135,
                decoration: BoxDecoration(
                  color: ColorResources.whiteF6F,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorResources.grey9AA.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          specialistList[index]["image"],
                        ),
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(height: 10),
                      heavyText(specialistList[index]["text1"],
                          ColorResources.blue0C1, 15, TextAlign.center),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
