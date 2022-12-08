import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/images.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_history.dart';

class MedicalHistory extends StatelessWidget {
  String role = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
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
                      child:
                          Icon(Icons.arrow_back, color: ColorResources.grey777),
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: HeaderWidget(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.person_outline,
                              color: Color.fromRGBO(241, 94, 34, 1), size: 30),
                          SizedBox(width: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: mediumText("Personal information",
                                ColorResources.grey777, 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: ColorResources.greyD4D.withOpacity(0.4),
                        thickness: 1,
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  bookText("Name   :   ",
                                      ColorResources.greyA0A, 16),
                                  mediumText("Sarah Alahmed",
                                      ColorResources.grey777, 16),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  bookText("Age      :   ",
                                      ColorResources.greyA0A, 16),
                                  mediumText("23", ColorResources.grey777, 16),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  bookText("Gender :   ",
                                      ColorResources.greyA0A, 16),
                                  mediumText(
                                      "Female", ColorResources.grey777, 16),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  bookText("Blood Type :  ",
                                      ColorResources.greyA0A, 16),
                                  mediumText("O+", ColorResources.grey777, 16),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  bookText(
                                      "ID   :   ", ColorResources.greyA0A, 16),
                                  mediumText(
                                      "1112345678", ColorResources.grey777, 16),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  bookText(
                                      "DOB:   ", ColorResources.greyA0A, 16),
                                  mediumText(
                                      "16-11-1998", ColorResources.grey777, 16),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  bookText("Nationality:   ",
                                      ColorResources.greyA0A, 16),
                                  mediumText(
                                      "Saudi", ColorResources.grey777, 16),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  bookText("Marital Status:   ",
                                      ColorResources.greyA0A, 16),
                                  mediumText(
                                      "Single", ColorResources.grey777, 16),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: ColorResources.greyD4D.withOpacity(0.4),
                        thickness: 1,
                      ),
                      SizedBox(height: 30),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  Images.allergy2,
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: mediumText("Allergies",
                                          ColorResources.grey777, 18),
                                    ),
                                    SizedBox(height: 10),
                                    romanText("Balsam of Peru",
                                        ColorResources.grey777, 16),
                                    SizedBox(height: 10),
                                    romanText("Sulfonamides",
                                        ColorResources.grey777, 16),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                SizedBox(width: 50),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.group,
                                        color: Color.fromRGBO(241, 94, 34, 0.7),
                                        size: 30),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 6),
                                          child: mediumText("Social History",
                                              ColorResources.grey777, 18),
                                        ),
                                        SizedBox(height: 10),
                                        romanText("Tobacco use",
                                            ColorResources.grey777, 16),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  Images.family2,
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: mediumText("Family History",
                                          ColorResources.grey777, 18),
                                    ),
                                    SizedBox(height: 10),
                                    romanText(
                                        "Diabetes", ColorResources.grey777, 16),
                                    SizedBox(height: 10),
                                    romanText("High Blood Pressure",
                                        ColorResources.grey777, 16),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                SizedBox(width: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Images.surgery2,
                                      width: 25,
                                      height: 25,
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 6),
                                          child: mediumText("Surgical History",
                                              ColorResources.grey777, 18),
                                        ),
                                        SizedBox(height: 10),
                                        romanText("Heart Surgery",
                                            ColorResources.grey777, 16),
                                        SizedBox(height: 10),
                                        romanText("Appendectomy",
                                            ColorResources.grey777, 16),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  Images.illness2,
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: mediumText("Medical Illnesses",
                                          ColorResources.grey777, 18),
                                    ),
                                    SizedBox(height: 10),
                                    romanText("Coronavirus",
                                        ColorResources.grey777, 16),
                                    SizedBox(height: 10),
                                    romanText("Bone Cancer",
                                        ColorResources.grey777, 16),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                      SizedBox(height: 30),
                      role == "UPphysician"
                          ? Column(
                              children: [
                                commonButton(() {
                                  Get.to(EditHistory());
                                }, "Edit", ColorResources.green009,
                                    ColorResources.white),
                                SizedBox(height: 30),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget HeaderWidget() {
    return Stack(
      children: [
        Container(
          height: 80,
          width: Get.width,
          padding: EdgeInsets.only(top: 23, left: 55),
          child: heavyText("Medical History ", ColorResources.green009, 30),
        ),
      ],
    );
  }
}
