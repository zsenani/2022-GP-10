import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:get/get.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import '../AuthScreens/signin_screen.dart';
import 'showLabResult.dart';

String visitID;
String LabSpID;
bool _loading = true;
List<String> testInfo;

class PreviouseTestDetails extends StatefulWidget {
  PreviouseTestDetails({Key key, String vid, String labid}) : super(key: key) {
    visitID = vid;
    LabSpID = labid;
  }
  @override
  State<PreviouseTestDetails> createState() => PreviouseTestDetailsState();
}

class PreviouseTestDetailsState extends State<PreviouseTestDetails> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      preTestD(visitID);
    });
  }

  Future preTestD(vId) async {
    testInfo = await mysqlDatabase.preVisitDet(vId);
    print("in lab spe prevose  details");
    print(testInfo.length);
    print(testInfo);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.whiteF6F,
        appBar: AppBar(
          backgroundColor: ColorResources.whiteF6F,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 18, top: 8, bottom: 8),
            child: InkWell(
              onTap: () {
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
                child: const Center(
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
                  Get.to(SignInScreen());
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: const Icon(Icons.logout_outlined,
                      color: ColorResources.grey777),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mediumText("Visit No. $visitID",
                                  ColorResources.grey777, 24),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                color: ColorResources.greyD4D.withOpacity(0.4),
                thickness: 1,
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Image.asset(
                      Images.doctor1,
                      height: 27,
                      width: 27,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText(
                          "Physician information", ColorResources.grey777, 18),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          bookText("Name   :   ", ColorResources.greyA0A, 16),
                          mediumText(
                              "Dr. " + testInfo[4], ColorResources.grey777, 16),
                        ],
                      ),
                      const SizedBox(height: 10),
                      romanText(testInfo[5] + " - " + testInfo[6],
                          ColorResources.greyA0A, 14),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/clock.png',
                    height: 27,
                    width: 27,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText("Visit time", ColorResources.grey777, 18),
                      const SizedBox(height: 10),
                      romanText(
                          "Date: " + testInfo[0], ColorResources.green009, 16),
                      const SizedBox(height: 10),
                      romanText(
                          "Time: " + testInfo[1], ColorResources.green009, 16),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/user.png',
                    height: 27,
                    width: 27,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText(
                          "Patient information", ColorResources.grey777, 18),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          bookText("Name   :   ", ColorResources.greyA0A, 16),
                          mediumText(testInfo[2], ColorResources.grey777, 16),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          bookText("Age      :   ", ColorResources.greyA0A, 16),
                          mediumText(testInfo[3], ColorResources.grey777, 16),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     bookText("Phone   :   ", ColorResources.greyA0A, 16),
                      //     mediumText(
                      //         "+966 5668 44776", ColorResources.grey777, 16),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Column(children: [
                commonButton(() {
                  Get.to(
                      showlabResult(vid: visitID, role: 'labS', id: LabSpID));
                }, "Show Results", const Color.fromRGBO(19, 156, 140, 1),
                    ColorResources.white),
                const SizedBox(height: 30),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
