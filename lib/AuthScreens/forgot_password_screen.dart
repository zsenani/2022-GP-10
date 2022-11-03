import 'package:medcore/AuthScreens/signin_screen.dart';
import 'package:medcore/AuthScreens/verification_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:medcore/index.dart';

class ForgotPasswordScreen extends StatelessWidget {
  String role;
  ForgotPasswordScreen({Key key, @required this.role}) : super(key: key);

  static const routeName = '/forgot-password-screen';

  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(
                    role: role,
                  ),
                ),
              );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationScreen(
                      role: role,
                    ),
                  ),
                );
              }, "Send OTP", ColorResources.green009, ColorResources.white),
            ],
          ),
        ),
      ),
    );
  }
}
