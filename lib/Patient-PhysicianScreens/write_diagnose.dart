import 'package:dropdown_search/dropdown_search.dart';

import '../Utiils/colors.dart';
import '../Utiils/common_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/database/mysqlDatabase.dart';

int visitId;

class writeDiagnose extends StatefulWidget {
  writeDiagnose({Key key, int id}) : super(key: key) {
    visitId = id;
  }
  @override
  State<writeDiagnose> createState() => _writeDiagnoseState();
}

class _writeDiagnoseState extends State<writeDiagnose> {
  final TextEditingController descriptionControllerS = TextEditingController();
  final TextEditingController descriptionControllerO = TextEditingController();
  final TextEditingController descriptionControllerA = TextEditingController();
  final TextEditingController descriptionControllerP = TextEditingController();
  final TextEditingController descriptionControllerD = TextEditingController();
  List<String> selectedSymptoms = [];
  void add() {
    mysqlDatabase.addDiagnose(
        descriptionControllerS.text,
        selectedSymptoms.toString(),
        descriptionControllerA.text,
        descriptionControllerP.text,
        visitId);
  }

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
                              padding: const EdgeInsets.only(
                                  top: 45, left: 10, bottom: 10),
                              child: Container(
                                height: 40,
                                width: 40,
                                child: const Center(
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
                                    left: 60, top: 60, right: 20, bottom: 0),
                                child: const Align(
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
                          ////////////////////////////
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, left: 35, bottom: 10),
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
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    heavyText(
                        " Subject", const Color.fromRGBO(241, 94, 34, 1), 18),
                    const SizedBox(height: 15),
                    textField2("Enter Description...", descriptionControllerS,
                        TextInputType.text),
                    const SizedBox(height: 20),
                    heavyText(
                        " Object", const Color.fromRGBO(241, 94, 34, 1), 18),
                    const SizedBox(height: 15),
                    Container(
                      width: 360,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: ColorResources.greyA0A.withOpacity(0.4),
                            width: 1,
                          )),
                      child: Theme(
                          data: ThemeData(
                            primarySwatch: Colors.teal,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            // inputDecorationTheme: InputDecorationTheme()
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: DropdownSearch<String>.multiSelection(
                              enabled: true,
                              selectedItems: selectedSymptoms,
                              items: const [
                                "itching",
                                "skin rash",
                                "nodal skin eruptions",
                                "continuous sneezing",
                                "shivering",
                                "chills",
                                "joint pain",
                                "stomach pain",
                                "acidity",
                                "ulcers on tongue",
                                "muscle wasting",
                                "vomiting",
                                "burning micturition",
                                "spotting urination",
                                "fatigue",
                                "weight gain",
                                "anxiety",
                                "cold hands and feets",
                                "mood swings",
                                "weight loss",
                                "restlessness",
                                "lethargy",
                                "patches in throat",
                                "irregular sugar level",
                                "cough",
                                "high fever",
                                "sunken eyes",
                                "breathlessness",
                                "sweating",
                                "dehydration",
                                "indigestion",
                                "headache",
                                "yellowish skin",
                                "dark urine",
                                "nausea",
                                "loss of appetite",
                                "pain behind the eyes",
                                "back pain",
                                "constipation",
                                "abdominal pain",
                                "diarrhoea",
                                "mild fever",
                                "yellow urine",
                                "yellowing of eyes",
                                "acute liver failure",
                                "fluid overload",
                                "swelling of stomach",
                                "swelled lymph nodes",
                                "malaise",
                                "blurred and distorted vision",
                                "phlegm",
                                "throat irritation",
                                "redness of eyes",
                                "sinus pressure",
                                "runny nose",
                                "congestion",
                                "chest pain",
                                "weakness in limbs",
                                "fast heart rate",
                                "pain during bowel movements",
                                "pain in anal region",
                                "bloody stool",
                                "irritation in anus",
                                "neck pain",
                                "dizziness",
                                "cramps",
                                "bruising",
                                "obesity",
                                "swollen legs",
                                "swollen blood vessels",
                                "puffy face and eyes",
                                "enlarged thyroid",
                                "brittle nails",
                                "swollen extremeties",
                                "excessive hunger",
                                "extra marital contacts",
                                "drying and tingling lips",
                                "slurred speech",
                                "knee pain",
                                "hip joint pain",
                                "muscle weakness",
                                "stiff neck",
                                "swelling joints",
                                "movement stiffness",
                                "spinning movements",
                                "loss of balance",
                                "unsteadiness",
                                "weakness of one body side",
                                "loss of smell",
                                "bladder discomfort",
                                "foul smell of urine",
                                "continuous feel of urine",
                                "passage of gases",
                                "internal itching",
                                "toxic look (typhos)",
                                "depression",
                                "irritability",
                                "muscle pain",
                                "altered sensorium",
                                "red spots over body",
                                "belly pain",
                                "abnormal menstruation",
                                "dischromic patches",
                                "watering from eyes",
                                "increased appetite",
                                "polyuria",
                                "family history",
                                "mucoid sputum",
                                "rusty sputum",
                                "lack of concentration",
                                "visual disturbances",
                                "receiving blood transfusion",
                                "receiving unsterile injections",
                                "coma",
                                "stomach bleeding",
                                "distention of abdomen",
                                "history of alcohol consumption",
                                "fluid overload.1",
                                "blood in sputum",
                                "prominent veins on calf",
                                "palpitations",
                                "painful walking",
                                "pus filled pimples",
                                "blackheads",
                                "scurring",
                                "skin peeling",
                                "silver like dusting",
                                "small dents in nails",
                                "inflammatory nails",
                                "blister",
                                "red sore around nose",
                                "yellow crust ooze"
                              ],
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                                showSelectedItems: true,
                                searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                        hintText: 'Search..',
                                        constraints:
                                            BoxConstraints(maxHeight: 40))),
                                constraints: BoxConstraints(maxHeight: 500),
                                scrollbarProps:
                                    ScrollbarProps(thumbVisibility: true),
                              ),
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "Select symptoms",
                                  hintStyle:
                                      TextStyle(color: ColorResources.grey777),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: //empty == false
                                          //?
                                          BorderSide(
                                              color: ColorResources.whiteF6F,
                                              width: 0)
                                      // : const BorderSide(
                                      //     color: Colors.red, width: 1),
                                      ),
                                ),
                              ),
                              onChanged: (List<String> selectedValue) {
                                //   // hospitals = selectedValue;

                                selectedSymptoms = selectedValue;
                              },
                            ),
                          )),
                    ),
                    const SizedBox(height: 20),
                    heavyText(
                      " Assessment",
                      const Color.fromRGBO(241, 94, 34, 1),
                      18,
                    ),
                    const SizedBox(height: 15),
                    textField4("Enter Description...", descriptionControllerA,
                        TextInputType.text),
                    const SizedBox(height: 20),
                    heavyText(
                        " Plan", const Color.fromRGBO(241, 94, 34, 1), 18),
                    const SizedBox(height: 15),
                    textField2("Enter Description...", descriptionControllerP,
                        TextInputType.text),
                    const SizedBox(height: 30),
                    commonButton(() {
                      showAlertDialog(context);
                    }, "Add Diagnose", ColorResources.green009,
                        ColorResources.white),
                    const SizedBox(height: 30),
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
        descriptionControllerA.text == "" ||
        descriptionControllerP.text == "" ||
        selectedSymptoms.length == 0) {
      title = "Oops";
      content = "Please make sure all fields are filled in correctly!";
    } else {
      title = "Saved";
      content = "The diagnose has been added successfully!";
    }
///////////////////////////////////
    Widget OKButton = title == 'Oops'
        ? TextButton(
            child: const Text(
              "OK",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        : TextButton(
            child: const Text(
              "OK",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              add();
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
      child: const Text(
        "CANCEL",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text(
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
      title: const Text("Add Diagnose"),
      content: const Text("Are you sure you want to add diagnosis?"),
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
