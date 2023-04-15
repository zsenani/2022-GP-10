import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:medcore/index.dart';
import 'change_password_screen.dart';
import 'otp.dart';
import 'package:get/get.dart';

String email1;

class ForgotPasswordScreen extends StatelessWidget {
  String role;

  ForgotPasswordScreen({Key key, String role1, String email})
      : super(key: key) {
    role = role1;
    email1 = email;
  }

  static const routeName = '/forgot-password-screen';

  final TextEditingController emailController2 = TextEditingController();
  //static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child:
                    const Icon(Icons.arrow_back, color: ColorResources.grey777),
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
              role2: role,
            ),

            const Spacer(),
            // Padding(padding: EdgeInsets.only(bottom: 30)),
            commonButton(() {
              print(email1);

              controller.restart();
              verifyOtp(email1, context);
              pinPutController.clear();
              // if (validateOTP == true) {
              Get.to(ChangePasswordScreen(role1: role, email: email1));
              // }
            }, "Next", ColorResources.green009, ColorResources.white),
          ],
        ),
      ),
    );
  }
}
