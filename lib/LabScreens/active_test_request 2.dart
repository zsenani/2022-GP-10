import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/LabScreens/active_test_details.dart';

class ActiveTestReq extends StatelessWidget {
  // ActiveReq({Key key}) : super(key: key);
  final List<Map> toDayList = [
    {
      "text2": " In Progress",
      "text3": "Patient: Brycen Bradford",
      "text4": "ID: 223112",
    },
    {
      "text2": " In Progress",
      "text3": "Patient: Mahmud Nik Hasan",
      "text4": "ID: 225412",
    },
    {
      "text2": " In Progress",
      "text3": "Patient: Tierra Riley",
      "text4": "ID: 112984",
    },
  ];

  final List<Map> tomorrowDayList = [
    {
      "text2": " In Progress",
      "text3": "Patient: Brycen Bradford",
      "text4": "ID: 665435",
    },
    {
      "text2": " In Progress",
      "text3": "Patient: Mahmud Nik Hasan",
      "text4": "ID: 909877",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3),
            TextFormField(
              cursorColor: Color.fromRGBO(19, 156, 140, 1),
              style: TextStyle(
                color: ColorResources.black,
                fontSize: 15,
                fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
              ),
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.search,
                  ),
                ),
                hintText: "Search by Request number . . .",
                hintStyle: TextStyle(
                  color: ColorResources.greyA0A,
                  fontSize: 16,
                  fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                ),
                filled: true,
                fillColor: ColorResources.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.greyA0A.withOpacity(0.2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.greyA0A.withOpacity(0.2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.greyA0A.withOpacity(0.2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 25),
            mediumText(
                "      Today - 10 June, 2020", ColorResources.grey777, 12),
            SizedBox(height: 10),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: toDayList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Get.to(ActiveTestDetails());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
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
                                  SizedBox(height: 5),
                                  mediumText(toDayList[index]["text3"],
                                      ColorResources.grey777, 18),
                                  SizedBox(height: 5),
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
            SizedBox(height: 20),
            mediumText(
                "      Monday - 11 June, 2020", ColorResources.grey777, 12),
            SizedBox(height: 10),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tomorrowDayList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Get.to(ActiveTestDetails());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            SizedBox(width: 20),
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
                                  SizedBox(height: 5),
                                  mediumText(tomorrowDayList[index]["text3"],
                                      ColorResources.grey777, 18),
                                  SizedBox(height: 5),
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
