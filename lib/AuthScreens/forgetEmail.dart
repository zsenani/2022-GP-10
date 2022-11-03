import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:medcore/AuthScreens/otp.dart';
import 'package:medcore/AuthScreens/signin_screen.dart';
import 'package:medcore/AuthScreens/verification_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:medcore/index.dart';
import 'package:medcore/MongoDBModel.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import '../database/constant.dart';
import '../database/mongoDB.dart';
import 'package:medcore/mongoDBModel2.dart';
import 'change_password_screen.dart';
import 'forgot_password_screen.dart';

final TextEditingController emailController = TextEditingController();
var totalLength = 0;
var mail;
String role2;

class ForgetEmail extends StatefulWidget {
  String role;
  ForgetEmail({Key key, @required this.role}) : super(key: key) {
    role = role;
    role2 = role;
  }

  static const routeName = '/forgot-password-screen';

  @override
  State<ForgetEmail> createState() => _ForgetEmailState();
}

class _ForgetEmailState extends State<ForgetEmail> {
  final formKey = GlobalKey<FormState>();
  int _dummy = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.whiteF6F,
      appBar: AppBar(
        backgroundColor: ColorResources.whiteF6F,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(7),
          child: InkWell(
            onTap: () {
              Get.back();
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
            padding: const EdgeInsets.only(right: 10, top: 15),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(index.routeName);
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
        padding:
            const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 60),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              heavyText("Forgot password", ColorResources.green009, 24),
              const SizedBox(height: 15),
              bookText(
                  "Please enter your email below to receive your OTP number.",
                  ColorResources.greyA0A,
                  16),
              const SizedBox(height: 50),
              Row(
                children: [
                  const Icon(Icons.email_outlined,
                      color: ColorResources.orange),
                  const SizedBox(width: 15),
                  mediumText("Email", ColorResources.grey777, 16),
                ],
              ),
              textField1(
                  "Enter email", emailController, TextInputType.emailAddress),
              const SizedBox(height: 30),
              const Spacer(),
              commonButton(() {
                checkEmail();
              }, "Send OTP", ColorResources.green009, ColorResources.white),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmail() async {
    String emailC =
        await DBConnection.checkEmailExsist(role2, emailController.text);

    if (emailC == null) {
<<<<<<< HEAD
=======
      //already exisit
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
      showAlertDialog(context);
    } else {
      Get.to(ForgotPasswordScreen(
        role: role2,
      ));
      sendOtp(emailController.text);
      finishTimer = false;
    }
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text(
        "Ok",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert;
    alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("Wrong e-mail entered. Please try again"),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
