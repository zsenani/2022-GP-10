import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:chip_list/chip_list.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_results.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medcore/database/mysqlDatabase.dart';

var diagnosis;
var PhyIds = [];
Map<String, dynamic> pieChart;
Map<String, double> pieCH;
bool loadingSearch = true;
List<List<String>> results1;
bool loading1 = true;
bool pressed = false;

var symptoms = const [
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
];
var zero = [];
bool empty = false;
List<String> selectedSymptoms = [];
List<int> commonSymptoms = [];

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => SearchScreenState();
}

Future<http.Response> postData(vector) {
  return http.post(
    //https://medcoreapp.azurewebsites.net/search
//http://10.0.2.2:5000/search
    Uri.parse('https://medcoreapp.azurewebsites.net/search'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, List<dynamic>>{
      'vector': vector,
    }),
  );
}

class SearchScreenState extends State<SearchScreen> {
  // SearchScreen({Key? key}) : super(key: key);
  String greating = '';
  String Id = Get.arguments;

  PhysicianInfor() async {
    results1 = await mysqlDatabase.PhyContInfo(PhyIds);
    setState(() {
      loading1 = false;
    });
    Get.to(SearchResults(), arguments: Id);
  }

  Widget loadingPage() {
    return const AlertDialog(
      content: Center(
        child: CircularProgressIndicator(
          color: ColorResources.grey777,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // selectedSymptoms.add('fever');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: ColorResources.whiteF6F,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HeaderWidget(),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    heavyText(
                        "   Most common symptoms", ColorResources.grey777, 15),
                  ]),
                  // Wrap(
                  //     spacing: 8.0, // gap between adjacent chips
                  //     runSpacing: 4.0, // gap between lines
                  // children: [
                  const SizedBox(height: 2),
                  ChipList(
                    mainAxisAlignment: MainAxisAlignment.start,
                    shouldWrap: true,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    listOfChipNames: const [
                      'high fever',
                      'headache',
                      'breathlessness',
                      'vomiting',
                      'cough',
                    ],
                    supportsMultiSelect: true,
                    activeBgColorList: [
                      const Color.fromARGB(183, 117, 197, 197).withOpacity(0.6),
                      const Color.fromARGB(183, 117, 197, 197).withOpacity(0.6),
                      const Color.fromARGB(183, 117, 197, 197).withOpacity(0.6),
                      const Color.fromARGB(183, 117, 197, 197).withOpacity(0.6),
                      const Color.fromARGB(183, 117, 197, 197).withOpacity(0.6),
                    ],
                    inactiveBgColorList: const [ColorResources.whiteF6F],
                    activeTextColorList: const [Colors.black],
                    inactiveTextColorList: const [Colors.black],

                    listOfChipIndicesCurrentlySeclected: commonSymptoms,
                    inactiveBorderColorList: [
                      const Color.fromARGB(183, 117, 197, 197).withOpacity(0.6),
                    ],
                    //  borderColorList: const [Colors.pink, Colors.yellow, Colors.green,Colors.yellow, Colors.green],
                  ),
                  //  ]),

                  const SizedBox(height: 6),
                  Container(
                    width: 360,
                    child: Theme(
                        data: ThemeData(
                          primarySwatch: Colors.teal,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          // inputDecorationTheme: InputDecorationTheme()
                        ),
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
                            "sunken eyes",
                            "sweating",
                            "dehydration",
                            "indigestion",
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
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Select symptoms",
                              hintStyle: const TextStyle(
                                  color: ColorResources.grey777),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: empty == false
                                    ? const BorderSide(
                                        color: ColorResources.greyA0A, width: 1)
                                    : const BorderSide(
                                        color: Colors.red, width: 1),
                              ),
                            ),
                          ),
                          onChanged: (List<String> selectedValue) {
                            //   // hospitals = selectedValue;

                            selectedSymptoms = selectedValue;
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  if (empty)
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heavyText("    Please select one symptom at least",
                              Colors.red, 14),
                        ]),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          pressed = true;
                          selectedSymptoms.length == 0 &&
                                  commonSymptoms.length == 0
                              ? empty = true
                              : empty = false;
                        });
                        if (empty == false) {
                          onsubmit();
                        }

                        var data = await postData(zero);
                        log(data.body);
                        var jsonD = jsonDecode(data.body);
                        print("jsonD+++++++++++");

                        diagnosis = jsonD["vector"];
                        PhyIds = jsonD["physID"];
                        PhysicianInfor();
                        pieChart = jsonD["symptomsDic"];
                        pieCH = Map.fromIterables(
                          pieChart.keys,
                          pieChart.values.map(
                              (e) => (double.tryParse(e.toString()) ?? 0.0)),
                        );
//loading1 == true || loadingSearch == true
                        //  ? loadingPage()
                        //  :
                        setState(() {
                          loadingSearch = false;
                        });
                        // if (loading1 == false && loadingSearch == false) {
                        //   Get.to(SearchResults(), arguments: Id);
                        // }
                        print(diagnosis);
                        print(PhyIds);
                        print(pieChart);
                      }, //loadingPage()
                      child: (loading1 == true || loadingSearch == true) &&
                              pressed == true
                          ? loadingPage()
                          : Container(
                              height: 50,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: ColorResources.green,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: heavyText("Show a Diagnosis",
                                    ColorResources.white, 18),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  onsubmit() {
    zero = [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0
    ];
    List<String> commonSymptomsString = [
      'high fever',
      'headache',
      'breathlessness',
      'vomiting',
      'cough',
    ];
    print(selectedSymptoms);
    print(commonSymptoms);
    for (int i = 0; i < selectedSymptoms.length; i++) {
      for (int j = 0; j < symptoms.length; j++) {
        if (symptoms[j] == selectedSymptoms[i]) {
          zero[j] = 1;
        }
      }
    }
    for (int i = 0; i < commonSymptoms.length; i++) {
      for (int j = 0; j < symptoms.length; j++) {
        if (symptoms[j] == commonSymptomsString[commonSymptoms[i]]) {
          zero[j] = 1;
        }
      }
    }
    log(zero.toString());
    // if (loadingSearch == true || loading1 == true) {
    //   loadingPage();
    // }
  }

  Widget HeaderWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(80),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorResources.green.withOpacity(0.2),
                ColorResources.lightBlue.withOpacity(0.2),
              ],
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedSymptoms = [];
                      commonSymptoms = [];
                      empty = false;
                    });

                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back,
                      color: ColorResources.grey777),
                ),
              ),
              const SizedBox(width: 83),
              heavyText("Symptoms Search", ColorResources.green, 22,
                  TextAlign.center),
            ],
          ),
        ),
        Positioned(
          bottom: -30,
          left: 24,
          right: 24,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
