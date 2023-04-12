import 'package:medcore/AuthScreens/signin_screen.dart';
import 'package:medcore/Controller/variable_controller.dart';
import 'package:medcore/Patient-PhysicianScreens/patient_home_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/AuthScreens/reset_password_screen.dart';
import '../database/mysqlDatabase.dart';
import 'edit_patient_profile.dart';

String Id;
bool loading = true;

class patientProfilePage extends StatefulWidget {
  patientProfilePage({Key key, String id}) : super(key: key) {
    Id = id;
  }

  @override
  State<patientProfilePage> createState() => _patientProfilePage();
}

class _patientProfilePage extends State<patientProfilePage> {
  final VariableController variableController = Get.put(VariableController());

  String selectedValue = "";
  ////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    getPatientProfileData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPatientProfileData();
  }

  void getPatientProfileData() async {
    var name = await conn
        .query('select name from Patient where NationalID=?', [int.parse(Id)]);
    for (var row in name) {
      setState(() {
        Pname = '${row[0]}';
      });
    }
    var email = await conn
        .query('select email from Patient where NationalID=?', [int.parse(Id)]);
    for (var row in email) {
      setState(() {
        Pemail = '${row[0]}';
      });
    }
    var phone = await conn.query(
        'select mobileNo from Patient where NationalID=?', [int.parse(Id)]);
    for (var row in phone) {
      setState(() {
        PmobileNo = '${row[0]}';
      });
    }

    setState(() {
      loading = false;
    });
  }

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

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
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
                title: heavyText("Name: " + Pname,
                    const Color.fromRGBO(19, 156, 140, 1), 24),
                trailing: InkWell(
                  onTap: () async {
                    loading = true;
                    String refresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPatientProfile(
                                  id: Id,
                                )));
                    if (refresh == 'refresh') {
                      getPatientProfileData();
                    }
                  },
                  child: Image.asset('assets/images/edit.png',
                      height: 25, width: 25),
                ),
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
            child: loading
                ? loadingPage()
                : Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset('assets/images/employee.png',
                            height: 30, width: 30),
                        title: romanText("ID:", ColorResources.grey777, 20),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            romanText(PnationalID, ColorResources.grey777, 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset('assets/images/DOB.png',
                            height: 30, width: 30),
                        title: romanText(
                            "Date of birth: ", ColorResources.grey777, 20),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            romanText(PDOB, ColorResources.grey777, 20),
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
                            romanText(Pemail, ColorResources.grey777, 16),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.phone,
                            color: Color.fromRGBO(241, 94, 34, 0.7), size: 30),
                        title: romanText(
                            "Phone Number: ", ColorResources.grey777, 20),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            romanText(
                                '0' + PmobileNo, ColorResources.grey777, 16),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset('assets/images/gender.png',
                            height: 30, width: 30),
                        title: romanText("Gender:", ColorResources.grey777, 20),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            romanText(Pgender, ColorResources.grey777, 20),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () async {
                          Get.to(ResetPasswordScreen(id: Id, role: "patient"));
                        },
                      ),
                      const SizedBox(height: 10),
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(
            role: 'patient',
          ),
        ),
      );
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
