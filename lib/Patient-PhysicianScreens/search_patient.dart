import 'package:medcore/Patient-PhysicianScreens/upcomming_visit_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_results.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utiils/images.dart';

class SearchPatient extends StatelessWidget {
  // SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          const SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: heavyText("Search result", ColorResources.green, 18),
          ),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () {
                  Get.to(UpCommingVisitScreen());
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
                                  text: "King Khalid Hospital",
                                  style: TextStyle(
                                    fontFamily:
                                        TextFontFamily.AVENIR_LT_PRO_ROMAN,
                                    fontSize: 10,
                                    color: ColorResources.green009,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              mediumText("Patient: Brycen Bradford",
                                  ColorResources.grey777, 18),
                              SizedBox(height: 5),
                              romanText(
                                  "ID: 1122311217", ColorResources.grey777, 12),
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
    );
  }

  Widget HeaderWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
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
            padding: EdgeInsets.only(top: 60),
            child: ListTile(
              title: heavyText(
                  "Patient Search", ColorResources.green, 22, TextAlign.center),
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
              cursorColor: ColorResources.black,
              style: TextStyle(
                color: ColorResources.black,
                fontSize: 15,
                fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child:
                        Icon(Icons.troubleshoot, color: ColorResources.green)),
                hintText: "1122311217",
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
          ),
        ),
      ],
    );
  }
}
