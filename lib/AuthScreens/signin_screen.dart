import 'package:medcore/AuthScreens/forgot_password_screen.dart';
import 'package:medcore/Controller/variable_controller.dart';

import 'package:medcore/LabScreens/lab_home_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medcore/AuthScreens/signup_screen.dart';
import 'package:medcore/Controller/role_location_controller.dart';
import 'package:medcore/index.dart';

class SignInScreen extends StatelessWidget {
  String role;
  SignInScreen({Key key, @required this.role}) : super(key: key);
  static const routeName = '/signin-screen';

  final TextEditingController idController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final RoleLocationController RolelocationController =
      Get.put(RoleLocationController());
  final formKey = GlobalKey<FormState>();

  final VariableController variableController = Get.put(VariableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 251, 251, 1),
        // backgroundColor: Color.fromRGBO(244, 251, 251, 1),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(7),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(index.routeName);
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
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (role != 'patient')
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
                            if (role != 'patient')
                              FormField(
                                builder: (FormFieldState<String> state) =>
                                    InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        12, 10, 20, 20),
                                    border: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 2),
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
                                            color: ColorResources.greyA0A,
                                            fontSize: 16,
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_BOOK,
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            RolelocationController.setSelected(
                                                newValue.toString());
                                            role = newValue.toString();
                                            print(role);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const Icon(Icons.perm_identity,
                                    color: ColorResources.orange),
                                const SizedBox(width: 15),
                                mediumText("Citizen ID/ Resident ID",
                                    ColorResources.grey777, 16),
                              ],
                            ),
                            textField1(
                                "Enter ID", idController, TextInputType.number),
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
                            Obx(
                              () => TextFormField(
                                cursorColor: ColorResources.black,
                                obscureText:
                                    variableController.isOpenLogIn.value,
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
                                        variableController.isOpenLogIn.value =
                                            !variableController
                                                .isOpenLogIn.value;
                                      },
                                      child: SvgPicture.asset(
                                        variableController.isOpenLogIn.isFalse
                                            ? Images.visibilityOnIcon
                                            : Images.visibilityOffIcon,
                                      ),
                                    ),
                                  ),
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(
                                    color: ColorResources.grey777,
                                    fontSize: 16,
                                    fontFamily:
                                        TextFontFamily.AVENIR_LT_PRO_BOOK,
                                  ),
                                  filled: true,
                                  fillColor: ColorResources.whiteF6F,
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorResources.greyA0A,
                                        width: 1),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorResources.greyA0A,
                                        width: 1),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorResources.greyA0A,
                                        width: 1),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen(
                                        role: role,
                                      ),
                                    ),
                                  );
                                },
                                child: heavyText("Forgot password?",
                                    ColorResources.greyA0A, 14),
                              ),
                            ),
                            const SizedBox(height: 40),
                            commonButton(() {
                              if (RolelocationController.selectedValue ==
                                  'Lab specialist') {
                                Get.to(LabHomePage1());
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
                                    if (role == 'hospital') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUpScreen(
                                              role: role,
                                            ),
                                          ));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUpScreen(
                                              role: role,
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
}
