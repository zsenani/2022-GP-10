import 'package:dbcrypt/dbcrypt.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Controller/variable_controller.dart';

String patientId;
String role3;
bool errorPass = false;
bool errorCurrentPass = false;
bool errorEq = false;
bool errorEqOld = false;

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key key, String id, String role}) : super(key: key) {
    patientId = id;
    role3 = role;
  }

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

bool _isVisiblePassword = false;
bool _isVisiblleConfirmPassword = false;
bool _isVisibleCurrentPass = false;

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

  void updatePasswordStatus(who) {
    if (who == 'password') {
      setState(() {
        _isVisiblePassword = !_isVisiblePassword;
      });
    } else if (who == 'confirmPassword') {
      setState(() {
        _isVisiblleConfirmPassword = !_isVisiblleConfirmPassword;
      });
    } else if (who == 'currentPassword') {
      setState(() {
        _isVisibleCurrentPass = !_isVisibleCurrentPass;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
              child: const SizedBox(
                height: 40,
                width: 40,
                child: Center(
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
                      mediumText(
                          "Current password", ColorResources.grey777, 16),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: currentPasswordController,
                    obscureText: _isVisibleCurrentPass ? false : true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: errorCurrentPass == false
                            ? const BorderSide(
                                color: ColorResources.greyA0A, width: 1)
                            : const BorderSide(color: Colors.red, width: 1),
                      ),
                      hintText: "Enter your current password",
                      suffixIcon: IconButton(
                        onPressed: () =>
                            updatePasswordStatus("currentPassword"),
                        icon: Icon(_isVisibleCurrentPass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (errorCurrentPass == true)
                    Padding(
                      padding: const EdgeInsets.only(right: 225),
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
                      padding: const EdgeInsets.only(right: 30),
                      child: mediumText(
                          "Password should be at least 8 characters one uppercase, lowercase characters, one digit and special character",
                          Colors.red,
                          15),
                    ),
                  if (errorEq == true)
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: mediumText(
                          "new password and the confirmation password doesn't match",
                          Colors.red,
                          16),
                    ),
                  if (errorEqOld == true)
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: mediumText(
                          "New password and the Old password are matching",
                          Colors.red,
                          16),
                    ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.lock_outlined,
                        color: ColorResources.orange,
                      ),
                      const SizedBox(width: 15),
                      mediumText(
                          "Confirm password", ColorResources.grey777, 16),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: confirmPasswordController,
                    obscureText: _isVisiblleConfirmPassword ? false : true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: errorEq == false && errorEqOld == false
                            ? const BorderSide(
                                color: ColorResources.greyA0A, width: 1)
                            : const BorderSide(color: Colors.red, width: 1),
                      ),
                      hintText: "Enter your new password again",
                      suffixIcon: IconButton(
                        onPressed: () =>
                            updatePasswordStatus("confirmPassword"),
                        icon: Icon(_isVisiblleConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  commonButton(() {
                    checkEq();
                    validateMyPass(newPasswordController.text);
                    checkPass();
                    // print(errorCurrentPass);
                  }, "Reset", ColorResources.green009, ColorResources.white),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  passValidator() => TextFormField(
        keyboardType: TextInputType.text,
        controller: newPasswordController,
        obscureText: _isVisiblePassword ? false : true,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide:
                errorPass == false && errorEq == false && errorEqOld == false
                    ? const BorderSide(color: ColorResources.greyA0A, width: 1)
                    : const BorderSide(color: Colors.red, width: 1),
          ),
          hintText: "Enter your new password",
          suffixIcon: IconButton(
            onPressed: () => updatePasswordStatus("password"),
            icon: Icon(
                _isVisiblePassword ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      );
  void checkEq() {
    if (newPasswordController.text == confirmPasswordController.text) {
      setState(() {
        errorEq = false;
      });
    } else {
      setState(() {
        errorEq = true;
      });
    }
    if (currentPasswordController.text == newPasswordController.text) {
      setState(() {
        errorEqOld = true;
      });
    } else {
      setState(() {
        errorEqOld = false;
      });
    }
  }

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
    if (regex.hasMatch(value)) {
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
    mysqlDatabase.resetPassword(role3, patientId, newPassword, "nationalID");
  }

  Future<void> checkPass() async {
    var c = await mysqlDatabase.checkOldPass(role3, patientId);
    print("type");
    print(c.runtimeType);
    print(c.toString());
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
    if (errorCurrentPass == false &&
        errorPass == false &&
        errorEq == false &&
        errorEqOld == false) {
      showAlertDialog1(context);
    }
  }
}
