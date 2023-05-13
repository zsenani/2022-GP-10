import 'package:medcore/Patient-PhysicianScreens/previous_visit_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/database/mysqlDatabase.dart';

import '../Utiils/images.dart';

List<List<String>> previouseVisit = [];
bool _loading = true;
String physicianId;

class PreVisitList extends StatefulWidget {
  PreVisitList({Key key, String id}) : super(key: key) {
    physicianId = id;
  }
  @override
  State<PreVisitList> createState() => _PreVisitListState();
}

class _PreVisitListState extends State<PreVisitList> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      previouseVisitP(physicianId);
      print("pre visit physicianId");
      print(physicianId);
    });
  }

  Future previouseVisitP(idVisit) async {
    previouseVisit.clear();
    _loading = true;

    previouseVisit = await mysqlDatabase.PhysicianPrevVisit(idVisit);
    print("in visit");
    print(previouseVisit.length);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _loading == true
            ? loadingPage()
            : previouseVisit.isEmpty
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
          const SizedBox(height: 10),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: previouseVisit.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    Get.to(PreviousVisitScreen(
                      patientID: previouseVisit[index][9],
                      hospitalN: previouseVisit[index][2],
                      visitD: previouseVisit[index][1],
                      visitT: previouseVisit[index][10],
                      patientAge: previouseVisit[index][5],
                      patientB: previouseVisit[index][8],
                      patientG: previouseVisit[index][4],
                      patientH: previouseVisit[index][6],
                      patientN: previouseVisit[index][3],
                      patientW: previouseVisit[index][7],
                      visitID: int.parse(previouseVisit[index][0]),
                    ));
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
                                        text: previouseVisit[index][2],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily
                                              .AVENIR_LT_PRO_ROMAN,
                                          fontSize: 14,
                                          color: ColorResources.green009,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 45),
                                    romanText(previouseVisit[index][1],
                                        ColorResources.grey777, 14),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                mediumText(
                                    "Patient: " + previouseVisit[index][3],
                                    ColorResources.grey777,
                                    18),
                                const SizedBox(height: 5),
                                romanText(
                                    "Visit ID: " + previouseVisit[index][0],
                                    ColorResources.grey777,
                                    12),
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
          const SizedBox(height: 20),
          romanText("There is no Previous Visits", ColorResources.grey777, 18,
              TextAlign.center),
        ],
      ),
    );
  }
}
