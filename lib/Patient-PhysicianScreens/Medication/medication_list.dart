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

class MedicationList extends StatelessWidget {
  MedicationList({Key key, String id, String vid, String Role})
      : super(key: key) {
    idp = int.parse(id);
    visitId = vid;
    role = Role;
  }
  final TabBarController tabBarController = Get.put(TabBarController());
  //String role = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print("medication listttttttttttttttttttt");
    print(role);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          // Padding(
          //   padding: const EdgeInsets.only(top: 40),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 10,
          //       ),
          //       InkWell(
          //         onTap: () {
          //           Navigator.of(context).pop();
          //         },
          //         child: Container(
          //           height: 40,
          //           width: 40,
          //           child: Center(
          //             child:
          //                 Icon(Icons.arrow_back, color: ColorResources.grey777),
          //           ),
          //         ),
          //       ),
          //       Flexible(
          //         flex: 10,
          //         child: HeaderWidget(),
          //       ),
          //       if (role != 'patient')
          //         InkWell(
          //           onTap: () {
          //             Navigator.of(context).pop();
          //             Navigator.of(context).pop();
          //           },
          //           child: Padding(
          //             padding: EdgeInsets.only(top: 10, left: 35, bottom: 10),
          //             child: Container(
          //               height: 60,
          //               width: 60,
          //               child: Center(
          //                 // heightFactor: 100,
          //                 child: Icon(Icons.home_outlined,
          //                     color: ColorResources.grey777),
          //               ),
          //             ),
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
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
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
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
    Stack(
      children: [
        Container(
          height: 50,
          width: Get.width,
          padding: EdgeInsets.only(top: 10, left: 30),
          child: heavyText("Medication List", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
