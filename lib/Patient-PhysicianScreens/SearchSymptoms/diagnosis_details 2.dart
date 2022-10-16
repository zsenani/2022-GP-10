<<<<<<< HEAD
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen.dart';
//import 'package:file_picker/src/platform_file.dart';

class DiagnosisDetails extends StatelessWidget {
  // OnlineAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      appBar: AppBar(
        backgroundColor: ColorResources.whiteF6F,
        // backgroundColor: Color.fromRGBO(244, 251, 251, 1),
        elevation: 0,
        title: Container(
          child: Row(children: [
            SizedBox(width: 30),
            mediumText("Diagnostic Details", ColorResources.grey777, 24),
          ]),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(7),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorResources.whiteF6F,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorResources.greyA0A.withOpacity(0.2),
                ),
              ),
              child:
                  const Icon(Icons.arrow_back, color: ColorResources.grey777),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10, top: 15),
            child: InkWell(
              onTap: () {
                Get.to(HomeScreen());
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorResources.whiteF6F,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorResources.greyA0A.withOpacity(0.2),
                  ),
                ),
                child: const Icon(Icons.home_outlined,
                    color: ColorResources.grey777),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    mediumText("Successful diagnosis",
                                        ColorResources.green009, 22),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: ColorResources.greyD4D.withOpacity(0.4),
                      thickness: 1,
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Image.asset(
                            'assets/images/doctor.png',
                            height: 27,
                            width: 27,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Physician information",
                                ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText(
                                    "Name   :   ", ColorResources.greyA0A, 16),
                                mediumText("Dr. Tierra Riley",
                                    ColorResources.grey777, 16),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText(
                                    "Phone  :   ", ColorResources.greyA0A, 16),
                                mediumText("+966 5668 44776",
                                    ColorResources.grey777, 16),
                              ],
                            ),
                            SizedBox(height: 10),
                            romanText(
                                "Cardiologist - Accra Medical College Hospital",
                                ColorResources.greyA0A,
                                14),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/clock.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText(
                                "Diagnosis date", ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            romanText(
                                "10 June, 2022", ColorResources.grey777, 16),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/user.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Patient information",
                                ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText("Gender   :   ",
                                    ColorResources.greyA0A, 16),
                                mediumText(
                                    "John Doe", ColorResources.grey777, 16),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText("Age      :   ",
                                    ColorResources.greyA0A, 16),
                                mediumText("21", ColorResources.grey777, 16),
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
                          'assets/images/document.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Patient's medical information",
                                ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText("Chronic diseases   :   ",
                                    ColorResources.greyA0A, 16),
                                mediumText("none", ColorResources.grey777, 16),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText("Genetic diseases      :   ",
                                    ColorResources.greyA0A, 16),
                                mediumText("none", ColorResources.grey777, 16),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(
                      color: ColorResources.greyD4D.withOpacity(0.4),
                      thickness: 1,
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/symptoms.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Symptoms", ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: 250,
                                  child: bookText(
                                      "Wheezing, Chest tightness, Swelling in ankles, feet or legs, Unintended weight loss, Frequent respiratory infections. ",
                                      ColorResources.green009,
                                      16),
                                )
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
                          'assets/images/diagnosis.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Diagnosis", ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  height: Get.height,
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      mediumText("Subject",
                                          Color.fromRGBO(241, 94, 34, 1), 18),
                                      SizedBox(height: 10),
                                      romanText(
                                          "Chronic obstructive pulmonary disease (COPD) is a chronic inflammatory lung disease that causes obstructed airflow from the lungs. Symptoms include breathing difficulty, cough, mucus (sputum) production and wheezing. It's typically caused by long-term exposure to irritating gases or particulate matter, most often from cigarette smoke. People with COPD are at increased risk of developing heart disease, lung cancer and a variety of other conditions.",
                                          ColorResources.greyA0A,
                                          16),
                                      SizedBox(height: 20),
                                      mediumText("Object",
                                          Color.fromRGBO(241, 94, 34, 1), 18),
                                      SizedBox(height: 10),
                                      romanText(
                                          "Emphysema and chronic bronchitis are the two most common conditions that contribute to COPD. These two conditions usually occur together and can vary in severity among individuals with COPD",
                                          ColorResources.greyA0A,
                                          16),
                                      SizedBox(height: 20),
                                      mediumText("Assignment",
                                          Color.fromRGBO(241, 94, 34, 1), 18),
                                      SizedBox(height: 10),
                                      romanText(
                                          "Emphysema and chronic bronchitis are the two most common conditions that contribute to COPD. These two conditions usually occur together and can vary in severity among individuals with COPD",
                                          ColorResources.greyA0A,
                                          16),
                                      SizedBox(height: 10),
                                      mediumText("Plan",
                                          Color.fromRGBO(241, 94, 34, 1), 18),
                                      SizedBox(height: 10),
                                      romanText(
                                          "Emphysema and chronic bronchitis are the two most common conditions that contribute to COPD. These two conditions usually occur together and can vary in severity among individuals with COPD",
                                          ColorResources.greyA0A,
                                          16),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ])))),
    );
  }
}
=======
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen.dart';
//import 'package:file_picker/src/platform_file.dart';

