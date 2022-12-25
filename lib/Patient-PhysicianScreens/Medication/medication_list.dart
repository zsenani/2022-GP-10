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

class MedicationList extends StatelessWidget {
  MedicationList({Key key, String id}) : super(key: key) {
    idp = int.parse(id);
  }
  final TabBarController tabBarController = Get.put(TabBarController());
  String role = Get.arguments;
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
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
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
                role == 'UPphysician'
                    ? Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            _startAdd(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 20,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(right: 24, left: 7),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: ColorResources.green009.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      ColorResources.green009.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.add,
                                    color: ColorResources.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 1),
                  child: InkWell(
                    onTap: () {
                      Get.to(SignInScreen());
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
          SizedBox(
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
                children: [currentMedication(), PastMedication()],
              ),
            ),
          ),
          SizedBox(height: 70),
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
          padding: EdgeInsets.only(top: 10, left: 50),
          child: heavyText("Medication List", ColorResources.green009, 30),
        ),
      ],
    );
  }

  void _startAdd(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      // isDismissible: true,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AddMedication(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
