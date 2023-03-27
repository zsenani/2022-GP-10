import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/images.dart';
import 'package:flutter/material.dart';
import 'package:medcore/database/mysqlDatabase.dart';

import '../../Utiils/text_font_family.dart';
import '../../main.dart';

List<List<String>> upVisit = [];
bool _loading = true;
String patientId;

class UpCommingVisit extends StatefulWidget {
  UpCommingVisit({Key key, String id}) : super(key: key) {
    patientId = id;
  }
  @override
  State<UpCommingVisit> createState() => UpCommingVisitState();
}

class UpCommingVisitState extends State<UpCommingVisit> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      upVisitM(patientId);
    });
  }

  Future upVisitM(idVisit) async {
    upVisit = await mysqlDatabase.PatientVisit(idVisit, "Up");
    print("in visit");
    print(upVisit.length);
    // print(upVisit[0][5]);
    for (int i = 0; i < upVisit.length; i++) {
      upVisit.sort((b, a) {
        var adate = a[i];
        var bdate = b[i];
        return -adate.compareTo(bdate);
      });
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.whiteF7F,
        body: _loading == true
            ? loadingPage()
            : upVisit.isEmpty
                ? emptyVisit()
                : fullVisit());
    //upVisit.length == 0 ? emptyVisit() : fullVisit()
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  Widget fullVisit() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: upVisit.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomRight,
                          children: const [
                            Image(
                              image: AssetImage(
                                Images.Visit,
                              ),
                              width: 30,
                              height: 30,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: upVisit[index][4] + " - ",
                                      style: TextStyle(
                                        fontFamily:
                                            TextFontFamily.AVENIR_LT_PRO_ROMAN,
                                        fontSize: 10,
                                        color: ColorResources.greyA0A,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Dr." + upVisit[index][2],
                                          style: TextStyle(
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_ROMAN,
                                            fontSize: 10,
                                            color: ColorResources.greyA0A,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: upVisit[index][0],
                                      style: TextStyle(
                                        fontFamily:
                                            TextFontFamily.AVENIR_LT_PRO_ROMAN,
                                        fontSize: 12,
                                        color: ColorResources.grey777,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              mediumText(upVisit[index][1],
                                  ColorResources.green009, 20),
                              const SizedBox(height: 2),
                              romanText(
                                  // "Dosage: " +
                                  //     preVisit[index][4] +
                                  "Physician's specialty: " + upVisit[index][3],
                                  ColorResources.grey777,
                                  12),
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
    );
  }

  Widget emptyVisit() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: Image.asset(
              Images.noVisit,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 20),
          romanText("There is no UpComming Visits", ColorResources.grey777, 18,
              TextAlign.center),
        ],
      ),
    );
  }
}
