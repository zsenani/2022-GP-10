import 'dart:async';
import 'package:medcore/AuthScreens/forgetEmail.dart';
<<<<<<< HEAD
import 'package:medcore/AuthScreens/signin_screen.dart';
=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
import 'package:medcore/Controller/variable_controller.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/database/mongoDB.dart';
import 'package:medcore/mongoDBModel2.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:medcore/main.dart';
import 'package:medcore/Controller/role_location_controller.dart';
import 'package:medcore/Controller/hospital_location_controller.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../LabScreens/lab_home_screen.dart';
import '../Patient-PhysicianScreens/home_screen.dart';
import '../Patient-PhysicianScreens/patient_home_screen.dart';
import '../database/mongoDB.dart';
import '../MongoDBModel.dart';
import '../database/mongoDB.dart';
import '../mongoDBModel3.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'otp.dart';
//import 'package:async/async.dart';

class SignUpScreen extends StatefulWidget {
  String role;

  SignUpScreen({Key key, @required this.role}) : super(key: key);
  static const routeName = '/signup-screen';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState(role);
}

class _SignUpScreenState extends State<SignUpScreen> {
  String role;
  var counterValid = 0;
  _SignUpScreenState(this.role);
  int currentStep = 0;
  var hashedPassword;

<<<<<<< HEAD
  DateTime pselectedDate = DateTime.now();
  DateTime plselectedDate = DateTime(
      DateTime.now().year - 20, DateTime.now().month, DateTime.now().day);
  DateTime selectedDate;
  DateTime picked;
  Future<void> selectDate(BuildContext context) async {
    if (role == 'patient') {
      picked = await showDatePicker(
          context: context,
          initialDate: pselectedDate,
          firstDate: DateTime(1900, 8),
          lastDate: DateTime.now());
    } else {
      picked = await showDatePicker(
          context: context,
          initialDate: plselectedDate,
          firstDate: DateTime(1900, 8),
          lastDate: DateTime(DateTime.now().year - 20, DateTime.now().month,
              DateTime.now().day));
    }

    if (role == 'patient' && picked != null && picked != pselectedDate) {
      setState(() {
        selectedDate = picked;
      });
    } else if (role != 'patient' &&
        picked != null &&
        picked != plselectedDate) {
=======
  DateTime selectedDate = DateTime.now();
  DateTime picked;
  Future<void> selectDate(BuildContext context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final formKey = GlobalKey<FormState>();
  final VariableController variableController = Get.put(VariableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, const Color.fromRGBO(244, 251, 251, 1)),
      body: Theme(
        data: ThemeData(
          canvasColor: const Color.fromRGBO(244, 251, 251, 1),
          colorScheme: Theme.of(context).colorScheme.copyWith(),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          onStepTapped: (int step) {
            if (step < currentStep) {
              setState(() => currentStep = step);
            }
          },
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            final isSecondStep = currentStep == getSteps().length - 2;
            if (isLastStep) {
              print('Completed');
              //Sent data to server
            } else if (isSecondStep) {
              checkSecond();
            } else {
              GenderlocationController.text = "select your gender";

              checkFirst();
            }
          },
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;
            final isSecondStep = currentStep == getSteps().length - 2;

            return Row(
              children: <Widget>[
                if (currentStep != 0 && currentStep != 2)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('BACK'),
                    ),
                  ),
                if (currentStep != 0 && currentStep != 2)
                  const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLastStep
                        ? role == "patient"
                            ? () => Patient()
                            : RolelocationController.selectedValue ==
                                    'Physician'
                                ? () => Physician()
                                : () => Lab()
                        : details.onStepContinue,
                    child: Text(isLastStep ? 'Verify' : 'NEXT'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text(''),
          content: FirstStep(context, selectedDate, selectDate),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(''),
          content: SecondStep(context),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text(''),
          content: otpMail(
            emailController2: emailController.text,
            role2: role,
          ),
        ),
      ];

  void Patient() {
    verifyOtp(emailController.text, context);
<<<<<<< HEAD
    pinPutController.clear();
=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
    if (validateOTP == true) {
      _insertDataPatient(
        nameController.text,
        hashedPassword = new DBCrypt()
            .hashpw(confirmPasswordController.text, new DBCrypt().gensalt()),
        "${selectedDate.toLocal()}".split(' ')[0],
        GenderlocationController.text,
        phoneController.text,
        confirmEmailController.text,
        nationalityController.text,
        maritalStatusController.text,
        IDController.text,
      );

<<<<<<< HEAD
      Get.to(SignInScreen(role: "patient"));
=======
      Get.to(PatientHomeScreen(), arguments: 'patient');
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
    }
  }

  void Physician() {
    verifyOtp(emailController.text, context);
<<<<<<< HEAD
    pinPutController.clear();
=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
    if (validateOTP == true && addedHospitals == true) {
      _insertDataPhysician(
          nameController.text,
          hashedPassword = new DBCrypt()
              .hashpw(confirmPasswordController.text, new DBCrypt().gensalt()),
          "${selectedDate.toLocal()}".split(' ')[0],
          GenderlocationController.text,
          phoneController.text,
          confirmEmailController.text,
          nationalityController.text,
          specializationController.text,
          IDController.text,
          IDOfHospitals);

<<<<<<< HEAD
      Get.to(SignInScreen(role: "hospital"));
=======
      Get.to(HomeScreen());
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
    }
  }

  void Lab() {
    verifyOtp(emailController.text, context);
<<<<<<< HEAD
    pinPutController.clear();
=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
    if (validateOTP == true) {
      _insertDataLab(
        nameController.text,
        hashedPassword = new DBCrypt()
            .hashpw(confirmPasswordController.text, new DBCrypt().gensalt()),
        "${selectedDate.toLocal()}".split(' ')[0],
        GenderlocationController.text,
        phoneController.text,
        confirmEmailController.text,
        nationalityController.text,
        IDController.text,
        hospital,
      );

<<<<<<< HEAD
      Get.to(SignInScreen(role: "hospital"));
=======
      Get.to(LabHomePage1());
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
    }
  }

  Future<void> _insertDataPhysician(
    String pname,
    String ppassword,
    String pdob,
    String pgender,
    String pmobileNo,
    String pemail,
    String pnationality,
    String pspecialization,
    String pnationalId,
    List<String> phospitals,
  ) async {
    var _id = M.ObjectId();
    final data = Welcome(
      id: _id,
      name: pname,
      password: ppassword,
      dob: pdob,
      gender: pgender,
      mobileNo: number + pmobileNo,
      email: pemail,
      nationality: pnationality,
      specialization: pspecialization,
      nationalId: pnationalId,
      hospitals: phospitals,
    );

    var result =
        await DBConnection.insertPhysician(data, phospitals, pnationalId);
    _clearAll();
  }

  void _clearAll() {
    nameController.text = "";
    IDController.text = "";
    confirmEmailController.text = "";
    nationalityController.text = "";
    GenderlocationController.text = "";
    specializationController.text = "";
    phoneController.text = "";
    confirmPasswordController.text = "";
    emailController.text = "";
    passwordController.text = "";
    selectedDate = null;
    hospitals = null;
    IDOfHospitals = null;
<<<<<<< HEAD
    picked = null;
=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
  }

  Future<void> _insertDataPatient(
    String fname,
    String fpassword,
    String fdob,
    String fgender,
    String fmobileNo,
    String femail,
    String fnationality,
    String fmaritalStatus,
    String fnationalId,
  ) async {
    var _id = M.ObjectId();
    final data = Welcome2(
      id: _id,
      name: fname,
      password: fpassword,
      dob: fdob,
      gender: fgender,
      mobileNo: number + fmobileNo,
      email: femail,
      nationality: fnationality,
      maritalStatus: fmaritalStatus,
      nationalId: fnationalId,
    );
    var result = await DBConnection.insertPatient(data);

    _clearAll2();
  }

  void _clearAll2() {
    nameController.text = "";
    IDController.text = "";
    confirmEmailController.text = "";
    nationalityController.text = "";
    GenderlocationController.text = "";
    phoneController.text = "";
    confirmPasswordController.text = "";
    emailController.text = "";
    passwordController.text = "";
    selectedDate = null;
    maritalStatusController.text = "";
<<<<<<< HEAD
    picked = null;
=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
  }

  Future<void> _insertDataLab(
    String lname,
    String lpassword,
    String ldob,
    String lgender,
    String lmobileNo,
    String lemail,
    String lnationality,
    String lnationalId,
    String lhospital,
  ) async {
    var _id = M.ObjectId();
    final data = Welcome3(
      id: _id,
      name: lname,
      password: lpassword,
      dob: ldob,
      gender: lgender,
      mobileNo: number + lmobileNo,
      email: lemail,
      nationality: lnationality,
      nationalId: lnationalId,
      hospital: lhospital,
    );
    var result = await DBConnection.insertLab(data, lnationalId);
    _clearAll3();
  }

  void _clearAll3() {
    nameController.text = "";
    IDController.text = "";
    confirmEmailController.text = "";
    nationalityController.text = "";
    GenderlocationController.text = "";
    phoneController.text = "";
    confirmPasswordController.text = "";
    emailController.text = "";
    passwordController.text = "";
    selectedDate = null;
    hospital = null;
<<<<<<< HEAD
    picked = null;
=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
  }

  TextEditingController IDController = TextEditingController();

  ScrollConfiguration FirstStep(context, selectedDate, selectDate) {
    final formKey = GlobalKey<FormState>();

    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 80),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_outline,
                                color: ColorResources.orange),
                            const SizedBox(width: 15),
                            mediumText("Citizen ID/ Resident ID",
                                ColorResources.grey777, 16),
                          ],
<<<<<<< HEAD
                        ),
                        textField1(
                            "Enter your ID", IDController, TextInputType.number,
                            error: errorID || errorID2),
                        const SizedBox(height: 5),
                        if (errorID == true)
                          mediumText("Enter a valid ID", Colors.red, 16),
                        if (errorID2 == true)
                          mediumText("ID Already used", Colors.red, 16),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined,
                                color: ColorResources.orange),
                            const SizedBox(width: 15),
                            mediumText(
                                "Date of birth", ColorResources.grey777, 16),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => selectDate(context),
                          child: role == 'patient'
                              ? Text(
                                  "${pselectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(
                                    color: ColorResources.grey777,
                                    fontSize: 16,
                                    fontFamily:
                                        TextFontFamily.AVENIR_LT_PRO_BOOK,
                                  ),
                                )
                              : Text(
                                  "${plselectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(
                                    color: ColorResources.grey777,
                                    fontSize: 16,
                                    fontFamily:
                                        TextFontFamily.AVENIR_LT_PRO_BOOK,
                                  ),
                                ),
                        ),
