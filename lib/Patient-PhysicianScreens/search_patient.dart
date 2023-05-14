import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/mysqlDatabase.dart';
import 'previous_visit_screen.dart';

int idPhysician;

class SearchPatient extends StatefulWidget {
  SearchPatient({Key key, String id}) : super(key: key) {
    idPhysician = int.parse(id);
  }
  @override
  State<SearchPatient> createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient> {
  // SearchScreen({Key? key}) : super(key: key);
  TextEditingController idPatient = TextEditingController();

  Widget HeaderWidget() {
    return Column(children: [
      Stack(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: ListTile(
                title: heavyText("Patient Search", ColorResources.green, 22,
                    TextAlign.center),
              ),
            ),
          ),
          Positioned(
            bottom: -25,
            left: 24,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorResources.white,
              ),
              child: TextFormField(
                onChanged: ((value) {
                  setState(() {
                    idPatient == null ? first = true : first = false;
                    returnedPatient.clear();
                    load = false;
                  });

                  searchPatientinfo(idPhysician, int.parse(idPatient.text));
                }),
                onFieldSubmitted: ((value) {
                  setState(() {
                    idPatient == null ? first = true : first = false;
                    returnedPatient.clear();
                    load = false;
                  });

                  searchPatientinfo(idPhysician, int.parse(idPatient.text));
                }),
                controller: idPatient,
                cursorColor: ColorResources.black,
                style: TextStyle(
                  color: ColorResources.black,
                  fontSize: 15,
                  fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  suffixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              idPatient == null ? first = true : first = false;
                              returnedPatient.clear();
                              load = false;
                            });

                            searchPatientinfo(
                                idPhysician, int.parse(idPatient.text));
                          },
                          child: const Icon(Icons.search_outlined,
                              color: ColorResources.green, size: 30))),
                  hintText: "Patient national/resident ID..",
                  hintStyle: TextStyle(
                    color: ColorResources.greyA0A,
                    fontSize: 16,
                    fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                  ),
                  filled: true,
                  fillColor: ColorResources.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorResources.greyA0A.withOpacity(0.2),
                        width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorResources.greyA0A.withOpacity(0.2),
                        width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorResources.greyA0A.withOpacity(0.2),
                        width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 30),
      if (idPatient.text.length != 10 && idPatient.text != "")
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          mediumText("       The ID should be 10 digits", Colors.red, 16),
        ])
    ]);
  }

  List<String> oneRow = [];
  List<String> returnedPatient = [];
  bool first = true;
  bool load = false;
  searchPatientinfo(idPhysician, idPatient) async {
    load = false;
    List<List<String>> info = [];
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print(load);
    var phyVisit = await conn.query(
        'select idvisit,date,time,idHospital,idPatient from Visit where idPhysician = ? AND  idPatient = ? AND date < ? ORDER BY date DESC ',
        [idPhysician, idPatient, DateTime.now().toUtc()]);
    print("########3");
    print(phyVisit);
    if (phyVisit.length == 0) {
      setState(() {
        load = true;
      });
    }
    print('jjjjjjjjjjjjjjjjjj');
    print(load);
    if (phyVisit.length != 0) {
      setState(() {
        load = false;
      });
      for (int g = 0; g < 1; g++) {
        for (var row in phyVisit) {
          info.add([
            '${row[0]}',
            '${row[1]}',
            '${row[2]}',
            '${row[3]}',
            '${row[4]}'
          ]);
        }
        // print(i++);
        print("info list date,idHospital,idPatient");
        // print(patientP.length);
        print(info);
      }

      List<String> oneRow = [];
      oneRow.add(info[0][0]); //idvisit
      oneRow.add(info[0][1].substring(0, 11)); //date
      // oneRow.add(info[g][2]);

      var visitH = await conn.query(
          'select name from Hospital where idhospital = ?', [info[0][3]]);
      for (var row in visitH) {
        oneRow.add('${row[0]}');
      }

      var visitP = await conn.query(
          'select name,gender,DOB,height,weight,BloodPressure from Patient where NationalID = ?',
          [info[0][4]]);
      for (var row in visitP) {
        oneRow.add('${row[0]}');
        oneRow.add('${row[1]}');
        oneRow.add('${row[2]}');
        oneRow.add('${row[3]}');
        oneRow.add('${row[4]}');
        oneRow.add('${row[5]}');
      }
      oneRow.add(info[0][4]);
      oneRow.add(info[0][2]); //visit date
      print("oneRow ---------------");
      print(oneRow);
      setState(() {
        returnedPatient = oneRow;
        // load = true;
      });
    }

    print('%%%%%%%%%%%%%%%55');
    print(load);
    print(returnedPatient);
    // print(returnedPatient[0]);
  }

  @override
  Widget build(BuildContext context) {
    return returnedPatient.isEmpty
        ? GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: ColorResources.whiteF7F,
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderWidget(),
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 160,
                            width: 160,
                          ),
                          const SizedBox(height: 20),
                          romanText(
                              first ||
                                      idPatient.text.length != 10 &&
                                          idPatient.text != ""
                                  ? ""
                                  : idPatient.text == ''
                                      ? "Please enter patient national/resident ID"
                                      : returnedPatient.length == 0 &&
                                              load == false
                                          ? "Please wait few sec.."
                                          : returnedPatient.length == 0 &&
                                                  load == true
                                              ? "There is no patient with this ID or you don't have access to the patient file"
                                              : '',
                              ColorResources.grey777,
                              18,
                              TextAlign.center),
                        ],
                      ),
                    ),
                  ]),
            ))
        : GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: ColorResources.whiteF6F,
              resizeToAvoidBottomInset: false,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                  ),
                  ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                              PreviousVisitScreen(
                                patientID: returnedPatient[9], //
                                hospitalN: returnedPatient[2], //
                                visitD: returnedPatient[1], //
                                visitT: returnedPatient[10], //
                                patientAge: returnedPatient[5],
                                patientB: returnedPatient[8],
                                patientG: returnedPatient[4],
                                patientH: returnedPatient[6],
                                patientN: returnedPatient[3],
                                patientW: returnedPatient[7],
                                visitID: int.parse(returnedPatient[0]),
                              ),
                              arguments: 'searchPatient');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorResources.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      mediumText(
                                          "Patient: " + returnedPatient[3],
                                          ColorResources.grey777,
                                          18),
                                      const SizedBox(height: 5),
                                      romanText("ID: " + returnedPatient[9],
                                          ColorResources.grey777, 12),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/right-arrow.png',
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
