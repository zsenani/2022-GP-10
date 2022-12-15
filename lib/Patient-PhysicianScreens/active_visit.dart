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
    activeVisit = await mysqlDatabase.PhysicianVisit(idVisit, "Up");
    print("in visit");
    print(activeVisit.length);
    // print(activeVisit[0][0]);
    for (int i = 0; i < activeVisit.length; i++) {
      activeVisit.sort((a, b) {
        var adate = a[i][0];
        var bdate = b[i][0];
        return -adate.compareTo(bdate);
      });
    }
    setState(() {
      _loading = false;
    });
  }

  // ActiveReq({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: _loading == true
            ? loadingPage()
            : activeVisit.isEmpty
                ? emptyVis()
                : fullVis());
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  Widget fullVis() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: activeVisit.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    Get.to(
                        UpCommingVisitScreen(
                            patientID: activeVisit[index][9],
                            hospitalN: activeVisit[index][2],
                            visitD: activeVisit[index][1],
                            visitT: activeVisit[index][10],
                            patientAge: activeVisit[index][5],
                            patientB: activeVisit[index][8],
                            patientG: activeVisit[index][4],
                            patientH: activeVisit[index][6],
                            patientN: activeVisit[index][3],
                            patientW: activeVisit[index][7],
                            vid: activeVisit[index][0]),
                        arguments: 'UPphysician');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorResources.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: activeVisit[index][2],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily
                                              .AVENIR_LT_PRO_ROMAN,
                                          fontSize: 14,
                                          color: ColorResources.green009,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 55),
                                    romanText(activeVisit[index][1],
                                        ColorResources.grey777, 14),
                                  ],
                                ),
                                SizedBox(height: 5),
                                mediumText("Patient: " + activeVisit[index][3],
                                    ColorResources.grey777, 18),
                                SizedBox(height: 5),
                                romanText("Visit ID: " + activeVisit[index][0],
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
          SizedBox(height: 20),
          romanText("There is no UpComming Visits", ColorResources.grey777, 18,
              TextAlign.center),
        ],
      ),
    );
  }
}
