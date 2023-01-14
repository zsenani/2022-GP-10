import '../../AuthScreens/signin_screen.dart';
import 'add_medication.dart';
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

class MedicationList extends StatelessWidget {
  MedicationList({Key key, String id, String vid, String role1})
      : super(key: key) {
    idp = int.parse(id);
    visitId = vid;
    role = role1;
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
                  offset: Offset(0, 0),
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
                  TextStyle(fontSize: 15, fontFamily: "RobotoRegular"),
              labelColor: ColorResources.white,
              controller: tabBarController.controller,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.all(
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
    print(
        '##################################################################3');
    print(patientfile);
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (role == 'patient')
                Get.back();
              else if (patientfile == "patientfile") {
                Get.back();
                Get.back();
                Get.back();
                Get.back();
              } else
                Get.back();
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
                child: Icon(Icons.arrow_back, color: ColorResources.grey777),
              ),
            ),
          ),
          SizedBox(width: 3),
          heavyText("Medication List", ColorResources.green009, 30),
          if (role != "patient")
            InkWell(
              onTap: () {
                Get.back();
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.only(top: 0, left: 0),
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
    );
  }
}
