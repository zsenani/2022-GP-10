import 'package:flutter/foundation.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:get/get.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import '../AuthScreens/signin_screen.dart';
import '../Patient-PhysicianScreens/home_screen.dart';
import '../Patient-PhysicianScreens/patient_home_screen.dart';
import '../Utiils/text_font_family.dart';
import 'lab_home_screen.dart';
import 'previouse_test_request.dart';

String visitID;
String ID;
String Role;
bool _loading = true;
List<String> testNameglobal = [];
List<String> testsIDglobal = [];
List<String> testsResultglobal = [];

class showlabResult extends StatefulWidget {
  showlabResult({String vid, String role, String id}) {
    visitID = vid;
    Role = role;
    ID = id;
  }
  @override
  State<showlabResult> createState() => showlabResultState();
}

bool cleared = false;

class showlabResultState extends State<showlabResult> {
  String page = Get.arguments;

  void initState() {
    print("****************************888888");
    print(page);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      testNameglobal.clear();
      testsIDglobal.clear();
      testsResultglobal.clear();
      labTestID(visitID);
    });
  }

  List<TextEditingController> _controller;

  labTestID(visitid) async {
    List<String> testID = [];
    List<String> testNames = [];
    List<String> result = [];
    var ID = await conn.query(
        'select labTestID from VisitLabTest where visitID = ?',
        [visitid]); //here check
    print(ID);

    for (var row in ID) {
      print('${row[0]}');
      testID.add('${row[0]}');
    }
    print("testId list cady_zozo:");
    print(testID);
    for (int i = 0; i < testID.length; i++) {
      var testsNam = await conn.query(
          'select name from LabTest where idlabTest = ?',
          [testID[i]]); //here check
      for (var row in testsNam) {
        testNames.add('${row[0]}');
      }
    }
    for (int i = 0; i < testID.length; i++) {
      var r = await conn.query(
          'select result from VisitLabTest where labTestID = ? and visitID=? ',
          [testID[i], visitid]); //here check
      for (var row in r) {
        result.add('${row[0]}');
      }
    }
    setState(() {
      testsIDglobal = testID;
      testNameglobal = testNames;
      testsResultglobal = result;
      _controller =
          List.generate(testNameglobal.length, (i) => TextEditingController());
      _loading = false;
    });

    print('global');
    print(testsIDglobal);
  }

  @override
  Widget build(BuildContext context) {
    //labTestID(visitID);
    // testNameglobal.clear();
    // testsIDglobal.clear();
    // testsResultglobal.clear();
    return Scaffold(
        backgroundColor: ColorResources.whiteF6F,
        appBar: AppBar(
          backgroundColor: ColorResources.whiteF6F,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 18, top: 8, bottom: 8),
            child: InkWell(
              onTap: () {
                testNameglobal.clear();
                testsIDglobal.clear();
                testsResultglobal.clear();
                Get.back();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorResources.whiteF6F,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorResources.greyA0A.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.arrow_back, color: ColorResources.grey777),
                ),
              ),
            ),
          ),
          title: mediumText("Test Request", ColorResources.grey777, 24),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 1),
              child: InkWell(
                onTap: () {
                  print(ID);
                  print(Role);
                  testNameglobal.clear();
                  testsIDglobal.clear();
                  testsResultglobal.clear();
                  Role == 'labS'
                      ? Get.to(LabHomePage1(id: ID))
                      : Role == 'patient'
                          ? Get.to(PatientHomeScreen(id: ID))
                          : Get.to(HomeScreen(id: ID));
                  //Role=='patient'?Get.to();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: const Icon(Icons.home, color: ColorResources.grey777),
                ),
              ),
            ),
          ],
        ),
        body: _loading == true ? loadingPage() : labTestinfo());
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  Widget labTestinfo() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Column(
        children: [
          SizedBox(height: 15),
          SizedBox(
            height: 60,
            child: Container(
              color: ColorResources.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mediumText('Test Name   ', ColorResources.white, 24),
                  mediumText('Result', ColorResources.white, 24),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          testsIDglobal.length == 0
              ? SizedBox(height: 400, child: loadingPage())
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: testsIDglobal.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  mediumText(testNameglobal[index],
                                      ColorResources.grey777, 24),
                                  mediumText(
                                      page == 'active'
                                          ? '-'
                                          : testsResultglobal[index],
                                      ColorResources.grey777,
                                      24),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
