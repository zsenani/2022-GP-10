import 'package:medcore/Patient-PhysicianScreens/previous_visit_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreVisitList extends StatelessWidget {
  // PastScreen({Key? key}) : super(key: key);
  final List<Map> toDayList = [
    {
      "text2": "King Khalid Hospital",
      "text3": "Patient: Brycen Bradford",
      "text4": "ID: 1119665435",
    },
    {
      "text2": "King Faisal Specialist Hospital",
      "text3": "Patient: Mahmud Nik Hasan",
      "text4": "ID: 1022909877",
    },
  ];

  final List<Map> tomorrowDayList = [
    {
      "text2": "King Khalid Hospital",
      "text3": "Patient: Brycen Bradford",
      "text4": "ID: 1122311217",
    },
    {
      "text2": "King Faisal Specialist Hospital",
      "text3": "Patient: Mahmud Nik Hasan",
      "text4": "ID: 1023225412",
    },
    {
      "text2": "King Fahad Medical City",
      "text3": "Patient: Tierra Riley",
      "text4": "ID: 1126573398",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            mediumText(
                "      Today - 10 June, 2020", ColorResources.grey777, 12),
            const SizedBox(height: 10),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: toDayList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Get.to(PreviousVisitScreen());
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: toDayList[index]["text1"],
                                      style: TextStyle(
                                        fontFamily:
                                            TextFontFamily.AVENIR_LT_PRO_ROMAN,
                                        fontSize: 10,
                                        color: ColorResources.greyA0A,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: toDayList[index]["text2"],
                                          style: TextStyle(
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_ROMAN,
                                            fontSize: 10,
                                            color: ColorResources.green009,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  mediumText(toDayList[index]["text3"],
                                      ColorResources.grey777, 18),
                                  const SizedBox(height: 5),
                                  romanText(toDayList[index]["text4"],
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
              ),
            ),
            const SizedBox(height: 20),
            mediumText(
                "      Monday - 11 June, 2020", ColorResources.grey777, 12),
            const SizedBox(height: 10),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tomorrowDayList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Get.to(PreviousVisitScreen());
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
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: tomorrowDayList[index]["text1"],
                                      style: TextStyle(
                                        fontFamily:
                                            TextFontFamily.AVENIR_LT_PRO_ROMAN,
                                        fontSize: 10,
                                        color: ColorResources.greyA0A,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: tomorrowDayList[index]["text2"],
                                          style: TextStyle(
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_ROMAN,
                                            fontSize: 10,
                                            color: ColorResources.green009,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  mediumText(tomorrowDayList[index]["text3"],
                                      ColorResources.grey777, 18),
                                  const SizedBox(height: 5),
                                  romanText(tomorrowDayList[index]["text4"],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
