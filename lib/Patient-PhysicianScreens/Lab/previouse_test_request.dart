import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/LabScreens/previose_test_details.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import 'package:medcore/Utiils/images.dart';

String labId;
List<List<String>> prevTest = [];
List<List<String>> prevpatientList = [];
bool _loading = true;
String message = '';

class PreviouseTestReq extends StatefulWidget {
  PreviouseTestReq({Key key, String id}) : super(key: key) {
    labId = id;
  }
  @override
  State<PreviouseTestReq> createState() => _PreviouseTestReqState();
}

class _PreviouseTestReqState extends State<PreviouseTestReq> {
  final TextEditingController idPatientprev = TextEditingController();
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      previTest(labId);
    });
  }

  Future previTest(idLabSpe) async {
    prevTest = await mysqlDatabase.labTestReq(idLabSpe, "Pre");
    print("in lab spe active home");
    print(prevTest.length);
    print(prevTest);

    setState(() {
      _loading = false;
    });
  }

  searchPatientPrev(String idP) {
    for (int i = 0; i < prevTest.length; i++) {
      print(prevTest[i][5].runtimeType);
      if (prevTest[i][5] == idP) {
        setState(() {
          prevpatientList.add(prevTest[i]);
        });
      }
    }
    if (prevpatientList.isEmpty) {
      setState(() {
        message = "   The patient dosn't have any active requests";
      });
    } else {
      setState(() {
        message = "  ";
      });
    }
    print("##########33");
    print(prevpatientList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _loading == true
            ? loadingPage()
            : prevTest.isEmpty
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
          const SizedBox(height: 3),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: idPatientprev,
            cursorColor: const Color.fromRGBO(19, 156, 140, 1),
            style: TextStyle(
              color: ColorResources.black,
              fontSize: 15,
              fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    prevpatientList.clear();
                    searchPatientPrev(idPatientprev.text);
                  });
                },
                icon: const Icon(
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
            onChanged: (value) {
              setState(() {
                message = ' ';
              });
            },
          ),
          const SizedBox(height: 2),
          if (idPatientprev.text.length != 10 && idPatientprev.text != "")
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              mediumText("   The ID should be 10 digits", Colors.red, 16),
            ])
          else if (idPatientprev.text != "" && idPatientprev.text.length == 10)
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              mediumText(message, Colors.grey, 16),
            ]),
          const SizedBox(height: 10),
          idPatientprev.text == ''
              ? ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: prevTest.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          Get.to(PreviouseTestDetails(
                            vid: prevTest[index][1],
                            labid: labId,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: prevTest[index][2],
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
                                      const SizedBox(height: 5),
                                      mediumText(
                                          "Patient: " + prevTest[index][4],
                                          ColorResources.grey777,
                                          18),
                                      const SizedBox(height: 5),
                                      romanText(
                                          "Visit ID: " + prevTest[index][1],
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: prevpatientList.length == 0
                        ? 0
                        : prevpatientList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          Get.to(PreviouseTestDetails(
                            vid: prevpatientList[index][1],
                            labid: labId,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: prevpatientList[index][2],
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
                                      const SizedBox(height: 5),
                                      mediumText(
                                          "Patient: " +
                                              prevpatientList[index][4],
                                          ColorResources.grey777,
                                          18),
                                      const SizedBox(height: 5),
                                      romanText(
                                          "Visit ID: " +
                                              prevpatientList[index][1],
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
          const SizedBox(height: 20),
          romanText("There is no active test requests", ColorResources.grey777,
              18, TextAlign.center),
        ],
      ),
    );
  }
}
//PreviouseTestDetails()
