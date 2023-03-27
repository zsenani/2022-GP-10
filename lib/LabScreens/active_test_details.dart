import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Utiils/images.dart';
import '../AuthScreens/signin_screen.dart';
import 'package:medcore/database/mysqlDatabase.dart';

import 'labResult.dart';

String visitID;
String LabSpID;
List<String> tests = [];
bool _loading = true;
List<String> testInfo = [];
List<DataRow> rows = [];
List<DataColumn> column = [];

class ActiveTestDetails extends StatefulWidget {
  ActiveTestDetails({Key key, String vid, String labid}) : super(key: key) {
    visitID = vid;
    LabSpID = labid;
    // for (int i = 0; i < testN.length; i + 4) {
    //   tests.add(testN[i]);
    // }
    // tests = testN;
    // print("tests:");
    // print(tests);
  }
  @override
  State<ActiveTestDetails> createState() => ActiveTestDetailsState();
}

class ActiveTestDetailsState extends State<ActiveTestDetails> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      activeTestDetails(visitID);
    });
  }

  Future activeTestDetails(vis) async {
    setState(() {
      _loading = true;
      column.clear();
      rows.clear();
    });
    testInfo = await mysqlDatabase.activeVisitDet(vis, tests);
    print("in lab test details active ");
    print(testInfo.length);
    print(testInfo);
    tests = await mysqlDatabase.labTestnames(vis);
    print("length tests");
    print(tests);
    for (var i = 0; i < tests.length && i < 2; i++) {
      column.add(
        DataColumn(
          label: Text(
            tests[i] == "yes"
                ? "Updated"
                : tests[i] == "no"
                    ? ""
                    : tests[i],
            style: TextStyle(
              fontSize: 19,
              color: tests[i] == "yes"
                  ? ColorResources.orange
                  : ColorResources.black,
            ),
          ),
        ),
      );
    }

    for (var i = 2; i < tests.length; i++) {
      rows.add(
        DataRow(
          cells: [
            DataCell(
              Text(
                tests[i],
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
            i + 1 < tests.length
                ? DataCell(
                    Text(
                      tests[++i] == "yes"
                          ? "Updated"
                          : tests[i] == "no"
                              ? ""
                              : "",
                      style: const TextStyle(
                          fontSize: 19, color: ColorResources.orange),
                    ),
                  )
                : const DataCell(
                    Text(
                      "",
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  )
          ],
        ),
      );
    }
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
        body: _loading == true ? loadingPage() : testDetails());
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  Widget testDetails() {
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
                              "Dr. ${testInfo[4]}", ColorResources.grey777, 16),
                        ],
                      ),
                      const SizedBox(height: 10),
                      romanText("${testInfo[5]} - ${testInfo[6]}",
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
                          "Date: ${testInfo[0]}", ColorResources.green009, 16),
                      const SizedBox(height: 10),
                      romanText(
                          "Time: ${testInfo[1]}", ColorResources.green009, 16),
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
              const SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/lab.png',
                        height: 27,
                        width: 27,
                        alignment: Alignment.centerLeft,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumText(
                              "Required Tests", ColorResources.grey777, 18),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                  DataTable(columns: column, rows: rows),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  commonButton(() {
                    Get.to(labResult(
                        vid: visitID,
                        lengthController: tests.length.toDouble(),
                        labid: LabSpID));
                  }, "Add Results", const Color.fromRGBO(19, 156, 140, 1),
                      ColorResources.white),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//   showAlertDialog(BuildContext context) {
//     // set up the buttons
//     Widget cancelButton = TextButton(
//       child: const Text(
//         "Cancel",
//         style: TextStyle(
//           fontSize: 15,
//         ),
//       ),
//       onPressed: () => Navigator.pop(context),
//     );
//     Widget continueButton = TextButton(
//       child: const Text(
//         "Upload",
//         style: TextStyle(
//           fontSize: 15,
//         ),
//       ),
//       onPressed: () {
//         Get.to(LabHomePage1());
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: const Text("Upload Results"),
//       content: const Text("Are you sure you want to upload results?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
}
