// ignore_for_file: deprecated_member_use

import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Controller/tab_controller.dart';
import 'package:medcore/LabScreens/active_test_request.dart';
import 'package:medcore/LabScreens/previouse_test_request.dart';
import 'package:medcore/LabScreens/lab_profile_screen.dart';

String Id;

class LabHomePage1 extends StatefulWidget {
  LabHomePage1({Key key, String id}) : super(key: key) {
    Id = id;
  }

  @override
  State<LabHomePage1> createState() => _LabHomePage1State();
}

class _LabHomePage1State extends State<LabHomePage1> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": LabHomePage2(id: Id)},
    {"screen": LabProfilePage(id: Id)}
  ];

  void selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: ColorResources.whiteF6F,
          body: _screens[_selectedScreenIndex]["screen"],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedScreenIndex,
            onTap: selectScreen,
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
      ),
    );
  }
}

String ID;

class LabHomePage2 extends StatelessWidget {
  LabHomePage2({Key key, String id}) : super(key: key) {
    ID = id;
  }
  final TabBarController tabBarController = Get.put(TabBarController());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: Stack(
        children: [
          //Welcome part
          LabHomeDetailsContainer(),

          //Tests
          LabOptionsContainer(),
        ],
      ),
    );
  }

  Widget LabHomeDetailsContainer() {
    return Container(
      height: 340,
      width: Get.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: RadialGradient(
          colors: [
            Color.fromRGBO(178, 224, 222, 1),
            Color.fromRGBO(19, 156, 140, 1)
          ],
          radius: 0.75,
          focal: Alignment(0.7, -0.7),
          tileMode: TileMode.clamp,
          // begin: Alignment.topRight,
          // end: Alignment.bottomLeft,
          // colors: [
          //   Color.fromRGBO(178, 224, 222, 1).withOpacity(0.4),
          //   Color.fromRGBO(19, 156, 140, 1).withOpacity(0.9),
          //],
        ),
      ),
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 25, top: 70, right: 80, bottom: 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      greeting() + ' JOHN',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, top: 24, right: 5),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Alhabib Hospital',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, top: 20, right: 80),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lab ID: 23826',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget LabOptionsContainer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 220),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: ColorResources.whiteF6F,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SingleChildScrollView(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(1),
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
                                          color: ColorResources.black
                                              .withOpacity(0.1),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      child: TabBar(
                                        tabs: tabBarController.myTabs,
                                        unselectedLabelColor:
                                            ColorResources.greyA0A,
                                        labelStyle: TextStyle(
                                            fontSize: 16,
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_MEDIUM),
                                        unselectedLabelStyle: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "RobotoRegular"),
                                        labelColor: ColorResources.white,
                                        controller: tabBarController.controller,
                                        indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color.fromRGBO(
                                                241, 94, 34, 1)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // here
              Expanded(
                child: TabBarView(
                  controller: tabBarController.controller,
                  children: [
                    ActiveTestReq(),
                    PreviouseTestReq(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
