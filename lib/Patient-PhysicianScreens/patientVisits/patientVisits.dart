import 'package:medcore/Patient-PhysicianScreens/pateint_profile_screen.dart';

import '../../Controller/patient_visit_tab_controller.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/text_font_family.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'previous.dart';
import 'upComming.dart';

String patientId;

class PatientVisit extends StatelessWidget {
  PatientVisit({Key key, String id}) : super(key: key) {
    patientId = id;
  }
  final PatientTabBarController tabBarController =
      Get.put(PatientTabBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    // UpCommingVisitState().upVisitM("1029384756");
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: const Center(
                      child:
                          Icon(Icons.arrow_back, color: ColorResources.grey777),
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: HeaderWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 1),
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
          const SizedBox(
            height: 20,
          ),
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
                  UpCommingVisit(
                    id: patientId,
                  ),
                  PreviousVisit(
                    id: patientId,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget HeaderWidget() {
    return Stack(
      children: [
        Container(
          height: 50,
          width: Get.width,
          padding: const EdgeInsets.only(top: 10, left: 118),
          child: heavyText("Visits", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
