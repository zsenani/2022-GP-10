import 'package:medcore/AuthScreens/reset_password_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/patientVisits/previous.dart';
import 'package:medcore/Patient-PhysicianScreens/search_patient.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Controller/tab_controller.dart';
import 'package:medcore/Patient-PhysicianScreens/previous_visit_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/upcomming_visit_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/prev_visit.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_results.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_screen.dart';
import '../AuthScreens/signin_screen.dart';
import 'Lab/add_request.dart';
import 'Lab/lab_tests.dart';
import 'Medication/medication_list.dart';
import 'SearchSymptoms/diagnosis_details.dart';
import 'active_visit.dart';
import 'medicalHistory/medical_history.dart';
import 'medical_reports.dart';
import 'pateint_profile_screen.dart';
import 'patientVisits/patientVisits.dart';
import 'patientVisits/upComming.dart';
import 'singleMedicalReport.dart';
import 'write_diagnose.dart';
import 'package:medcore/database/mysqlDatabase.dart';

String Id;
bool _loading = true;

class PatientHomeScreen extends StatefulWidget {
  PatientHomeScreen({Key key, String id}) : super(key: key) {
    Id = id;
  }

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": PatientVisitScreen()},
    {"screen": patientProfilePage(id: Id)},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorResources.whiteF6F,
        body: _screens[_selectedScreenIndex]["screen"],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedScreenIndex,
          onTap: _selectScreen,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
              backgroundColor: Color.fromRGBO(19, 156, 140, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Color.fromRGBO(19, 156, 140, 1),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> patientInfor = [];
String PDOB = "";
var ageNow = 0;

class PatientVisitScreen extends StatefulWidget {
  // HomeScreen({Key? key}) : super(key: key);
  @override
  State<PatientVisitScreen> createState() => _PatientVisitScreenState();
}

class _PatientVisitScreenState extends State<PatientVisitScreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      patient(Id);
    });
  }

  Future patient(idPatient) async {
    patientInfor = await mysqlDatabase.PatientHomeScreen(idPatient);
    ageNow = DateTime.now().year - int.parse(patientInfor[2].substring(0, 4));
    setState(() {
      _loading = false;
    });
    print("patient home page");
    print(patientInfor[1]);
  }

  final TextEditingController emailController = TextEditingController();
  String role = Get.arguments;

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
      "caller": MedicalHistory(),
    },
    {
      "image": Images.report,
      "text1": "Medical Report",
      "caller": MedicalReports(),
    },
    {
      "image": Images.labTest,
      "text1": "Lab Results",
      "caller": labTests(),
    },
    {
      "image": Images.list,
      "text1": "Medication List",
      "caller": MedicationList(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _loading == true ? loadingPage() : HeaderWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: heavyText("Service:", ColorResources.grey777, 18),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                onTap: () {
                  Get.to(PatientVisit(
                    id: Id,
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
                    child: heavyText("Visits", ColorResources.white, 18),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: heavyText("My Files", ColorResources.grey777, 18),
            ),
            const SizedBox(height: 10),
            Container(
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      Get.to(MedicalHistory(), arguments: "patient");
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
                            heavyText(specialistList[0]["text1"],
                                ColorResources.blue0C1, 15, TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Get.to(MedicalReports(), arguments: "patient");
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
                            heavyText(specialistList[1]["text1"],
                                ColorResources.blue0C1, 15, TextAlign.center),
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
                      Get.to(labTests(), arguments: "patient");
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
                            heavyText(specialistList[2]["text1"],
                                ColorResources.blue0C1, 15, TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Get.to(MedicationList(), arguments: "patient");
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
                            heavyText(specialistList[3]["text1"],
                                ColorResources.blue0C1, 15, TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ]),
            )
          ]),
        ),
      ),
    );
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
            padding: const EdgeInsets.only(top: 60),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        heavyText(
                            greeting() +
                                " " +
                                patientInfor[1], //+ patientInfor[1]
                            ColorResources.green,
                            20,
                            TextAlign.left),

                        const SizedBox(height: 8),
                        // heavyText("ID: 1120772892", ColorResources.grey777, 18,
                        //     TextAlign.left),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 1, bottom: 225),
                    child: InkWell(
                      onTap: () {
                        // Get.to(SignInScreen());
                        showAlertDialog2(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        child: const Icon(Icons.logout_outlined,
                            color: ColorResources.grey777),
                      ),
                    ),
                  ),
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        const SizedBox(height: 13),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child:
                              heavyText("ID: $Id", ColorResources.grey777, 16),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: heavyText("DoB: ${patientInfor[2]}",
                              ColorResources.grey777, 16),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: heavyText("${patientInfor[3]}, $ageNow y",
                                ColorResources.grey777, 16)),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            const Image(
                                image: AssetImage(Images.height),
                                width: 20,
                                height: 20),
                            mediumText("Hieght:", ColorResources.grey777, 12),
                            SizedBox(
                              width: 28,
                              child: romanText(patientInfor[4],
                                  ColorResources.grey777, 12, TextAlign.center),
                            ),
                            const SizedBox(width: 10),
                            const Image(
                              image: AssetImage(Images.weight),
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 1),
                            mediumText("Weight:", ColorResources.grey777, 12),
                            SizedBox(
                              width: 28,
                              child: romanText(patientInfor[5],
                                  ColorResources.grey777, 12, TextAlign.center),
                            ),
                            const SizedBox(width: 8),
                            const Image(
                              image: AssetImage(Images.pressurIcon),
                              width: 20,
                              height: 20,
                            ),
                            mediumText(
                                "Blood pressure:", ColorResources.grey777, 12),
                            SizedBox(
                              width: 28,
                              child: romanText(patientInfor[6],
                                  ColorResources.grey777, 12, TextAlign.center),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ))
      ],
    );
  }
}
