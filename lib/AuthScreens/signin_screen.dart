import 'package:flutter/services.dart';
import 'package:medcore/AuthScreens/forgetEmail.dart';
import 'package:medcore/AuthScreens/otp.dart';
import 'package:medcore/Controller/variable_controller.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/AuthScreens/signup_screen.dart';
import 'package:medcore/Controller/role_location_controller.dart';
import 'package:medcore/index.dart';
import '../database/mysqlDatabase.dart';
import 'otpLogIn.dart';

bool errorRoleSelect = false;

class SignInScreen extends StatefulWidget {
  String role;

  SignInScreen({Key key, @required this.role}) : super(key: key);

  static const routeName = '/signin-screen';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String role;

  bool error = false;
  bool errorPassword = false;
  bool errorID = false;
  bool _isVisiblePassword = false;

  final TextEditingController idController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //static final formKey = GlobalKey<FormState>();

  final VariableController variableController = Get.put(VariableController());
  updatePasswordStatus() {
    setState(() {
      _isVisiblePassword = !_isVisiblePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 251, 251, 1),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(index.routeName);
            },
            child: const Icon(Icons.arrow_back, color: ColorResources.grey777),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.authScreenBackGroundImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 80),
                      child: Form(
                        // key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.role != 'patient')
                              if (error)
                                mediumText("Username or Password incorrect!",
                                    Colors.red, 16),
                            if (widget.role != 'patient')
                              const SizedBox(height: 10),
                            if (widget.role != 'patient')
                              Row(
                                children: [
                                  const Icon(
                                    Icons.group_outlined,
                                    color: ColorResources.orange,
                                  ),
                                  const SizedBox(width: 15),
                                  mediumText(
                                      "Role", ColorResources.grey777, 16),
                                ],
                              ),
                            if (widget.role != 'patient')
                              FormField(
                                builder: (FormFieldState<String> state) =>
                                    InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        12, 10, 20, 20),
                                    border: UnderlineInputBorder(
                                      borderSide: errorRoleSelect == false
                                          ? const BorderSide(
                                              color: ColorResources.greyA0A,
                                              width: 1)
                                          : const BorderSide(
                                              color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: errorRoleSelect == false
                                          ? const BorderSide(
                                              color: ColorResources.greyA0A,
                                              width: 1)
                                          : const BorderSide(
                                              color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: errorRoleSelect == false
                                          ? const BorderSide(
                                              color: ColorResources.greyA0A,
                                              width: 1)
                                          : const BorderSide(
                                              color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: GetBuilder<RoleLocationController>(
                                    init: RoleLocationController(),
                                    builder: (controller) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: RolelocationController
                                              .selectedValue,
                                          items: RolelocationController.role
                                              .map((element) {
                                            return DropdownMenuItem<String>(
                                              child: Text(element),
                                              value: element,
                                            );
                                          }).toList(),
                                          hint: const Text("Select your role"),
                                          style: TextStyle(
                                            color: ColorResources.black,
                                            fontSize: 16,
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_BOOK,
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            RolelocationController.setSelected(
                                                newValue.toString());
                                            widget.role = newValue.toString();
                                            print(widget.role);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            const SizedBox(height: 5),
                            if (errorRoleSelect == true &&
                                widget.role != "patient")
                              mediumText(
                                  "  please select your role ", Colors.red, 16),
                            const SizedBox(height: 30),

                            if (widget.role == 'patient')
                              if (error)
                                mediumText("Username or Password incorrect",
                                    Colors.red, 16),
                            if (widget.role == 'patient')
                              const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.perm_identity,
                                    color: ColorResources.orange),
                                const SizedBox(width: 15),
                                mediumText("Citizen ID/ Resident ID",
                                    ColorResources.grey777, 16),
                              ],
                            ),
                            // textField1(
                            //     "Enter ID", idController, TextInputType.number),
                            TextFormField(
                              controller: idController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter ID",
                                hintStyle: TextStyle(
                                  color: ColorResources.grey777,
                                  fontSize: 16,
                                  fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                                ),
                                filled: true,
                                fillColor: ColorResources.whiteF6F,
                                border: UnderlineInputBorder(
                                  borderSide: errorID == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorID == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: errorID == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            if (errorID)
                              mediumText(
                                  "  Please enter your ID", Colors.red, 16),

                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const Icon(
                                  Icons.lock_outlined,
                                  color: ColorResources.orange,
                                ),
                                const SizedBox(width: 15),
                                mediumText(
                                    "Password", ColorResources.grey777, 16),
                              ],
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obscureText: _isVisiblePassword ? false : true,
                              decoration: InputDecoration(
                                hintText: " Enter password",
                                contentPadding:
                                    const EdgeInsets.only(top: 15, left: 12),
                                suffixIcon: IconButton(
                                  onPressed: () => updatePasswordStatus(),
                                  icon: Icon(_isVisiblePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  color: ColorResources.grey9AA,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: errorPassword == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorPassword == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: errorPassword == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            if (errorPassword)
                              mediumText("  Please enter your Password",
                                  Colors.red, 16),

                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  Get.to(ForgetEmail(role: widget.role));
                                },
                                child: heavyText("Forgot password?",
                                    ColorResources.greyA0A, 14),
                              ),
                            ),

                            const SizedBox(height: 40),
                            commonButton(() {
                              if (passwordController.text != '' &&
                                  idController.text != '' &&
                                  widget.role != "hospital") {
                                setState(() {
                                  errorRoleSelect = false;
                                  errorPassword = false;
                                  errorID = false;
                                });
                              }

                              if (passwordController.text == '' &&
                                  idController.text == '' &&
                                  widget.role == "hospital") {
                                setState(() {
                                  errorRoleSelect = true;
                                  errorPassword = true;
                                  errorID = true;
                                });
                              } else if (passwordController.text == '' &&
                                  idController.text == '' &&
                                  widget.role != "hospital") {
                                setState(() {
                                  errorRoleSelect = false;
                                  errorPassword = true;
                                  errorID = true;
                                });
                              } else if (passwordController.text != '' &&
                                  idController.text == '' &&
                                  widget.role != "hospital") {
                                setState(() {
                                  errorRoleSelect = false;
                                  errorPassword = false;
                                  errorID = true;
                                });
                              } else if (passwordController.text == '' &&
                                  idController.text != '' &&
                                  widget.role != "hospital") {
                                setState(() {
                                  errorRoleSelect = false;
                                  errorPassword = true;
                                  errorID = false;
                                });
                              } else if (passwordController.text == '' &&
                                  idController.text == '' &&
                                  widget.role == "hospital") {
                                setState(() {
                                  errorRoleSelect = true;
                                  errorPassword = true;
                                  errorID = true;
                                });
                              } else if (passwordController.text != '' &&
                                  idController.text == '' &&
                                  widget.role == "hospital") {
                                setState(() {
                                  errorRoleSelect = true;
                                  errorPassword = false;
                                  errorID = true;
                                });
                              } else if (passwordController.text == '' &&
                                  idController.text != '' &&
                                  widget.role == "hospital") {
                                setState(() {
                                  errorRoleSelect = true;
                                  errorPassword = true;
                                  errorID = false;
                                });
                              } else if (passwordController.text != '' &&
                                  idController.text != '' &&
                                  widget.role == "hospital") {
                                setState(() {
                                  errorRoleSelect = true;
                                  errorPassword = false;
                                  errorID = false;
                                });
                              } else if (widget.role == 'Lab specialist') {
                                AuthlogIn1("Lab specialist", idController,
                                    passwordController);
                              } else if (widget.role == 'Physician') {
                                AuthlogIn1("Physician", idController,
                                    passwordController);
                              } else {
                                AuthlogIn1("patient", idController,
                                    passwordController);
                              }
                            }, "Sign In", ColorResources.green009,
                                ColorResources.white),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bookText("Don’t have an account?",
                                    ColorResources.grey777, 14),
                                InkWell(
                                  onTap: () {
                                    if (widget.role == 'hospital') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUpScreen(
                                              role: widget.role,
                                            ),
                                          ));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUpScreen(
                                              role: widget.role,
                                            ),
                                          ));
                                    }
                                  },
                                  child: mediumText(" Create New",
                                      ColorResources.green009, 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                Positioned(
                  top: 60,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundColor: ColorResources.white.withOpacity(0),
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        Center(
                          child: Image.asset(Images.medcoreLogo),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<State> AuthlogIn1(String role, TextEditingController idController,
      TextEditingController passwordController) async {
    //connect with table

    // bool errorAuth = await DBConnection.AuthlogIn(
    //     role, idController.text, passwordController.text);
    bool errorAuth = await mysqlDatabase.AuthlogIn(
        role, int.parse(idController.text), passwordController.text);
    if (!errorAuth) {
      setState(() {
        error = false;
      });
      // var email = await DBConnection.getEmail(role, idController.text);
      var email =
          await mysqlDatabase.getEmail(role, int.parse(idController.text));
      print(email);
      sendOtp(email);
      Get.to(
          otpLogInScreen(role: role, email: email, idController: idController));
    } else {
      setState(() {
        error = true;
      });
      print('Sorry user name or password not correct!!!');
    }
  }
}
