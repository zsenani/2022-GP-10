import 'package:medcore/AuthScreens/signin_screen.dart';
import 'package:medcore/Controller/variable_controller.dart';
import 'package:medcore/LabScreens/edit_profile_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:medcore/AuthScreens/reset_password_screen';
import 'package:get/get.dart';

class LabProfilePage extends StatefulWidget {
  // SettingScreen({Key? key}) : super(key: key);
  static const routeName = '/lab-profile-screen';

  @override
  State<LabProfilePage> createState() => _LabProfilePageState();
}

class _LabProfilePageState extends State<LabProfilePage> {
  final VariableController variableController = Get.put(VariableController());

  String selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF7F,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //HeaderWidget
          HeaderWidget(),

          const SizedBox(height: 80),
          //ColumnListTileWidget
          ColumnListTileWidget(),
        ],
      ),
    );
  }

  Widget HeaderWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 165,
          width: Get.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: Color.fromRGBO(19, 156, 140, 1),
          ),
          child: Center(
            child: mediumText("Profile", ColorResources.white, 24),
          ),
        ),
        Positioned(
          bottom: -45,
          left: 24,
          right: 24,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorResources.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
              child: ListTile(
                title: heavyText("Name: John Doe",
                    const Color.fromRGBO(19, 156, 140, 1), 24),
                trailing: InkWell(
                    onTap: () {
                      Get.to(EditProfileScreen());
                    },
                    child: Image.asset('assets/images/edit.png',
                        height: 25, width: 25)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ColumnListTileWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset('assets/images/employee.png',
                      height: 30, width: 30),
                  title: romanText("Lab ID:", ColorResources.grey777, 20),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      romanText("23826", ColorResources.grey777, 20),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset('assets/images/location-pin.png',
                      height: 30, width: 30),
                  title: romanText("Adress: ", ColorResources.grey777, 20),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      romanText(
                          "Saudi Arabia,Riyadh", ColorResources.grey777, 16),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset('assets/images/email.png',
                      height: 30, width: 30),
                  title: romanText("E-mail:", ColorResources.grey777, 20),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      romanText(
                          "johndoe@gmail.com", ColorResources.grey777, 16),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 10),
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   leading: Image.asset(Images.help, height: 50, width: 50),
                //   title: romanText("Help", ColorResources.grey777, 16),
                //   trailing: Icon(Icons.arrow_forward_ios,
                //       color: ColorResources.grey777.withOpacity(0.3),
                //       size: 16),
                // ),
                TextButton(
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    Get.to(ResetPasswordScreen());
                  },
                ),
                const SizedBox(height: 80),
                InkWell(
                  child: Container(
                    height: 55,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 242, 29, 29),
                          width: 1),
                      color: const Color.fromARGB(255, 242, 29, 29),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        romanText("Logout", ColorResources.white, 16),
                      ],
                    ),
                  ),
                  onTap: () {
                    showAlertDialog2(context);
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog2(BuildContext context) {
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
      "Yes",
      style: TextStyle(
        fontSize: 15,
      ),
    ),
    onPressed: () {
      Get.to(SignInScreen());
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Logout"),
    content: const Text("Are you sure you want to logout?"),
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
