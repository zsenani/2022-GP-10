import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';

import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/images.dart';
import '../../database/mysqlDatabase.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_history.dart';
import '../patient_home_screen.dart';

String Id;
bool loading = true;
bool cancel = false;

class MedicalHistory extends StatefulWidget {
  MedicalHistory({Key key, String id}) : super(key: key) {
    Id = id;
  }

  @override
  State<MedicalHistory> createState() => MedicalHistoryState();
}

class MedicalHistoryState extends State<MedicalHistory> {
  final TextEditingController BloodController = TextEditingController();
  bool errorBlood = false;

  String role = Get.arguments;
  List<String> _Allergy = [];
  List<String> _social = [];
  List<String> _family = [];
  List<String> _surgery = [];
  List<String> _Medical = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();

      setState(() {
        loading = true;
      });
    });
  }

  Future getData() async {
    var info = await conn.query(
        'select allergies,socialHistory,familyHistory,surgicalHistory,medicalIllnesses,bloodType from Patient where nationalId=?',
        [int.parse(Id)]);
    for (var row in info) {
      print(Id);
      setState(() {
        bloodType = '${row[5]}';
        allergies = '${row[0]}';
        socialHistory = '${row[1]}';
        familyHistory = '${row[2]}';
        surgicalHistory = '${row[3]}';
        medicalIllnesses = '${row[4]}';
      });
    }
    setState(() {
      _Allergy = allergies.split(',');
      _social = socialHistory.split(',');
      _family = familyHistory.split(',');
      _surgery = surgicalHistory.split(',');
      _Medical = medicalIllnesses.split(',');
    });
    setState(() {
      loading = false;
    });
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  void updatePatientInfo() async {
    if (BloodController.text != "null") {
      var pNewBlood = await conn.query(
          'update Patient set bloodType=? where NationalID=?',
          [BloodController.text, int.parse(nationalID)]);
    }
    setState(() {
      bloodType = BloodController.text;
      loading = false;
    });
  }

  bool validateBlood(String valueW) {
    // Pattern pattern = r'^([a-zA-Z]{1,1}[+-]{1,1})$';
    // RegExp regex = new RegExp(pattern);
    if (valueW == null || valueW == '') {
      print('wrong blood type');
      setState(() {
        errorBlood = true;
      });
      return false;
    } else {
      print("valid blood type");
      setState(() {
        errorBlood = false;
      });
      return true;
    }
  }

  Widget info() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Images.allergy2,
                  width: 25,
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child:
                          mediumText("Allergies", ColorResources.grey777, 18),
                    ),
                    const SizedBox(height: 10),
                    for (var index in _Allergy) ...[
                      if (index != null && index != ' ')
                        Column(
                          children: [
                            if ("${index}" != '' &&
                                "${index}" != ' ' &&
                                "${index}" != 'null')
                              romanText("${index}", ColorResources.grey777, 16),
                            if ("${index}" != '' &&
                                "${index}" != ' ' &&
                                "${index}" != 'null')
                              const SizedBox(height: 5),
                          ],
                        ),
                    ],
                  ],
                ),
              ]),
          const SizedBox(width: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.group,
                  color: Color.fromRGBO(241, 94, 34, 0.7), size: 30),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, right: 10),
                    child: mediumText(
                        "Social History", ColorResources.grey777, 18),
                  ),
                  const SizedBox(height: 10),
                  for (var index in _social) ...[
                    Column(
                      children: [
                        if ("${index}" != '' &&
                            "${index}" != ' ' &&
                            "${index}" != 'null')
                          romanText("${index}", ColorResources.grey777, 16),
                        if ("${index}" != '' &&
                            "${index}" != ' ' &&
                            "${index}" != 'null')
                          const SizedBox(height: 5),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Images.family2,
            width: 25,
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: mediumText("Family History", ColorResources.grey777, 18),
              ),
              const SizedBox(height: 10),
              const SizedBox(width: 10),
              for (var index in _family) ...[
                Column(
                  children: [
                    if ("${index}" != '' &&
                        "${index}" != ' ' &&
                        "${index}" != 'null')
                      romanText("${index}", ColorResources.grey777, 16),
                    if ("${index}" != '' &&
                        "${index}" != ' ' &&
                        "${index}" != 'null')
                      const SizedBox(height: 5),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(width: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Images.surgery2,
                width: 25,
                height: 25,
              ),
              //const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 3),
                    child: mediumText(
                        "Surgical History", ColorResources.grey777, 18),
                  ),
                  const SizedBox(height: 10),
                  for (var index in _surgery) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Column(
                        children: [
                          if ("${index}" != '' &&
                              "${index}" != ' ' &&
                              "${index}" != 'null')
                            romanText("${index}", ColorResources.grey777, 16),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Images.illness2,
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child:
                    mediumText("Medical Illnesses", ColorResources.grey777, 18),
              ),
              const SizedBox(height: 10),
              for (var index in _Medical) ...[
                Column(
                  children: [
                    if ("${index}" != '' &&
                        "${index}" != ' ' &&
                        "${index}" != 'null')
                      romanText("${index}", ColorResources.grey777, 16),
                    if ("${index}" != '' &&
                        "${index}" != ' ' &&
                        "${index}" != 'null')
                      const SizedBox(height: 5),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    print("bloodType");
    print(bloodType);

    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
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
                    child: const Center(
                      child:
                          Icon(Icons.arrow_back, color: ColorResources.grey777),
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: HeaderWidget(),
                ),
                if (role != "patient")
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();

                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 0),
                      child: Container(
                        height: 60,
                        width: 60,
                        child: const Center(
                          // heightFactor: 100,
                          child: Icon(Icons.home_outlined,
                              color: ColorResources.grey777),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            loading == true
                ? loadingPage()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.person_outline,
                                        color: Color.fromRGBO(241, 94, 34, 1),
                                        size: 30),
                                    const SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: mediumText("Personal information",
                                          ColorResources.grey777, 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Divider(
                                  color:
                                      ColorResources.greyD4D.withOpacity(0.4),
                                  thickness: 1,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            bookText("Name:   ",
                                                ColorResources.greyA0A, 16),
                                            mediumText(name,
                                                ColorResources.grey777, 16),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            bookText("Age   :   ",
                                                ColorResources.greyA0A, 16),
                                            mediumText('${age}',
                                                ColorResources.grey777, 16),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            bookText("Nationality: ",
                                                ColorResources.greyA0A, 15),
                                            mediumText(nationality + " ",
                                                ColorResources.grey777, 14),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            bookText("Gender :   ",
                                                ColorResources.greyA0A, 16),
                                            mediumText(gender,
                                                ColorResources.grey777, 16),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            bookText("ID : ",
                                                ColorResources.greyA0A, 16),
                                            mediumText(nationalID,
                                                ColorResources.grey777, 16),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            bookText("DOB: ",
                                                ColorResources.greyA0A, 16),
                                            mediumText(DOB,
                                                ColorResources.grey777, 16),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            bookText("Marital Status: ",
                                                ColorResources.greyA0A, 16),
                                            mediumText(maritalStatus,
                                                ColorResources.grey777, 16),
                                          ],
                                        ),
                                        if (role != "patient")
                                          const SizedBox(height: 10),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                bookText("Blood Type:  ",
                                                    ColorResources.greyA0A, 16),
                                                if (role == "patient")
                                                  Container(
                                                    width: 80,
                                                    child:
                                                        DropdownSearch<String>(
                                                      // selectedItem:
                                                      //     BloodController.text,
                                                      popupProps:
                                                          const PopupProps.menu(
                                                        showSelectedItems: true,
                                                        constraints:
                                                            BoxConstraints(
                                                          maxHeight: 260,
                                                          //maxWidth: 90
                                                        ),
                                                        // scrollbarProps:
                                                        //     ScrollbarProps(
                                                        //         thumbVisibility:
                                                        //             true),
                                                      ),
                                                      items: const [
                                                        'O+',
                                                        'O-',
                                                        'A+',
                                                        'A-',
                                                        'B+',
                                                        'B-',
                                                        'AB+',
                                                        'AB-'
                                                      ],
                                                      dropdownDecoratorProps:
                                                          DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          hintText: bloodType ==
                                                                      'null' ||
                                                                  bloodType ==
                                                                      ''
                                                              ? '--'
                                                              : bloodType,
                                                          hintStyle: const TextStyle(
                                                              color:
                                                                  ColorResources
                                                                      .grey777,
                                                              fontSize: 13),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: errorBlood ==
                                                                    false
                                                                ? const BorderSide(
                                                                    color: ColorResources
                                                                        .greyA0A,
                                                                    width: 1)
                                                                : const BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 1),
                                                          ),
                                                        ),
                                                      ),
                                                      onChanged: (String
                                                          selectedValue) {
                                                        BloodController.text =
                                                            selectedValue;
                                                      },
                                                    ),
                                                  ),
                                                if ((bloodType == 'null' ||
                                                        bloodType == '') &&
                                                    role != "patient")
                                                  bookText(
                                                      '--',
                                                      ColorResources.grey777,
                                                      16),
                                                if ((bloodType != 'null' &&
                                                        bloodType != '') &&
                                                    role != "patient")
                                                  bookText(
                                                      bloodType,
                                                      ColorResources.grey777,
                                                      16),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            role == "patient"
                                                ? Center(
                                                    child: Container(
                                                      width: 80,
                                                      height: 20,
                                                      // margin: EdgeInsets.all(25),
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                          'Update',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                        onPressed: () {
                                                          validateBlood(
                                                              BloodController
                                                                  .text);

                                                          if (errorBlood ==
                                                              false) {
                                                            alertDialogUpdate(
                                                                context);
                                                          } else {
                                                            alertUpdateError(
                                                                context);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Divider(
                                  color:
                                      ColorResources.greyD4D.withOpacity(0.4),
                                  thickness: 1,
                                ),

                                const SizedBox(height: 30),
                                info(),

                                const SizedBox(height: 30),
                                role == "UPphysician"
                                    ? Column(
                                        children: [
                                          commonButton(() async {
                                            loading = true;
                                            String refresh =
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditHistory(
                                                              id: Id,
                                                            )));
                                            if (refresh == 'refresh') {
                                              getData();
                                            }
                                          }, "Edit", ColorResources.green009,
                                              ColorResources.white),
                                          const SizedBox(height: 30),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  alertDialogUpdate(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
        child: const Text(
          "Cancel",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        });
    Widget continueButton = TextButton(
      child: const Text(
        "Confirm",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        print('control');
        print(BloodController.text);

        updatePatientInfo();
        setState(() {
          loading = true;
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Update"),
      content: Text("Are you sure you want to update the blood type to " +
          BloodController.text +
          " ?"),
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

  alertUpdateError(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: const Text(
        "Ok",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("Please choose a blood type"),
      actions: [
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

  Widget HeaderWidget() {
    return Stack(
      children: [
        Container(
          height: 80,
          width: Get.width,
          padding: const EdgeInsets.only(top: 23, left: 35),
          child: heavyText("Medical History ", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
