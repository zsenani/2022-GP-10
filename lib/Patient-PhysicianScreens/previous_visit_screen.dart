import 'package:medcore/Patient-PhysicianScreens/medicalHistory/medical_history.dart';
import 'package:medcore/Patient-PhysicianScreens/prev_visit.dart';
import 'package:medcore/Patient-PhysicianScreens/singleMedicalReport.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/mysqlDatabase.dart';
import 'Lab/lab_tests.dart';
import 'Medication/medication_list.dart';
import 'medical_reports.dart';
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
var age1 = 0;

int visitId;

class PreviousVisitScreen extends StatefulWidget {
  PreviousVisitScreen(
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
      int visitID})
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
    visitId = visitID;
    age1 = DateTime.now().year - int.parse(patientAge.substring(0, 4));
    if (int.parse(patientAge.substring(5, 7)) > DateTime.now().month) {
      age1 = age1 - 1;
    } else if (int.parse(patientAge.substring(5, 7)) == DateTime.now().month) {
      if (int.parse(patientAge.substring(8, 10)) > DateTime.now().day) {
        age1 = age1 - 1;
      }
    }
  }
  @override
  State<PreviousVisitScreen> createState() => _PreviousVisitScreenState();
}

class _PreviousVisitScreenState extends State<PreviousVisitScreen> {
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

  final List<Map> specialistList = [
    {
      "image": Images.history,
      "text1": "Medical History",
      "caller": MedicalHistory(
        id: patientId,
      ),
    },
    {
      "image": Images.report,
      "text1": "Medical Report",
      "caller": MedicalReports(id: patientId),
    },
    {
      "image": Images.labTest,
      "text1": "Lab Results",
      "caller": labTests(id: patientId, idPhy: physicianId, r: 'physician'),
    },
    {
      "image": Images.list,
      "text1": "Medication List",
      "caller": MedicationList(
        id: patientId,
        idPHy: physicianId,
      ),
    },
  ];

