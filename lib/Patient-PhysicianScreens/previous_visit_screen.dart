import 'package:medcore/Patient-PhysicianScreens/medicalHistory/medical_history.dart';
import 'package:medcore/Patient-PhysicianScreens/singleMedicalReport.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';

import 'Lab/lab_tests.dart';
import 'Medication/medication_list.dart';
import 'medical_reports.dart';

class PreviousVisitScreen extends StatefulWidget {
  // HomeScreen({Key? key}) : super(key: key);
  @override
  State<PreviousVisitScreen> createState() => _PreviousVisitScreenState();
}

class _PreviousVisitScreenState extends State<PreviousVisitScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: heavyText("Patient Files", ColorResources.grey777, 18),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 150,
                width: Get.width,
                child: Specialist(),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: heavyText("Services", ColorResources.grey777, 18),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Get.to(singleMedicalReport());
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
              padding: EdgeInsets.only(top: 40),
              child: ListTile(
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    InkWell(
                      onTap: () {
                        Get.to(HomeScreen());
                      },
                      child: Container(
                        child: const Icon(Icons.arrow_back,
                            color: ColorResources.grey777),
                      ),
                    ),
                    Row(children: [
                      SizedBox(width: 44),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heavyText("King Faisal Specialist Hospital",
                                ColorResources.green, 20, TextAlign.center),
                            SizedBox(height: 0.5),
                            bookText("Visit date: 17-Oct-2022",
                                ColorResources.grey777, 20, TextAlign.center),
                            SizedBox(height: 0.5),
                            bookText("Yesterday- 10:45 AM",
                                ColorResources.orange, 20, TextAlign.center),
                          ]),
                    ])
                  ]))),
        ),
        Positioned(
            bottom: -20,
            left: 0.5,
            right: 0.5,
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                      SizedBox(height: 18),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: heavyText("Patient Name: Ahmad Alsaleh",
                            ColorResources.grey777, 16),
                      ),
                      SizedBox(height: 1.5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: heavyText("Patient ID: 1126147832",
                            ColorResources.grey777, 16),
                      ),
                      SizedBox(height: 1.5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: heavyText(
                            "MobileNo: 0505832613", ColorResources.grey777, 16),
                      ),
                      SizedBox(height: 1.5),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          child: heavyText(
                              "Gender: Male", ColorResources.grey777, 16)),
                      SizedBox(height: 1.5),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          child:
                              heavyText("Age: 35", ColorResources.grey777, 16)),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Image(
                              image: AssetImage(Images.height),
                              width: 24,
                              height: 24),
                          mediumText(
                              "Hieght: 170", ColorResources.grey777, 13.5),
                          SizedBox(width: 10),
                          Image(
                            image: AssetImage(Images.weight),
                            width: 21,
                            height: 21,
                          ),
                          SizedBox(width: 1),
                          mediumText(
                              "Weight: 55", ColorResources.grey777, 13.5),
                          SizedBox(width: 8),
                          Image(
                            image: AssetImage(Images.pressurIcon),
                            width: 24,
                            height: 24,
                          ),
                          mediumText("Blood pressure: 90",
                              ColorResources.grey777, 13.5),
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
        padding: EdgeInsets.only(left: 24, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(right: 16),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                    SizedBox(height: 10),
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
