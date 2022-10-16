import './singleMedicalReport.dart';
import '../Utiils/colors.dart';
import '../Utiils/common_widgets.dart';
import '../Utiils/images.dart';
import '../Utiils/text_font_family.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class MedicalReports extends StatefulWidget {
  // HomeScreen({Key? key}) : super(key: key);

  @override
  State<MedicalReports> createState() => _MedicalReports();
}

class _MedicalReports extends State<MedicalReports> {
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
              SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      //Get.to(HomeScreen());
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorResources.whiteF6F,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorResources.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back,
                            color: ColorResources.grey777),
                      ),
                    ),
                  ),
                  HeaderWidget(),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    itemCount: 5, //medicalReports.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(singleMedicalReport());
                          },
                          child: Container(
                            height: 90,
                            width: 500,
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: ColorResources.greyA0A.withOpacity(0.1),
                                width: 4,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 22),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 45,
                                    width: 40,
                                    child: Image.asset(
                                      Images.medical2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: heavyText(
                                            'Dr. Saleh Alhabib',
                                            //getCareList[index]["text2"],
                                            ColorResources.green009,
                                            20,
                                            TextAlign.left),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Alhabib Hospital - ",
                                          style: TextStyle(
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_BOOK,
                                            fontSize: 14,
                                            color: ColorResources.grey777,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "Date: 11-16",
                                              style: TextStyle(
                                                fontFamily: TextFontFamily
                                                    .AVENIR_LT_PRO_BOOK,
                                                fontSize: 14,
                                                color: ColorResources.greyA0A,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget HeaderWidget() {
    return Stack(
      children: [
        Container(
          height: 50,
          width: Get.width,
          padding: EdgeInsets.only(top: 8, left: 40),
          child: heavyText("Medical Reports", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
