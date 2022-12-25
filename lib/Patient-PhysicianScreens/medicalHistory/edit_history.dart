import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Patient-PhysicianScreens/patient_home_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import '../../Utiils/common_widgets.dart';
import '../../main.dart';
import '../upcomming_visit_screen.dart';
import 'medical_history.dart';

String Pid;

class EditHistory extends StatefulWidget {
  static const String routeName = '/edit_history';

  EditHistory({Key key, String id}) : super(key: key) {
    Pid = id;
    //MedicalHistoryState.getData();
  }

  @override
  _EditHistory createState() => _EditHistory();
}

class _EditHistory extends State<EditHistory> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  //String _Allergy1 = allergies;
  List<String> _Allergy1 = allergies.split(',');
  List<String> _social1 = socialHistory.split(',');
  List<String> _family1 = familyHistory.split(',');
  List<String> _surgery1 = surgicalHistory.split(',');
  List<String> _Medical1 = medicalIllnesses.split(',');

  List<String> Allergy;
  List<String> social;
  List<String> family;
  List<String> surgery;
  List<String> Medical;

  // String _social1 = socialHistory;
  // String _family1 = familyHistory;
  // String _surgery1 = surgicalHistory;
  // String _Medical1 = medicalIllnesses;
  final TextEditingController SocialController = TextEditingController();
  final TextEditingController AllergyController = TextEditingController();
  final TextEditingController FamilyController = TextEditingController();
  final TextEditingController SurgicalController = TextEditingController();
  final TextEditingController MedicalController = TextEditingController();

  void edit() {
    if (AllergyController.text != "") {
      _Allergy1.add(AllergyController.text);
      mysqlDatabase.deleteHistory("allergies", _Allergy1, int.parse(Pid));
    }
    if (FamilyController.text != "") {
      _family1.add(FamilyController.text);
      mysqlDatabase.deleteHistory("familyHistory", _family1, int.parse(Pid));
    }
    if (SocialController.text != "") {
      _social1.add(SocialController.text);
      mysqlDatabase.deleteHistory("socialHistory", _social1, int.parse(Pid));
    }
    if (MedicalController.text != "") {
      _Medical1.add(MedicalController.text);
      mysqlDatabase.deleteHistory(
          "medicalIllnesses", _Medical1, int.parse(Pid));
    }
    if (SurgicalController.text != "") {
      _surgery1.add(SurgicalController.text);
      mysqlDatabase.deleteHistory("surgicalHistory", _surgery1, int.parse(Pid));
    }
  }

  void delete() {
    if (Allergy != null)
      mysqlDatabase.deleteHistory("allergies", Allergy, int.parse(Pid));
    if (social != null)
      mysqlDatabase.deleteHistory("socialHistory", social, int.parse(Pid));
    if (family != null)
      mysqlDatabase.deleteHistory("familyHistory", family, int.parse(Pid));
    if (surgery != null)
      mysqlDatabase.deleteHistory("surgicalHistory", surgery, int.parse(Pid));
    if (Medical != null)
      mysqlDatabase.deleteHistory("medicalIllnesses", Medical, int.parse(Pid));
  }

  void getData() async {
    var info = await conn.query(
        'select allergies,socialHistory,familyHistory,surgicalHistory,medicalIllnesses from Patient where nationalId=?',
        [int.parse(Pid)]);
    for (var row in info) {
      setState(() {
        allergies = '${row[0]}';
        socialHistory = '${row[1]}';
        familyHistory = '${row[2]}';
        surgicalHistory = '${row[3]}';
        medicalIllnesses = '${row[4]}';
        _Allergy1 = allergies.split(',');
        _social1 = socialHistory.split(',');
        _family1 = familyHistory.split(',');
        _surgery1 = surgicalHistory.split(',');
        _Medical1 = medicalIllnesses.split(',');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: Get.width,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
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
                                    color: ColorResources.grey777),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  ' Edit Medical History',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: ColorResources.green009,
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
                                    color: ColorResources.grey777),
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
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child:
                            mediumText("Allergies", ColorResources.orange, 18),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 100,
                        child: txtfield(AllergyController),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //  height: ,
                        width: 190,
                        child: Column(
                          children: [
                            for (var index in _Allergy1) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 20),
                                  if (index != "") Text('${index}'),
                                  if (index != "")
                                    IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            _Allergy1.remove(index);
                                            Allergy = _Allergy1;
                                          });
                                        })
                                ],
                              ),
                            ],
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
                        //height: 40,
                        width: 140,
                        child: Column(
                          children: [
                            for (var index in _social1) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (index != "") Text('${index}'),
                                  if (index != "")
                                    IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            _social1.remove(index);
                                            social = _social1;
                                          });
                                        })
                                ],
                              ),
                            ],
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
                      //height: 40,
                      width: 190,
                      child: Column(
                        children: [
                          for (var index in _family1) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 50),
                                if (index != "")
                                  Text('${index}'
                                      // _family1,
                                      ),
                                if (index != "")
                                  IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _family1.remove(index);
                                          family = _family1;
                                        });
                                      })
                              ],
                            ),
                          ],
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
                      //  height: 40,
                      width: 160,
                      child: Column(
                        children: [
                          for (var index in _surgery1) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 20),
                                if (index != "") Text('${index}'),
                                if (index != "")
                                  IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _surgery1.remove(index);
                                          surgery = _surgery1;
                                        });
                                      })
                              ],
                            ),
                          ],
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
                    //height: 40,
                    width: 150,
                    child: Column(
                      children: [
                        for (var index in _Medical1) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 20),
                              if (index != "") Text('${index}'),
                              if (index != "")
                                IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _Medical1.remove(index);
                                        Medical = _Medical1;
                                      });
                                    })
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
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
        if (AllergyController.text != "" ||
            FamilyController != "" ||
            SocialController != "" ||
            MedicalController != "" ||
            SurgicalController != "") edit();

        if (Allergy != null ||
            social != null ||
            family != null ||
            Medical != null ||
            surgery != null) delete();
        Navigator.of(context).pop();

        Navigator.pop(context, 'refresh');

        // Get.to(
        //     MedicalHistory(
        //       id: Pid,
        //     ),
        //     arguments: "UPphysician");
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
