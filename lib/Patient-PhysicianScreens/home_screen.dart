// ignore_for_file: deprecated_member_use

import 'package:medcore/Patient-PhysicianScreens/search_patient.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Controller/tab_controller.dart';
import 'package:medcore/Patient-PhysicianScreens/previous_visit_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/upcomming_visit_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/prev_visit.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_results.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_screen.dart';
import 'SearchSymptoms/diagnosis_details.dart';
import 'active_visit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": labHomePage()},
    {"screen": SearchPatient()},
    {"screen": labHomePage()},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Color.fromRGBO(19, 156, 140, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
            backgroundColor: Color.fromRGBO(19, 156, 140, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Color.fromRGBO(19, 156, 140, 1),
          ),
        ],
      ),
    );
  }
}

class labHomePage extends StatelessWidget {
  //const labHomePage({Key key}) : super(key: key);
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
          //Image
          LabHomeDetailsContainer(),

          //Doctor Detail
          LabOptionsContainer(),
        ],
      ),
    );
  }

  Widget LabHomeDetailsContainer() {
    return Container(
      height: 340,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorResources.green, ColorResources.lightBlue2],

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
        child: Stack(children: [
          Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 25, top: 70, right: 80, bottom: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    greeting() + ' Dr.Saleh',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 25, top: 24, right: 5),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'King Faisal Specialist Hospital',
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
        ]),
      ),
    );
  }

  Widget LabOptionsContainer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 170),
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
                                    padding: EdgeInsets.all(1),
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
                                        unselectedLabelStyle: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "RobotoRegular"),
                                        labelColor: ColorResources.white,
                                        controller: tabBarController.controller,
                                        indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Color.fromRGBO(241, 94, 34, 1)),
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
                    ActiveVisit(),
                    PreVisitList(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Get.to(SearchScreen());
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
                          "Symptoms Search", ColorResources.white, 18),
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
}
