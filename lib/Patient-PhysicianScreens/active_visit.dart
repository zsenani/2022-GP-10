import 'package:medcore/Patient-PhysicianScreens/upcomming_visit_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/database/mysqlDatabase.dart';

import '../Utiils/images.dart';

List<List<String>> activeVisit = [];
bool _loading = true;
String physicianId;
List<List<String>> todayVisits = [];
List<List<String>> upcommingVisits = [];

class ActiveVisit extends StatefulWidget {
  ActiveVisit({Key key, String id}) : super(key: key) {
    physicianId = id;
  }
  @override
  State<ActiveVisit> createState() => _ActiveVisitState();
}

class _ActiveVisitState extends State<ActiveVisit> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      activeVisitP(physicianId);
    });
  }

  Future activeVisitP(idVisit) async {
    todayVisits.clear();

    upcommingVisits.clear();

    activeVisit.clear();

    _loading = true;
    //activeVisit = await mysqlDatabase.PhysicianVisit(idVisit, "Up");
    activeVisit = await mysqlDatabase.PhysicianActiveVisit(idVisit);
    print("in visit");
    print(activeVisit);
    // print(activeVisit[0][0]);
    for (int i = 0; i < activeVisit.length; i++) {
      activeVisit.sort((b, a) {
        var adate = a[i];
        var bdate = b[i];
        return -adate.compareTo(bdate);
      });
    }

    for (int i = 0; i < activeVisit.length; i++) {
      print("loop today list");
      print(i);
      var visitDate = "${activeVisit[i][1]}00:00:00";
      var dateVisit = DateTime.parse(visitDate);
      if (dateVisit.year == DateTime.now().year &&
          dateVisit.month == DateTime.now().month &&
          dateVisit.day == DateTime.now().day) {
        print(activeVisit[i]);
        todayVisits.add(activeVisit[i]);
      } else {
        upcommingVisits.add(activeVisit[i]);
      }
    }
    print("today visits:");
    print(todayVisits.length);
    print(todayVisits);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _loading == true
            ? loadingPage()
            : upcommingVisits.isEmpty && todayVisits.isEmpty
                ? emptyVis()
                : todayVisits.isNotEmpty && upcommingVisits.isEmpty
                    ? TodatVOnly()
                    : todayVisits.isEmpty && upcommingVisits.isNotEmpty
                        ? upcommingV()
                        : fullVis());
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  Widget TodatVOnly() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //today visit
          const SizedBox(height: 15),
          mediumText("      Today Visits ", ColorResources.grey777, 15),
          const SizedBox(height: 10),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todayVisits.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () async {
                    Get.to(UpCommingVisitScreen(
                      patientID: todayVisits[index][9],
                      hospitalN: todayVisits[index][2],
                      visitD: todayVisits[index][1],
                      visitT: todayVisits[index][10],
                      patientAge: todayVisits[index][5],
                      patientB: todayVisits[index][8],
                      patientG: todayVisits[index][4],
                      patientH: todayVisits[index][6],
                      patientN: todayVisits[index][3],
                      patientW: todayVisits[index][7],
                      vid: todayVisits[index][0],
                    ));
                    var visits = await conn.query(
                        'select idvisit from Visit where idPatient = ?',
                        [todayVisits[index][9]]);
                    isFilled3 = 0;
                    visitsIds.clear();
                    int visitsArrayLength = await visits.length;
                    for (var row2 in visits) {
                      if (isFilled3 != visitsArrayLength) {
                        int visit = int.parse('${row2[0]}');
                        visitsIds.add(visit);
                        isFilled3 = isFilled3 + 1;
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorResources.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: todayVisits[index][2],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily
                                              .AVENIR_LT_PRO_ROMAN,
                                          fontSize: 14,
                                          color: ColorResources.green009,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 45),
                                    romanText(todayVisits[index][1],
                                        ColorResources.grey777, 14),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                mediumText("Patient: ${todayVisits[index][3]}",
                                    ColorResources.grey777, 18),
                                const SizedBox(height: 5),
                                romanText("Visit ID: ${todayVisits[index][0]}",
                                    ColorResources.grey777, 12),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/right-arrow.png',
                            height: 30,
                            width: 30,
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget upcommingV() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //upcomming visit
          const SizedBox(height: 10),
          mediumText("      Upcomming Visits ", ColorResources.grey777, 15),
          const SizedBox(height: 10),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: upcommingVisits.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  // onTap: () {
                  //   Get.to(UpCommingVisitScreen(
                  //     patientID: upcommingVisits[index][9],
                  //     hospitalN: upcommingVisits[index][2],
                  //     visitD: upcommingVisits[index][1],
                  //     visitT: upcommingVisits[index][10],
                  //     patientAge: upcommingVisits[index][5],
                  //     patientB: upcommingVisits[index][8],
                  //     patientG: upcommingVisits[index][4],
                  //     patientH: upcommingVisits[index][6],
                  //     patientN: upcommingVisits[index][3],
                  //     patientW: upcommingVisits[index][7],
                  //     vid: upcommingVisits[index][0],
                  //   ));
                  // },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorResources.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: upcommingVisits[index][2],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily
                                              .AVENIR_LT_PRO_ROMAN,
                                          fontSize: 14,
                                          color: ColorResources.green009,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                    romanText(upcommingVisits[index][1],
                                        ColorResources.grey777, 14),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                mediumText(
                                    "Patient: ${upcommingVisits[index][3]}",
                                    ColorResources.grey777,
                                    18),
                                const SizedBox(height: 5),
                                romanText(
                                    "Visit ID: ${upcommingVisits[index][0]}",
                                    ColorResources.grey777,
                                    12),
                              ],
                            ),
                          ),
                          // Image.asset(
                          //   'assets/images/right-arrow.png',
                          //   height: 30,
                          //   width: 30,
                          //   alignment: Alignment.centerRight,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fullVis() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //today visit
          const SizedBox(height: 15),
          mediumText("      Today Visits ", ColorResources.grey777, 15),
          const SizedBox(height: 10),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todayVisits.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () async {
                    Get.to(UpCommingVisitScreen(
                      patientID: todayVisits[index][9],
                      hospitalN: todayVisits[index][2],
                      visitD: todayVisits[index][1],
                      visitT: todayVisits[index][10],
                      patientAge: todayVisits[index][5],
                      patientB: todayVisits[index][8],
                      patientG: todayVisits[index][4],
                      patientH: todayVisits[index][6],
                      patientN: todayVisits[index][3],
                      patientW: todayVisits[index][7],
                      vid: todayVisits[index][0],
                    ));
                    var visits = await conn.query(
                        'select idvisit from Visit where idPatient = ?',
                        [todayVisits[index][9]]);
                    int visitsArrayLength = await visits.length;
                    for (var row2 in visits) {
                      if (isFilled3 != visitsArrayLength) {
                        int visit = int.parse('${row2[0]}');
                        visitsIds.add(visit);
                        isFilled3 = isFilled3 + 1;
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorResources.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: todayVisits[index][2],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily
                                              .AVENIR_LT_PRO_ROMAN,
                                          fontSize: 14,
                                          color: ColorResources.green009,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 45),
                                    romanText(todayVisits[index][1],
                                        ColorResources.grey777, 14),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                mediumText("Patient: ${todayVisits[index][3]}",
                                    ColorResources.grey777, 18),
                                const SizedBox(height: 5),
                                romanText("Visit ID: ${todayVisits[index][0]}",
                                    ColorResources.grey777, 12),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/right-arrow.png',
                            height: 30,
                            width: 30,
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //upcomming visit
          const SizedBox(height: 5),
          mediumText("      Upcomming Visits ", ColorResources.grey777, 15),
          const SizedBox(height: 10),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: upcommingVisits.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  // onTap: () {
                  //   Get.to(UpCommingVisitScreen(
                  //     patientID: upcommingVisits[index][9],
                  //     hospitalN: upcommingVisits[index][2],
                  //     visitD: upcommingVisits[index][1],
                  //     visitT: upcommingVisits[index][10],
                  //     patientAge: upcommingVisits[index][5],
                  //     patientB: upcommingVisits[index][8],
                  //     patientG: upcommingVisits[index][4],
                  //     patientH: upcommingVisits[index][6],
                  //     patientN: upcommingVisits[index][3],
                  //     patientW: upcommingVisits[index][7],
                  //     vid: upcommingVisits[index][0],
                  //   ));
                  // },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorResources.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: upcommingVisits[index][2],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily
                                              .AVENIR_LT_PRO_ROMAN,
                                          fontSize: 14,
                                          color: ColorResources.green009,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                    romanText(upcommingVisits[index][1],
                                        ColorResources.grey777, 14),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                mediumText(
                                    "Patient: ${upcommingVisits[index][3]}",
                                    ColorResources.grey777,
                                    18),
                                const SizedBox(height: 5),
                                romanText(
                                    "Visit ID: ${upcommingVisits[index][0]}",
                                    ColorResources.grey777,
                                    12),
                              ],
                            ),
                          ),
                          // Image.asset(
                          //   'assets/images/right-arrow.png',
                          //   height: 30,
                          //   width: 30,
                          //   alignment: Alignment.centerRight,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyVis() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: Image.asset(
              Images.noVisit,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 20),
          romanText("There is no UpComming Visits", ColorResources.grey777, 18,
              TextAlign.center),
        ],
      ),
    );
  }
}
