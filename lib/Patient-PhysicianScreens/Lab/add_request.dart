import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';

import '../../Controller/test_tab_conroller.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../database/mysqlDatabase.dart';
import 'ActiveReq.dart';
import 'lab_tests.dart';
import 'previousReq.dart';
import 'tests.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
//import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:parent_child_checkbox/parent_child_checkbox.dart';

bool loading = true;
String visitId;
String Page;
bool isFirst = true;

class TestRequest extends StatefulWidget {
  TestRequest({Key key, String vid, String page}) : super(key: key) {
    visitId = vid;
    Page = page;
  }
  State<TestRequest> createState() => _TestRequestState();
}

class _TestRequestState extends State<TestRequest> {
  final LabTabBarController tabBarController = Get.put(LabTabBarController());
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        loading = true;
      });
      Tests();
    });
  }

  void add() {
    if (allArrayLength > _tests.length)
      mysqlDatabase.addTest(selectedTest, int.parse(visitId), 'yes');
    else
      mysqlDatabase.addTest(selectedTest, int.parse(visitId), 'no');

    selectedTest.forEach((element) {
      _tests.remove(element);
    });
  }

  static final List<Widget> pages = [ActiveReq(), PreviousReq()];

  List<String> _tests = new List<String>();

  var _items;

  List<String> selectedTest = new List<String>();
  int isFilled = 0;
  int isFilled2 = 0;
  int allArrayLength = 0;
  int index = 0;
  Tests() async {
    List<int> testIds = [];
    var results = await conn.query(
        'select labTestID from VisitLabTest where visitID = ?', [visitId]);
    int ArrayLength = await results.length;

    for (var row2 in results) {
      if (isFilled2 != ArrayLength) {
        int testNo2 = int.parse('${row2[0]}');
        testIds.add(testNo2);
        isFilled2 = isFilled2 + 1;
      }
    }
    var allResults = await conn.query('select name,idlabTest from LabTest');
    allArrayLength = await allResults.length;

    if (isFilled2 == ArrayLength) {
      bool exist = false;
      for (var row in allResults) {
        setState(() {
          exist = false;
        });
        if (isFilled != allArrayLength) {
          String testName = '${row[0]}';
          int testNo1 = int.parse('${row[1]}');
          if (ArrayLength != 0) {
            testIds.forEach((element) {
              if (element == testNo1)
                setState(() {
                  exist = true;
                });
            });
          }
          if (!exist) _tests.add(testName);

          isFilled = isFilled + 1;
        }
      }

      setState(() {
        loading = false;
      });
    }
    if (loading == false)
      _items =
          _tests.map((tests) => MultiSelectItem<String>(tests, tests)).toList();
    // for (var lab in _tests)
    //   listItemSelected.add(ItemSelect(value: index++, label: '${lab[index]}'));
  }

  final _multiSelectKey = GlobalKey<FormFieldState>();
  final old = Get.previousRoute;

  Widget loadingPage() {
    return Center(
      child: const CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  // Future list() {
  //   if (selectedTest.length != 0)
  //     for (var index in selectedTest) {
  //       Row(
  //         children: [
  //           SizedBox(width: 10),
  //           Text('${index}'),
  //           IconButton(
  //               icon: Icon(Icons.close),
  //               onPressed: () {
  //                 setState(() {
  //                   selectedTest.remove(index);
  //                   // Allergy = true;
  //                 });
  //               })
  //         ],
  //       );
  //     }
  // }

  TextEditingController controllerName = TextEditingController();
  void _onSelectionComplete(value) {
    selectedTest?.addAll(value);
    print(selectedTest);
    setState(() {});
  }

  bool selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              old != '/lab_tests'
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 50),
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Icon(Icons.arrow_back,
                                color: ColorResources.grey777),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 50,
                    ),
              Flexible(
                flex: 10,
                child: HeaderWidget(),
              ),
              if (Page != 'active')
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 60, left: 0, bottom: 10),
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Center(
                        // heightFactor: 100,
                        child: Icon(Icons.home_outlined,
                            color: ColorResources.grey777),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          loading == true
              ? loadingPage()
              : InkWell(
                  onTap: () {
                    setState(() {
                      selected = viewTest();
                    });
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(" Select a lab test"),
                          Icon(Icons.arrow_downward),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  )),

          // Card(
          //   color: ColorResources.green009.withOpacity(0.4),
          //   borderOnForeground: true,
          //   shadowColor: Colors.grey,
          //   elevation: 4,
          //   child: ParentChildCheckbox(
          //     parent: Text(
          //       'Select All',
          //       style: TextStyle(fontSize: 20),
          //     ),
          //     children: [
          //       for (var lab in _tests)
          //         Text(
          //           lab,
          //           style: TextStyle(fontSize: 20),
          //         ),
          //     ],
          //     parentCheckboxColor: Colors.orange,
          //     childrenCheckboxColor: Colors.red,
          //   ),
          // ),
          // Spacer(),
          // allArrayLength > _tests.length
          //     ? commonButton(() {
          //         selectedTest =
          //             ParentChildCheckbox.selectedChildrens['Select All'];
          //         log(ParentChildCheckbox.isParentSelected.toString());
          //         log(ParentChildCheckbox.selectedChildrens.toString());
          //         print(ParentChildCheckbox.selectedChildrens['Select All']
          //             .toString());
          //         print(selectedTest);
          //         showAlertDialog(context);
          //       }, "UPDATE", ColorResources.green009, ColorResources.white)
          //     : commonButton(() {
          //         selectedTest =
          //             ParentChildCheckbox.selectedChildrens['Select All'];
          //         log(ParentChildCheckbox.isParentSelected.toString());
          //         log(ParentChildCheckbox.selectedChildrens.toString());
          //         print(ParentChildCheckbox.selectedChildrens['Select All']
          //             .toString());
          //         print(selectedTest);
          //         showAlertDialog(context);
          //       }, "SEND", ColorResources.green009, ColorResources.white),

          // ElevatedButton(
          //   child: allArrayLength > _tests.length?Text('UPDATE'):Text('SEND'),
          //   onPressed: () {
          //     selectedTest =
          //         ParentChildCheckbox.selectedChildrens['Select All'];
          //     log(ParentChildCheckbox.isParentSelected.toString());
          //     log(ParentChildCheckbox.selectedChildrens.toString());
          //     print(ParentChildCheckbox.selectedChildrens['Select All']
          //         .toString());
          //     print(selectedTest);
          //     showAlertDialog(context);
          //   },
          // ),
          // MultiSelectBottomSheetField<String>(
          //     key: _multiSelectKey,
          //     initialChildSize: 0.7,
          //     maxChildSize: 0.95,
          //     title: _tests.length == 0
          //         ? Text(
          //             " You have requested all the lab tests",
          //             style: TextStyle(fontSize: 20, color: Colors.red),
          //           )
          //         : Text("Lab Tests"),
          //     buttonText: Text("Choose Lab Tests"),
          //     items: _items,
          //     searchable: true,
          //     confirmText: const Text(
          //       "SAVE",
          //       style: TextStyle(
          //         color: ColorResources.green009,
          //       ),
          //     ),
          //     cancelText: const Text(
          //       "CANCEL",
          //       style: TextStyle(
          //         color: ColorResources.green009,
          //       ),
          //     ),
          //     selectedColor: Color.fromRGBO(241, 94, 34, 0.8),
          //     validator: (values) {
          //       if (values == null || values.isEmpty) {
          //         return "Required";
          //       }

          //       return null;
          //     },
          //     onConfirm: (values) {
          //       setState(() {
          //         selectedTest = values;
          //       });
          //       print(_multiSelectKey.currentState.value);
          //       if (_multiSelectKey.currentState.value != null)
          //         _multiSelectKey.currentState.value.forEach((element) {
          //           if (element == 'Select All')
          //             setState(() {
          //               _multiSelectKey.currentState.setValue(_tests);
          //               print(_multiSelectKey.currentState.value);
          //               _multiSelectKey.currentState.validate();
          //             });
          //         });
          //     },
          //     chipDisplay: MultiSelectChipDisplay(
          //       icon: Icon(
          //         Icons.close,
          //         color: Color.fromRGBO(241, 94, 34, 0.8),
          //       ),
          //       onTap: (item) {
          //         setState(() {
          //           selectedTest.remove(item);
          //         });
          //         _multiSelectKey.currentState.validate();
          //       },
          //     ),
          //   ),
          // Spacer(),
          // if (loading == false)
          //   Row(
          //     children: [
          //       SizedBox(width: 6),
          //       if (allArrayLength > _tests.length)
          //         commonButton(() {
          //           showAlertDialog(context);
          //         }, "UPDATE", ColorResources.green009, ColorResources.white),
          //       if (allArrayLength == _tests.length)
          //         commonButton(() {
          //           showAlertDialog(context);
          //         }, "SEND", ColorResources.green009, ColorResources.white),
          //     ],
          //   ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget HeaderWidget() {
    return Stack(
      children: [
        Container(
          height: 80,
          width: 500,
          padding: EdgeInsets.only(top: 50, left: 0),
          child: heavyText("Request Lab Tests", ColorResources.green009, 30),
        ),
      ],
    );
  }

  sendReq() {
    String title;
    String content;
    Navigator.of(context).pop();
    Navigator.of(context).pop();

    if (selectedTest.length == 0) {
      title = "Oops";
      content = "Please choose at least one test";
    } else if (!isFirst) {
      title = "DONE!";
      content =
          "The request has been updated successfully!\n\nYour Request Number is " +
              visitId;
    } else {
      title = "DONE!";
      content =
          "The request has been sent successfully!\n\nYour Request Number is " +
              visitId;
    }
    Widget OKButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        Get.to(
          labTests(
              id: idp.toString(),
              idPhy: idPhysician,
              r: 'physician',
              vid: visitId),
          arguments: 'patientfile',
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [OKButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  viewTest() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: SingleChildScrollView(
            child: Column(
              children: [
                _tests.length != 0
                    ? ParentChildCheckbox(
                        parent: Text(
                          'Select All',
                          style: TextStyle(fontSize: 15),
                        ),
                        children: [
                          for (var lab in _tests)
                            Text(
                              lab,
                              style: TextStyle(fontSize: 15),
                            ),
                        ],
                        parentCheckboxColor: ColorResources.green009,
                        childrenCheckboxColor: Colors.orange,
                      )
                    : Text(
                        "\nYou have requested all the lab tests",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                SizedBox(
                  height: 10,
                ),
                if (_tests.length != 0)
                  allArrayLength > _tests.length
                      ? commonButton(() {
                          selectedTest = ParentChildCheckbox
                              .selectedChildrens['Select All'];
                          log(ParentChildCheckbox.isParentSelected.toString());
                          log(ParentChildCheckbox.selectedChildrens.toString());
                          print(ParentChildCheckbox
                              .selectedChildrens['Select All']
                              .toString());
                          print(selectedTest);
                          showAlertDialog(context);
                        }, "UPDATE", ColorResources.green009,
                          ColorResources.white)
                      : commonButton(() {
                          selectedTest = ParentChildCheckbox
                              .selectedChildrens['Select All'];
                          log(ParentChildCheckbox.isParentSelected.toString());
                          log(ParentChildCheckbox.selectedChildrens.toString());
                          print(ParentChildCheckbox
                              .selectedChildrens['Select All']
                              .toString());
                          print(selectedTest);
                          showAlertDialog(context);
                        }, "SEND", ColorResources.green009,
                          ColorResources.white),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
        child: Text(
          "CANCEL",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        }

        // Navigator.pop(context),
        );
    Widget continueButton;
    if (allArrayLength > _tests.length) {
      continueButton = TextButton(
        child: Text(
          "UPDATE",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: () {
          add();
          setState(() {
            isFirst = false;
          });
          sendReq();
        },
      );
    } else {
      continueButton = TextButton(
        child: Text(
          "SEND",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: () {
          add();
          setState(() {
            isFirst = true;
          });
          sendReq();
        },
      );
    }

    AlertDialog alert;
    // set up the AlertDialog
    if (allArrayLength > _tests.length)
      alert = AlertDialog(
        title: Text("Update Request"),
        content: Text("Are you sure you want to update the request?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
    else
      alert = AlertDialog(
        title: Text("Send Request"),
        content: Text("Are you sure you want to send request?"),
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