=======
                        ),
                        textField1(
                            "Enter your ID", IDController, TextInputType.number,
                            error: errorID || errorID2),
                        const SizedBox(height: 5),
                        if (errorID == true)
                          mediumText("Enter a valid ID", Colors.red, 16),
                        if (errorID2 == true)
                          mediumText("ID Already used", Colors.red, 16),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined,
                                color: ColorResources.orange),
                            const SizedBox(width: 15),
                            mediumText(
                                "Date of birth", ColorResources.grey777, 16),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => selectDate(context),
                          child: Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(
                              color: ColorResources.grey777,
                              fontSize: 16,
                              fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                            ),
                          ),
                        ),
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                        Divider(
                          color: errorDate == false
                              ? Colors.black.withOpacity(0.4)
                              : Colors.red,
                          indent: 0,
                          thickness: 1,
                        ),
                        const SizedBox(height: 5),
                        if (errorDate == true)
                          mediumText("Enter a valid DOB", Colors.red, 16),
                        const SizedBox(height: 20),
                        if (role != 'patient')
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
                        if (role != 'patient')
                          FormField(
                            builder: (FormFieldState<String> state) =>
                                InputDecorator(
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(12, 10, 20, 20),
                                border: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorResources.greyA0A, width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorResources.greyA0A, width: 2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorRole == false
                                      ? BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : BorderSide(color: Colors.red, width: 1),
                                ),
                              ),
                              child: GetBuilder<RoleLocationController>(
                                init: RoleLocationController(),
                                builder: (controller) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value:
                                          RolelocationController.selectedValue,
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
                                        fontFamily:
                                            TextFontFamily.AVENIR_LT_PRO_BOOK,
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
                        const SizedBox(height: 5),
                        if (errorRole == true)
                          mediumText("Enter a valid role", Colors.red, 16),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool errorPhone = false;
  bool errorID = false;
  bool errorPass = false;
  bool errorName = false;
  bool errorSpecialization = false;
  bool errorEmail = false;
  bool errorNationality = false;
  bool errorGender = false;
  bool errorMaritalStatus = false;
  bool errorRole = false;
  bool errorDate = false;
  bool errorHospital = false;
  bool errorHospitals = false;
  bool errorID2 = false;
  bool errorEmail2 = false;

  bool validateMyPhone(String value) {
    Pattern pattern = r'^[0-9]{9}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      print('Enter Valid Phone number');
      setState(() {
        errorPhone = true;
      });
      return false;
    } else {
      print("valid Phone number");
      setState(() {
        errorPhone = false;
      });
      return true;
    }
  }

  bool validateNationality(String value) {
    if (value.isEmpty) {
      print('Enter Valid nationality');
      setState(() {
        errorNationality = true;
      });
      return false;
    } else {
      print("valid Nationality");
      setState(() {
        errorNationality = false;
      });
      return true;
    }
  }

  bool validateGender(String value) {
    if (value.isEmpty || value == "select your gender") {
      print('Enter Valid gender');
      setState(() {
        errorGender = true;
      });
      return false;
    } else {
      print("valid Nationality");
      setState(() {
        errorGender = false;
      });
      return true;
    }
  }

  bool validateHospital(String value) {
    if (value == null) {
      print('Enter Valid Hospital');
      setState(() {
        errorHospital = true;
      });
      return false;
    } else {
      print("valid Hospital");
      setState(() {
        errorHospital = false;
      });
      return true;
    }
  }

  bool validateHospitals(List<String> value) {
    if (value == null) {
      print('Enter Valid Hospital');
      setState(() {
        errorHospitals = true;
      });
      return false;
    } else {
      print("valid Hospital");
      setState(() {
        errorHospitals = false;
      });
      return true;
    }
  }

  bool validateRole(value) {
    if (value != "Physician" && value != "Lab specialist") {
      print('Enter Valid role');
      setState(() {
        errorRole = true;
      });
      return false;
    } else {
      print("valid role");
      setState(() {
        errorRole = false;
      });
      return true;
    }
  }

  bool validateDate(DateTime value) {
    print(value);
    if (value == null) {
      print('Enter Valid date');
      setState(() {
        errorDate = true;
      });
      return false;
    } else {
      print("valid date");
      setState(() {
        errorDate = false;
      });
      return true;
    }
  }

  bool validateMaritalStatus(String value) {
    if (value.isEmpty) {
      print('Enter Valid marital status');
      setState(() {
        errorMaritalStatus = true;
      });
      return false;
    } else {
      print("valid marital status");
      setState(() {
        errorMaritalStatus = false;
      });
      return true;
    }
  }

  bool validateMyID(String value) {
    Pattern pattern = r'^[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      print('Enter Valid ID');
      setState(() {
        errorID = true;
      });
      return false;
    } else {
      setState(() {
        errorID = false;
      });
      print("valid Name");
      return true;
    }
  }

  bool validateMyPass(String value) {
    Pattern pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$";
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value)) {
      counterValid++;
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

  bool validateMyName(String value) {
    Pattern pattern = r"^([a-zA-Z]{2,}\s[a-zA-Z]{2,})";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      print('Enter Valid name');
      setState(() {
        errorName = true;
      });
      return false;
    } else {
      print("valid name");
      setState(() {
        errorName = false;
      });
      return true;
    }
  }

  bool validateSpecialization(String value) {
    Pattern pattern = r"^([a-zA-Z]{2,})";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      print('Enter Valid Specializtion');
      setState(() {
        errorSpecialization = true;
      });
      return false;
    } else {
      print("valid Specializtion");
      setState(() {
        errorSpecialization = false;
      });
      return true;
    }
  }

  bool validateEmail(String value) {
    Pattern pattern = r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$";
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value)) {
      print('Valid Email');

      setState(() {
        errorEmail = false;
      });
      return true;
    } else {
      print("Enter Valid Email");
      setState(() {
        errorEmail = true;
      });
      return false;
    }
  }

  TextEditingController nameController = TextEditingController();
  HospitalLocationController HospitallocationController =
      Get.put(HospitalLocationController());
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController GenderlocationController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  //VariableController variableController = Get.put(VariableController());
<<<<<<< HEAD
  bool isOther = false;
