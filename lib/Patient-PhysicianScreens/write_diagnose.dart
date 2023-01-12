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
                          ////////////////////////////
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 50, left: 35, bottom: 10),
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Center(
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
                                "shortness of breath",
                                "dizziness",
                                "asthenia",
                                "fall",
                                "syncope",
                                "vertigo",
                                "sweat",
                                "sweating increased",
                                "palpitation",
                                "nausea",
                                "angina pectoris",
                                "pressure chest",
                                "polyuria",
                                "polydypsia",
                                "pain chest",
                                "orthopnea",
                                "rale",
                                "unresponsiveness",
                                "mental status changes",
                                "vomiting",
                                "labored breathing",
                                "feeling suicidal",
                                "suicidal",
                                "hallucinations auditory",
                                "feeling hopeless",
                                "weepiness",
                                "sleeplessness",
                                "motor retardation",
                                "irritable mood",
                                "blackout",
                                "mood depressed",
                                "hallucinations visual",
                                "worry",
                                "agitation",
                                "tremor",
                                "intoxication",
                                "verbal auditory hallucinations",
                                "energy increased",
                                "difficulty",
                                "nightmare",
                                "unable to concentrate",
                                "homelessness",
                                "hypokinesia",
                                "dyspnea on exertion",
                                "chest tightness",
                                "cough",
                                "fever", ////
                                "decreased translucency",
                                "productive cough",
                                "pleuritic pain",
                                "yellow sputum",
                                "breath sounds decreased",
                                "chill",
                                "rhonchus",
                                "green sputum",
                                "non-productive cough",
                                "wheezing",
                                "haemoptysis",
                                "distress respiratory",
                                "tachypnea",
                                "malaise",
                                "night sweat",
                                "jugular venous distention",
                                "dyspnea",
                                "dysarthria",
                                "speech slurred",
                                "facial paresis",
                                "hemiplegia",
                                "seizure",
                                "numbness",
                                "symptom aggravating factors",
                                "st segment elevation",
                                "st segment depression",
                                "t wave inverted",
                                "presence of q wave",
                                "chest discomfort",
                                "bradycardia",
                                "pain",
                                "nonsmoker",
                                "erythema",
                                "hepatosplenomegaly",
                                "pruritus",
                                "diarrhea",
                                "abscess bacterial",
                                "swelling",
                                "apyrexial",
                                "dysuria",
                                "hematuria",
                                "renal angle tenderness",
                                "lethargy",
                                "hyponatremia",
                                "hemodynamically stable",
                                "difficulty passing urine",
                                "consciousness clear",
                                "guaiac positive",
                                "monoclonal",
                                "ecchymosis",
                                "tumor cell invasion",
                                "haemorrhage",
                                "pallor",
                                "fatigue",
                                "heme positive",
                                "pain back",
                                "orthostasis",
                                "arthralgia",
                                "transaminitis",
                                "sputum purulent",
                                "hypoxemia",
                                "hypercapnia",
                                "patient non compliance",
                                "unconscious state",
                                "bedridden",
                                "abdominal tenderness",
                                "unsteady gait",
                                "hyperkalemia",
                                "urgency of micturition",
                                "ascites",
                                "hypotension",
                                "enuresis",
                                "asterixis",
                                "muscle twitch",
                                "sleepy",
                                "headache",
                                "lightheadedness",
                                "food intolerance",
                                "numbness of hand",
                                "general discomfort",
                                "drowsiness",
                                "stiffness",
                                "prostatism",
                                "weight gain",
                                "tired",
                                "mass of body structure",
                                "has religious belief",
                                "nervousness",
                                "formication",
                                "hot flush",
                                "lesion",
                                "cushingoid facies",
                                "cushingoid habitus",
                                "emphysematous change",
                                "decreased body weight",
                                "hoarseness",
                                "thicken",
                                "pulsus paradoxus",
                                "gravida 10",
                                "heartburn",
                                "pain abdominal",
                                "dullness",
                                "spontaneous rupture of membranes",
                                "muscle hypotonia",
                                "hypotonic",
                                "redness",
                                "hypesthesia",
                                "hyperacusis",
                                "scratch marks",
                                "sore to touch",
                                "burning sensation",
                                "satiety early",
                                "throbbing sensation quality",
                                "sensory discomfort",
                                "constipation",
                                "breech presentation",
                                "cyanosis",
                                "pain in lower limb",
                                "cardiomegaly",
                                "clonus",
                                "unwell",
                                "anorexia",
                                "history of - blackout",
                                "anosmia",
                                "metastatic lesion",
                                "hemianopsia homonymous",
                                "hematocrit decreased",
                                "neck stiffness",
                                "cicatrisation",
                                "hypometabolism",
                                "aura",
                                "myoclonus",
                                "gurgle",
                                "wheelchair bound",
                                "left atrial hypertrophy",
                                "oliguria",
                                "catatonia",
                                "unhappy",
                                "paresthesia",
                                "gravida 0",
                                "lung nodule",
                                "distended abdomen",
                                "ache",
                                "macerated skin",
                                "heavy feeling",
                                "rest pain",
                                "sinus rhythm",
                                "withdraw",
                                "behavior hyperactive",
                                "terrify",
                                "photopsia",
                                "giddy mood",
                                "disturbed family",
                                "hypersomnia",
                                "hyperhidrosis disorder",
                                "mydriasis",
                                "extrapyramidal sign",
                                "loose associations",
                                "exhaustion",
                                "snore",
                                "r wave feature",
                                "overweight",
                                "systolic murmur",
                                "asymptomatic",
                                "splenomegaly",
                                "bleeding of vagina",
                                "macule",
                                "photophobia",
                                "painful swallowing",
                                "cachexia",
                                "hypocalcemia result",
                                "hypothermia, natural",
                                "atypia",
                                "general unsteadiness",
                                "throat sore",
                                "snuffle",
                                "hacking cough",
                                "stridor",
                                "paresis",
                                "aphagia",
                                "focal seizures",
                                "abnormal sensation",
                                "stupor",
                                "fremitus",
                                "Stahli's line",
                                "stinging sensation",
                                "paralyse",
                                "hirsutism",
                                "sniffle",
                                "bradykinesia",
                                "out of breath",
                                "urge incontinence",
                                "vision blurred",
                                "room spinning",
                                "rambling speech",
                                "clumsiness",
                                "decreased stool caliber",
                                "hematochezia",
                                "egophony",
                                "scar tissue",
                                "neologism",
                                "decompensation",
                                "stool color yellow",
                                "rigor - temperature-associated observation",
                                "paraparesis",
                                "moody",
                                "fear of falling",
                                "spasm",
                                "hyperventilation",
                                "excruciating pain",
                                "gag",
                                "posturing",
                                "pulse absent",
                                "dysesthesia",
                                "polymyalgia",
                                "passed stones",
                                "qt interval prolonged",
                                "ataxia",
                                "Heberden's node",
                                "hepatomegaly",
                                "sciatica",
                                "frothy sputum",
                                "mass in breast",
                                "retropulsion",
                                "estrogen use",
                                "hypersomnolence",
                                "underweight",
                                "red blotches",
                                "colic abdominal",
                                "hypokalemia",
                                "hunger",
                                "prostate tender",
                                "pain foot",
                                "urinary hesitation",
                                "disequilibrium",
                                "flushing",
                                "indifferent mood",
                                "urinoma",
                                "hypoalbuminemia",
                                "pustule",
                                "slowing of urinary stream",
                                "extreme exhaustion",
                                "no status change",
                                "breakthrough pain",
                                "pansystolic murmur",
                                "systolic ejection murmur",
                                "stuffy nose",
                                "barking cough",
                                "rapid shallow breathing",
                                "noisy respiration",
                                "nasal discharge present",
                                "frail",
                                "cystic lesion",
                                "projectile vomiting",
                                "heavy legs",
                                "titubation",
                                "dysdiadochokinesia",
                                "achalasia",
                                "side pain",
                                "monocytosis",
                                "posterior rhinorrhea",
                                "incoherent",
                                "lameness",
                                "claudication",
                                "clammy skin",
                                "mediastinal shift",
                                "nausea and vomiting",
                                "awakening early",
                                "tenesmus",
                                "fecaluria",
                                "pneumatouria",
                                "todd paralysis",
                                "alcoholic withdrawal symptoms",
                                "myalgia",
                                "dyspareunia",
                                "poor dentition",
                                "floppy",
                                "inappropriate affect",
                                "poor feeding",
                                "moan",
                                "welt",
                                "tinnitus",
                                "hydropneumothorax",
                                "superimposition",
                                "feeling strange",
                                "uncoordination",
                                "absences finding",
                                "tonic seizures",
                                "debilitation",
                                "impaired cognition",
                                "drool",
                                "pin-point pupils",
                                "tremor resting",
                                "groggy",
                                "adverse reaction",
                                "adverse effect",
                                "abdominal bloating",
                                "fatigability",
                                "para 2",
                                "abortion",
                                "intermenstrual heavy bleeding",
                                "previous pregnancies 2",
                                "primigravida",
                                "abnormally hard consistency",
                                "proteinemia",
                                "pain neck",
                                "dizzy spells",
                                "shooting pain",
                                "hyperemesis",
                                "milky",
                                "regurgitates after swallowing",
                                "lip smacking",
                                "phonophobia",
                                "rolling of eyes",
                                "ambidexterity",
                                "bruit",
                                "breath-holding spell",
                                "scleral icterus",
                                "retch",
                                "blanch",
                                "elation",
                                "verbally abusive behavior",
                                "transsexual",
                                "behavior showing increased motor activity",
                                "coordination abnormal",
                                "choke",
                                "bowel sounds decreased",
                                "no known drug allergies",
                                "low back pain",
                                "charleyhorse",
                                "sedentary",
                                "feels hot/feverish",
                                "flare",
                                "pericardial friction rub",
                                "hoard",
                                "panic",
                                "cardiovascular finding",
                                "cardiovascular event",
                                "soft tissue swelling",
                                "rhd positive",
                                "para 1",
                                "nasal flaring",
                                "sneeze",
                                "hypertonicity",
                                "Murphy's sign",
                                "flatulence",
                                "gasping for breath",
                                "feces in rectum",
                                "prodrome",
                                "hypoproteinemia",
                                "alcohol binge episode",
                                "abdomen acute",
                                "air fluid level",
                                "catching breath",
                                "large-for-dates fetus",
                                "immobile",
                                "homicidal thoughts"
                              ],
                              popupProps: PopupPropsMultiSelection.menu(
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
                                  hintStyle:
                                      TextStyle(color: ColorResources.grey777),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: //empty == false
                                          //?
                                          const BorderSide(
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
                    SizedBox(height: 20),
                    heavyText(
                      " Assessment",
                      Color.fromRGBO(241, 94, 34, 1),
                      18,
                    ),
                    SizedBox(height: 15),
                    textField4("Enter Description...", descriptionControllerA,
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
            child: Text(
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
            child: Text(
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
