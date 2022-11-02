import 'package:dbcrypt/dbcrypt.dart';
import 'package:medcore/AuthScreens/otp.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/database/mongoDB.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medcore/Controller/variable_controller.dart';

String patientId;
String role3;
bool errorPass = false;
bool errorCurrentPass = false;

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key key, String id, String role}) : super(key: key) {
    patientId = id;
    role3 = role;
  }

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final VariableController currentVariableController =
      Get.put(VariableController());
  final VariableController newVariableController =
      Get.put(VariableController());
  final VariableController confirmVariableController =
      Get.put(VariableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF7F,
      appBar: AppBar(
        backgroundColor: ColorResources.whiteF7F,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18, top: 35, bottom: 8),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 40,
              width: 40,
              child: const Center(
                child: Icon(Icons.arrow_back, color: ColorResources.grey777),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10, top: 38, bottom: 8),
          child: mediumText("Reset Password", ColorResources.grey777, 24),
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 65),
                Row(
                  children: [
                    const Icon(
                      Icons.lock_outlined,
                      color: ColorResources.orange,
                    ),
                    const SizedBox(width: 15),
                    mediumText("Current password", ColorResources.grey777, 16),
                  ],
                ),
                Obx(
                  () => TextFormField(
                    cursorColor: ColorResources.black,
                    obscureText: currentVariableController.isOpenPassword.value,
                    controller: currentPasswordController,
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
                            currentVariableController.isOpenPassword.value =
                                !currentVariableController.isOpenPassword.value;
                          },
                          child: SvgPicture.asset(
                            currentVariableController.isOpenPassword.isFalse
                                ? Images.visibilityOnIcon
                                : Images.visibilityOffIcon,
                          ),
                        ),
                      ),
                      hintText: "Enter your current password",
                      hintStyle: TextStyle(
                        color: ColorResources.grey777,
                        fontSize: 16,
                        fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                      ),
                      filled: true,
                      fillColor: ColorResources.whiteF6F,
                      border: UnderlineInputBorder(
                        borderSide: errorCurrentPass == false
                            ? const BorderSide(
                                color: ColorResources.greyA0A, width: 1)
                            : const BorderSide(color: Colors.red, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: errorCurrentPass == false
                            ? const BorderSide(
                                color: ColorResources.greyA0A, width: 1)
                            : const BorderSide(color: Colors.red, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: errorCurrentPass == false
                            ? const BorderSide(
                                color: ColorResources.greyA0A, width: 1)
                            : const BorderSide(color: Colors.red, width: 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (errorCurrentPass == true)
                  Padding(
                    padding: EdgeInsets.only(right: 225),
                    child: mediumText("Wrong password", Colors.red, 16),
                  ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.lock_outlined,
                      color: ColorResources.orange,
                    ),
                    const SizedBox(width: 15),
                    mediumText("New password", ColorResources.grey777, 16),
                  ],
                ),
                passValidator(),
                const SizedBox(height: 5),
                if (errorPass == true)
                  Padding(
                    padding: EdgeInsets.only(right: 185),
                    child: mediumText("Enter a valid password", Colors.red, 16),
                  ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.lock_outlined,
                      color: ColorResources.orange,
                    ),
                    const SizedBox(width: 15),
                    mediumText("Confirm password", ColorResources.grey777, 16),
                  ],
                ),
                Obx(
                  () => TextFormField(
                    cursorColor: ColorResources.black,
                    obscureText:
                        confirmVariableController.isOpenConfirmPassword.value,
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
                            confirmVariableController
                                    .isOpenConfirmPassword.value =
                                !confirmVariableController
                                    .isOpenConfirmPassword.value;
                          },
                          child: SvgPicture.asset(
                            confirmVariableController
                                    .isOpenConfirmPassword.isFalse
                                ? Images.visibilityOnIcon
                                : Images.visibilityOffIcon,
                          ),
                        ),
                      ),
                      hintText: "Confirm your password",
                      hintStyle: TextStyle(
                        color: ColorResources.grey777,
                        fontSize: 16,
                        fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                      ),
                      filled: true,
                      fillColor: ColorResources.whiteF6F,
                      border: UnderlineInputBorder(
                        borderSide: errorPass == false
                            ? const BorderSide(
                                color: ColorResources.greyA0A, width: 1)
                            : const BorderSide(color: Colors.red, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: errorPass == false
                            ? const BorderSide(
                                color: ColorResources.greyA0A, width: 1)
                            : const BorderSide(color: Colors.red, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: errorPass == false
                            ? const BorderSide(
                                color: ColorResources.greyA0A, width: 1)
                            : const BorderSide(color: Colors.red, width: 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                commonButton(() {
                  validateMyPass(confirmPasswordController.text);
                  checkPass();
                  // print(errorCurrentPass);
                }, "Reset", ColorResources.green009, ColorResources.white),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  passValidator() => TextFormField(
        cursorColor: ColorResources.black,
        obscureText: newVariableController.isOpenNewPassowrd.value,
        controller: newPasswordController,
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
                newVariableController.isOpenNewPassowrd.value =
                    !newVariableController.isOpenNewPassowrd.value;
              },
              child: SvgPicture.asset(
                newVariableController.isOpenNewPassowrd.isFalse
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
          border: UnderlineInputBorder(
            borderSide: errorPass == false
                ? const BorderSide(color: ColorResources.greyA0A, width: 1)
                : const BorderSide(color: Colors.red, width: 1),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: errorPass == false
                ? const BorderSide(color: ColorResources.greyA0A, width: 1)
                : const BorderSide(color: Colors.red, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: errorPass == false
                ? const BorderSide(color: ColorResources.greyA0A, width: 1)
                : const BorderSide(color: Colors.red, width: 1),
          ),
        ),
      );

  showAlertDialog1(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Confirm",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        resetPass();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Reset password"),
      content: const Text("Are you sure you want to reset your password?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool validateMyPass(String value) {
    Pattern pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$";
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value) &&
        newPasswordController.text.compareTo(confirmPasswordController.text) ==
            0) {
      print('Valid password');
      setState(() {
        errorPass = false;
      });
      return true;
    } else {
      print("Enter Valid password");
      setState(() {
        errorPass = true;
      });
      return false;
    }
  }

  void resetPass() {
    var newPassword = new DBCrypt()
        .hashpw(confirmPasswordController.text, new DBCrypt().gensalt());
    DBConnection.resetPassword(role3, patientId, newPassword);
  }

  Future<void> checkPass() async {
    String c = await DBConnection.checkOldPass(role3, patientId);
    //print(oldpass);
    // print(c);
    var isCorrect = new DBCrypt().checkpw(currentPasswordController.text, c);
    if (isCorrect) {
      setState(() {
        errorCurrentPass = false;
      });
    } else {
      setState(() {
        errorCurrentPass = true;
      });
    }
    if (errorCurrentPass == false && errorPass == false) {
      showAlertDialog1(context);
    }
  }
}