=======
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7

  int isFilled = 0;
  Hospitals() async {
    var status = db.serverStatus();
    var collection = db.collection('Hospital');
    int ArrayLength = await collection.find().length;
    String Hospital;
    await collection.find().forEach((element) {
      if (isFilled != ArrayLength) {
        Hospital = element['name'] + ", " + element['district'];
        ArrayOfHospitals.add(Hospital);
        isFilled = isFilled + 1;
      }
    });
  }

  final formKey1 = GlobalKey<FormState>();

  ScrollConfiguration SecondStep(context) {
    Hospitals();
    if (role == 'hospital') {
      if (RolelocationController.selectedValue == "Physician")
        role = "Physician";
      else if (RolelocationController.selectedValue == "Lab specialist")
        role = "Lab specialist";
    }

    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Container(
                  child: Form(
                    key: formKey1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_outline,
                                color: ColorResources.orange),
                            const SizedBox(width: 15),
                            mediumText("Full Name", ColorResources.grey777, 16),
                          ],
                        ),
                        textField1("Enter your full name", nameController,
                            TextInputType.name,
                            error: errorName),
                        const SizedBox(height: 5),
                        if (errorName == true)
                          mediumText("Enter a valid Name", Colors.red, 16),
                        if (role != 'patient') const SizedBox(height: 30),
                        if (role != 'patient')
                          Row(
                            children: [
                              const Icon(
                                Icons.location_city_outlined,
                                color: ColorResources.orange,
                              ),
                              const SizedBox(width: 15),
                              mediumText(
                                  "Hospital", ColorResources.grey777, 16),
                            ],
                          ),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue ==
                                'Lab specialist')
                          DropdownSearch<String>(
<<<<<<< HEAD
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                              searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                      hintText: 'Search..',
                                      constraints:
                                          BoxConstraints(maxHeight: 40))),
                              constraints: BoxConstraints(maxHeight: 230),
                              scrollbarProps:
                                  ScrollbarProps(thumbVisibility: true),
                            ),
                            items: ArrayOfHospitals,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Choose your hospital",
                                hintStyle:
                                    TextStyle(color: ColorResources.grey777),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorHospital == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                ),
                              ),
                            ),
                            onChanged: (String selectedValue) {
                              hospital = selectedValue;
                            },
