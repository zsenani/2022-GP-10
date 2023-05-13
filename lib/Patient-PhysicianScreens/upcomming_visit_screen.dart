import 'package:medcore/Patient-PhysicianScreens/Lab/add_request.dart';
import 'package:medcore/Patient-PhysicianScreens/Lab/lab_tests.dart';
import 'package:medcore/Patient-PhysicianScreens/Medication/medication_list.dart';
import 'package:medcore/Patient-PhysicianScreens/active_visit.dart';
import 'package:medcore/Patient-PhysicianScreens/medicalHistory/medical_history.dart';
import 'package:medcore/Patient-PhysicianScreens/medical_reports.dart';
import 'package:medcore/Patient-PhysicianScreens/write_diagnose.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/mysqlDatabase.dart';
import 'patient_home_screen.dart';

String patientId = "";
String patientName = "";
String patientGender = "";
String HospitalID = '';
var patientDob;
String patientHeight = "";
String patientWeight = "";
String patientBloodP = "";
String hospitalName = "";
String visitDate = "";
String visitTime = "";
String visitId = '';
bool errorH = false;
bool errorW = false;
bool errorP = false;
bool isHNull = false;
bool isWNull = false;
bool isPNull = false;
List<int> visitsIds = [];
int isFilled3 = 0;
var age1 = 0;
String hid;

class UpCommingVisitScreen extends StatefulWidget {
  UpCommingVisitScreen(
      {Key key,
      String patientID,
      String patientN,
      String patientG,
      String patientAge,
      String patientH,
      String patientW,
      String patientB,
      String hospitalN,
      String visitD,
      String visitT,
      String vid,
      String HID})
      : super(key: key) {
    patientId = patientID;
    patientName = patientN;
    patientGender = patientG;
    patientDob = DateTime.now().year - int.parse(patientAge.substring(0, 4));
    patientHeight = patientH;
    patientWeight = patientW;
    patientBloodP = patientB;
    hospitalName = hospitalN;
    visitDate = visitD;
    visitTime = visitT;
    visitId = vid;
    HospitalID = HID;
    hid = HID;
    age1 = DateTime.now().year - int.parse(patientAge.substring(0, 4));
    if (int.parse(patientAge.substring(5, 7)) > DateTime.now().month) {
      age1 = age1 - 1;
    } else if (int.parse(patientAge.substring(5, 7)) == DateTime.now().month) {
      if (int.parse(patientAge.substring(8, 10)) > DateTime.now().day) {
        age1 = age1 - 1;
      }
    }
  }
  @override
  State<UpCommingVisitScreen> createState() => _UpCommingVisitScreenState();
}

