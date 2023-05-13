import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';

import 'current_medication.dart';
import './past_medication.dart';
import '../../Controller/tab_controller.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/text_font_family.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int idp;
String visitId;
String role;
String patientfile;
String idPhysician;

class MedicationList extends StatelessWidget {
  MedicationList({Key key, String id, String vid, String role1, String idPHy})
      : super(key: key) {
    idp = int.parse(id);
    visitId = vid;
    role = role1;
    idPhysician = idPHy;
  }
  final TabBarController tabBarController = Get.put(TabBarController());
  //String role = Get.arguments;
  @override
  Widget build(BuildContext context) {
    patientfile = Get.arguments;
    print("medication listttttttttttttttttttt");
    print(role);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          Container(
            height: 50,
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorResources.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                  color: ColorResources.black.withOpacity(0.1),
                ),
              ],
            ),
            child: TabBar(
              tabs: tabBarController.myTabs,
              unselectedLabelColor: ColorResources.greyA0A,
              labelStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: TextFontFamily.AVENIR_LT_PRO_MEDIUM),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 15, fontFamily: "RobotoRegular"),
              labelColor: ColorResources.white,
              controller: tabBarController.controller,
              indicator: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: ColorResources.green009.withOpacity(0.8)),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: TabBarView(
                controller: tabBarController.controller,
                children: [
                  currentMedication(
                    vid: visitId,
                    role: role,
                    idPHy: idPhysician,
                  ),
                  PastMedication()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget HeaderWidget() {
    print('#################################################################3');
    print(patientfile);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            if (role == 'patient') {
              Get.back();
            } else if (patientfile == "patientfile") {
              Get.back();
              Get.back();
              Get.back();
              Get.back();
              Get.back();
            } else {
              Get.back();
            }
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
        // const SizedBox(width: 60),
        // heavyText("Medication List", ColorResources.green009, 30),
        if (role != "patient")
          InkWell(
            onTap: () {
              Get.to(HomeScreen(id: idPhysician));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, bottom: 10),
              child: Container(
                height: 60,
                width: 60,
                child: const Center(
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
          padding: const EdgeInsets.only(top: 25, left: 50),
          child: heavyText("Medication List", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