=======
                            mode: Mode.MENU,
                            maxHeight: 300,
                            showSelectedItems: true,
                            onChanged: (String selectedValue) {
                              hospital = selectedValue;
                            },
                            items: ArrayOfHospitals,
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Select your hospital",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: errorHospital == false
                                    ? const BorderSide(
                                        color: ColorResources.greyA0A, width: 1)
                                    : const BorderSide(
                                        color: Colors.red, width: 1),
                              ),
                            ),
                            showSearchBox: true,
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                          ),
                        const SizedBox(height: 5),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue ==
                                'Lab specialist' &&
                            errorHospital == true)
                          mediumText("Enter a valid Hospital", Colors.red, 16),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue == 'Physician')
                          Theme(
<<<<<<< HEAD
                              data: ThemeData(
                                primarySwatch: Colors.teal,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                // inputDecorationTheme: InputDecorationTheme()
                              ),
                              child: DropdownSearch<String>.multiSelection(
                                items: ArrayOfHospitals,
                                popupProps: PopupPropsMultiSelection.menu(
                                  showSelectedItems: true,
                                  searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                          hintText: 'Search..',
                                          constraints:
                                              BoxConstraints(maxHeight: 40))),
                                  constraints: BoxConstraints(maxHeight: 230),
                                  scrollbarProps:
                                      ScrollbarProps(thumbVisibility: true),
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: "Select your hospital",
                                    hintStyle: TextStyle(
                                        color: ColorResources.grey777),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: errorHospitals == false
                                          ? const BorderSide(
                                              color: ColorResources.greyA0A,
                                              width: 1)
                                          : const BorderSide(
                                              color: Colors.red, width: 1),
                                    ),
                                  ),
                                ),
                                onChanged: (List<String> selectedValue) {
                                  hospitals = selectedValue;
                                },
                              )),
