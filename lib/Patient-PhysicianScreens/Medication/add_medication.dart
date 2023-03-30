import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';
import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utiils/text_font_family.dart';
import '../../database/mysqlDatabase.dart';
import '../../main.dart';
import '../upcomming_visit_screen.dart';
import 'medication_list.dart';

String visitId;
int patientId;

class AddMedication extends StatefulWidget {
  AddMedication({Key key, String vid, int pid}) : super(key: key) {
    visitId = vid;
    patientId = pid;
  }
  State<AddMedication> createState() => _AddMedicationState();
}

bool loading = true;

class _AddMedicationState extends State<AddMedication> {
  // final LabTabBarController tabBarController = Get.put(LabTabBarController());
  final TextEditingController ControllerName = TextEditingController();
  final TextEditingController ControllerDosage = TextEditingController();
  final TextEditingController ControllerDescription = TextEditingController();

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        loading = true;
      });
      Medications();
    });
  }

  void add() {
    mysqlDatabase.addMedication(
        medication,
        ControllerDosage.text,
        "${selectedDate.toLocal()}".split(' ')[0],
        "${selectedDate2.toLocal()}".split(' ')[0],
        ControllerDescription.text,
        int.parse(visitId));
  }

  String date;
  bool errorDate = false;
  bool errorDate2 = false;
  bool errorDateorder = false;
  bool errorName = false;
  bool errorDosage = false;

  DateTime SselectedDate = DateTime.now();
  DateTime EselectedDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 2);
  DateTime selectedDate;
  DateTime picked;
  DateTime selectedDate2;
  DateTime picked2;
  Future<void> selectDate(BuildContext context) async {
    if (date == 'start') {
      picked = await showDatePicker(
          context: context,
          initialDate: SselectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 3));
    } else if (date == 'end') {
      picked2 = await showDatePicker(
          context: context,
          initialDate: EselectedDate,
          firstDate: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2),
          lastDate: DateTime(DateTime.now().year + 5));
    }
    //if (date == 'start' && picked != null && picked != SselectedDate) {
    if (date == 'start' && picked != null) {
      setState(() {
        selectedDate = picked;
        SselectedDate = picked;
      });
    }
    //if (date == 'end' && picked2 != null && picked2 != EselectedDate) {
    if (date == 'end' && picked2 != null) {
      setState(() {
        selectedDate2 = picked2;
        EselectedDate = picked2;
      });
    }
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

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
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30, top: 40),
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
                              child: Icon(Icons.arrow_back,
                                  color: ColorResources.grey777),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 10,
                        child: HeaderWidget(),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            left: 25,
                          ),
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
                  Divider(
                    color: ColorResources.greyD4D.withOpacity(0.4),
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: loading == true
                        ? loadingPage()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                const SizedBox(height: 20),
                                heavyText("Name",
                                    const Color.fromRGBO(241, 94, 34, 1), 18),
                                // textField1("Enter Medication name...", ControllerName,
                                //     TextInputType.text,
                                //     error: errorName),
                                DropdownSearch<String>(
                                  selectedItem: medication,
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            hintText: 'Search..',
                                            constraints:
                                                BoxConstraints(maxHeight: 40))),
                                    constraints: BoxConstraints(maxHeight: 230),
                                    scrollbarProps:
                                        ScrollbarProps(thumbVisibility: true),
                                  ),
                                  items: ArrayOfMedication,
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Choose medication",
                                      hintStyle: const TextStyle(
                                          color: ColorResources.grey777),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: errorName == false
                                            ? const BorderSide(
                                                color: ColorResources.greyA0A,
                                                width: 1)
                                            : const BorderSide(
                                                color: Colors.red, width: 1),
                                      ),
                                    ),
                                  ),
                                  onChanged: (String selectedValue) {
                                    medication = selectedValue;
                                  },
                                ),
                                const SizedBox(height: 5),
                                if (errorName == true)
                                  mediumText(
                                      "Choose medication", Colors.red, 16),
                                const SizedBox(height: 20),
                                heavyText("Dosage",
                                    const Color.fromRGBO(241, 94, 34, 1), 18),
                                textField1("Enter Dosage...", ControllerDosage,
                                    TextInputType.text,
                                    error: errorDosage),
                                const SizedBox(height: 5),
                                if (errorDosage == true)
                                  mediumText("Enter dosage", Colors.red, 16),
                                const SizedBox(height: 30),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        mediumText(
                                            "Start date",
                                            const Color.fromRGBO(
                                                241, 94, 34, 1),
                                            20),
                                        if (selectedDate == null)
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                date = 'start';
                                              });
                                              selectDate(context);
                                            },
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.all(10.0),
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: errorDate
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: Border.all(
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.7),
                                                            strokeAlign: StrokeAlign
                                                                .inside))
                                                    : BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: Border.all(
                                                            color: ColorResources.grey777
                                                                .withOpacity(0.7),
                                                            strokeAlign: StrokeAlign.inside)),
                                                child: Text(
                                                  "${SselectedDate.toLocal()}"
                                                      .split(' ')[0],
                                                  style: TextStyle(
                                                    color:
                                                        ColorResources.grey777,
                                                    fontSize: 16,
                                                    fontFamily: TextFontFamily
                                                        .AVENIR_LT_PRO_BOOK,
                                                  ),
                                                )),
                                          ),
                                        if (selectedDate != null)
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                date = 'start';
                                              });
                                              selectDate(context);
                                            },
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.all(10.0),
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: errorDate
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: Border.all(
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.7),
                                                            strokeAlign: StrokeAlign
                                                                .inside))
                                                    : BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: Border.all(
                                                            color: ColorResources.grey777
                                                                .withOpacity(0.7),
                                                            strokeAlign: StrokeAlign.inside)),
                                                child: Text(
                                                  "${SselectedDate.toLocal()}"
                                                      .split(' ')[0],
                                                  style: TextStyle(
                                                    color: ColorResources.black,
                                                    fontSize: 16,
                                                    fontFamily: TextFontFamily
                                                        .AVENIR_LT_PRO_BOOK,
                                                  ),
                                                )),
                                          ),
                                        const SizedBox(height: 3),
                                        if (errorDate == true)
                                          mediumText(
                                              "Enter a date", Colors.red, 16),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        mediumText(
                                            "End date",
                                            const Color.fromRGBO(
                                                241, 94, 34, 1),
                                            20),
                                        if (selectedDate2 == null)
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                date = 'end';
                                              });
                                              selectDate(context);
                                            },
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.all(10.0),
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: errorDate2 || errorDateorder
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: Border.all(
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.7),
                                                            strokeAlign: StrokeAlign
                                                                .inside))
                                                    : BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: Border.all(
                                                            color: ColorResources.grey777
                                                                .withOpacity(0.7),
                                                            strokeAlign: StrokeAlign.inside)),
                                                child: Text(
                                                  "${EselectedDate.toLocal()}"
                                                      .split(' ')[0],
                                                  style: TextStyle(
                                                    color:
                                                        ColorResources.grey777,
                                                    fontSize: 16,
                                                    fontFamily: TextFontFamily
                                                        .AVENIR_LT_PRO_BOOK,
                                                  ),
                                                )),
                                          ),
                                        if (selectedDate2 != null)
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                date = 'end';
                                              });
                                              selectDate(context);
                                            },
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.all(10.0),
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: errorDate2 || errorDateorder
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: Border.all(
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.7),
                                                            strokeAlign: StrokeAlign
                                                                .inside))
                                                    : BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: Border.all(
                                                            color: ColorResources.grey777
                                                                .withOpacity(0.7),
                                                            strokeAlign: StrokeAlign.inside)),
                                                child: Text(
                                                  "${EselectedDate.toLocal()}"
                                                      .split(' ')[0],
                                                  style: TextStyle(
                                                    color: ColorResources.black,
                                                    fontSize: 16,
                                                    fontFamily: TextFontFamily
                                                        .AVENIR_LT_PRO_BOOK,
                                                  ),
                                                )),
                                          ),
                                        const SizedBox(height: 3),
                                        if (errorDate2 == true)
                                          mediumText(
                                              "Enter a date", Colors.red, 16),
                                        if (errorDateorder == true)
                                          mediumText(
                                              "End date should be at least",
                                              Colors.red,
                                              13),
                                        if (errorDateorder == true)
                                          mediumText(
                                              "2 days after the start date",
                                              Colors.red,
                                              13),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                heavyText(
                                  "Description",
                                  const Color.fromRGBO(241, 94, 34, 1),
                                  18,
                                ),
                                const SizedBox(height: 10),
                                textField2("Enter Description...",
                                    ControllerDescription, TextInputType.text),
                                const SizedBox(height: 60),
                                commonButton(() {
                                  sendReq();
                                }, "ADD", ColorResources.green009,
                                    ColorResources.white),
                              ]),
                  ),
                ],
              ),
            )));
  }

  Widget HeaderWidget() {
    return Container(
      //alignment: Alignment.center,
      height: 80,
      width: Get.width,
      padding: const EdgeInsets.only(top: 50, left: 15),
      child: heavyText("Add Medication", ColorResources.green009, 25),
    );
  }

  bool validateStartDate(DateTime value) {
    print(value);
    if (value == null) {
      print('Enter Valid date');
      setState(() {
        errorDate = true;
      });
      return false;
    } else {
      print("valid date");
      setState(() {
        errorDate = false;
      });
      return true;
    }
  }

  bool validateEndDate(DateTime value) {
    print(value);
    if (value == null) {
      print('Enter Valid date');
      setState(() {
        errorDate2 = true;
      });
      return false;
    } else {
      print(selectedDate2.difference(selectedDate).inDays);
      if (selectedDate2.isBefore(selectedDate) ||
          selectedDate2.isAtSameMomentAs(selectedDate) ||
          selectedDate2.difference(selectedDate).inDays <= 1) {
        setState(() {
          errorDateorder = true;
        });
      } else {
        setState(() {
          errorDateorder = false;
        });
      }
      print("valid date");
      setState(() {
        errorDate2 = false;
      });
      return true;
    }
  }

  bool validateName(String value) {
    print(value);
    if (value == '' || value == null) {
      print('Enter valid name');
      setState(() {
        errorName = true;
      });
      return false;
    } else {
      print("valid name");
      setState(() {
        errorName = false;
      });
      return true;
    }
  }

  bool validateDosage(String value) {
    print(value);
    if (value == '') {
      print('Enter valid dosage');
      setState(() {
        errorDosage = true;
      });
      return false;
    } else {
      print("valid dosage");
      setState(() {
        errorDosage = false;
      });
      return true;
    }
  }

  String medication;
  List<String> ArrayOfMedication = new List<String>();

  int isFilled = 0;
  int isFilled2 = 0;

  Medications() async {
    var visits = await conn
        .query('select idvisit from Visit where idPatient = ?', [patientId]);
    int visitLength = await visits.length;
    int ArrayLength;
    List<int> medIds = [];
    for (var visit in visits) {
      isFilled2 = 0;
      var results = await conn
          .query('select medicationID from VisitMedication where visitID = ? ',

              ///and endDate>? , DateTime.now().toUtc()
              [int.parse('${visit[0]}')]);
      print("result");
      print(results);

      print(int.parse('${visit[0]}'));
      ArrayLength = await results.length;
      if (ArrayLength != 0) {
        print("enter");
        for (var row2 in results) {
          if (isFilled2 != ArrayLength) {
            int medNo2 = int.parse('${row2[0]}');
            medIds.add(medNo2);
            isFilled2 = isFilled2 + 1;
          }
        }
      }
    }
    print("medIds");

    print(medIds);
    print(isFilled2);
    print(ArrayLength);

    var allResults =
        await conn.query('select name,idmedication from Medication');
    int allArrayLength = await allResults.length;
    if (isFilled2 == ArrayLength) {
      bool exist = false;
      String medication;
      for (var row in allResults) {
        setState(() {
          exist = false;
        });
        print(allResults);
        if (isFilled != allArrayLength) {
          medication = '${row[0]}';
          int medNo1 = int.parse('${row[1]}');
          if (ArrayLength != 0) {
            medIds.forEach((element) {
              if (element == medNo1) {
                setState(() {
                  exist = true;
                });
              }
            });
          }
          if (!exist) ArrayOfMedication.add(medication);
          //   ArrayOfMedication.add(medication);
          print("ArrayOfMedication");
          print(ArrayOfMedication);

          isFilled = isFilled + 1;
        }
      }

      setState(() {
        loading = false;
      });
    }
  }

  sendReq() {
    String title;
    String content;
    String done;
    validateStartDate(selectedDate);
    validateEndDate(selectedDate2);
    validateName(medication);
    validateDosage(ControllerDosage.text);
    if (errorName == false &&
        errorDosage == false &&
        errorDate == false &&
        errorDate2 == false &&
        errorDateorder == false) {
      showAlertDialog(context);
    }
  }

  showAlertDialog1(BuildContext context) {
    Widget OKButton = TextButton(
        child: const Text(
          "OK",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: () {
          add();
          Get.to(
              MedicationList(
                id: patientId.toString(),
                vid: visitId,
                role1: 'UPphysician',
                idPHy: idPhysician,
              ),
              arguments: 'patientfile');
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("DONE!"),
      content: const Text("The Medication Added successfully"),
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
    Widget continueButton = TextButton(
      child: const Text(
        "ADD",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        showAlertDialog1(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Add Medication"),
      content: const Text("Are you sure you want to Add this medication?"),
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
