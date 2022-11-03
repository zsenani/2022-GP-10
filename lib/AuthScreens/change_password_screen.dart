import 'package:dbcrypt/dbcrypt.dart';
import 'package:medcore/AuthScreens/forgetEmail.dart';
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
import 'package:medcore/database/mongoDB.dart';
import 'package:medcore/index.dart';

class ChangePasswordScreen extends StatefulWidget {
  String role;
  ChangePasswordScreen({Key key, @required this.role}) : super(key: key);
  static const routeName = '/change-password-screen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
                    filled: false,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: errorPass == false
                          ? const BorderSide(
                              color: ColorResources.greyA0A, width: 1)
                          : const BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (errorPass == true)
                mediumText("Enter a valid password", Colors.red, 16),
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
                    filled: false,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: passwordController.text ==
                              confirmPasswordController.text
                          ? const BorderSide(
                              color: ColorResources.greyA0A, width: 1)
                          : const BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (passwordController.text != confirmPasswordController.text)
                mediumText("Password did not match", Colors.red, 16),
              const Spacer(),
              commonButton(() {
                if (passwordController.text != null &&
                    confirmPasswordController.text != null) {
                  if (validateMyPass(passwordController.text)) {
<<<<<<< HEAD
                    print(widget.role);
                    updatePass();
                    Get.to(SignInScreen(
                      role: widget.role,
=======
                    print(role);
                    updatePass();
                    Get.to(SignInScreen(
                      role: role,
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                    ));
                  }
                }
              }, "Reset Password", ColorResources.green009,
                  ColorResources.white),
            ],
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  bool errorPass = false;

=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
  bool validateMyPass(String value) {
    Pattern pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$";

    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value) &&
        passwordController.text == confirmPasswordController.text) {
      print('Valid password');
<<<<<<< HEAD
      setState(() {
        errorPass = false;
      });
      return true;
    } else {
      print("Enter Valid password");
      setState(() {
        errorPass = true;
      });
=======
      return true;
    } else {
      print("Enter Valid password");
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
      return false;
    }
  }

  void updatePass() async {
    var passHash = new DBCrypt()
        .hashpw(confirmPasswordController.text, new DBCrypt().gensalt());
<<<<<<< HEAD
    DBConnection.update(widget.role, emailController.text, passHash);
=======
    DBConnection.update(role, emailController.text, passHash);
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
  }
}