=======
                            data: ThemeData(
                                primarySwatch: Colors.teal,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            child: DropdownSearch<String>.multiSelection(
                              mode: Mode.MENU,
                              maxHeight: 300,
                              showSelectedItems: true,
                              onChanged: (List<String> selectedValue) {
                                hospitals = selectedValue;
                              },
                              items: ArrayOfHospitals,
                              dropdownSearchDecoration: InputDecoration(
                                labelStyle: TextStyle(fontSize: 1000),
                                hintText: 'Select your hospital',
                                hoverColor: ColorResources.orange,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorHospitals == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                ),
                              ),
                              showSearchBox: true,
                            ),
                          ),
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                        const SizedBox(height: 5),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue ==
                                'Physician' &&
                            errorHospitals == true)
                          mediumText("Enter a valid Hospital", Colors.red, 16),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              color: ColorResources.orange,
                            ),
                            const SizedBox(width: 15),
                            mediumText("Email", ColorResources.grey777, 16),
                          ],
                        ),
                        textField1("Enter your email", emailController,
                            TextInputType.emailAddress,
                            error: errorEmail || errorEmail2),
                        const SizedBox(height: 5),
                        if (errorEmail == true)
                          mediumText("Enter a valid Email", Colors.red, 16),
                        if (errorEmail2 == true)
                          mediumText("Email Already used", Colors.red, 16),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              color: ColorResources.orange,
                            ),
                            const SizedBox(width: 15),
                            mediumText(
                                "Confirm Email", ColorResources.grey777, 16),
                          ],
                        ),
                        textField1("Enter confirm email",
                            confirmEmailController, TextInputType.emailAddress,
                            error: emailController.text !=
                                confirmEmailController.text),
                        const SizedBox(height: 5),
                        if (emailController.text != confirmEmailController.text)
                          mediumText("Email did not match", Colors.red, 16),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.language_outlined,
                                color: ColorResources.orange),
                            const SizedBox(width: 15),
                            mediumText(
                                "Nationality", ColorResources.grey777, 16),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CountryCodePicker(
                              onChanged: (CountryCode countryCode) {
                                nationalityController.text = countryCode.name;
                              },
                              initialSelection: 'SA',
                              favorite: const ['+966', 'SA'],
                              textStyle: TextStyle(
                                fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                                fontSize: 16,
                                color: Color.fromARGB(255, 179, 160, 170),
                              ),
                              showCountryOnly: true,
                              showFlag: true,
                              showOnlyCountryWhenClosed: true,
                              alignLeft: false,
                            ),
                          ],
                        ),
                        Divider(
                          color: errorNationality == false
                              ? Colors.black
                              : Colors.red,
                          indent: 0,
                          thickness: 0.4,
                        ),
                        const SizedBox(height: 5),
                        if (errorNationality == true)
                          mediumText(
                              "Enter a valid nationality", Colors.red, 16),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.group_outlined,
                              color: ColorResources.orange,
                            ),
                            const SizedBox(width: 15),
                            mediumText("Gender", ColorResources.grey777, 16),
                          ],
                        ),
                        DropdownSearch<String>(
<<<<<<< HEAD
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            constraints: BoxConstraints(maxHeight: 120),
                          ),
