import 'package:medcore/Patient-PhysicianScreens/upcomming_visit_screen.dart';
import '../../Controller/test_tab_conroller.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../database/mysqlDatabase.dart';
import 'ActiveReq.dart';
import 'previousReq.dart';

bool loading = true;
String visitId;
String Page;
bool isFirst = true;
int patientID;
String hospitalName;

class TestRequest extends StatefulWidget {
  TestRequest({Key key, String vid, String page, int pid, String hosname})
      : super(key: key) {
    visitId = vid;
    Page = page;
    patientID = pid;
    hospitalName = hosname;
  }
  State<TestRequest> createState() => _TestRequestState();
}

class _TestRequestState extends State<TestRequest> {
  var back = Get.arguments;
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
    if (allArrayLength > _tests.length) {
      mysqlDatabase.addTest(
          selectedTest, int.parse(visitId), 'yes', hospitalName);
    } else {
      mysqlDatabase.addTest(
          selectedTest, int.parse(visitId), 'no', hospitalName);
    }

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
  List<int> testIds = [];
  var results;
  int ArrayLength;
  var allResults;
  Tests() async {
    visitsIds.forEach((element) async {
      results = await conn.query(
          'select labTestID from VisitLabTest where visitID = ?', [element]);
      print("element");

      print(element);
      ArrayLength = await results.length;
      if (element == int.parse(visitId)) {
        print("element");
        print(element);
        if (ArrayLength == 0) {
          setState(() {
            isFirst = true;
          });
        } else {
          setState(() {
            isFirst = false;
          });
        }
      }
      isFilled2 = 0;
      for (var row2 in results) {
        if (isFilled2 != ArrayLength) {
          int testNo2 = int.parse('${row2[0]}');
          testIds.add(testNo2);
          isFilled2 = isFilled2 + 1;
        }
      }
      if (element == visitsIds.last) {
        Tests2();
      }
    });
  }

  Tests2() async {
    allResults = await conn.query('select name,idlabTest from LabTest');
    allArrayLength = await allResults.length;
    //if (isFilled2 == ArrayLength) {
    print("isFilled2");

    bool exist = false;
    for (var row in allResults) {
      setState(() {
        exist = false;
      });
      if (isFilled != allArrayLength) {
        String testName = '${row[0]}';
        int testNo1 = int.parse('${row[1]}');
        if (testIds.length != 0) {
          testIds.forEach((element) {
            if (element == testNo1) {
              setState(() {
                exist = true;
              });
            }
          });
        }
        if (!exist) _tests.add(testName);
        isFilled = isFilled + 1;
      }
    }

    setState(() {
      loading = false;
    });
    //}
    if (loading == false) {
      _items =
          _tests.map((tests) => MultiSelectItem<String>(tests, tests)).toList();
    }
    // for (var lab in _tests)
    //   listItemSelected.add(ItemSelect(value: index++, label: '${lab[index]}'));
  }

  final _multiSelectKey = GlobalKey<FormFieldState>();
  final old = Get.previousRoute;

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  TextEditingController controllerName = TextEditingController();

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
              const SizedBox(
                width: 10,
              ),
              old != '/lab_tests'
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20, top: 50),
                        child: SizedBox(
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
                  child: const Padding(
                    padding: EdgeInsets.only(top: 60, left: 0, bottom: 10),
                    child: SizedBox(
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
          const SizedBox(
            height: 20,
          ),
          loading == true
              ? loadingPage()
              : MultiSelectBottomSheetField<String>(
                  key: _multiSelectKey,
                  initialChildSize: 0.7,
                  maxChildSize: 0.95,
                  title: _tests.length == 0
                      ? const Text(
                          " You have requested all the lab tests",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        )
                      : const Text("Lab Tests"),
                  buttonText: const Text("Choose Lab Tests"),
                  items: _items,
                  searchable: true,
                  confirmText: const Text(
                    "SAVE",
                    style: TextStyle(
                      color: ColorResources.green009,
                    ),
                  ),
                  cancelText: const Text(
                    "CANCEL",
                    style: TextStyle(
                      color: ColorResources.green009,
                    ),
                  ),
                  selectedColor: const Color.fromRGBO(241, 94, 34, 0.8),
                  validator: (values) {
                    if (values == null || values.isEmpty) {
                      return "Required";
                    }

                    return null;
                  },
                  onConfirm: (values) {
                    setState(() {
                      selectedTest = values;
                    });
                    _multiSelectKey.currentState.validate();
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromRGBO(241, 94, 34, 0.8),
                    ),
                    onTap: (item) {
                      setState(() {
                        selectedTest.remove(item);
                      });
                      _multiSelectKey.currentState.validate();
                    },
                  ),
                ),
          const Spacer(),
          if (loading == false)
            Row(
              children: [
                const SizedBox(width: 6),
//&&  allArrayLength > _tests.length
                if (!isFirst)
                  commonButton(() {
                    showAlertDialog(context);
                  }, "UPDATE", ColorResources.green009, ColorResources.white),
                //isFirst allArrayLength == _tests.length
                if (isFirst)
                  commonButton(() {
                    showAlertDialog(context);
                  }, "SEND", ColorResources.green009, ColorResources.white),
              ],
            ),
          const SizedBox(height: 30),
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
          padding: const EdgeInsets.only(top: 50, left: 0),
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

    if (!isFirst) {
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
      child: const Text(
        "OK",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        if (back == 'back2') {
          print('befoooooore');
          Get.back();
        } else {
          Get.back();
          Get.back();
        }
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
        child: const Text(
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
    Widget oKButton = TextButton(
        child: const Text(
          "Ok",
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
    if (!isFirst) {
      continueButton = TextButton(
        child: const Text(
          "UPDATE",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: () {
          if (selectedTest.length != 0) add();
          // setState(() {
          //   isFirst = false;
          // });
          sendReq();
        },
      );
    } else {
      continueButton = TextButton(
        child: const Text(
          "SEND",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: () {
          if (selectedTest.length != 0) add();
          // setState(() {
          //   isFirst = true;
          // });
          sendReq();
        },
      );
    }

    AlertDialog alert;
    // set up the AlertDialog
    if (selectedTest.length == 0) {
      alert = AlertDialog(
        title: const Text("Oops"),
        content: const Text("Please choose at least one test"),
        actions: [
          oKButton,
        ],
      );
    } else if (!isFirst) {
      alert = AlertDialog(
        title: const Text("Update Request"),
        content: const Text("Are you sure you want to update the request?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
    } else {
      alert = AlertDialog(
        title: const Text("Send Request"),
        content: const Text("Are you sure you want to send request?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
    }
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
