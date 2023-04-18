import 'package:dbcrypt/dbcrypt.dart';
import 'package:medcore/AuthScreens/forgetEmail.dart';
import 'package:medcore/AuthScreens/signin_screen.dart';
import 'package:medcore/Controller/variable_controller.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import 'package:medcore/index.dart';

String email2;

class ChangePasswordScreen extends StatefulWidget {
  String role;

  ChangePasswordScreen({Key key, String role1, String email})
      : super(key: key) {
    role = role1;
    email2 = email;
  }
  static const routeName = '/change-password-screen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

bool _isVisiblePassword = false;
bool _isVisiblleConfirmPassword = false;

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  //static final formKey = GlobalKey<FormState>();

  final VariableController variableController = Get.put(VariableController());

  void updatePasswordStatus(who) {
    if (who == 'password') {
      setState(() {
        _isVisiblePassword = !_isVisiblePassword;
      });
    } else if (who == 'confirmPassword') {
      setState(() {
        _isVisiblleConfirmPassword = !_isVisiblleConfirmPassword;
      });
    }
  }

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
              child: const SizedBox(
                height: 40,
                width: 40,
                child: Icon(Icons.home_outlined, color: ColorResources.grey777),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
        child: Form(
          //  key: formKey,
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
              TextFormField(
                keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: _isVisiblePassword ? false : true,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: errorPass == false
                        ? const BorderSide(
                            color: ColorResources.greyA0A, width: 1)
                        : const BorderSide(color: Colors.red, width: 1),
                  ),
                  hintText: "Enter your new password",
                  suffixIcon: IconButton(
                    onPressed: () => updatePasswordStatus("password"),
                    icon: Icon(_isVisiblePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
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
              TextFormField(
                keyboardType: TextInputType.text,
                controller: confirmPasswordController,
                obscureText: _isVisiblleConfirmPassword ? false : true,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: passwordController.text ==
                            confirmPasswordController.text
                        ? const BorderSide(
                            color: ColorResources.greyA0A, width: 1)
                        : const BorderSide(color: Colors.red, width: 1),
                  ),
                  hintText: "Enter your new password again",
                  suffixIcon: IconButton(
                    onPressed: () => updatePasswordStatus("confirmPassword"),
                    icon: Icon(_isVisiblleConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
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
                    // print(widget.role);
                    // updatePass();
                    showAlertDialog9(context);
                    // Get.to(SignInScreen(
                    //   role: widget.role,
                    // ));
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

  bool errorPass = false;

  bool validateMyPass(String value) {
    Pattern pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$";

    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value) &&
        passwordController.text == confirmPasswordController.text) {
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

  showAlertDialog9(BuildContext context) {
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
        updatePass();
        Get.to(SignInScreen(
          role: widget.role,
        ));
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

  void updatePass() async {
    // var x = ForgetEmail.
    var passHash = new DBCrypt()
        .hashpw(confirmPasswordController.text, new DBCrypt().gensalt());
    print("email ff=");
    print(mail);
    mysqlDatabase.resetPassword(widget.role, email2, passHash, "email");
  }
}
