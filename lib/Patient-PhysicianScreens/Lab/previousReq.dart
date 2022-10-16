import './lab_tests.dart';

import '/../Utiils/colors.dart';
import '/../Utiils/common_widgets.dart';
import '/../Utiils/images.dart';
import '/../Utiils/text_font_family.dart';
import '/../main.dart';
import 'package:flutter/material.dart';

import 'datePicker.dart';

class PreviousReq extends StatelessWidget {
  final List<Map> toDayList = [
    {
      "image": Images.blood_test,
      "text1": "Dr. Ahmed Alsaleh",
      "text2": "Dallah Hospital",
      "text3": "23-02-2022",
    },
    {
      "image": Images.blood_test,
      "text1": "Dr. Saleh Alhabib",
      "text2": "Alhabib Hospital",
      "text3": "30-01-2022",
    },
    {
      "image": Images.blood_test,
      "text1": "Dr. Sarah Alali",
      "text2": "Dallah Hospital",
      "text3": "19-12-2019",
    },
    {
      "image": Images.blood_test,
      "text1": "Dr. Ahmed Alsaleh",
      "text2": "Dallah Hospital",
      "text3": "23-10-2019",
    },
    {
      "image": Images.blood_test,
      "text1": "Dr. Saleh Alhabib",
      "text2": "Alhabib Hospital",
      "text3": "23-10-2019",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF7F,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 3),
                height: 455,
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
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                            toDayList[index]["image"],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              mediumText(
                                                  toDayList[index]["text1"],
                                                  ColorResources.green009,
                                                  20),
                                              SizedBox(height: 2),
                                              romanText(
                                                  toDayList[index]["text2"],
                                                  ColorResources.grey777,
                                                  12),
                                              SizedBox(height: 4),
                                              romanText(
                                                  toDayList[index]["text3"],
                                                  ColorResources.grey777,
                                                  12),
                                            ],
                                          ),
                                          Button(() {
                                            // Get.to(RoutScreen());
                                          },
                                              "View Results",
                                              Color.fromRGBO(241, 94, 34, 0.7),
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
              Padding(
                padding: EdgeInsets.only(left: 340, bottom: 0, right: 0),
                child: InkWell(
                  onTap: () {
                    _startAdd2(context);
                  },
                  child: Flexible(
                    flex: 1,
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
                        child:
                            Icon(Icons.filter_alt, color: ColorResources.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
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
}