  void getData() async {
    name = '';
    gender = '';
    bloodType = '';
    nationalID = '';
    DOB = '';
    nationality = '';
    maritalStatus = '';
    age = 0;
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
        nationality = '${row[5]}';
        maritalStatus = '${row[6]}';
        // age = '${row[7]}';
        age = DateTime.now().year - int.parse(DOB.substring(0, 4));
        if (int.parse(DOB.substring(5, 7)) > DateTime.now().month) {
          age = age - 1;
        } else if (int.parse(DOB.substring(5, 7)) == DateTime.now().month) {
          if (int.parse(DOB.substring(8, 10)) > DateTime.now().day) {
            age = age - 1;
          }
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

  String searchPatient = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print('00000000000000000000000');
    print(searchPatient);
    print('111111111111');
    print(visitId);
    print('dd');
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: heavyText("Patient Files", ColorResources.grey777, 18),
              ),
              const SizedBox(height: 10),
              if (searchPatient != 'searchPatient')
                SizedBox(
                  height: 150,
                  width: Get.width,
                  child: Specialist(),
                ),
              if (searchPatient != 'searchPatient') const SizedBox(height: 35),
              if (searchPatient != 'searchPatient')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: heavyText("Services", ColorResources.grey777, 18),
                ),
              if (searchPatient != 'searchPatient') const SizedBox(height: 10),
              if (searchPatient != 'searchPatient')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: InkWell(
                    onTap: () {
                      Get.to(singleMedicalReport(
                        ind: visitId,
                        page: 'prePhysician',
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
                            "Show a Diagnosis", ColorResources.white, 18),
                      ),
                    ),
                  ),
                ),
              if (searchPatient == "searchPatient")
                Container(
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        onTap: () {
                          getData();
                          Get.to(specialistList[0]["caller"],
                              arguments: "PREphysician");
                        },
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            color: ColorResources.whiteF6F,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorResources.grey9AA.withOpacity(0.25),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    specialistList[0]["image"],
                                  ),
                                  width: 65,
                                  height: 65,
                                ),
                                const SizedBox(height: 10),
                                heavyText(
                                    specialistList[0]["text1"],
                                    ColorResources.blue0C1,
                                    15,
                                    TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          Get.to(specialistList[1]["caller"],
                              arguments: "PREphysician");
                        },
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            color: ColorResources.whiteF6F,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorResources.grey9AA.withOpacity(0.25),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    specialistList[1]["image"],
                                  ),
                                  width: 65,
                                  height: 65,
                                ),
                                const SizedBox(height: 10),
                                heavyText(
                                    specialistList[1]["text1"],
                                    ColorResources.blue0C1,
                                    15,
                                    TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        onTap: () {
                          Get.to(specialistList[2]["caller"],
                              arguments: "PREphysician");
                        },
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            color: ColorResources.whiteF6F,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorResources.grey9AA.withOpacity(0.25),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    specialistList[2]["image"],
                                  ),
                                  width: 65,
                                  height: 65,
                                ),
                                const SizedBox(height: 10),
                                heavyText(
                                    specialistList[2]["text1"],
                                    ColorResources.blue0C1,
                                    15,
                                    TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          Get.to(specialistList[3]["caller"],
                              arguments: "PREphysician");
                        },
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            color: ColorResources.whiteF6F,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorResources.grey9AA.withOpacity(0.25),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    specialistList[3]["image"],
                                  ),
                                  width: 65,
                                  height: 65,
                                ),
                                const SizedBox(height: 10),
                                heavyText(
                                    specialistList[3]["text1"],
                                    ColorResources.blue0C1,
                                    15,
                                    TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
                )
            ],
          ),
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
            borderRadius: const BorderRadius.only(
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
              padding: const EdgeInsets.only(top: 50),
              child: ListTile(
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: const Icon(Icons.arrow_back,
                            color: ColorResources.grey777),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heavyText(hospitalName, ColorResources.green, 20,
                                TextAlign.center),
                            const SizedBox(height: 0.5),
                            bookText("Date: " + visitDate,
                                ColorResources.grey777, 20, TextAlign.center),
                            const SizedBox(height: 0.5),
                            bookText("Time: " + visitTime,
                                ColorResources.orange, 20, TextAlign.center),
                          ]),
                    ])
                  ]))),
        ),
        Positioned(
            bottom: 15,
            left: 0.5,
            right: 0.5,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  height: 140,
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
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: heavyText("Patient ID: " + patientId,
                            ColorResources.grey777, 16),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: heavyText(patientGender + ", $age1 y",
                              ColorResources.grey777, 16)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                              image: AssetImage(Images.height),
                              width: 20,
                              height: 20),
                          mediumText("Hieght: ", ColorResources.grey777, 12),
                          SizedBox(
                            width: 35,
                            child: romanText(
                                patientHeight == "null" ? "---" : patientHeight,
                                ColorResources.grey777,
                                12,
                                TextAlign.center),
                          ),
                          const SizedBox(width: 12),
                          const Image(
                            image: AssetImage(Images.weight),
                            width: 17,
                            height: 17,
                          ),
                          const SizedBox(width: 1),
                          mediumText(" Weight: ", ColorResources.grey777, 12),
                          SizedBox(
                            width: 30,
                            child: romanText(
                                patientWeight == "null" ? "---" : patientWeight,
                                ColorResources.grey777,
                                12,
                                TextAlign.center),
                          ),
                          const SizedBox(width: 10),
                          const Image(
                            image: AssetImage(Images.pressurIcon),
                            width: 20,
                            height: 20,
                          ),
                          mediumText(
                              " Blood pressure: ", ColorResources.grey777, 12),
                          SizedBox(
                            width: 33,
                            child: romanText(
                                patientBloodP == "null" ? "---" : patientBloodP,
                                ColorResources.grey777,
                                12,
                                TextAlign.center),
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
                  arguments: "PREphysician");
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
            ),
          ),
        ),
      ),
    );
  }
}
