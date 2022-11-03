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
            // Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  gradient: RadialGradient(
                    colors: [
                      Color.fromARGB(255, 154, 194, 183),
                      Color.fromRGBO(19, 156, 140, 1)
                    ],
                    radius: 0.75,
                    focal: Alignment(0.3, -0.2),
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 0, left: 10, bottom: 10),
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
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 80, top: 50, right: 20, bottom: 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  ' Diagnosis',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ScrollConfiguration(
              //   behavior: MyBehavior(),
              //   child: SingleChildScrollView(
              //     child: Column(
              //     children: [
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
              //  nav(),
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
