import 'package:flutter/foundation.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:get/get.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import '../AuthScreens/signin_screen.dart';
import '../Utiils/text_font_family.dart';
import 'lab_home_screen.dart';

String visitID;
String LabSpID;
bool _loading = true;
List<String> testNames;
List<String> testsIDglobal = [];

class labResult extends StatefulWidget {
  labResult({String vid, List<String> testnames, String labid}) {
    visitID = vid;
    testNames = testnames;
    LabSpID = labid;
  }
  @override
  State<labResult> createState() => labResultState();
}

class labResultState extends State<labResult> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      labTestID(visitID);
    });
  }

  List<TextEditingController> _controller =
      List.generate(testNames.length, (i) => TextEditingController());

  labTestID(visitid) async {
    List<String> testID = [];
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
    setState(() {
      testsIDglobal = testID;
      _loading = false;
    });
    testsIDglobal = testID;

    print('global');
    print(testsIDglobal);
  }

  List<bool> flagcontroller = [];
  bool isFilled = true;
  addResult() async {
    isFilled = true;
    for (int index = 0; index < testNames.length; index++) {
      if (_controller[index].text == '') {
        setState(() {
          flagcontroller[index] = true;
        });

        isFilled = false;
      } else
        setState(() {
          flagcontroller[index] = false;
        });
    }
    if (isFilled) {
      showAlertDialog(context);
      // for (int i = 0; i < testNames.length; i++) {
      //   var result = await conn.query(
      //       'update VisitLabTest set status=?, result=? where visitID =? and labTestID =?',
      //       ['done', _controller[i].text, visitID, testsIDglobal[i]]);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < testNames.length; i++) {
      flagcontroller.add(false);
    }
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
                  Get.to(LabHomePage1(
                    id: LabSpID,
                  ));
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
    print('1111111111111111');
    print(LabSpID);
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
          if (isFilled == false) SizedBox(height: 15),
          if (isFilled == false)
            mediumText('All the fields should be filled ', Colors.red, 17),
          SizedBox(height: 15),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: testsIDglobal.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: InkWell(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 12),
                                  mediumText(testNames[index] + ": ",
                                      ColorResources.grey777, 25),
                                ],
                              ),
                              SizedBox(
                                width: 110,
                                child: TextFormField(
                                  controller: _controller[index],
                                  decoration: InputDecoration(
                                    //  floatingLabelStyle: TextStyle(),

                                    hintText: 'Enter result',
                                    border: UnderlineInputBorder(
                                      borderSide: flagcontroller[index] == false
                                          ? const BorderSide(
                                              color: ColorResources.greyA0A,
                                              width: 2)
                                          : const BorderSide(
                                              color: Colors.red, width: 4),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: flagcontroller[index] == false
                                          ? const BorderSide(
                                              color: ColorResources.greyA0A,
                                              width: 2)
                                          : const BorderSide(
                                              color: Colors.red, width: 4),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: flagcontroller[index] == false
                                          ? const BorderSide(
                                              color: ColorResources.greyA0A,
                                              width: 2)
                                          : const BorderSide(
                                              color: Colors.red, width: 4),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
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
          Spacer(),
          SizedBox(
            width: 360,
            child: commonButton(() {
              addResult();
            }, "Upload", const Color.fromRGBO(19, 156, 140, 1),
                ColorResources.white),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Upload",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () async {
        for (int i = 0; i < testNames.length; i++) {
          var result = await conn.query(
              'update VisitLabTest set status=?, result=? where visitID =? and labTestID =?',
              ['done', _controller[i].text, visitID, testsIDglobal[i]]);
        }
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Upload Results"),
      content: const Text("Are you sure you want to upload results?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
