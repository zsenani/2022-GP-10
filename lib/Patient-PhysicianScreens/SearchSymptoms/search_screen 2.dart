<<<<<<< HEAD
import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_results.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:
                heavyText("View Selected Symptoms", ColorResources.green, 18),
          ),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Flexible(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 5,
                      direction: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      SizedBox(width: 1),
                                      mediumText(
                                          'Symptoms1',
                                          ColorResources.grey777,
                                          15,
                                          TextAlign.center),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      SizedBox(width: 1),
                                      mediumText(
                                          'Symptoms2',
                                          ColorResources.grey777,
                                          15,
                                          TextAlign.center),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      SizedBox(width: 1),
                                      mediumText(
                                          'Symptoms3',
                                          ColorResources.grey777,
                                          15,
                                          TextAlign.center),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      mediumText('Symptoms4',
                                          ColorResources.grey777, 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      mediumText('Symptoms5',
                                          ColorResources.grey777, 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      mediumText('Symptoms6',
                                          ColorResources.grey777, 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      mediumText('Symptoms7',
                                          ColorResources.grey777, 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: InkWell(
              onTap: () {
                Get.to(SearchResults());
              },
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorResources.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child:
                      heavyText("Show a Diagnosis", ColorResources.white, 18),
                ),
              ),
            ),
          ),
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
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    Get.to(HomeScreen());
                  },
                  child: const Icon(Icons.arrow_back,
                      color: ColorResources.grey777),
                ),
              ),
              const SizedBox(width: 83),
              heavyText("Symptoms Search", ColorResources.green, 22,
                  TextAlign.center),
            ])),
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
              decoration: InputDecoration(
                suffixIcon: const Padding(
                    padding: EdgeInsets.all(15),
                    child:
                        Icon(Icons.troubleshoot, color: ColorResources.green)),
                hintText: "Symptoms Search. . .",
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
=======
import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_results.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:
                heavyText("View Selected Symptoms", ColorResources.green, 18),
          ),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Flexible(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 5,
                      direction: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      SizedBox(width: 1),
                                      mediumText(
                                          'Symptoms1',
                                          ColorResources.grey777,
                                          15,
                                          TextAlign.center),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      SizedBox(width: 1),
                                      mediumText(
                                          'Symptoms2',
                                          ColorResources.grey777,
                                          15,
                                          TextAlign.center),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      SizedBox(width: 1),
                                      mediumText(
                                          'Symptoms3',
                                          ColorResources.grey777,
                                          15,
                                          TextAlign.center),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      mediumText('Symptoms4',
                                          ColorResources.grey777, 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      mediumText('Symptoms5',
                                          ColorResources.grey777, 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      mediumText('Symptoms6',
                                          ColorResources.grey777, 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 40,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: ColorResources.orange,
                                          size: 20),
                                      mediumText('Symptoms7',
                                          ColorResources.grey777, 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: InkWell(
              onTap: () {
                Get.to(SearchResults());
              },
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorResources.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child:
                      heavyText("Show a Diagnosis", ColorResources.white, 18),
                ),
              ),
            ),
          ),
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
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    Get.to(HomeScreen());
                  },
                  child: const Icon(Icons.arrow_back,
                      color: ColorResources.grey777),
                ),
              ),
              const SizedBox(width: 83),
              heavyText("Symptoms Search", ColorResources.green, 22,
                  TextAlign.center),
            ])),
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
              decoration: InputDecoration(
                suffixIcon: const Padding(
                    padding: EdgeInsets.all(15),
                    child:
                        Icon(Icons.troubleshoot, color: ColorResources.green)),
                hintText: "Symptoms Search. . .",
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
>>>>>>> c5383dcd26a3a910ece9bf052004373fcc42df14
