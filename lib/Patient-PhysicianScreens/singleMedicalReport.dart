import '../Utiils/colors.dart';
import '../Utiils/common_widgets.dart';
import '../Utiils/text_font_family.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class singleMedicalReport extends StatelessWidget {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 10, bottom: 200),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 60,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Dr. Sarah Alhabib',
                        style: TextStyle(
                          fontFamily: TextFontFamily.AVENIR_LT_PRO_ROMAN,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 22,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: "Alhabib Hospital - ",
                        style: TextStyle(
                          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                          fontSize: 18,
                          color: ColorResources.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "11-16-2022",
                            style: TextStyle(
                              fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                              fontSize: 18,
                              color: ColorResources.white,
                            ),
                          ),
                        ],
                      ),
                    ),
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
            ],
          ),
        ]),
      ),
    );
  }

  Widget DoctorDetailsContainer() {
    return Padding(
      padding: EdgeInsets.only(top: 180),
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: ColorResources.white,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
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
              padding: EdgeInsets.only(top: 10),
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
                          child: romanText(
                              "Dr. Jane Cooper is the top most Cardiologist specialist in Dhaka Medical College Hospital at Accra. SHe achived several awards for her wonderful contribution in her own field. SHe is avaliable for private consultation.",
                              ColorResources.greyA0A,
                              16),
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
                          child: romanText(
                              "Dr. Jane Cooper is the top most Cardiologist specialist in Dhaka Medical College Hospital at Accra. SHe achived several awards for her wonderful contribution in her own field. SHe is avaliable for private consultation.",
                              ColorResources.greyA0A,
                              16),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: mediumText(
                              "Assignment", Color.fromRGBO(241, 94, 34, 1), 18),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: romanText(
                              "Dr. Jane Cooper is the top most Cardiologist specialist in Dhaka Medical College Hospital at Accra. SHe achived several awards for her wonderful contribution in her own field. SHe is avaliable for private consultation.",
                              ColorResources.greyA0A,
                              16),
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
                          child: romanText(
                              "Dr. Jane Cooper is the top most Cardiologist specialist in Dhaka Medical College Hospital at Accra. SHe achived several awards for her wonderful contribution in her own field. SHe is avaliable for private consultation.",
                              ColorResources.greyA0A,
                              16),
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
