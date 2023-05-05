import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/LabScreens/previose_test_details.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import '../Utiils/images.dart';

String labId;
List<List<String>> prevTest = [];
List<List<String>> prevpatientList = [];
bool _loading = true;

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
    prevTest.clear();
    _loading = true;
    prevTest = await mysqlDatabase.labTestReq("Pre");

    print("in lab spe active home");
    print(prevTest.length);
    print(prevTest);

    setState(() {
      _loading = false;
    });
  }

  searchPatientPrev(String idP) {
    print("fffffffffffffffffffffffffffffffffffffff");
    print(idP);
    print(prevTest);
    for (int i = 0; i < prevTest.length; i++) {
      print(prevTest[i][5].runtimeType);
      if (prevTest[i][5] == idP) {
        setState(() {
          prevpatientList.add(prevTest[i]);
        });
      }
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
            onChanged: ((value) {
              setState(() {
                prevpatientList.clear();
                searchPatientPrev(idPatientprev.text);
              });
            }),
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
          ),
          const SizedBox(height: 2),
          if (idPatientprev.text.length != 10 && idPatientprev.text != "")
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              mediumText("   The ID should be 10 digits", Colors.red, 16),
            ])
          else if (idPatientprev.text != "" &&
              idPatientprev.text.length == 10 &&
              prevpatientList.isEmpty)
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              mediumText("   The patient dosn't have any previouse requests",
                  Colors.grey, 16),
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
                                              text:
                                                  "Visit ID: ${prevTest[index][1]}",
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
                                          "Patient: ${prevTest[index][4]}",
                                          ColorResources.grey777,
                                          18),
                                      const SizedBox(height: 5),
                                      romanText(
                                          "Physician: ${prevTest[index][6]}",
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
                                              text:
                                                  "Visit ID: ${prevpatientList[index][1]}",
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
                                          "Patient: ${prevpatientList[index][4]}",
                                          ColorResources.grey777,
                                          18),
                                      const SizedBox(height: 5),
                                      romanText(
                                          "Physician: ${prevpatientList[index][6]}",
                                          ColorResources.grey777,
                                          15),
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
          romanText("There is no previous test requests",
              ColorResources.grey777, 18, TextAlign.center),
        ],
      ),
    );
  }
}
//PreviouseTestDetails()