=======
                          mode: Mode.MENU,
                          showSelectedItems: true,
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                          items: const [
                            "Female",
                            'Male',
                          ],
<<<<<<< HEAD
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'select your gender',
                              hintStyle:
                                  TextStyle(color: ColorResources.grey777),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: errorGender == false
                                    ? const BorderSide(
                                        color: ColorResources.greyA0A, width: 1)
                                    : const BorderSide(
                                        color: Colors.red, width: 1),
                              ),
=======
                          maxHeight: 120,
                          dropdownSearchDecoration: InputDecoration(
                            hintText: GenderlocationController.text,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: errorGender == false
                                  ? const BorderSide(
                                      color: ColorResources.greyA0A, width: 1)
                                  : const BorderSide(
                                      color: Colors.red, width: 1),
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                            ),
                          ),
                          onChanged: (String selectedValue) {
                            GenderlocationController.text = selectedValue;
                          },
                        ),
                        const SizedBox(height: 5),
                        if (errorGender == true)
                          mediumText("Enter a valid gender", Colors.red, 16),
                        if (role == 'patient') const SizedBox(height: 30),
                        if (role == 'patient')
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                color: ColorResources.orange,
                              ),
                              const SizedBox(width: 15),
                              mediumText(
                                  "Marital status", ColorResources.grey777, 16),
                            ],
                          ),
                        if (role == 'patient')
                          DropdownSearch<String>(
<<<<<<< HEAD
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              constraints: BoxConstraints(maxHeight: 280),
                            ),
=======
                            mode: Mode.MENU,
                            showSelectedItems: true,
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                            items: const [
                              "Single",
                              'Married',
                              'Divorced',
                              'Separated',
                              'Widow(er)'
                            ],
<<<<<<< HEAD
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: 'select your marital status',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorMaritalStatus == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                ),
=======
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'select your marital status',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: errorMaritalStatus == false
                                    ? const BorderSide(
                                        color: ColorResources.greyA0A, width: 1)
                                    : const BorderSide(
                                        color: Colors.red, width: 1),
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                              ),
                            ),
                            onChanged: (String selectedValue) {
                              maritalStatusController.text = selectedValue;
                            },
                          ),
                        const SizedBox(height: 5),
                        if (role == 'patient' && errorMaritalStatus == true)
                          mediumText(
                              "Enter a valid marital status", Colors.red, 16),
                        const SizedBox(height: 30),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue == 'Physician')
                          Row(
                            children: [
                              const Icon(Icons.perm_identity_outlined,
                                  color: ColorResources.orange),
                              const SizedBox(width: 15),
                              mediumText(
                                  "Specialization", ColorResources.grey777, 16),
                            ],
                          ),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue == 'Physician')
