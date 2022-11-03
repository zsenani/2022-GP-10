import 'package:medcore/AuthScreens/signin_screen.dart';
import 'package:medcore/AuthScreens/verification_screen.dart';
import 'package:medcore/Controller/variable_controller.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medcore/index.dart';

class ChangePasswordScreen extends StatelessWidget {
  String role;
  ChangePasswordScreen({Key key, @required this.role}) : super(key: key);
  static const routeName = '/change-password-screen';

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  final VariableController variableController = Get.put(VariableController());

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
                  builder: (context) => VerificationScreen(
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
              heavyText("Recovery password", ColorResources.green009, 24),
              const SizedBox(height: 15),
              bookText(
                  "Enter your new and confirm password to reset your password.",
                  ColorResources.greyA0A,
                  16),
              const SizedBox(height: 50),
              Row(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    color: ColorResources.orange,
                  ),
                  const SizedBox(width: 15),
                  mediumText("Password", ColorResources.grey777, 16),
                ],
              ),
              Obx(
                () => TextFormField(
                  cursorColor: ColorResources.black,
                  obscureText: variableController.isOpenPassword.value,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: ColorResources.black,
                    fontSize: 16,
                    fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          variableController.isOpenPassword.value =
                              !variableController.isOpenPassword.value;
                        },
                        child: SvgPicture.asset(
                          variableController.isOpenPassword.isFalse
                              ? Images.visibilityOnIcon
                              : Images.visibilityOffIcon,
                        ),
                      ),
                    ),
                    hintText: "Enter password",
                    hintStyle: TextStyle(
                      color: ColorResources.grey777,
                      fontSize: 16,
                      fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                    ),
                    filled: true,
                    fillColor: ColorResources.whiteF6F,
                    border: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyA0A, width: 1),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyA0A, width: 1),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyA0A, width: 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    color: ColorResources.orange,
                  ),
                  const SizedBox(width: 15),
                  mediumText("Confirm password", ColorResources.grey777, 16),
                ],
              ),
              Obx(
                () => TextFormField(
                  cursorColor: ColorResources.black,
                  obscureText: variableController.isOpenConfirmPassword.value,
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: ColorResources.black,
                    fontSize: 16,
                    fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          variableController.isOpenConfirmPassword.value =
                              !variableController.isOpenConfirmPassword.value;
                        },
                        child: SvgPicture.asset(
                          variableController.isOpenConfirmPassword.isFalse
                              ? Images.visibilityOnIcon
                              : Images.visibilityOffIcon,
                        ),
                      ),
                    ),
                    hintText: "Enter confirm password",
                    hintStyle: TextStyle(
                      color: ColorResources.grey777,
                      fontSize: 16,
                      fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                    ),
                    filled: true,
                    fillColor: ColorResources.whiteF6F,
                    border: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyA0A, width: 1),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyA0A, width: 1),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyA0A, width: 1),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              commonButton(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(
                      role: role,
                    ),
                  ),
                );
              }, "Reset Password", ColorResources.green009,
                  ColorResources.white),
            ],
          ),
        ),
      ),
    );
  }
}
