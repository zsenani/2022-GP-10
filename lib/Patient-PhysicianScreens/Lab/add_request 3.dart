import '../../Controller/test_tab_conroller.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'ActiveReq.dart';
import 'previousReq.dart';
import 'tests.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class TestRequest extends StatefulWidget {
  State<TestRequest> createState() => _TestRequestState();
}

class _TestRequestState extends State<TestRequest> {
  final LabTabBarController tabBarController = Get.put(LabTabBarController());

  static final List<Widget> pages = [ActiveReq(), PreviousReq()];

  static List<Tests> _tests = [
    Tests(id: 1, name: "MPV"),
    Tests(id: 2, name: "RDW"),
    Tests(id: 3, name: "RBC"),
    Tests(id: 4, name: "Hct"),
    Tests(id: 5, name: "MCV"),
    Tests(id: 6, name: "MCH"),
    Tests(id: 7, name: "Hgb"),
    Tests(id: 8, name: "Uric Acid"),
  ];

  final _items =
      _tests.map((tests) => MultiSelectItem<Tests>(tests, tests.name)).toList();
  //List<Tests> _selectedTests = [];
  List<Tests> _selectedTests2 = [];
  List<Tests> _selectedTests3 = [];
  //List<Tests> _selectedTests4 = [];
  List<Tests> _selectedTests5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedTests5 = _tests;
    super.initState();
  }

  final old = Get.previousRoute;

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
                        padding: const EdgeInsets.only(right: 30, top: 50),
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
            ],
          ),
          SizedBox(
            height: 20,
          ),
          MultiSelectBottomSheetField<Tests>(
            key: _multiSelectKey,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            title: Text("Lab Tests"),
            buttonText: Text("Choose Lab Tests"),
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
            selectedColor: Color.fromRGBO(241, 94, 34, 0.8),
            validator: (values) {
              if (values == null || values.isEmpty) {
                return "Required";
              }
              // List<String> names = values.map((e) => e.name).toList();
              // if (names.contains("Frog")) {
              //   return "Frogs are weird!";
              // }
              return null;
            },
            onConfirm: (values) {
              setState(() {
                _selectedTests3 = values;
              });
              _multiSelectKey.currentState.validate();
            },
            chipDisplay: MultiSelectChipDisplay(
              icon: Icon(
                Icons.close,
                color: Color.fromRGBO(241, 94, 34, 0.8),
              ),
              onTap: (item) {
                setState(() {
                  _selectedTests3.remove(item);
                });
                _multiSelectKey.currentState.validate();
              },
            ),
          ),
          Spacer(),
          Row(
            children: [
              SizedBox(width: 6),
              commonButton(() {
                showAlertDialog(context);
              }, "SEND", ColorResources.green009, ColorResources.white),
            ],
          ),
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
          width: Get.width,
          padding: EdgeInsets.only(top: 50, left: 10),
          child: heavyText("Request Lab Tests", ColorResources.green009, 30),
        ),
      ],
    );
  }

  sendReq() {
    String title;
    String content;
    Navigator.of(context).pop();

    if (_selectedTests3.length == 0) {
      title = "Oops";
      content = "Please choose at least one test";
    } else {
      title = "DONE!";
      content = "The request has been sent successfully";
    }
    Widget OKButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
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
    Widget continueButton = TextButton(
      child: Text(
        "SEND",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        sendReq();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
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
