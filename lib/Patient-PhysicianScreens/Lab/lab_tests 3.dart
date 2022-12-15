import '../../AuthScreens/signin_screen.dart';
import './datePicker.dart';
import './previousReq.dart';
import '../../Controller/test_tab_conroller.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/text_font_family.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ActiveReq.dart';
import 'add_request.dart';

class labTests extends StatefulWidget {
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
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: EdgeInsets.only(right: 38, left: 5),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: ColorResources.green009.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorResources.green009.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child:
                                  Icon(Icons.add, color: ColorResources.white),
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
                children: [ActiveReq(), PreviousReq()], // pages,
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
          padding: EdgeInsets.only(top: 25, left: 80),
          child: heavyText("Lab Results", ColorResources.green009, 30),
        ),
      ],
    );
  }

  void _startAdd(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: TestRequest(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
