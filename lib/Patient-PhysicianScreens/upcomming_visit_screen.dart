import 'package:medcore/Patient-PhysicianScreens/Lab/add_request.dart';
import 'package:medcore/Patient-PhysicianScreens/Lab/lab_tests.dart';
import 'package:medcore/Patient-PhysicianScreens/Medication/medication_list.dart';
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

class UpCommingVisitScreen extends StatefulWidget {
  // HomeScreen({Key? key}) : super(key: key);
  @override
  State<UpCommingVisitScreen> createState() => _UpCommingVisitScreenState();
}

class _UpCommingVisitScreenState extends State<UpCommingVisitScreen> {
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
            HeaderWidget(),
            const SizedBox(height: 40),
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
              const SizedBox(height: 38),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: heavyText("Services", ColorResources.grey777, 18),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Get.to(TestRequest());
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
                    Get.to(writeDiagnose());
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
              padding: const EdgeInsets.only(top: 60),
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
                    Row(children: [
                      const SizedBox(width: 55),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heavyText("King Faisal Specialist Hospital",
                                ColorResources.green, 20, TextAlign.center),
                            const SizedBox(height: 0.5),
                            bookText("Visit date: 1-Oct-2022",
                                ColorResources.grey777, 20, TextAlign.center),
                            const SizedBox(height: 0.5),
                            bookText("Today- 10:45 AM", ColorResources.orange,
                                20, TextAlign.center),
                          ]),
                    ])
                  ]))),
        ),
        Positioned(
            bottom: -40,
            left: 0.5,
            right: 0.5,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  height: 180,
                  width: 380,
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
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: heavyText("Patient Name: Ahmad Alsaleh",
                                  ColorResources.grey777, 16),
                            ),
                            const SizedBox(height: 1.5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: heavyText("Patient ID: 1126147832",
                                  ColorResources.grey777, 16),
                            ),
                            const SizedBox(height: 1.5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: heavyText("MobileNo: 0505832613",
                                  ColorResources.grey777, 16),
                            ),
                          ]),
                      const SizedBox(height: 1.5),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: heavyText(
                              "Gender: Male", ColorResources.grey777, 16)),
                      const SizedBox(height: 1.5),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child:
                              heavyText("Age: 23", ColorResources.grey777, 16)),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          const Image(
                              image: AssetImage(Images.height),
                              width: 24,
                              height: 24),
                          mediumText("Hieght:", ColorResources.grey777, 13.5),
                          const SizedBox(
                            width: 28,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: '170',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Image(
                            image: AssetImage(Images.weight),
                            width: 21,
                            height: 21,
                          ),
                          const SizedBox(width: 1),
                          mediumText("Weight:", ColorResources.grey777, 13.5),
                          const SizedBox(
                            width: 28,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: '55',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Image(
                            image: AssetImage(Images.pressurIcon),
                            width: 24,
                            height: 24,
                          ),
                          mediumText(
                              "Blood pressure:", ColorResources.grey777, 13.5),
                          const SizedBox(
                            width: 31,
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: '90',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
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
