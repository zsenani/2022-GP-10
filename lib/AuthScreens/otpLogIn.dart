import 'package:medcore/AuthScreens/forgetEmail.dart';
import 'package:medcore/AuthScreens/signin_screen.dart';

import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/patient_home_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:medcore/index.dart';
import '../LabScreens/lab_home_screen.dart';
import 'change_password_screen.dart';
import 'otp.dart';
import 'package:get/get.dart';

class otpLogInScreen extends StatelessWidget {
  String role, email;
  TextEditingController idController;
  otpLogInScreen(
      {Key key,
      @required this.role,
      @required this.email,
      @required this.idController})
      : super(key: key);

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('in log in otp');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorResources.white,
        appBar: AppBar(
          backgroundColor: ColorResources.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(7),
            child: InkWell(
              onTap: () {
                pinPutController.clear();
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back,
                      color: ColorResources.grey777),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 15),
              child: InkWell(
                onTap: () {
                  pinPutController.clear();
                  Navigator.of(context).pushNamed(index.routeName);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //        color: ColorResources.greyA0A.withOpacity(0.2),
                    //     ),
                  ),
                  child: const Icon(Icons.home_outlined,
                      color: ColorResources.grey777),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 40,
            top: 20,
          ),
          child: Column(
            children: [
              otpMail(
                emailController2: email,
                role2: role,
              ),

              const Spacer(),
              // Padding(padding: EdgeInsets.only(bottom: 30)),
              commonButton(() {
                controller.restart();

                verifyOtp(email, context);
                if (validateOTP == true) {
                  if (role == 'Physician') {
                    pinPutController.clear();
                    Get.to(HomeScreen(id: idController.text));
                  } else if (role == 'patient') {
                    pinPutController.clear();
                    Get.to(PatientHomeScreen(id: idController.text),
                        arguments: 'patient');
                  } else if (role == 'Lab specialist') {
                    pinPutController.clear();
                    Get.to(LabHomePage1(id: idController.text));
                  }
                }
              }, "Next", ColorResources.green009, ColorResources.white),
            ],
          ),
        ),
      ),
    );
  }
}
