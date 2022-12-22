import 'package:medcore/Patient-PhysicianScreens/medical_reports.dart';

import '../Utiils/colors.dart';
import '../Utiils/common_widgets.dart';
import '../Utiils/text_font_family.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class singleMedicalReport extends StatelessWidget {
  int ind;
  singleMedicalReport({Key key, @required this.ind}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: Stack(
        children: [
          //Image
          DoctorHeader(context),

          //Doctor Detail
          DoctorDetailsContainer(),
        ],
      ),
    );
  }

  Widget DoctorHeader(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 30),
        height: 340,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(178, 224, 222, 1),
              Color.fromRGBO(19, 156, 140, 1)
            ],
            radius: 0.75,
            focal: Alignment(0.7, -0.7),
            tileMode: TileMode.clamp,
          ),
        ),
        child: Container(
          child: Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 200),
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Center(
                      child:
                          Icon(Icons.arrow_back, color: ColorResources.white),
                    ),
                  ),
                ),
              ),
              //SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 70,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        drName[ind]['name'],
                        style: TextStyle(
                          fontFamily: TextFontFamily.AVENIR_LT_PRO_ROMAN,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                        text: hospitalname[ind]['name'],
                        style: TextStyle(
                          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                          fontSize: 18,
                          color: ColorResources.white,
                        ),
                      )),
                      RichText(
                        text: TextSpan(
                          text: "Date: " +
                              toDayList[ind]['date'].substring(
                                  0, toDayList[ind]['date'].indexOf(' ')) +
                              " Time: " +
                              toDayList[ind]['time'],
                          style: TextStyle(
                            fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                            fontSize: 18,
                            color: ColorResources.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10, bottom: 200),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Center(
                      // heightFactor: 100,
                      child: Icon(Icons.home_outlined,
                          color: ColorResources.white),
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ));
  }

  Widget DoctorDetailsContainer() {
    return Padding(
      padding: EdgeInsets.only(top: 210),
      child: Container(
        height: 950,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: ColorResources.white,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 10,
              left: 24,
              right: 24,
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: heavyText(
                              "Subject", Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(toDayList[ind]['subject'],
                              ColorResources.greyA0A, 16),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: mediumText(
                              "Object", Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(toDayList[ind]['object'],
                              ColorResources.greyA0A, 16),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: mediumText(
                              "Assessment", Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(toDayList[ind]['assessment'],
                              ColorResources.greyA0A, 16),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: mediumText(
                              "Plan", Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(toDayList[ind]['plan'],
                              ColorResources.greyA0A, 16),
                        ),
                        SizedBox(height: 10),
                      ],
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