class DiagnosisDetails extends StatelessWidget {
  // OnlineAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      appBar: AppBar(
        backgroundColor: ColorResources.whiteF6F,
        // backgroundColor: Color.fromRGBO(244, 251, 251, 1),
        elevation: 0,
        title: Container(
          child: Row(children: [
            SizedBox(width: 30),
            mediumText("Diagnostic Details", ColorResources.grey777, 24),
          ]),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(7),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorResources.whiteF6F,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorResources.greyA0A.withOpacity(0.2),
                ),
              ),
              child:
                  const Icon(Icons.arrow_back, color: ColorResources.grey777),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10, top: 15),
            child: InkWell(
              onTap: () {
                Get.to(HomeScreen());
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorResources.whiteF6F,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorResources.greyA0A.withOpacity(0.2),
                  ),
                ),
                child: const Icon(Icons.home_outlined,
                    color: ColorResources.grey777),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    mediumText("Successful diagnosis",
                                        ColorResources.green009, 22),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: ColorResources.greyD4D.withOpacity(0.4),
                      thickness: 1,
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Image.asset(
                            'assets/images/doctor.png',
                            height: 27,
                            width: 27,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Physician information",
                                ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText(
                                    "Name   :   ", ColorResources.greyA0A, 16),
                                mediumText("Dr. Tierra Riley",
                                    ColorResources.grey777, 16),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText(
                                    "Phone  :   ", ColorResources.greyA0A, 16),
                                mediumText("+966 5668 44776",
                                    ColorResources.grey777, 16),
                              ],
                            ),
                            SizedBox(height: 10),
                            romanText(
                                "Cardiologist - Accra Medical College Hospital",
                                ColorResources.greyA0A,
                                14),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/clock.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText(
                                "Diagnosis date", ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            romanText(
                                "10 June, 2022", ColorResources.grey777, 16),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/user.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Patient information",
                                ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText("Gender   :   ",
                                    ColorResources.greyA0A, 16),
                                mediumText(
                                    "John Doe", ColorResources.grey777, 16),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText("Age      :   ",
                                    ColorResources.greyA0A, 16),
                                mediumText("21", ColorResources.grey777, 16),
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
                          'assets/images/document.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Patient's medical information",
                                ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText("Chronic diseases   :   ",
                                    ColorResources.greyA0A, 16),
                                mediumText("none", ColorResources.grey777, 16),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                bookText("Genetic diseases      :   ",
                                    ColorResources.greyA0A, 16),
                                mediumText("none", ColorResources.grey777, 16),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(
                      color: ColorResources.greyD4D.withOpacity(0.4),
                      thickness: 1,
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/symptoms.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Symptoms", ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: 250,
                                  child: bookText(
                                      "Wheezing, Chest tightness, Swelling in ankles, feet or legs, Unintended weight loss, Frequent respiratory infections. ",
                                      ColorResources.green009,
                                      16),
                                )
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
                          'assets/images/diagnosis.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("Diagnosis", ColorResources.grey777, 18),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  height: Get.height,
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      mediumText("Subject",
                                          Color.fromRGBO(241, 94, 34, 1), 18),
                                      SizedBox(height: 10),
                                      romanText(
                                          "Chronic obstructive pulmonary disease (COPD) is a chronic inflammatory lung disease that causes obstructed airflow from the lungs. Symptoms include breathing difficulty, cough, mucus (sputum) production and wheezing. It's typically caused by long-term exposure to irritating gases or particulate matter, most often from cigarette smoke. People with COPD are at increased risk of developing heart disease, lung cancer and a variety of other conditions.",
                                          ColorResources.greyA0A,
                                          16),
                                      SizedBox(height: 20),
                                      mediumText("Object",
                                          Color.fromRGBO(241, 94, 34, 1), 18),
                                      SizedBox(height: 10),
                                      romanText(
                                          "Emphysema and chronic bronchitis are the two most common conditions that contribute to COPD. These two conditions usually occur together and can vary in severity among individuals with COPD",
                                          ColorResources.greyA0A,
                                          16),
                                      SizedBox(height: 20),
                                      mediumText("Assignment",
                                          Color.fromRGBO(241, 94, 34, 1), 18),
                                      SizedBox(height: 10),
                                      romanText(
                                          "Emphysema and chronic bronchitis are the two most common conditions that contribute to COPD. These two conditions usually occur together and can vary in severity among individuals with COPD",
                                          ColorResources.greyA0A,
                                          16),
                                      SizedBox(height: 10),
                                      mediumText("Plan",
                                          Color.fromRGBO(241, 94, 34, 1), 18),
                                      SizedBox(height: 10),
                                      romanText(
                                          "Emphysema and chronic bronchitis are the two most common conditions that contribute to COPD. These two conditions usually occur together and can vary in severity among individuals with COPD",
                                          ColorResources.greyA0A,
                                          16),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ])))),
    );
  }
}
>>>>>>> c5383dcd26a3a910ece9bf052004373fcc42df14