class _UpCommingVisitScreenState extends State<UpCommingVisitScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bloodPressController = TextEditingController();

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

  void getData() async {
    name = '';
    gender = '';
    bloodType = '';
    nationalID = '';
    DOB = '';
    nationality = '';
    maritalStatus = '';
    age = 0;
    var user = await conn.query(
        'select name,gender,bloodType,nationalID,DOB,nationality,maritalStatus from Patient where nationalId=?',
        [int.parse(patientId)]);
    for (var row in user) {
      setState(() {
        name = '${row[0]}';
        gender = '${row[1]}';
        bloodType = '${row[2]}';
        nationalID = '${row[3]}';
        DOB = '${row[4]}'.split(' ')[0];
        nationality = '${row[5]}';
        maritalStatus = '${row[6]}';
        // age = '${row[7]}';
       age = DateTime.now().year - int.parse(DOB.substring(0, 4));
        if (int.parse(DOB.substring(5, 7)) > DateTime.now().month) {
          age = age - 1;
        } else if (int.parse(DOB.substring(5, 7)) == DateTime.now().month) {
          if (int.parse(DOB.substring(8, 10)) > DateTime.now().day) {
            age = age - 1;
          }
        }
      });
    }

    var info = await conn.query(
        'select allergies,socialHistory,familyHistory,surgicalHistory,medicalIllnesses from Patient where nationalId=?',
        [int.parse(patientId)]);
    for (var row in info) {
      setState(() {
        allergies = '${row[0]}';
        socialHistory = '${row[1]}';
        familyHistory = '${row[2]}';
        surgicalHistory = '${row[3]}';
        medicalIllnesses = '${row[4]}';
      });
    }
//  var visits = await conn
//         .query('select idvisit from Visit where idPatient = ?', [patientID]);
//     int visitsArrayLength = await visits.length;
//     for (var row2 in visits) {
//       if (isFilled3 != visitsArrayLength) {
//         int visit = int.parse('${row2[0]}');
//         visitsIds.add(visit);
//         isFilled3 = isFilled3 + 1;
//       }
//     }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  final List<Map> specialistList = [
    {
      "image": Images.history,
      "text1": "Medical History",
      "caller": MedicalHistory(id: patientId),
    },
    {
      "image": Images.report,
      "text1": "Medical Report",
      "caller": MedicalReports(id: patientId),
    },
    {
      "image": Images.labTest,
      "text1": "Lab Results",
      "caller": labTests(
          id: patientId,
          idPhy: physicianId,
          r: 'UPphysician',
          vid: visitId,
          hosName: hospitalName,
          hosid: HospitalID),
    },
    {
      "image": Images.list,
      "text1": "Medication List",
      "caller": MedicationList(
        id: patientId,
        vid: visitId,
        role1: 'UPphysician',
        idPHy: physicianId,
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    print(visitId);
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HeaderWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: heavyText("Patient Files", ColorResources.grey777, 18),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              width: Get.width,
              child: Specialist(),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: heavyText("Services", ColorResources.grey777, 18),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Get.to(
                        TestRequest(
                          vid: visitId,
                          pid: int.parse(patientId),
                          hosname: hospitalName,
                          hid: HospitalID,
                        ),
                        arguments: 'back2');
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: heavyText(
                          "Request a Lab Test", ColorResources.white, 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Get.to(writeDiagnose(
                      id: int.parse(visitId),
                    ));
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: heavyText(
                          "Write a Diagnosis", ColorResources.white, 18),
                    ),
                  ),
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }

  void updatePatientInfo() async {
    var hight;
    var weight;
    var bloodPress;
    if (hightController.text != "null" || hightController.text != "0.0") {
      print("hieght kkk");
      print(hightController.text);
      if (hightController.text.contains(".0") == false) {
        hight = hightController.text + ".0";
      } else {
        hight = hightController.text;
      }
      print(hight);
      var pNewHight = await conn.query(
          'update Patient set  height=? where NationalID =?',
          [double.parse(hight), int.parse(patientId)]);
    }
    if (weightController.text != "null" || weightController.text != "0.0") {
      print("weight kkk");
      print(weightController.text);
      print(weightController.text.contains(".0"));
      if (weightController.text.contains(".0") == false) {
        weight = weightController.text + ".0";
      } else {
        weight = weightController.text;
      }
      print("kkkkdddddd");
      print(weight);
      var pNewWeight = await conn.query(
          'update Patient set weight=? where NationalID =?',
          [double.parse(weight), int.parse(patientId)]);
    }
    if (bloodPressController.text != "null" ||
        bloodPressController.text != "0.0") {
      print("blood pres kkkk");
      print(bloodPressController.text);
      if (bloodPressController.text.contains(".0") == false) {
        bloodPress = bloodPressController.text + ".0";
      } else {
        bloodPress = bloodPressController.text;
      }
      print(bloodPress);
      var newPatientInfo = await conn.query(
          'update Patient set BloodPressure=? where NationalID =?',
          [double.parse(bloodPress), int.parse(patientId)]);
    }
  }

  bool validateH(String valueH) {
    isHNull = false;
    Pattern pattern = r'^\d{1,3}(\.\d+)?$';
    RegExp regex = new RegExp(pattern);
    print("value h");
    print(valueH);
    print(valueH.isEmpty);
    print(patientHeight == "null");
    if (valueH.isEmpty && patientHeight == "null") {
      isHNull = true;

      print(isHNull);
    } else if (valueH.isEmpty) {
      valueH = patientHeight;
      isHNull = false;
    }
    print("**************");
    print(valueH);
    if (isHNull == false) {
      if (!regex.hasMatch(valueH)) {
        print('Please enter Numbers');
        setState(() {
          isHNull = false;
          errorH = true;
        });
        return false;
      } else {
        print("valid Hight");
        setState(() {
          errorH = false;
        });
        return true;
      }
    }
  }

  bool validateW(String valueW) {
    isWNull = false;
    Pattern pattern = r'^\d{1,3}(\.\d+)?$';
    RegExp regex = new RegExp(pattern);
    if (valueW.isEmpty && patientWeight == "null") {
      isWNull = true;
      print(isWNull);
    } else if (valueW.isEmpty) {
      isWNull = false;
      valueW = patientWeight;
    }
    print("**************");
    print(valueW);
    if (isWNull == false) {
      if (!regex.hasMatch(valueW)) {
        print('wrong wight');
        setState(() {
          isWNull = false;
          errorW = true;
        });
        return false;
      } else {
        print("valid wiegth");
        setState(() {
          errorW = false;
        });
        return true;
      }
    }
  }

  bool validateP(String valueB) {
    isPNull = false;
    Pattern pattern = r'^\d{1,3}(\.\d+)?$';
    RegExp regex = new RegExp(pattern);
    if (valueB.isEmpty && patientBloodP == "null") {
      isPNull = true;

      print(isPNull);
    } else if (valueB.isEmpty) {
      isPNull = false;
      valueB = patientBloodP;
    }
    print("**************");
    print(valueB);
    if (isPNull == false) {
      if (!regex.hasMatch(valueB)) {
        print('wrong blood pressure');
        setState(() {
          isPNull = false;
          errorP = true;
        });
        return false;
      } else {
        print("valid blood pressure");
        setState(() {
          errorP = false;
        });
        return true;
      }
    }
  }

  Widget HeaderWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 320,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(240),
              bottomRight: Radius.circular(240),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      child: const Icon(Icons.arrow_back,
                          color: ColorResources.grey777),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heavyText(hospitalName, ColorResources.green, 20,
                              TextAlign.center),
                          const SizedBox(height: 0.5),
                          bookText("Date: " + visitDate, ColorResources.grey777,
                              20, TextAlign.center),
                          const SizedBox(height: 0.5),
                          bookText("Time: " + visitTime, ColorResources.orange,
                              20, TextAlign.center),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 9,
          left: 0.5,
          right: 0.5,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                height: 150,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorResources.whiteF6F,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorResources.grey9AA.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: heavyText("Patient Name: " + patientName,
                          ColorResources.grey777, 16),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: heavyText("Patient ID: " + patientId,
                          ColorResources.grey777, 16),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: heavyText("$patientGender , $age1 y",
                            ColorResources.grey777, 16)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                            image: AssetImage(Images.height),
                            width: 20,
                            height: 20),
                        mediumText("Hieght: ", ColorResources.grey777, 12),
                        Padding(
                          padding: const EdgeInsets.only(top: 9),
                          child: SizedBox(
                            height: 13,
                            width: 35,
                            child: TextField(
                              controller: hightController,
                              decoration: InputDecoration(
                                hintText: patientHeight == "null"
                                    ? "---"
                                    : patientHeight,
                                border: const UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorH == false
                                      ? const BorderSide(
                                          color: ColorResources.grey777,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                ),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                            // romanText(patientHeight,
                            //     ColorResources.grey777, 12, TextAlign.center),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Image(
                          image: AssetImage(Images.weight),
                          width: 17,
                          height: 17,
                        ),
                        const SizedBox(width: 1),
                        mediumText(" Weight: ", ColorResources.grey777, 12),
                        Padding(
                          padding: const EdgeInsets.only(top: 9),
                          child: SizedBox(
                            height: 13,
                            width: 30,
                            child: TextField(
                              controller: weightController,
                              decoration: InputDecoration(
                                hintText: patientWeight == "null"
                                    ? "---"
                                    : patientWeight,
                                border: const UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorW == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                ),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Image(
                          image: AssetImage(Images.pressurIcon),
                          width: 20,
                          height: 20,
                        ),
                        mediumText(
                            " Blood pressure: ", ColorResources.grey777, 12),
                        Padding(
                          padding: const EdgeInsets.only(top: 9),
                          child: SizedBox(
                            height: 13,
                            width: 30,
                            child: TextField(
                              controller: bloodPressController,
                              decoration: InputDecoration(
                                hintText: patientBloodP == "null"
                                    ? "---"
                                    : patientBloodP,
                                border: const UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorP == false
                                      ? const BorderSide(
                                          color: ColorResources.grey777,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                ),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: 175,
                        height: 20,
                        // margin: EdgeInsets.all(25),
                        child: ElevatedButton(
                          child: const Text(
                            'Update patient\'s info',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            if (hightController.text.isEmpty &&
                                weightController.text.isEmpty &&
                                bloodPressController.text.isEmpty) {
                              alertUpdateError(context,
                                  "Please make sure that you fill the input fields");
                            }
                            if (hightController.text.isNotEmpty ||
                                weightController.text.isNotEmpty ||
                                bloodPressController.text.isNotEmpty) {
                              if (patientHeight != "null" &&
                                  hightController.text.isEmpty) {
                                hightController.text = patientHeight;
                              }
                              if (patientWeight != "null" &&
                                  weightController.text.isEmpty) {
                                weightController.text = patientWeight;
                              }
                              if (patientBloodP != "null" &&
                                  bloodPressController.text.isEmpty) {
                                bloodPressController.text = patientBloodP;
                              }
                              print(hightController.text.isNotEmpty);
                              print(weightController.text.isNotEmpty);
                              print(bloodPressController.text.isNotEmpty);

                              validateH(hightController.text);
                              validateP(bloodPressController.text);
                              validateW(weightController.text);
                              print("*****");
                              print(errorP);
                              if (isHNull && isWNull && isPNull) {
                                print("###########");
                                print(isHNull);
                                print(isWNull);
                                print(isPNull);
                                alertUpdateError(context,
                                    "Please make sure that you fill the input fields");
                              } else if (errorH == false &&
                                  errorW == false &&
                                  errorP == false) {
                                alertDialogUpdate(context);
                              } else {
                                alertUpdateError(context,
                                    "Please make sure that you entered digits in the fields");
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Specialist() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        itemCount: specialistList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 24, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
              onTap: () {
                Get.to(specialistList[index]["caller"],
                    arguments: "UPphysician");
              },
              child: Container(
                height: 145,
                width: 135,
                decoration: BoxDecoration(
                  color: ColorResources.whiteF6F,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorResources.grey9AA.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          specialistList[index]["image"],
                        ),
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(height: 10),
                      heavyText(specialistList[index]["text1"],
                          ColorResources.blue0C1, 15, TextAlign.center),
                    ],
                  ),
                ),
              )),
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
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Confirm",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        updatePatientInfo();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Update"),
      content: const Text("Are you sure you want to update patient info ?"),
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

  alertUpdateError(BuildContext context, String message) {
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
      content: Text(message),
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
}