<<<<<<< HEAD
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: const [
                              "Allergy and immunology",
                              "Anesthesiology",
                              "Dermatology",
                              "Diagnostic radiology",
                              "Emergency medicine",
                              "Family medicine",
                              "Internal medicine",
                              "Medical genetics",
                              "Neurology",
                              "Nuclear medicine",
                              "Obstetrics and gynecology",
                              "Ophthalmology",
                              "Pathology",
                              "Pediatrics",
                              "Physical medicine and rehabilitation",
                              "Preventive medicine",
                              "Psychiatry",
                              "Radiation oncology",
                              "Surgery",
                              "Urology",
                              "Other"
                            ],
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                // labelText: "",
                                hintText: "Select your specialty",
                              ),
                            ),
                            onChanged: (String specialization) {
                              if (specialization == 'Other') {
                                setState(() {
                                  isOther = true;
                                });
                              } else {
                                specializationController.text = specialization;
                                setState(() {
                                  isOther = false;
                                });
                              }
                            },
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (isOther)
                          TextField(
                            controller: specializationController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Enter your specialty",
                              hintStyle: TextStyle(
                                color: ColorResources.grey777,
                                fontSize: 16,
                                fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                              ),
                              // filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: errorSpecialization == false
                                    ? const BorderSide(
                                        color: ColorResources.greyA0A, width: 1)
                                    : const BorderSide(
                                        color: Colors.red, width: 1),
                              ),
                            ),
                          ),
                        SizedBox(height: 5),
=======
                          textField1("Enter your specialty",
                              specializationController, TextInputType.name,
                              error: errorSpecialization),
                        const SizedBox(height: 5),
