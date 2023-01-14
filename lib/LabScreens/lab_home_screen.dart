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
import 'package:medcore/database/mysqlDatabase.dart';
import '../AuthScreens/signin_screen.dart';
import '../index.dart';

String Id;
bool _loading = true;

String lname = " ";
String lnationalId = " ";
String lemail = " ";
String lDOB = " ";
String lgender = " ";
String lmobileNo = " ";
String Page;
String hid;

class LabHomePage1 extends StatefulWidget {
  LabHomePage1({Key key, String id, String page}) : super(key: key) {
    Id = id;
    Page = page;
  }

  @override
  State<LabHomePage1> createState() => _LabHomePage1State();
}

class _LabHomePage1State extends State<LabHomePage1> {
  int _selectedScreenIndex;

  void initState() {
    print(Page);
    super.initState();
    setState(() {
      if (Page == 'edit')
        _selectedScreenIndex = 1;
      else
        _selectedScreenIndex = 0;
    });
  }

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
String labName;
String labH;
List<String> labInfo = [];

class LabHomePage2 extends StatefulWidget {
  LabHomePage2({Key key, String id}) : super(key: key) {
    ID = id;
  }

  @override
  State<LabHomePage2> createState() => _LabHomePage2State();
}

class _LabHomePage2State extends State<LabHomePage2> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      labSpecalist(ID);
    });
  }

  void getLabProfileData() async {
    var user = await conn.query(
        'select idHospital,NationalID,DOB,email,gender,mobileNo,name from LabSpecialist where NationalID=?',
        [int.parse(Id)]);
    for (var row in user) {
      setState(() {
        hid = '${row[0]}';
        lname = '${row[6]}';
        lnationalId = '${row[1]}';
        lDOB = '${row[2]}'.split(' ')[0];
        lemail = '${row[3]}';
        lgender = '${row[4]}';
        lmobileNo = '${row[5]}';
      });
    }
  }

  Future labSpecalist(ID) async {
    labInfo = await mysqlDatabase.labSpecHomeScreen(ID);
    // return patientInfor;
    labName = labInfo[0].substring(0, labInfo[0].indexOf(" "));
    labH = labInfo[1];
    setState(() {
      _loading = false;
    });
    print("lab specalist home page");
    print(labName);
    print(labH);
  }

  final TabBarController tabBarController = Get.put(TabBarController());

  String greeting() {
    getLabProfileData();
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
          _loading == true ? loadingPage() : LabHomeDetailsContainer(),

          //Tests
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
        gradient: RadialGradient(
          colors: [
            Color.fromRGBO(178, 224, 222, 1),
            Color.fromRGBO(19, 156, 140, 1)
          ],
          radius: 0.75,
          focal: Alignment(0.7, -0.7),
          tileMode: TileMode.clamp,
        ),
      ),
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25, top: 70, bottom: 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "\n" + greeting() + ' $labName',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // padding: const EdgeInsets.only(left: 25, top: 24, right: 5),
                Container(
                  padding: EdgeInsets.only(left: 25, top: 24, right: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' $labH',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
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
                    ActiveTestReq(
                      id: ID,
                    ),
                    PreviouseTestReq(
                      id: ID,
                    ),
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
