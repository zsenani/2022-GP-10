import 'package:medcore/Controller/splash_controller.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  // SplashScreen({Key? key}) : super(key: key);

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.lightBlue,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: Center(
          child: Image.asset(Images.medcoreAppSplashLogo),
        ),
      ),
    );
  }
}
