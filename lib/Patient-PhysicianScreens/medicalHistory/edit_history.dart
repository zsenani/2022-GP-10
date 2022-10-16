import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../main.dart';

class EditHistory extends StatefulWidget {
  @override
  _EditHistory createState() => _EditHistory();
}

class _EditHistory extends State<EditHistory> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  String _Allergy1 = "Balsam of Peru";
  //TextEditingController _Allergy2 = TextEditingController(text: "Sulfonamides");
  String _social1 = "Tobacco use";
  String _family1 = "Diabetes";
  //TextEditingController _family2 =TextEditingController(text: "High Blood Pressure");
  String _surgery1 = "Heart Surgery";
  //TextEditingController _surgery2 = TextEditingController(text: "Appendectomy");
  String _Medical1 = "Coronavirus";
  //TextEditingController _Medical2 = TextEditingController(text: "Bone Canser");
  final TextEditingController SocialController = TextEditingController();
  final TextEditingController AllergyController = TextEditingController();
  final TextEditingController FamilyController = TextEditingController();
  final TextEditingController SurgicalController = TextEditingController();
  final TextEditingController MedicalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Container(
            height: Get.height, //670,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 110,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 100,
                                ),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: Icon(Icons.arrow_back,
                                        color: ColorResources.white),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 30,
                                    right: 40,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      ' Edit Medical History',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 100,
                                ),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: Icon(Icons.home_outlined,
                                        color: ColorResources.white),
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
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: mediumText(
                                "Allergies", ColorResources.orange, 18),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: 100,
                            child: txtfield(AllergyController),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: 190,
                            child: Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  _Allergy1,
                                ),
                                _Allergy1 != ""
                                    ? IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            _Allergy1 = "";
                                          });
                                        })
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: mediumText(
                                "Social History", ColorResources.orange, 18),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: 100,
                            child: txtfield(SocialController),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: 140,
                            child: Row(
                              children: [
                                Text(
                                  _social1,
                                ),
                                _social1 != ""
                                    ? IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            _social1 = "";
                                          });
                                        })
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: mediumText(
                              "Family History", ColorResources.orange, 18),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          width: 100,
                          child: txtfield(FamilyController),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          width: 190,
                          child: Row(
                            children: [
                              SizedBox(width: 50),
                              Text(
                                _family1,
                              ),
                              _family1 != ""
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _family1 = "";
                                        });
                                      })
                                  : Container(),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: mediumText(
                              "Surgical History", ColorResources.orange, 18),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          width: 100,
                          child: txtfield(SurgicalController),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          width: 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 20),
                              Text(
                                _surgery1,
                              ),
                              _surgery1 != ""
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _surgery1 = "";
                                        });
                                      })
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 210),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: mediumText(
                            "Medical Illnesses", ColorResources.orange, 18),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 100,
                        child: txtfield(MedicalController),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 20),
                            Text(
                              _Medical1,
                            ),
                            _Medical1 != ""
                                ? IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _Medical1 = "";
                                      });
                                    })
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    SizedBox(width: 5),
                    commonButton(
                      () {
                        showAlertDialog(context);
                      },
                      "Save",
                      ColorResources.green009,
                      ColorResources.white,
                    ),
                    SizedBox(width: 5),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget txtfield(_controller) {
    return TextField(
        style: TextStyle(
          backgroundColor: ColorResources.white,
        ),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResources.greyA0A, width: 1),
          ),
        ),
        controller: _controller,
        keyboardType: TextInputType.text);
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

      // Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: Text(
        "SAVE",
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
      title: Text("Save Changes"),
      content: Text("Are you sure you want to save changes?"),
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
