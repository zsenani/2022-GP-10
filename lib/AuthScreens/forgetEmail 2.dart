import 'package:get/get.dart';
import 'package:medcore/AuthScreens/otp.dart';
import 'package:medcore/AuthScreens/signup_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:medcore/database/mysqlDatabase.dart';
import 'package:medcore/index.dart';
import '../Controller/role_location_controller.dart';
import '../Utiils/text_font_family.dart';
import 'forgot_password_screen.dart';

final TextEditingController emailController = TextEditingController();
var totalLength = 0;
var mail;
String role2;
bool errorRoleSelect = false;

class ForgetEmail extends StatefulWidget {
  String role;
  ForgetEmail({Key key, @required this.role}) : super(key: key) {
    role = role;
    role2 = role;
    errorRoleSelect = false;
  }

  static const routeName = '/forgot-password-screen';

  @override
  State<ForgetEmail> createState() => _ForgetEmailState();
}

class _ForgetEmailState extends State<ForgetEmail> {
  static final formKey = GlobalKey<FormState>();

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
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorResources.whiteF6F,
        appBar: AppBar(
          backgroundColor: ColorResources.whiteF6F,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(7),
            child: InkWell(
              onTap: () {
                emailController.clear();
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
                  emailController.clear();
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
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                heavyText("Forgot password", ColorResources.green009, 24),
                const SizedBox(height: 15),
                if (widget.role != 'patient')
                  bookText(
                      "Please enter your role and email below to receive your OTP number.",
                      ColorResources.greyA0A,
                      16),
                if (widget.role == 'patient')
                  bookText(
                      "Please enter your email below to receive your OTP number.",
                      ColorResources.greyA0A,
                      16),
                const SizedBox(height: 50),
                if (widget.role != 'patient')
                  Row(
                    children: [
                      const Icon(
                        Icons.group_outlined,
                        color: ColorResources.orange,
                      ),
                      const SizedBox(width: 15),
                      mediumText("Role", ColorResources.grey777, 16),
                    ],
                  ),
                if (widget.role != 'patient')
                  FormField(
                    builder: (FormFieldState<String> state) => InputDecorator(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 10, 20, 20),
                        border: UnderlineInputBorder(
                          borderSide: errorRoleSelect == false
                              ? const BorderSide(
                                  color: ColorResources.greyA0A, width: 1)
                              : const BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: errorRoleSelect == false
                              ? const BorderSide(
                                  color: ColorResources.greyA0A, width: 1)
                              : const BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: errorRoleSelect == false
                              ? const BorderSide(
                                  color: ColorResources.greyA0A, width: 1)
                              : const BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: GetBuilder<RoleLocationController>(
                        init: RoleLocationController(),
                        builder: (controller) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: RolelocationController.selectedValue,
                              items: RolelocationController.role.map((element) {
                                return DropdownMenuItem<String>(
                                  child: Text(element),
                                  value: element,
                                );
                              }).toList(),
                              hint: const Text("Select your role"),
                              style: TextStyle(
                                color: ColorResources.black,
                                fontSize: 16,
                                fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                              ),
                              isExpanded: true,
                              isDense: true,
                              onChanged: (newValue) {
                                RolelocationController.setSelected(
                                    newValue.toString());
                                role2 = newValue.toString();
                                print(role2);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
                if (errorRoleSelect == true && role2 != "patient")
                  mediumText(
                      "  please select your role first ", Colors.red, 16),
                const SizedBox(
                  height: 16,
                ),
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
                  checkRole();
                  checkEmail();
                  // emailController.clear();
                }, "Send OTP", ColorResources.green009, ColorResources.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkRole() {
    if (role2 != "Physician" || role2 != "Lab specialist") {
      setState(() {
        errorRoleSelect = true;
      });
    } else {
      setState(() {
        errorRoleSelect = false;
      });
    }
  }

  static var mail = emailController.text;
  Future<void> checkEmail() async {
    String emailC =
        await mysqlDatabase.checkEmailExsist(role2, emailController.text);
    print(emailC);
    if (emailC == null) {
      showAlertDialog(context);
    } else {
      Get.to(ForgotPasswordScreen(role1: role2, email: emailController.text));
      //sendOtp(emailController.text);
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
