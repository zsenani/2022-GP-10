import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/LabScreens/previose_test_details.dart';
import 'package:medcore/database/mysqlDatabase.dart';

import '../Utiils/images.dart';
import 'active_test_details.dart';

String labId;
List<List<String>> ActiveTest1 = [];
List<List<String>> activepatientList = [];
bool _loading = true;

class ActiveTestReq extends StatefulWidget {
  ActiveTestReq({Key key, String id}) : super(key: key) {
    labId = id;
  }
  @override
  State<ActiveTestReq> createState() => _ActiveTestReqState();
}

class _ActiveTestReqState extends State<ActiveTestReq> {
  final TextEditingController idPatientactive = TextEditingController();
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ActiveTest(labId);
    });
  }

  Future ActiveTest(idLabSpe) async {
    ActiveTest1 = await mysqlDatabase.labTestReq(idLabSpe, "active");
    print("in lab spe active home");
    print(ActiveTest1.length);
    print(ActiveTest1);

    setState(() {
      _loading = false;
    });
  }

  searchPatientActive(String idP) {
    for (int i = 0; i < ActiveTest1.length; i++) {
      print(ActiveTest1[i][5].runtimeType);
      if (ActiveTest1[i][5] == idP) {
        setState(() {
          activepatientList.add(ActiveTest1[i]);
        });
      }
    }
    print("##########33");
    print(activepatientList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _loading == true
            ? loadingPage()
            : ActiveTest1.isEmpty
                ? emptyTest()
                : fullTest());
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  @override
  Widget fullTest() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3),
          TextFormField(
            controller: idPatientactive,
            cursorColor: Color.fromRGBO(19, 156, 140, 1),
            style: TextStyle(
              color: ColorResources.black,
              fontSize: 15,
              fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    activepatientList.clear();
                    searchPatientActive(idPatientactive.text);
                  });
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
              hintText: "Search by Patient ID . . .",
              hintStyle: TextStyle(
                color: ColorResources.greyA0A,
                fontSize: 16,
                fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
              ),
              filled: true,
              fillColor: ColorResources.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorResources.greyA0A.withOpacity(0.2), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorResources.greyA0A.withOpacity(0.2), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorResources.greyA0A.withOpacity(0.2), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 2),
          if (idPatientactive.text.length != 10 && idPatientactive.text != "")
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              mediumText("   The ID should be 10 digits", Colors.red, 16),
            ])
          else if (idPatientactive.text != "" &&
              idPatientactive.text.length == 10 &&
              activepatientList.isEmpty)
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              mediumText("   The patient dosn't have any active requests",
                  Colors.grey, 16),
            ]),
          SizedBox(height: 10),
          idPatientactive.text == ''
              ? ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ActiveTest1.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          Get.to(ActiveTestDetails(
                            vid: ActiveTest1[index][1],
                            labid: labId,
                          ));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: ActiveTest1[index][2],
                                              style: TextStyle(
                                                fontFamily: TextFontFamily
                                                    .AVENIR_LT_PRO_ROMAN,
                                                fontSize: 14,
                                                color: ColorResources.green009,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      mediumText(
                                          "Patient: " + ActiveTest1[index][4],
                                          ColorResources.grey777,
                                          18),
                                      SizedBox(height: 5),
                                      romanText(
                                          "Visit ID: " + ActiveTest1[index][1],
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
                )
              : ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: activepatientList.length == 0
                        ? 0
                        : activepatientList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          Get.to(ActiveTestDetails(
                            vid: activepatientList[index][1],
                            labid: labId,
                          ));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: activepatientList[index][2],
                                              style: TextStyle(
                                                fontFamily: TextFontFamily
                                                    .AVENIR_LT_PRO_ROMAN,
                                                fontSize: 14,
                                                color: ColorResources.green009,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      mediumText(
                                          "Patient: " +
                                              activepatientList[index][4],
                                          ColorResources.grey777,
                                          18),
                                      SizedBox(height: 5),
                                      romanText(
                                          "Visit ID: " +
                                              activepatientList[index][1],
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

  Widget emptyTest() {
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
          romanText("There is no active test requests", ColorResources.grey777,
              18, TextAlign.center),
        ],
      ),
    );
  }
}
//PreviouseTestDetails()
