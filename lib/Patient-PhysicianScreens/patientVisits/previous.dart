import 'package:medcore/database/mysqlDatabase.dart';
import 'package:medcore/mongoDBModel2.dart';

import '/../Utiils/colors.dart';
import '/../Utiils/common_widgets.dart';
import '/../Utiils/images.dart';
import '/../Utiils/text_font_family.dart';
import '/../main.dart';
import 'package:flutter/material.dart';

List<List<String>> preVisit = [];
bool _loading = true;
String patientId;

class PreviousVisit extends StatefulWidget {
  PreviousVisit({Key key, String id}) : super(key: key) {
    patientId = id;
  }
  @override
  State<PreviousVisit> createState() => _PreviousVisitState();
}

class _PreviousVisitState extends State<PreviousVisit> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      previousVisitM(patientId);
    });
    print("previose patientId");
    print(patientId);
  }

  Future previousVisitM(idVisit) async {
    preVisit = await mysqlDatabase.PatientVisit(idVisit, "Pre");
    print("in visit");
    print(preVisit.length);
    // print(preVisit[0][5]);
    for (int i = 0; i < preVisit.length; i++) {
      preVisit.sort((b, a) {
        var adate = a[i];
        var bdate = b[i];
        return -adate.compareTo(bdate);
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.whiteF7F,
        body: _loading == true
            ? loadingPage()
            : preVisit.isEmpty
                ? emptyVisit()
                : fullVisit());
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  Widget fullVisit() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: preVisit.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomRight,
                          children: const [
                            Image(
                              image: AssetImage(
                                Images.Visit,
                              ),
                              width: 30,
                              height: 30,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: preVisit[index][4] + " - ",
                                      style: TextStyle(
                                        fontFamily:
                                            TextFontFamily.AVENIR_LT_PRO_ROMAN,
                                        fontSize: 10,
                                        color: ColorResources.greyA0A,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Dr." + preVisit[index][2],
                                          style: TextStyle(
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_ROMAN,
                                            fontSize: 10,
                                            color: ColorResources.greyA0A,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: preVisit[index][0],
                                      style: TextStyle(
                                        fontFamily:
                                            TextFontFamily.AVENIR_LT_PRO_ROMAN,
                                        fontSize: 12,
                                        color: ColorResources.grey777,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              mediumText(preVisit[index][1],
                                  ColorResources.green009, 20),
                              SizedBox(height: 2),
                              romanText(
                                  // "Dosage: " +
                                  //     preVisit[index][4] +
                                  "Physician's specialty: " +
                                      preVisit[index][3],
                                  ColorResources.grey777,
                                  12),
                            ],
                          ),
                        ),
                      ],
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

  Widget emptyVisit() {
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
          romanText("There is no Previous Visits", ColorResources.grey777, 18,
              TextAlign.center),
        ],
      ),
    );
  }
}
