import '../../Controller/test_tab_conroller.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../Utiils/text_font_family.dart';
import '../../main.dart';
import '../Lab/tests.dart';
import 'current_medication.dart';
import 'past_medication.dart';

import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class AddMedication extends StatefulWidget {
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  // final LabTabBarController tabBarController = Get.put(LabTabBarController());
  final TextEditingController ControllerName = TextEditingController();
  final TextEditingController ControllerDosage = TextEditingController();
  final TextEditingController ControllerDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.whiteF6F,
        body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30, top: 40),
                          child: Flexible(
                            flex: 1,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: ColorResources.whiteF6F,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: ColorResources.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.arrow_back,
                                    color: ColorResources.grey777),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 10,
                        child: HeaderWidget(),
                      ),
                    ],
                  ),
                  Divider(
                    color: ColorResources.greyD4D.withOpacity(0.4),
                    thickness: 1,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          heavyText("Name", Color.fromRGBO(241, 94, 34, 1), 18),
                          textField1("Enter Medication name...", ControllerName,
                              TextInputType.text),
                          SizedBox(height: 20),
                          heavyText(
                              "Dosage", Color.fromRGBO(241, 94, 34, 1), 18),
                          textField1("Enter Dosage...", ControllerDosage,
                              TextInputType.text),
                          SizedBox(height: 20),
                          heavyText(
                            "Description",
                            Color.fromRGBO(241, 94, 34, 1),
                            18,
                          ),
                          SizedBox(height: 10),
                          textField2("Enter Description...",
                              ControllerDescription, TextInputType.text),
                          SizedBox(height: 60),
                          commonButton(() {
                            showAlertDialog(context);
                          }, "ADD", ColorResources.green009,
                              ColorResources.white),
                        ]),
                  ),
                  // Spacer(),
                ],
              ),
            )));
  }

  Widget HeaderWidget() {
    return Container(
      //alignment: Alignment.center,
      height: 80,
      width: Get.width,
      padding: EdgeInsets.only(top: 40, left: 30),
      child: heavyText("Add Medication", ColorResources.green009, 25),
    );
  }

  sendReq() {
    String title;
    String content;
    String done;
    Navigator.of(context).pop();

    if (ControllerName.text == '' || ControllerDosage.text == '') {
      title = "Oops";
      content = "Please Enter Name and Dosage";
      done = 'false';
    } else {
      title = "DONE!";
      content = "The Medication Added successfully";
      done = 'true';
    }
    Widget OKButton = TextButton(
        child: Text(
          "OK",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: () {
          if (done == 'true') {
            Navigator.pop(context);
            Navigator.pop(context);
          } else
            Navigator.pop(context);
        });

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
        "ADD",
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
      title: Text("Add Medication"),
      content: Text("Are you sure you want to Add this medication?"),
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
