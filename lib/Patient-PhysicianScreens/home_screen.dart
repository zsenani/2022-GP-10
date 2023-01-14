// ignore_for_file: deprecated_member_use

// import 'dart:js';

import 'package:medcore/Patient-PhysicianScreens/pateint_profile_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/patient_home_screen.dart';
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
import '../AuthScreens/signin_screen.dart';
import 'SearchSymptoms/diagnosis_details.dart';
import 'active_visit.dart';
import 'package:medcore/Patient-PhysicianScreens/Physician_profile_screen.dart';
import 'package:medcore/database/mysqlDatabase.dart';

String Id;
bool _loading = true;
String Page;
String PHname = "";
String PHnationalID = "";
String PHgender = "";
String PHmobileNo = "";
String PHDOB = "";
String PHemail = "";

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, String id, String page}) : super(key: key) {
    Id = id;
    Page = page;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreenIndex;
  void initState() {
    print(Page);
    super.initState();
    setState(() {
      if (Page == 'edit')
        _selectedScreenIndex = 2;
      else
        _selectedScreenIndex = 0;
    });
  }

  final List _screens = [
    {"screen": labHomePage()},
    {"screen": SearchPatient(id: Id)},
    {"screen": PhysicianProfilePage(id: Id)},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorResources.whiteF6F,
        body: _screens[_selectedScreenIndex]["screen"],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedScreenIndex,
          onTap: _selectScreen,
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
      ),
    );
  }
}

String physicianName = "";

class labHomePage extends StatefulWidget {
  @override
  State<labHomePage> createState() => _labHomePageState();
}

class _labHomePageState extends State<labHomePage> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      physician(Id);
    });
  }

  void getProfileData() async {
    var user = await conn.query(
        'select name,nationalId,DOB,email,gender,mobileNo from Physician where nationalID=?',
        [int.parse(Id)]);
    for (var row in user) {
      setState(() {
        PHname = '${row[0]}';
        PHnationalID = '${row[1]}';
        PHDOB = '${row[2]}'.split(' ')[0];
        PHemail = '${row[3]}';
        PHgender = '${row[4]}';
        PHmobileNo = '${row[5]}';
      });
    }
  }

  Future physician(ID) async {
    physicianName = await mysqlDatabase.PhysicianHomeScreen(ID);
    // return patientInfor;
    physicianName = physicianName.substring(0, physicianName.indexOf(" "));
    setState(() {
      _loading = false;
    });
    print("physician home page");
    print(physicianName);
  }

  final TabBarController tabBarController = Get.put(TabBarController());

  String greeting() {
    getProfileData();
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
          _loading == true ? loadingPage() : LabHomeDetailsContainer(),

          //Doctor Detail
          LabOptionsContainer(),
        ],
      ),
    );
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorResources.green, ColorResources.lightBlue2],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 25, top: 70, bottom: 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\n" + greeting() + " Dr." + physicianName,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 90),
                      child: InkWell(
                        onTap: () {
                          // Get.to(SignInScreen());
                          showAlertDialogP(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child: const Icon(Icons.logout_outlined,
                              color: Color.fromARGB(255, 86, 90, 123)),
                        ),
                      ),
                    ),
                  ],
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
                                        unselectedLabelStyle: const TextStyle(
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
                    ActiveVisit(
                      id: Id,
                    ),
                    PreVisitList(
                      id: Id,
                    ),
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

showAlertDialogP(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text(
      "Cancel",
      style: TextStyle(
        fontSize: 15,
      ),
    ),
    onPressed: () => Navigator.pop(context),
  );
  Widget continueButton = TextButton(
    child: const Text(
      "Yes",
      style: TextStyle(
        fontSize: 15,
      ),
    ),
    onPressed: () {
      Get.to(SignInScreen(
        role: "hospital",
      ));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Logout"),
    content: const Text("Are you sure you want to logout?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
