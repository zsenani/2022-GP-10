import './previousReq.dart';
import '../../Controller/test_tab_conroller.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/text_font_family.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ActiveReq.dart';

int idp;
String idPhysician;
String roleHome;
String visitId;
String hospName;

class labTests extends StatefulWidget {
  labTests(
      {Key key, String id, String idPhy, String r, String vid, String hosName})
      : super(key: key) {
    idp = int.parse(id);
    idPhysician = idPhy;
    roleHome = r;
    visitId = vid;
    hospName = hosName;
  }
  static const String routeName = '/lab_tests';
  @override
  State<labTests> createState() => _labTestsState();
}

class _labTestsState extends State<labTests> {
  final LabTabBarController tabBarController = Get.put(LabTabBarController());
  String role = Get.arguments;
  //"patient";
  static final List<Widget> pages = [ActiveReq(), PreviousReq()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(
                    child:
                        Icon(Icons.arrow_back, color: ColorResources.grey777),
                  ),
                ),
              ),
              Flexible(
                flex: 10,
                child: HeaderWidget(),
              ),
              if (role != 'patient')
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10, left: 35, bottom: 10),
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        // heightFactor: 100,
                        child: Icon(Icons.home_outlined,
                            color: ColorResources.grey777),
                      ),
                    ),
                  ),
                ),
            ],
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
                  ActiveReq(vid: visitId, role: role),
                  PreviousReq()
                ], // pages,
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
          height: 80,
          width: Get.width,
          padding: const EdgeInsets.only(top: 25, left: 80),
          child: heavyText("Lab Results", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
