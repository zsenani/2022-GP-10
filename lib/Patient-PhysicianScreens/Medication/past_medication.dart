import '/../Utiils/colors.dart';
import '/../Utiils/common_widgets.dart';
import '/../Utiils/images.dart';
import '/../Utiils/text_font_family.dart';
import '/../main.dart';
import 'package:flutter/material.dart';

class PastMedication extends StatelessWidget {
  final List<Map> toDayList = [
    {
      "image": Images.pills2,
      "text1": "Dallah Hospital  - ",
      "text2": " Dr. Ahmed Alsaleh",
      "text3": "Metformin 500mg Tablets",
      "text4": "23-02-2022",
      "text5": "20 MG Daily 30 Days"
    },
    {
      "image": Images.pills2,
      "text1": "Alhabib Hospital - ",
      "text2": " Dr. Saleh Alhabib",
      "text3": "Diltiazem SR60mg Capsules",
      "text4": "30-01-2022",
      "text5": "1 Apply Twice Daily 1 Week"
    },
    {
      "image": Images.pills2,
      "text1": "Dallah Hospital - ",
      "text2": "Dr. Sarah Alali",
      "text3": "Losartan 50mg Tablets",
      "text4": "19-12-2019",
      "text5": "1 EA STAT 1 Day"
    },
    {
      "image": Images.pills2,
      "text1": "Dallah Hospital  - ",
      "text2": " Dr. Ahmed Alsaleh",
      "text3": "Metformin 500mg Tablets",
      "text4": "23-10-2019",
      "text5": "20 MG Daily 30 Days"
    },
    {
      "image": Images.pills2,
      "text1": "Alhabib Hospital - ",
      "text2": " Dr. Saleh Alhabib",
      "text3": "Diltiazem SR60mg Capsules",
      "text4": "23-10-2019",
      "text5": "1 Apply Twice Daily 1 Week"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF7F,
      body: SingleChildScrollView(
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
                itemCount: toDayList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorResources.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                radius: 20,
                                backgroundImage: AssetImage(
                                  toDayList[index]["image"],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
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
                                        text: toDayList[index]["text1"],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily
                                              .AVENIR_LT_PRO_ROMAN,
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
                                              color: ColorResources.greyA0A,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: toDayList[index]["text4"],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily
                                              .AVENIR_LT_PRO_ROMAN,
                                          fontSize: 12,
                                          color: ColorResources.grey777,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                mediumText(toDayList[index]["text3"],
                                    ColorResources.green009, 20),
                                SizedBox(height: 2),
                                romanText(
                                    "Dosage: " + toDayList[index]["text5"],
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
      ),
    );
  }
}