>>>>>>> 9114863e90d01b064ce086b8cedf9371e589bbb7
                        if (role != 'patient' &&
                            RolelocationController.selectedValue ==
                                'Physician' &&
                            errorSpecialization == true)
                          mediumText(
                              "Enter a valid Specialization", Colors.red, 16),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue == 'Physician')
                          const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              color: ColorResources.orange,
                            ),
                            const SizedBox(width: 15),
                            mediumText(
                                "Phone number", ColorResources.grey777, 16),
                          ],
                        ),
                        phoneValidator(),
                        const SizedBox(height: 5),
                        if (errorPhone == true)
                          mediumText(
                              "Enter a valid phone number", Colors.red, 16),
                        const SizedBox(height: 30),
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
                        passValidator(),
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
                            mediumText(
                                "Confirm password", ColorResources.grey777, 16),
                          ],
                        ),
                        Obx(
                          () => TextFormField(
                            cursorColor: ColorResources.black,
                            obscureText:
                                variableController.isOpenConfirmPassword.value,
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
                                    variableController
                                            .isOpenConfirmPassword.value =
                                        !variableController
                                            .isOpenConfirmPassword.value;
                                  },
                                  child: SvgPicture.asset(
                                    variableController
                                            .isOpenConfirmPassword.isFalse
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
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorResources.greyA0A, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: passwordController.text ==
                                          confirmPasswordController.text
                                      ? BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : BorderSide(
                                          color: Colors.red, width: 1)),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorResources.greyA0A, width: 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        if (passwordController.text !=
                            confirmPasswordController.text)
                          mediumText("Password did not match", Colors.red, 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool allValid1 = false;
  Future<void> checkFirst() async {
    var isFound;
    isFound = await DBConnection.checkExisting(IDController.text, role, "ID");
    if (role != 'patient') {
      setState(() {
        allValid1 = false;
      });
      validateRole(RolelocationController.selectedValue);
      validateMyID(IDController.text);
      validateDate(picked);

      if (!errorID && !errorRole && !errorDate) {
        setState(() {
          allValid1 = true;
        });
      }
    } else {
      setState(() {
        allValid1 = false;
      });
      validateMyID(IDController.text);
      validateDate(picked);
      if (!errorID && !errorDate) {
        setState(() {
          allValid1 = true;
        });
      }
    }
    if (isFound == true) {
      setState(() {
        errorID2 = true;
      });
    } else if (isFound == false) {
      errorID2 = false;
    }
    if (isFound == false && allValid1) {
      setState(() {
        currentStep += 1;
      });
    }
  }

  bool allValid2 = false;
  Future<void> checkSecond() async {
    var isFound =
        await DBConnection.checkExisting(emailController.text, role, "email");
    setState(() {
      allValid2 = false;
    });
    validateMyName(nameController.text);
    validateEmail(emailController.text);
    validateNationality(nationalityController.text);
    validateGender(GenderlocationController.text);
    validateMyPhone(phoneController.text);
    validateMyPass(passwordController.text);

    if (role == 'patient') validateMaritalStatus(maritalStatusController.text);
    if (RolelocationController.selectedValue == 'Physician') {
      validateHospitals(hospitals);
      validateSpecialization(specializationController.text);
    }
    if (RolelocationController.selectedValue == 'Lab specialist')
      validateHospital(hospital);
    if (!errorEmail &&
        emailController.text == confirmEmailController.text &&
        !errorGender &&
        !errorName &&
        !errorNationality &&
        !errorPass &&
        passwordController.text == confirmPasswordController.text &&
        !errorPhone) {
      if ((role == 'patient' && !errorMaritalStatus) ||
          (RolelocationController.selectedValue == 'Physician' &&
              !errorSpecialization &&
              !errorHospitals) ||
          (RolelocationController.selectedValue == 'Lab specialist' &&
              !errorHospital)) {
        setState(() {
          allValid2 = true;
        });
      }
    }
    if (isFound == true || !allValid2) {
      Hospitals() => null;
    }
    if (isFound == true) {
      setState(() {
        errorEmail2 = true;
      });
    } else if (isFound == false) {
      errorEmail2 = false;
    }
    if (isFound == false && allValid2) {
      setState(() {
        controller.restart();
        finishTimer = false;
        sendOtp(emailController.text);
        currentStep += 1;
      });
    }
  }

  String number = "966";
  passValidator() => TextFormField(
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
  phoneValidator() => TextFormField(
        cursorColor: ColorResources.black,
        style: TextStyle(
          color: ColorResources.black,
          fontSize: 16,
          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
        ),
        keyboardType: TextInputType.number,
        controller: phoneController,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red[400],
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountryCodePicker(
                  onChanged: ((value) => number = value.toString()),
                  initialSelection: 'SA',
                  favorite: const ['+966', 'SA'],
                  textStyle: TextStyle(
                    fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                    fontSize: 16,
                    color: ColorResources.greyA0A,
                  ),
                  showCountryOnly: false,
                  showFlag: true,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          hintText: "Enter phone number",
          hintStyle: TextStyle(
            color: ColorResources.greyA0A,
            fontSize: 18,
            fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
          ),
          filled: false,
          enabledBorder: UnderlineInputBorder(
            borderSide: errorPhone == false
                ? const BorderSide(color: ColorResources.greyA0A, width: 1)
                : const BorderSide(color: Colors.red, width: 1),
          ),
        ),
      );
}

final RoleLocationController RolelocationController =
    Get.put(RoleLocationController());

List<String> ArrayOfHospitals = new List<String>();
List<String> hospitals;
List<String> IDOfHospitals = new List<String>();
String hospital;
bool addedHospitals = false;
int isFinish = 0;
Future<bool> HospitalsPhysician() async {
  var status = db.serverStatus();
  var collection = db.collection('Hospital');
  int ArrayLength = ArrayOfHospitals.length;
  String Hospital;
  String ID;
  await collection.find().forEach((element) {
    if (isFinish < ArrayLength) {
      Hospital = element['name'] + ", " + element['district'];
      hospitals.forEach((thisHospital) {
        print("hospital: " + thisHospital);
        print("Hospital: " + Hospital);
        if (thisHospital == Hospital) {
          // hID = element['_id'];
          print(element['_id']);
          hosArray.add(element['_id']);
          // print(element['_id']);
          ID = element['_id'].$oid.toString();
          IDOfHospitals.add(ID);
          addedHospitals = true;
        }
      });
      isFinish = isFinish + 1;
    }
  });
  print(IDOfHospitals);
}

int isFinish2 = 0;
HospitalsLab() async {
  var status = db.serverStatus();
  var collection = db.collection('Hospital');
  int ArrayLength = ArrayOfHospitals.length;

  String Hospital;
  String ID;
  await collection.find().forEach((element) {
    if (isFinish2 < ArrayLength) {
      Hospital = element['name'] + ", " + element['district'];
      print("hospital: " + hospital);
      print("Hospital: " + Hospital);
      if (hospital == Hospital) {
        // ID = element['hospitalId'];
        hid = element['_id'];
        ID = element['_id'].$oid.toString();
        hospital = ID;
        print(hospital);
        print(hid);
      }

      isFinish2 = isFinish2 + 1;
    }
  });
  print(hospital);
}
