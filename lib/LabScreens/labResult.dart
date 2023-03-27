import 'package:dropdown_search/dropdown_search.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import 'lab_home_screen.dart';

String visitID;
String LabSpID;
var idpatient;
bool _loading = true;
double lengthnames;
List<String> testsIDglobal = [];
List<String> testUnitglobal = [];
List<String> testNamesGlabal = [];

class labResult extends StatefulWidget {
  labResult({String vid, double lengthController, String labid}) {
    visitID = vid;
    lengthnames = lengthController / 2;
    LabSpID = labid;
  }
  @override
  State<labResult> createState() => labResultState();
}

class labResultState extends State<labResult> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      testNamesGlabal.clear();
      testUnitglobal.clear();
      testsIDglobal.clear();
      labTestID(visitID);
    });
  }

  List<TextEditingController> _controller =
      List.generate(lengthnames.round(), (i) => TextEditingController());
  labTestID(visitid) async {
    print(visitid);
    var idpat = await conn
        .query('select idPatient from Visit where idvisit = ?', [visitid]);
    for (var row in idpat) {
      idpatient = '${row[0]}';
    }
    List<String> testID = [];
    var ID = await conn.query(
        'select labTestID from VisitLabTest where visitID = ?',
        [visitid]); //here check
    print(ID);

    for (var row in ID) {
      print('${row[0]}');
      testID.add('${row[0]}');
    }
    for (int i = 0; i < testID.length; i++) {
      var units = await conn.query(
          'select name,unit from LabTest where idlabTest = ?', [testID[i]]);
      for (var un in units) {
        testNamesGlabal.add('${un[0]}');
        testUnitglobal.add('${un[1]}');
      }
    }

    print("testId list cady_zozo:");
    print(testID);

    // for (int i = 0; i < testNames.length; i++) {
    //   var units = await conn
    //       .query('select unit from LabTest where name = ?', [testNames[i]]);
    //   for (var un in units) {
    //     testUnitglobal.add('${un[0]}');
    //   }
    // }
    print('units');
    print(testUnitglobal);
    testsIDglobal = testID;

    print('global');
    print(testsIDglobal);
    setState(() {
      testsIDglobal = testID;
      _loading = false;
    });
    print('ddddddd');
    print(testNamesGlabal);
  }

  List<bool> flagcontroller = [];
  bool isFilled = true;
  addResult() async {
    isFilled = true;
    for (int index = 0; index < testNamesGlabal.length; index++) {
      if (_controller[index].text == '') {
        setState(() {
          flagcontroller[index] = true;
        });

        isFilled = false;
      } else {
        setState(() {
          flagcontroller[index] = false;
        });
      }
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
    for (int i = 0; i < testNamesGlabal.length; i++) {
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
                  Get.to(LabHomePage1(
                    id: LabSpID,
                  ));
                },
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.home, color: ColorResources.grey777),
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
          const SizedBox(height: 15),
          SizedBox(
            height: 60,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
                gradient: LinearGradient(
                  colors: [
                    ColorResources.orange,
                    ColorResources.orange,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mediumText('Test Name   ', ColorResources.white, 24),
                  mediumText('Result', ColorResources.white, 24),
                ],
              ),
            ),
          ),
          if (isFilled == false) const SizedBox(height: 15),
          if (isFilled == false)
            mediumText('All the fields should be filled ', Colors.red, 17),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: testsIDglobal.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 16, right: 20),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorResources.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                    mediumText(testNamesGlabal[index] + ": ",
                                        ColorResources.grey777, 22),
                                  ],
                                ),
                                SizedBox(
                                  width: 110,
                                  child: testNamesGlabal[index] == 'ABO'
                                      ? DropdownSearch<String>(
                                          popupProps: const PopupProps.menu(
                                            showSelectedItems: true,
                                            constraints:
                                                BoxConstraints(maxHeight: 199),
                                          ),
                                          items: const [
                                            "A+",
                                            'A-',
                                            'B+',
                                            'B-',
                                            'AB+',
                                            'AB-',
                                            'O+',
                                            'O-'
                                          ],
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              hintText: 'Select..',
                                              hintStyle: const TextStyle(
                                                  color:
                                                      ColorResources.grey777),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide:
                                                    flagcontroller[index] ==
                                                            false
                                                        ? const BorderSide(
                                                            color:
                                                                ColorResources
                                                                    .greyA0A,
                                                            width: 1)
                                                        : const BorderSide(
                                                            color: Colors.red,
                                                            width: 1),
                                              ),
                                            ),
                                          ),
                                          onChanged: (String selectedValue) {
                                            _controller[index].text =
                                                selectedValue;
                                          },
                                        )
                                      : TextFormField(
                                          controller: _controller[index],
                                          decoration: InputDecoration(
                                            //  floatingLabelStyle: TextStyle(),

                                            hintText: testUnitglobal[index] !=
                                                    'null'
                                                ? 'In ' + testUnitglobal[index]
                                                : 'Enter result',
                                            border: UnderlineInputBorder(
                                              borderSide:
                                                  flagcontroller[index] == false
                                                      ? const BorderSide(
                                                          color: ColorResources
                                                              .greyA0A,
                                                          width: 2)
                                                      : const BorderSide(
                                                          color: Colors.red,
                                                          width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                                  flagcontroller[index] == false
                                                      ? const BorderSide(
                                                          color: ColorResources
                                                              .greyA0A,
                                                          width: 2)
                                                      : const BorderSide(
                                                          color: Colors.red,
                                                          width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  flagcontroller[index] == false
                                                      ? const BorderSide(
                                                          color: ColorResources
                                                              .greyA0A,
                                                          width: 2)
                                                      : const BorderSide(
                                                          color: Colors.red,
                                                          width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
          ),
          // Spacer(),
          SizedBox(
            width: 360,
            child: commonButton(() {
              addResult();
            }, "Upload", const Color.fromRGBO(19, 156, 140, 1),
                ColorResources.white),
          ),
          const SizedBox(height: 40),
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
        for (int i = 0; i < testNamesGlabal.length; i++) {
          if (testNamesGlabal[i] == 'ABO') {
            print('cocococ');
            print(idpatient);
            var rr = await conn.query(
                'update Patient set bloodType=? where NationalID=?',
                [_controller[i].text, idpatient]);
          }
          var result = await conn.query(
              'update VisitLabTest set status=?, result=? where visitID =? and labTestID =?',
              ['done', _controller[i].text, visitID, testsIDglobal[i]]);
        }
        Get.to(LabHomePage1(
          id: LabSpID,
        ));
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
