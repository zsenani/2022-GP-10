import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Patient-PhysicianScreens/patient_home_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import '../../Utiils/common_widgets.dart';

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

  bool Allergy = false;
  bool social = false;
  bool family = false;
  bool surgery = false;
  bool Medical = false;

  final TextEditingController SocialController = TextEditingController();
  final TextEditingController AllergyController = TextEditingController();
  final TextEditingController FamilyController = TextEditingController();
  final TextEditingController SurgicalController = TextEditingController();
  final TextEditingController MedicalController = TextEditingController();

  void edit() {
    if (AllergyController.text != "" && AllergyController.text != " ") {
      _Allergy1.add(AllergyController.text);
      mysqlDatabase.deleteHistory("allergies", _Allergy1, int.parse(Pid));
    }
    if (FamilyController.text != "" && FamilyController.text != " ") {
      _family1.add(FamilyController.text);
      mysqlDatabase.deleteHistory("familyHistory", _family1, int.parse(Pid));
    }
    if (SocialController.text != "" && SocialController.text != " ") {
      _social1.add(SocialController.text);
      mysqlDatabase.deleteHistory("socialHistory", _social1, int.parse(Pid));
    }
    if (MedicalController.text != "" && MedicalController.text != " ") {
      _Medical1.add(MedicalController.text);
      mysqlDatabase.deleteHistory(
          "medicalIllnesses", _Medical1, int.parse(Pid));
    }
    if (SurgicalController.text != "" && SurgicalController.text != " ") {
      _surgery1.add(SurgicalController.text);
      mysqlDatabase.deleteHistory("surgicalHistory", _surgery1, int.parse(Pid));
    }
  }

  void delete() {
    if (Allergy) {
      mysqlDatabase.deleteHistory("allergies", _Allergy1, int.parse(Pid));
      Allergy = false;
    }
    if (social) {
      mysqlDatabase.deleteHistory("socialHistory", _social1, int.parse(Pid));
      social = false;
    }
    if (family) {
      mysqlDatabase.deleteHistory("familyHistory", _family1, int.parse(Pid));
      family = false;
    }
    if (surgery) {
      mysqlDatabase.deleteHistory("surgicalHistory", _surgery1, int.parse(Pid));
      surgery = false;
    }
    if (Medical) {
      mysqlDatabase.deleteHistory(
          "medicalIllnesses", _Medical1, int.parse(Pid));
      Medical = false;
    }
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
            SizedBox(
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
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              bottom: 100,
                            ),
                            child: SizedBox(
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
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: const Align(
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
                            //////////////////////////////
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                              bottom: 100,
                            ),
                            child: SizedBox(
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
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10),
                    child: mediumText("Allergies", ColorResources.orange, 18),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    //width: 200,
                    child: txtfield(AllergyController),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Column(
                      children: [
                        for (var index in _Allergy1) ...[
                          if (index != null &&
                              index != ' ' &&
                              "${index}" != 'null')
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                if (index != "" && "${index}" != 'null')
                                  Text('${index}'),
                                if (index != "" && "${index}" != 'null')
                                  IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _Allergy1.remove(index);
                                          Allergy = true;
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10),
                    child:
                        mediumText("Social History", ColorResources.orange, 18),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: txtfield(SocialController),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Column(
                      children: [
                        for (var index in _social1) ...[
                          if (index != null &&
                              index != ' ' &&
                              "${index}" != 'null')
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                if (index != "" && "${index}" != 'null')
                                  Text('${index}'),
                                if (index != "" && "${index}" != 'null')
                                  IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _social1.remove(index);
                                          social = true;
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10),
                    child:
                        mediumText("Family History", ColorResources.orange, 18),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: txtfield(FamilyController),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Column(
                      children: [
                        for (var index in _family1) ...[
                          if (index != null &&
                              index != ' ' &&
                              "${index}" != 'null')
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                if (index != "" && "${index}" != 'null')
                                  Text('${index}'
                                      // _family1,
                                      ),
                                if (index != "" && "${index}" != 'null')
                                  IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _family1.remove(index);
                                          family = true;
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10),
                    child: mediumText(
                        "Surgical History", ColorResources.orange, 18),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: txtfield(SurgicalController),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Column(
                      children: [
                        for (var index in _surgery1) ...[
                          if (index != null &&
                              index != ' ' &&
                              "${index}" != 'null')
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                if (index != "" && "${index}" != 'null')
                                  Text('${index}'),
                                if (index != "" && "${index}" != 'null')
                                  IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _surgery1.remove(index);
                                          surgery = true;
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10),
                    child: mediumText(
                        "Medical Illnesses", ColorResources.orange, 18),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: txtfield(MedicalController),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Column(
                      children: [
                        for (var index in _Medical1) ...[
                          if (index != null &&
                              index != ' ' &&
                              "${index}" != 'null')
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                if (index != "" && "${index}" != 'null')
                                  Text('${index}'),
                                if (index != "" && "${index}" != 'null')
                                  IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _Medical1.remove(index);
                                          Medical = true;
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
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 5),
                commonButton(
                  () {
                    showAlertDialog(context);
                  },
                  "Save",
                  ColorResources.green009,
                  ColorResources.white,
                ),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget txtfield(_controller) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      controller: _controller,
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
      onPressed: () => Navigator.pop(context),

      // Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text(
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

        if (Allergy || social || family || Medical || surgery) delete();
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
      title: const Text("Save Changes"),
      content: const Text("Are you sure you want to save changes?"),
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
