import '../Utiils/colors.dart';
import '../Utiils/common_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class writeDiagnose extends StatefulWidget {
  @override
  State<writeDiagnose> createState() => _writeDiagnoseState();
}

class _writeDiagnoseState extends State<writeDiagnose> {
  final TextEditingController descriptionControllerS = TextEditingController();
  final TextEditingController descriptionControllerO = TextEditingController();
  final TextEditingController descriptionControllerA = TextEditingController();
  final TextEditingController descriptionControllerP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 145,
                width: Get.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 45, left: 10, bottom: 10),
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Icon(Icons.arrow_back,
                                      color: ColorResources.grey777),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 60, top: 60, right: 20, bottom: 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    ' Diagnosis',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900,
                                      color: ColorResources.green009,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    heavyText(" Subject", Color.fromRGBO(241, 94, 34, 1), 18),
                    SizedBox(height: 15),
                    textField2("Enter Description...", descriptionControllerS,
                        TextInputType.text),
                    SizedBox(height: 20),
                    heavyText(" Object", Color.fromRGBO(241, 94, 34, 1), 18),
                    SizedBox(height: 15),
                    textField2("Enter Description...", descriptionControllerO,
                        TextInputType.text),
                    SizedBox(height: 20),
                    heavyText(
                      " Assignment",
                      Color.fromRGBO(241, 94, 34, 1),
                      18,
                    ),
                    SizedBox(height: 15),
                    textField2("Enter Description...", descriptionControllerA,
                        TextInputType.text),
                    SizedBox(height: 20),
                    heavyText(" Plan", Color.fromRGBO(241, 94, 34, 1), 18),
                    SizedBox(height: 15),
                    textField2("Enter Description...", descriptionControllerP,
                        TextInputType.text),
                    SizedBox(height: 30),
                    commonButton(() {
                      showAlertDialog(context);
                    }, "Add Diagnose", ColorResources.green009,
                        ColorResources.white),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //   ),
    // );
  }

  addDiagnose() {
    String title;
    String content;
    Navigator.of(context).pop();

    if (descriptionControllerS.text == "" ||
        descriptionControllerO.text == "" ||
        descriptionControllerA.text == "" ||
        descriptionControllerP.text == "") {
      title = "Oops";
      content = "Please make sure all fields are filled in correctly!";
    } else {
      title = "Saved";
      content = "The diagnose has been added successfully!";
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
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: Text(
        "ADD",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        addDiagnose();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add Diagnose"),
      content: Text("Are you sure you want to add diagnose?"),
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
