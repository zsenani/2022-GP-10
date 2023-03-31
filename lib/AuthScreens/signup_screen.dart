import 'dart:async';
import 'package:medcore/Controller/variable_controller.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:medcore/Controller/role_location_controller.dart';
import 'package:medcore/Controller/hospital_location_controller.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../LabScreens/lab_home_screen.dart';
import '../Patient-PhysicianScreens/home_screen.dart';
import '../Patient-PhysicianScreens/patient_home_screen.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'otp.dart';
import 'package:medcore/database/mysqlDatabase.dart';
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
        pselectedDate = picked;
      });
    } else if (role != 'patient' &&
        picked != null &&
        picked != plselectedDate) {
      setState(() {
        selectedDate = picked;
        plselectedDate = picked;
      });
    }
  }

  //static final formKey = GlobalKey<FormState>();
  final VariableController variableController = Get.put(VariableController());

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
                GenderlocationController.text = "Select your gender";
                maritalStatusController.text = "Select your marital status";
                nationalityController.text = "Saudi Arabia";

                checkFirst();
              }
            },
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
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
    pinPutController.clear();
    //  if (validateOTP == true) {
    mysqlDatabase.insertPatient(
      nameController.text,
      hashedPassword = new DBCrypt()
          .hashpw(confirmPasswordController.text, new DBCrypt().gensalt()),
      "${selectedDate.toLocal()}".split(' ')[0],
      GenderlocationController.text,
      phoneController.text,
      confirmEmailController.text,
      nationalityController.text,
      maritalStatusController.text,
      BloodTypeController.text,
      int.parse(IDController.text),
    );

    Get.to(PatientHomeScreen(id: IDController.text), arguments: 'patient');
    _clearAll2();
    //   }
  }

  void Physician() {
    verifyOtp(emailController.text, context);
    pinPutController.clear();
    //if (validateOTP == true && addedHospitals == true) {
    mysqlDatabase.insertPhysician(
        nameController.text,
        hashedPassword = new DBCrypt()
            .hashpw(confirmPasswordController.text, new DBCrypt().gensalt()),
        "${selectedDate.toLocal()}".split(' ')[0],
        GenderlocationController.text,
        phoneController.text,
        confirmEmailController.text,
        nationalityController.text,
        specializationController.text,
        int.parse(IDController.text),
        IDOfHospitals);

    Get.to(HomeScreen(id: IDController.text));
    _clearAll();
    // }
  }

  void Lab() {
    verifyOtp(emailController.text, context);
    pinPutController.clear();
    // if (validateOTP == true) {
    mysqlDatabase.insertLab(
        nameController.text,
        hashedPassword = new DBCrypt()
            .hashpw(confirmPasswordController.text, new DBCrypt().gensalt()),
        "${selectedDate.toLocal()}".split(' ')[0],
        GenderlocationController.text,
        phoneController.text,
        confirmEmailController.text,
        nationalityController.text,
        int.parse(IDController.text),
        int.parse(hosID));

    Get.to(LabHomePage1(id: IDController.text));
    _clearAll3();
    // }
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
    picked = null;
    ArrayOfHospitals.clear();
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
    BloodTypeController.text = "";
    picked = null;
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
    picked = null;
    ArrayOfHospitals.clear();
  }

  TextEditingController IDController = TextEditingController();

  ScrollConfiguration FirstStep(context, selectedDate, selectDate) {
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
                    // key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_outline,
                                color: ColorResources.orange),
                            const SizedBox(width: 15),
                            mediumText("* ", Colors.red, 16),
                            mediumText("Citizen ID/ Resident ID",
                                ColorResources.grey777, 16),
                          ],
                        ),
                        textField1("Enter your national ID or your Iqama ID",
                            IDController, TextInputType.number,
                            error: errorID || errorID2),
                        const SizedBox(height: 5),
                        if (errorID == true)
                          mediumText(
                              "ID should be 10 digits and start with 1 or 2",
                              Colors.red,
                              16),
                        if (errorID2 == true)
                          mediumText("ID Already used", Colors.red, 16),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined,
                                color: ColorResources.orange),
                            const SizedBox(width: 15),
                            mediumText("* ", Colors.red, 16),
                            mediumText(
                                "Date of birth", ColorResources.grey777, 16),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (selectedDate == null)
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
                        if (selectedDate != null)
                          InkWell(
                            onTap: () => selectDate(context),
                            child: role == 'patient'
                                ? Text(
                                    "${pselectedDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 16,
                                      fontFamily:
                                          TextFontFamily.AVENIR_LT_PRO_BOOK,
                                    ),
                                  )
                                : Text(
                                    "${plselectedDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 16,
                                      fontFamily:
                                          TextFontFamily.AVENIR_LT_PRO_BOOK,
                                    ),
                                  ),
                          ),
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
                              mediumText("* ", Colors.red, 16),
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
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorResources.greyA0A, width: 2),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorResources.greyA0A, width: 2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorRole == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
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
                                        color: ColorResources.black,
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
  bool errorGender = false;
  bool errorMaritalStatus = false;
  bool errorRole = false;
  bool errorDate = false;
  bool errorHospital = false;
  bool errorHospitals = false;
  bool errorID2 = false;
  bool errorEmail2 = false;
  bool _isVisiblePassword = false;
  bool _isVisiblleConfirmPassword = false;
  bool errorBloodType = false;

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

  bool validateGender(String value) {
    if (value.isEmpty || value == "Select your gender") {
      print('Enter Valid gender');
      setState(() {
        errorGender = true;
      });
      return false;
    } else {
      print("valid gender");
      setState(() {
        errorGender = false;
      });
      return true;
    }
  }

  bool validateBlood(String value) {
    if (value.isEmpty) {
      print('Enter Valid blood type');
      setState(() {
        errorBloodType = true;
      });
      return false;
    } else {
      print("valid blood type");
      setState(() {
        errorBloodType = false;
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
    if (value.isEmpty || value == "Select your marital status") {
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
    Pattern pattern = r'^[1-2]{1}[0-9]{9}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == '0000000000') {
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
    Pattern pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
    // Pattern pattern = r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$";
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
  TextEditingController BloodTypeController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  //VariableController variableController = Get.put(VariableController());
  bool isOther = false;

  int isFilled = 0;
  Hospitals() async {
    var results = await conn.query('select name, district from Hospital');
    int ArrayLength = await results.length;
    String Hospital;
    for (var row in results) {
      if (isFilled != ArrayLength) {
        Hospital = '${row[0]},${row[1]}';
        ArrayOfHospitals.add(Hospital);
        isFilled = isFilled + 1;
      }
    }
    ;
  }

  //static final formKey1 = GlobalKey<FormState>();

  ScrollConfiguration SecondStep(context) {
    if (ArrayOfHospitals.isEmpty == true) Hospitals();
    if (role == 'hospital') {
      if (RolelocationController.selectedValue == "Physician") {
        role = "Physician";
      } else if (RolelocationController.selectedValue == "Lab specialist") {
        role = "Lab specialist";
      }
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
                    //   key: formKey1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_outline,
                                color: ColorResources.orange),
                            const SizedBox(width: 15),
                            mediumText("* ", Colors.red, 16),
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
                              mediumText("* ", Colors.red, 16),
                              mediumText(
                                  "Hospital", ColorResources.grey777, 16),
                            ],
                          ),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue ==
                                'Lab specialist')
                          DropdownSearch<String>(
                            selectedItem: hospital,
                            popupProps: const PopupProps.menu(
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
                                hintStyle: const TextStyle(
                                    color: ColorResources.grey777),
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
                              data: ThemeData(
                                primarySwatch: Colors.teal,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                // inputDecorationTheme: InputDecorationTheme()
                              ),
                              child: DropdownSearch<String>.multiSelection(
                                selectedItems: hospitalsll,
                                items: ArrayOfHospitals,
                                popupProps: const PopupPropsMultiSelection.menu(
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
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: "Select your hospital",
                                    hintStyle: const TextStyle(
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
                                  hospitalsll = selectedValue;
                                },
                              )),
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
                            mediumText("* ", Colors.red, 16),
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
                            mediumText("* ", Colors.red, 16),
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
                            mediumText("* ", Colors.red, 16),
                            mediumText(
                                "Nationality", ColorResources.grey777, 16),
                          ],
                        ),
                        DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                    hintText: 'Search..',
                                    constraints:
                                        BoxConstraints(maxHeight: 40))),
                            constraints: BoxConstraints(maxHeight: 300),
                          ),
                          items: const [
                            "Afghanistan",
                            "Aland Islands",
                            "Albania",
                            "Algeria",
                            "American Samoa",
                            "AndorrA",
                            "Angola",
                            "Anguilla",
                            "Antarctica",
                            "Antigua and Barbuda",
                            "Argentina",
                            "Armenia",
                            "Aruba",
                            "Australia",
                            "Austria",
                            "Azerbaijan",
                            "Bahamas",
                            "Bahrain",
                            "Bangladesh",
                            "Barbados",
                            "Belarus",
                            "Belgium",
                            "Belize",
                            "Benin",
                            "Bermuda",
                            "Bhutan",
                            "Bolivia",
                            "Bosnia and Herzegovina",
                            "Botswana",
                            "Bouvet Island",
                            "Brazil",
                            "British Indian Ocean Territory",
                            "Brunei Darussalam",
                            "Bulgaria",
                            "Burkina Faso",
                            "Burundi",
                            "Cambodia",
                            "Cameroon",
                            "Canada",
                            "Cape Verde",
                            "Cayman Islands",
                            "Central African Republic",
                            "Chad",
                            "Chile",
                            "China",
                            "Christmas Island",
                            "Cocos (Keeling) Islands",
                            "Colombia",
                            "Comoros",
                            "Congo",
                            "Congo, The Democratic Republic of the",
                            "Cook Islands",
                            "Costa Rica",
                            "Croatia",
                            "Cuba",
                            "Cyprus",
                            "Czech Republic",
                            "Denmark",
                            "Djibouti",
                            "Dominica",
                            "Dominican Republic",
                            "Ecuador",
                            "Egypt",
                            "El Salvador",
                            "Equatorial Guinea",
                            "Eritrea",
                            "Estonia",
                            "Ethiopia",
                            "Falkland Islands (Malvinas)",
                            "Faroe Islands",
                            "Fiji",
                            "Finland",
                            "France",
                            "French Guiana",
                            "French Polynesia",
                            "French Southern Territories",
                            "Gabon",
                            "Gambia",
                            "Georgia",
                            "Germany",
                            "Ghana",
                            "Gibraltar",
                            "Greece",
                            "Greenland",
                            "Grenada",
                            "Guadeloupe",
                            "Guam",
                            "Guatemala",
                            "Guernsey",
                            "Guinea",
                            "Guinea-Bissau",
                            "Guyana",
                            "Haiti",
                            "Holy See (Vatican City State)",
                            "Honduras",
                            "Hong Kong",
                            "Hungary",
                            "Iceland",
                            "India",
                            "Indonesia",
                            "Iran, Islamic Republic Of",
                            "Iraq",
                            "Ireland",
                            "Isle of Man",
                            "Israel",
                            "Italy",
                            "Jamaica",
                            "Japan",
                            "Jersey",
                            "Jordan",
                            "Kazakhstan",
                            "Kenya",
                            "Kiribati",
                            "Korea, Republic of",
                            "Kuwait",
                            "Kyrgyzstan",
                            "Latvia",
                            "Lebanon",
                            "Lesotho",
                            "Liberia",
                            "Libyan Arab Jamahiriya",
                            "Liechtenstein",
                            "Lithuania",
                            "Luxembourg",
                            "Macao",
                            "Madagascar",
                            "Malawi",
                            "Malaysia",
                            "Maldives",
                            "Mali",
                            "Malta",
                            "Marshall Islands",
                            "Martinique",
                            "Mauritania",
                            "Mauritius",
                            "Mayotte",
                            "Mexico",
                            "Micronesia, Federated States of",
                            "Moldova, Republic of",
                            "Monaco",
                            "Mongolia",
                            "Montserrat",
                            "Morocco",
                            "Mozambique",
                            "Myanmar",
                            "Namibia",
                            "Nauru",
                            "Nepal",
                            "Netherlands",
                            "Netherlands Antilles",
                            "New Caledonia",
                            "New Zealand",
                            "Nicaragua",
                            "Niger",
                            "Nigeria",
                            "Niue",
                            "Norfolk Island",
                            "Northern Mariana Islands",
                            "Norway",
                            "Oman",
                            "Pakistan",
                            "Palau",
                            "Palestinian Territory, Occupied",
                            "Panama",
                            "Papua New Guinea",
                            "Paraguay",
                            "Peru",
                            "Philippines",
                            "Pitcairn",
                            "Poland",
                            "Portugal",
                            "Puerto Rico",
                            "Qatar",
                            "Reunion",
                            "Romania",
                            "Russian Federation",
                            "RWANDA",
                            "Saint Helena",
                            "Saint Kitts and Nevis",
                            "Saint Lucia",
                            "Saint Pierre and Miquelon",
                            "Saint Vincent and the Grenadines",
                            "Samoa",
                            "San Marino",
                            "Sao Tome and Principe",
                            "Saudi Arabia",
                            "Senegal",
                            "Serbia and Montenegro",
                            "Seychelles",
                            "Sierra Leone",
                            "Singapore",
                            "Slovakia",
                            "Slovenia",
                            "Solomon Islands",
                            "Somalia",
                            "South Africa",
                            "South Georgia and the South Sandwich Islands",
                            "Spain",
                            "Sri Lanka",
                            "Sudan",
                            "Suriname",
                            "Svalbard and Jan Mayen",
                            "Swaziland",
                            "Sweden",
                            "Switzerland",
                            "Syrian Arab Republic",
                            "Taiwan, Province of China",
                            "Tajikistan",
                            "Tanzania, United Republic of",
                            "Thailand",
                            "Timor-Leste",
                            "Togo",
                            "Tokelau",
                            "Tonga",
                            "Trinidad and Tobago",
                            "Tunisia",
                            "Turkey",
                            "Turkmenistan",
                            "Turks and Caicos Islands",
                            "Tuvalu",
                            "Uganda",
                            "Ukraine",
                            "United Arab Emirates",
                            "United Kingdom",
                            "United States",
                            "Uruguay",
                            "Uzbekistan",
                            "Vanuatu",
                            "Venezuela",
                            "Viet Nam",
                            "Virgin Islands, British",
                            "Virgin Islands, U.S.",
                            "Wallis and Futuna",
                            "Western Sahara",
                            "Yemen",
                            "Zambia",
                            "Zimbabwe",
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: nationalityController.text,
                              hintStyle: const TextStyle(
                                  color: ColorResources.grey777),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: //errorGender == false
                                      BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                  // : const BorderSide(
                                  //     color: Colors.red, width: 1),
                                  ),
                            ),
                          ),
                          onChanged: (String selectedValue) {
                            nationalityController.text = selectedValue;
                          },
                        ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     CountryCodePicker(
                        //       onChanged: (CountryCode countryCode) {
                        //         nationalityController.text = countryCode.name;
                        //       },
                        //       initialSelection: 'SA',
                        //       favorite: const ['+966', 'SA'],
                        //       textStyle: TextStyle(
                        //         fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                        //         fontSize: 16,
                        //         color: Color.fromARGB(255, 179, 160, 170),
                        //       ),
                        //       showCountryOnly: true,
                        //       showFlag: true,
                        //       showOnlyCountryWhenClosed: true,
                        //       alignLeft: false,
                        //     ),
                        //   ],
                        // ),
                        // Divider(
                        //   color: Colors.black,
                        //   indent: 0,
                        //   thickness: 0.4,
                        // ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.group_outlined,
                              color: ColorResources.orange,
                            ),
                            const SizedBox(width: 15),
                            mediumText("* ", Colors.red, 16),
                            mediumText("Gender", ColorResources.grey777, 16),
                          ],
                        ),
                        DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                            constraints: BoxConstraints(maxHeight: 120),
                          ),
                          items: const [
                            "Female",
                            'Male',
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: GenderlocationController.text,
                              hintStyle: const TextStyle(
                                  color: ColorResources.grey777),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: errorGender == false
                                    ? const BorderSide(
                                        color: ColorResources.greyA0A, width: 1)
                                    : const BorderSide(
                                        color: Colors.red, width: 1),
                              ),
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
                              mediumText("* ", Colors.red, 16),
                              mediumText(
                                  "Marital status", ColorResources.grey777, 16),
                            ],
                          ),
                        if (role == 'patient')
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              constraints: BoxConstraints(maxHeight: 280),
                            ),
                            items: const [
                              "Single",
                              'Married',
                              'Divorced',
                              'Separated',
                              'Widow(er)'
                            ],
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: maritalStatusController.text,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorMaritalStatus == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                ),
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
                        const SizedBox(height: 20),
                        if (role == 'patient')
                          Row(
                            children: [
                              const Icon(
                                Icons.bloodtype_outlined,
                                color: ColorResources.orange,
                              ),
                              const SizedBox(width: 15),
                              mediumText("* ", Colors.red, 16),
                              mediumText(
                                  "Blood Type", ColorResources.grey777, 16),
                            ],
                          ),
                        if (role == 'patient')
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              constraints: BoxConstraints(maxHeight: 160),
                            ),
                            items: const [
                              'O+',
                              'O-',
                              'A+',
                              'A-',
                              'B+',
                              'B-',
                              'AB+',
                              'AB-',
                              'I\'m not sure'
                            ],
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: 'Select your blood type',
                                hintStyle: const TextStyle(
                                    color: ColorResources.grey777),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: errorBloodType == false
                                      ? const BorderSide(
                                          color: ColorResources.greyA0A,
                                          width: 1)
                                      : const BorderSide(
                                          color: Colors.red, width: 1),
                                ),
                              ),
                            ),
                            onChanged: (String selectedValue) {
                              BloodTypeController.text = selectedValue;
                            },
                          ),
                        const SizedBox(height: 5),
                        if (errorBloodType == true && role == 'patient')
                          mediumText(
                              "Enter a valid blood type", Colors.red, 16),
                        if (role == 'patient') const SizedBox(height: 30),

                        if (role != 'patient' &&
                            RolelocationController.selectedValue == 'Physician')
                          Row(
                            children: [
                              const Icon(Icons.perm_identity_outlined,
                                  color: ColorResources.orange),
                              const SizedBox(width: 15),
                              mediumText("* ", Colors.red, 16),
                              mediumText(
                                  "Specialization", ColorResources.grey777, 16),
                            ],
                          ),
                        if (role != 'patient' &&
                            RolelocationController.selectedValue == 'Physician')
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
                          height: 5,
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
                            mediumText("* ", Colors.red, 16),
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
                            mediumText("* ", Colors.red, 16),
                            mediumText("Password", ColorResources.grey777, 16),
                          ],
                        ),
                        passValidator(),
                        const SizedBox(height: 5),
                        if (errorPass == true)
                          mediumText("Password should be at least 8 characters",
                              Colors.red, 15),
                        if (errorPass == true)
                          mediumText(
                              "one uppercase, lowercase characters, one digit and special character",
                              Colors.red,
                              15),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(
                              Icons.lock_outline,
                              color: ColorResources.orange,
                            ),
                            const SizedBox(width: 15),
                            mediumText("* ", Colors.red, 16),
                            mediumText(
                                "Confirm password", ColorResources.grey777, 16),
                          ],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: confirmPasswordController,
                          obscureText:
                              _isVisiblleConfirmPassword ? false : true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: passwordController.text ==
                                      confirmPasswordController.text
                                  ? const BorderSide(
                                      color: ColorResources.greyA0A, width: 1)
                                  : const BorderSide(
                                      color: Colors.red, width: 1),
                            ),
                            hintText: "Enter your password again",
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  updatePasswordStatus("confirmPassword"),
                              icon: Icon(_isVisiblleConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
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
    isFound = await mysqlDatabase.checkExisting(IDController.text, role, "ID");
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
        await mysqlDatabase.checkExisting(emailController.text, role, "email");
    setState(() {
      allValid2 = false;
    });
    validateMyName(nameController.text);
    validateEmail(emailController.text);
    validateGender(GenderlocationController.text);
    validateMyPhone(phoneController.text);
    validateMyPass(passwordController.text);

    if (role == 'patient') {
      validateMaritalStatus(maritalStatusController.text);
      validateBlood(BloodTypeController.text);
    }
    if (RolelocationController.selectedValue == 'Physician') {
      validateHospitals(hospitals);
      validateSpecialization(specializationController.text);
    }
    if (RolelocationController.selectedValue == 'Lab specialist') {
      validateHospital(hospital);
    }
    if (!errorEmail &&
        emailController.text == confirmEmailController.text &&
        !errorGender &&
        !errorName &&
        !errorPass &&
        passwordController.text == confirmPasswordController.text &&
        !errorPhone) {
      if ((role == 'patient' && !errorMaritalStatus && !errorBloodType) ||
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
        keyboardType: TextInputType.text,
        controller: passwordController,
        obscureText: _isVisiblePassword ? false : true,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: errorPass == false
                ? const BorderSide(color: ColorResources.greyA0A, width: 1)
                : const BorderSide(color: Colors.red, width: 1),
          ),
          hintText: "Enter password",
          suffixIcon: IconButton(
            onPressed: () => updatePasswordStatus("password"),
            icon: Icon(
                _isVisiblePassword ? Icons.visibility : Icons.visibility_off),
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
          hintText: "556667777",
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
List<String> hospitalsll = [];
List<int> IDOfHospitals = new List<int>();
String hospital;
bool addedHospitals = false;
int ArrayLength = ArrayOfHospitals.length;
int isFinish = 0;
Future<bool> HospitalsPhysician() async {
  int ID;
  var results =
      await conn.query('select name,district,idHospital from Hospital ');

  if (isFinish < ArrayLength) {
    for (var row in results) {
      hospitals.forEach((thisHospital) {
        if ('${row[0]},${row[1]}' == thisHospital) {
          print('true' + '${row[2]}');
          ID = int.parse('${row[2]}');
          IDOfHospitals.add(ID);
          addedHospitals = true;
        }
      });
      isFinish = isFinish + 1;
    }
  }
}

int isFinish2 = 0;
String hosID;
HospitalsLab() async {
  var results =
      await conn.query('select name,district,idHospital from Hospital ');

  if (isFinish2 < ArrayLength) {
    for (var row in results) {
      print(hospital);
      print('${row[0]},${row[1]}');
      if ('${row[0]},${row[1]}' == hospital) {
        print('true' + '${row[2]}');
        hosID = '${row[2]}';
      }
    }
    isFinish2 = isFinish2 + 1;
  }
}
