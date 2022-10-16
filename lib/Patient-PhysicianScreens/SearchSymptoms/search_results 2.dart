<<<<<<< HEAD
import 'package:medcore/Controller/rout_controller.dart';
import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/diagnosis_details.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResults extends StatelessWidget {
  //  SpeciaListScreen({Key? key}) : super(key: key);

  final RoutController routController = Get.put(RoutController());
  final List<Map> nearByDoctorsList = [
    {
      "text1": "Dr. Mahmud Nik Hasan",
      "text2": "Atypical hemolytic uremic syndrome",
    },
    {
      "text1": "Dr. Jane Cooper",
      "text2": "Alport syndrome",
    },
    {
      "text1": "Dr. Brycen Bradford",
      "text2": "Amyloidosis",
    },
    {
      "text1": "Dr. Tierra Riley",
      "text2": "Cystinosis",
    },
    {
      "text1": "Dr. Ashley Wentworth",
      "text2": "Glomerulonephritis",
    },
    {
      "text1": "Dr. Ashley Wentworth",
      "text2": "Focal segmental glomerulosclerosis",
    },
    {
      "text1": "Dr. Brycen Bradford",
      "text2": "Goodpasture syndrome",
    },
    {
      "text1": "Dr. Tierra Riley",
      "text2": "Fabry disease",
    },
  ];

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
            SizedBox(width: 50),
            mediumText("Search Results", ColorResources.grey777, 24),
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
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 80),
          shrinkWrap: true,
          itemCount: nearByDoctorsList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Get.to(DiagnosisDetails());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(Images.search),
                        width: 33,
                        height: 33,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText(nearByDoctorsList[index]["text2"],
                                ColorResources.grey777, 18),
                            SizedBox(height: 6),
                            RichText(
                              text: TextSpan(
                                text: nearByDoctorsList[index]["text1"],
                                style: TextStyle(
                                  fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                                  fontSize: 12,
                                  color: ColorResources.grey777,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: ColorResources.orange)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
=======
import 'package:medcore/Controller/rout_controller.dart';
import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/diagnosis_details.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResults extends StatelessWidget {
  //  SpeciaListScreen({Key? key}) : super(key: key);

  final RoutController routController = Get.put(RoutController());
  final List<Map> nearByDoctorsList = [
    {
      "text1": "Dr. Mahmud Nik Hasan",
      "text2": "Atypical hemolytic uremic syndrome",
    },
    {
      "text1": "Dr. Jane Cooper",
      "text2": "Alport syndrome",
    },
    {
      "text1": "Dr. Brycen Bradford",
      "text2": "Amyloidosis",
    },
    {
      "text1": "Dr. Tierra Riley",
      "text2": "Cystinosis",
    },
    {
      "text1": "Dr. Ashley Wentworth",
      "text2": "Glomerulonephritis",
    },
    {
      "text1": "Dr. Ashley Wentworth",
      "text2": "Focal segmental glomerulosclerosis",
    },
    {
      "text1": "Dr. Brycen Bradford",
      "text2": "Goodpasture syndrome",
    },
    {
      "text1": "Dr. Tierra Riley",
      "text2": "Fabry disease",
    },
  ];

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
            SizedBox(width: 50),
            mediumText("Search Results", ColorResources.grey777, 24),
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
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 80),
          shrinkWrap: true,
          itemCount: nearByDoctorsList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Get.to(DiagnosisDetails());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(Images.search),
                        width: 33,
                        height: 33,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText(nearByDoctorsList[index]["text2"],
                                ColorResources.grey777, 18),
                            SizedBox(height: 6),
                            RichText(
                              text: TextSpan(
                                text: nearByDoctorsList[index]["text1"],
                                style: TextStyle(
                                  fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                                  fontSize: 12,
                                  color: ColorResources.grey777,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: ColorResources.orange)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
>>>>>>> c5383dcd26a3a910ece9bf052004373fcc42df14
