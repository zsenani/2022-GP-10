import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../LabScreens/showLabResult.dart';
import '../../database/mysqlDatabase.dart';
import './lab_tests.dart';

import '/../Utiils/colors.dart';
import '/../Utiils/common_widgets.dart';
import '/../Utiils/images.dart';
import '/../Utiils/text_font_family.dart';
import '/../main.dart';
import 'package:flutter/material.dart';

import 'add_request.dart';

bool setRange = false;
String _rangeCount = '';
PickerDateRange dateRange;
String startDate;
String endDate;
DateTime startdt;
DateTime enddt;

String visitId;
String Role;

class ActiveReq extends StatefulWidget {
  ActiveReq({Key key, String vid, String role}) : super(key: key) {
    visitId = vid;
    Role = role;
  }
  @override
  State<ActiveReq> createState() => _ActiveReqState();
}

class _ActiveReqState extends State<ActiveReq> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      aa();
      setRange = false;
    });
  }

  void didUpdateWidget(ActiveReq oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  int arraylength = 0;
  int isFilled = 0;
  bool load = false;
  int setlength;
  var resultsActive;
  List<Map> toDayList = [];
  List<Map> toDayListFilttered = [];
  List<Map> drName = [];
  List<Map> hospitalname = [];
  List<Map> drNameFil = [];
  List<Map> hospitalnameFil = [];

  aa() async {
    resultsActive = await conn.query(
        'select * from Visit where idPatient=? and idvisit IN(select visitID from VisitLabTest where status =?)',
        [idp, 'active']);
    print(resultsActive);
    arraylength = resultsActive.length;
    setlength = resultsActive.length;
    print(arraylength);
    Map day = {
      "idvisit": "",
      "time": "",
      "date": "",
      "idHospital": "",
      "idPhysician": "",
      "idPatient": "",
      "subject": "",
      "object": "",
      "assessment": "",
      "plan": "",
      "Department": "",
    };
    Map nameD = {"name": ""};
    var doctor;
    Map nameH = {"Hospitalname": ""};
    var hospital;
    for (var row in resultsActive) {
      day = {
        "idvisit": "${row[0]}",
        "time": "${row[1]}",
        "date": "${row[2]}",
        "idHospital": "${row[3]}",
        "idPhysician": "${row[4]}",
        "idPatient": "${row[5]}",
        "subject": "${row[6]}",
        "object": "${row[7]}",
        "assessment": "${row[8]}",
        "plan": "${row[9]}",
        "Department": "${row[10]}",
        "image": Images.blood_test,
      };

      if (isFilled != arraylength) {
        doctor = await conn.query(
            'select name from Physician where nationalID=?', ['${row[4]}']);
        print(doctor.length);
        for (var d in doctor) {
          nameD = {"name": "${d[0]}"};
          drName.add(nameD);
        }

        hospital = await conn.query(
            'select name from Hospital where idhospital=?', ['${row[3]}']);
        print(hospital.length);
        for (var h in hospital) {
          nameH = {"name": "${h[0]}"};
          hospitalname.add(nameH);
        }

        isFilled = isFilled + 1;
      }
      toDayList.add(day);
    }
    setState(() {
      load = true;
    });
    print(toDayList);
    print(drName);
    print(hospitalname);
  }

  filter() {
    if (setRange == true) {
      toDayListFilttered.clear();
      print("today length");
      print(toDayList.length);
      for (var i = 0; i < toDayList.length; i++) {
        var resDate = toDayList[i]["date"];
        DateTime dt1 = DateTime.parse(resDate);
        print("date");
        print(dt1);
        if (startDate != null && endDate != null) {
          print("inside if stat 1");

          if ((dt1.isAfter(startdt) ||
                  (dt1.year == startdt.year &&
                      dt1.month == startdt.month &&
                      dt1.day == startdt.day)) &&
              (dt1.isBefore(enddt) ||
                  (dt1.year == enddt.year &&
                      dt1.month == enddt.month &&
                      dt1.day == enddt.day))) {
            print("inside if 2");
            toDayListFilttered.add(toDayList[i]);
            print(toDayList);
            drNameFil.add(drName[i]);
            hospitalnameFil.add(hospitalname[i]);
            print("inter loop filter1");
          }
        }

        print("inter loop filter3");
      }
      print("toDayListFilttered");
      print(toDayListFilttered);
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
    print("dateRange");
    print(dateRange);
    return arraylength != 0
        ? Scaffold(
            backgroundColor: ColorResources.whiteF7F,
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0),
                          height: Get.height - 250,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30),
                                ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: setRange == false
                                        ? arraylength
                                        : toDayListFilttered.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(bottom: 16),
                                      child: Container(
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: ColorResources.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Row(
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 255, 255, 255),
                                                    radius: 20,
                                                    backgroundImage: AssetImage(
                                                      setRange == false
                                                          ? toDayList[index]
                                                              ["image"]
                                                          : toDayListFilttered[
                                                              index]["image"],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        setRange == false
                                                            ? mediumText(
                                                                drName[index]
                                                                    ["name"],
                                                                ColorResources
                                                                    .green009,
                                                                20)
                                                            : mediumText(
                                                                drNameFil[index]
                                                                    ["name"],
                                                                ColorResources
                                                                    .green009,
                                                                20),
                                                        SizedBox(height: 2),
                                                        setRange == false
                                                            ? romanText(
                                                                hospitalname[
                                                                        index]
                                                                    ["name"],
                                                                ColorResources
                                                                    .grey777,
                                                                12)
                                                            : romanText(
                                                                hospitalnameFil[
                                                                        index]
                                                                    ["name"],
                                                                ColorResources
                                                                    .grey777,
                                                                12),
                                                        SizedBox(height: 4),
                                                        setRange == false
                                                            ? romanText(
                                                                toDayList[index]
                                                                        ["date"]
                                                                    .substring(
                                                                        0,
                                                                        toDayList[index]["date"].indexOf(
                                                                            ' ')),
                                                                ColorResources
                                                                    .grey777,
                                                                12)
                                                            : romanText(
                                                                toDayListFilttered[
                                                                            index]
                                                                        ["date"]
                                                                    .substring(
                                                                        0,
                                                                        toDayListFilttered[index]["date"].indexOf(
                                                                            ' ')),
                                                                ColorResources
                                                                    .grey777,
                                                                12),
                                                      ],
                                                    ),
                                                    Button(() {
                                                      roleHome == 'patient'
                                                          ? Get.to(
                                                              showlabResult(
                                                                  vid: toDayList[
                                                                          index]
                                                                      [
                                                                      "idvisit"],
                                                                  id: idp
                                                                      .toString(),
                                                                  role:
                                                                      'patient'),
                                                              arguments:
                                                                  'active')
                                                          : Get.to(
                                                              showlabResult(
                                                                  vid: toDayList[
                                                                          index]
                                                                      [
                                                                      "idvisit"],
                                                                  id:
                                                                      idPhysician,
                                                                  role:
                                                                      'physician'),
                                                              arguments:
                                                                  'active');
                                                    },
                                                        "View",
                                                        Color.fromRGBO(
                                                            241, 94, 34, 0.7),
                                                        //ColorResources.green009,
                                                        ColorResources.white),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 300, bottom: 0, right: 7),
                            child: InkWell(
                              onTap: () {
                                _startAdd2(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: ColorResources.green009,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: ColorResources.green009,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Icons.filter_alt,
                                      color: ColorResources.white),
                                ),
                              ),
                            ),
                          ),

                          ///////////////////////////////

                          if (Role == 'UPphysician')
                            Padding(
                              padding: EdgeInsets.only(bottom: 0, right: 0),
                              child: InkWell(
                                onTap: () {
                                  _startAdd(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: ColorResources.green009,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                      color: ColorResources.green009,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.add,
                                        color: ColorResources.white),
                                  ),
                                ),
                              ),
                            )
                        ])
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        // : setRange == true && toDayListFilttered.isEmpty
        //     ? Scaffold(
        //         backgroundColor: ColorResources.whiteF7F,
        //         body: Align(
        //           alignment: Alignment.center,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               SizedBox(
        //                 height: 160,
        //                 width: 160,
        //                 child: Image.asset(
        //                   Images.report2,
        //                   color: ColorResources.greyA0A,
        //                   alignment: Alignment.center,
        //                 ),
        //               ),
        //               SizedBox(height: 20),
        //               romanText(
        //                   "There is no test request at this time you selected",
        //                   ColorResources.grey777,
        //                   18,
        //                   TextAlign.center),
        //             ],
        //           ),
        //         ),
        //       )
        : Scaffold(
            backgroundColor: ColorResources.whiteF7F,
            body: load
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: Get.height - 280,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 160,
                                width: 160,
                                child: Image.asset(
                                  Images.report2,
                                  color: ColorResources.greyA0A,
                                  alignment: Alignment.center,
                                ),
                              ),
                              romanText("There is no test request",
                                  ColorResources.grey777, 18, TextAlign.center),
                            ],
                          ),
                        ),

                        ///////////////////////////////

                        if (Role == 'UPphysician')
                          Padding(
                            padding:
                                EdgeInsets.only(left: 320, bottom: 0, right: 0),
                            child: InkWell(
                              onTap: () {
                                _startAdd(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: ColorResources.green009,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: ColorResources.green009,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Icons.add,
                                      color: ColorResources.white),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                : loadingPage());
  }

  void _startAdd(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          //////////////////////////////
          child: TestRequest(
            vid: visitId,
            page: 'active',
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _startAdd2(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: DatePicker(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startDate = args.value.startDate.toString();
      endDate = args.value.endDate.toString();
      startdt = DateTime.parse(startDate);
      enddt = DateTime.parse(endDate);
      dateRange = args.value;
      _rangeCount = args.value.toString();
      // setRange = true;
    });
  }

  @override
  Widget DatePicker() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10),
        height: 380,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              //  height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // children: <Widget>[
                //   // Text('Selected range: $_range'),
                //   Text(
                //     ' Selected ranges count: $_rangeCount',
                //     style:
                //         TextStyle(color: ColorResources.grey777, fontSize: 14),
                //   )
                // ],
              ),
            ),
            Positioned(
              left: 0,
              top: 10,
              right: 0,
              bottom: 20,
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
                maxDate: DateTime.now(),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 5,
              child: Row(
                children: [
                  Button(() {
                    Navigator.pop(context);
                  }, "Cancel", ColorResources.orange.withOpacity(0.9),
                      ColorResources.white),
                  SizedBox(
                    width: 10,
                  ),
                  Button(() {
                    Navigator.pop(context);
                    setState(() {
                      setRange = true;
                      filter();
                    });
                  }, "Save", ColorResources.orange.withOpacity(0.9),
                      ColorResources.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
