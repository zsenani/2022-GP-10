import 'package:medcore/AuthScreens/signin_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/main.dart';

class index extends StatefulWidget {
  static const routeName = '/index';

  @override
  State<index> createState() => _index();
}

class _index extends State<index> {
  PageController pageController = PageController(initialPage: 0);

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 10,
      ),
      primary: const Color.fromRGBO(244, 251, 251, 1),
      shadowColor: Colors.grey,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 340,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.authScreenBackGroundImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 210),
                      CircleAvatar(
                        radius: 120,
                        backgroundColor: ColorResources.white.withOpacity(0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(Images.medcoreLogo),
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        width: 250,
                        child: ElevatedButton(
                          style: style,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(
                                role: 'patient',
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Images.user),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              const Text(
                                'Patient',
                                style: TextStyle(
                                  color: ColorResources.green009,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 90,
                        width: 250,
                        child: ElevatedButton(
                          style: style,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(
                                role: 'hospital',
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Images.doctors),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              const Text(
                                'Hospital',
                                style: TextStyle(
                                  //Color.fromRGBO(241, 94, 34, 1)
                                  color: ColorResources.green009,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
