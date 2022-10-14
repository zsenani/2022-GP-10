import 'package:medcore/Controller/variable_controller.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:medcore/main.dart';
import 'package:medcore/Controller/role_location_controller.dart';
import 'package:medcore/Controller/hospital_location_controller.dart';
import 'package:medcore/Utiils/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:medcore/Controller/gender_location_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SignUpScreen extends StatefulWidget {
  final String role;
  SignUpScreen({Key key, @required this.role}) : super(key: key);
  static const routeName = '/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState(role);
}

class _SignUpScreenState extends State<SignUpScreen> {
  String role;
  _SignUpScreenState(this.role);
  int currentStep = 0;

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
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
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              print('Completed');
              //Sent data to server
            } else {
              setState(() => currentStep += 1);
            }
          },
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;
            return Row(
              children: <Widget>[
                if (currentStep != 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('BACK'),
                    ),
                  ),
                if (currentStep != 0) const SizedBox(width: 50),
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
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
          content: FirstStep(context, role, selectedDate, selectDate),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text(''),
            content: SecondStep(context, role)),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text(''),
          content: ThirdStep(),
        ),
      ];
}

final TextEditingController IDController = TextEditingController();
final RoleLocationController RolelocationController =
    Get.put(RoleLocationController());

ScrollConfiguration FirstStep(context, role, selectedDate, selectDate) {
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
                      ),
                      textField1(
                          "Enter your ID", IDController, TextInputType.number),
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
                      const Divider(color: Colors.black),
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorResources.greyA0A, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorResources.greyA0A, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: GetBuilder<RoleLocationController>(
                              init: RoleLocationController(),
                              builder: (controller) {
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: RolelocationController.selectedValue,
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

final TextEditingController nameController = TextEditingController();
final HospitalLocationController HospitallocationController =
    Get.put(HospitalLocationController());
final TextEditingController emailController = TextEditingController();
final TextEditingController confirmEmailController = TextEditingController();
final TextEditingController nationalityController = TextEditingController();
final GenderLocationController GenderlocationController =
    Get.put(GenderLocationController());
final TextEditingController specializationController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
final VariableController variableController = Get.put(VariableController());
final formKey = GlobalKey<FormState>();

ScrollConfiguration SecondStep(context, role) {
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
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_outline,
                              color: ColorResources.orange),
                          const SizedBox(width: 15),
                          mediumText("Name", ColorResources.grey777, 16),
                        ],
                      ),
                      textField1("Enter your full name", nameController,
                          TextInputType.name),
                      if (role != 'patient') const SizedBox(height: 30),
                      if (role != 'patient')
                        Row(
                          children: [
                            const Icon(
                              Icons.location_city_outlined,
                              color: ColorResources.orange,
                            ),
                            const SizedBox(width: 15),
                            mediumText("Hospital", ColorResources.grey777, 16),
                          ],
                        ),
                      if (role != 'patient' &&
                          RolelocationController.selectedValue ==
                              'Lab specialist')
                        DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: const [
                            "King Khalid Hospital",
                            'AlHabib Hospital'
                          ],
                          dropdownSearchDecoration: const InputDecoration(
                            hintText: 'Select your hospital',
                          ),
                          showSearchBox: true,
                        ),
                      if (role != 'patient' &&
                          RolelocationController.selectedValue == 'Physician')
                        Theme(
                          data: ThemeData(
                            primarySwatch: Colors.teal,
                          ),
                          child: DropdownSearch<String>.multiSelection(
                            mode: Mode.MENU,
                            showSelectedItems: true,
                            items: const [
                              "King Khalid Hospital",
                              'AlHabib Hospital'
                            ],
                            dropdownSearchDecoration: const InputDecoration(
                              hintText: 'Select your hospital',
                              hoverColor: ColorResources.orange,
                            ),
                            showSearchBox: true,
                          ),
                        ),
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
                          TextInputType.emailAddress),
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
                      textField1("Enter confirm email", confirmEmailController,
                          TextInputType.emailAddress),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.language_outlined,
                              color: ColorResources.orange),
                          const SizedBox(width: 15),
                          mediumText("Nationality", ColorResources.grey777, 16),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryCodePicker(
                            onChanged: print,
                            initialSelection: 'SA',
                            favorite: const ['+966', 'SA'],
                            textStyle: TextStyle(
                              fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                              fontSize: 16,
                              color: ColorResources.greyA0A,
                            ),
                            showCountryOnly: true,
                            showFlag: true,
                            showOnlyCountryWhenClosed: true,
                            alignLeft: false,
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black),
                      const SizedBox(height: 30),
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
                      FormField(
                        builder: (FormFieldState<String> state) =>
                            InputDecorator(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 10, 20, 20),
                            border: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorResources.greyA0A, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorResources.greyA0A, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorResources.greyA0A, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: GetBuilder<GenderLocationController>(
                            init: GenderLocationController(),
                            builder: (controller) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: GenderlocationController.selectedValue,
                                  items: GenderlocationController.gender
                                      .map((element) {
                                    return DropdownMenuItem<String>(
                                      child: Text(element),
                                      value: element,
                                    );
                                  }).toList(),
                                  hint: const Text("Male"),
                                  style: TextStyle(
                                    color: ColorResources.greyA0A,
                                    fontSize: 16,
                                    fontFamily:
                                        TextFontFamily.AVENIR_LT_PRO_BOOK,
                                  ),
                                  isExpanded: true,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    GenderlocationController.setSelected(
                                        newValue.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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
                        textField1("Enter your specialty",
                            specializationController, TextInputType.name),
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
                      TextFormField(
                        cursorColor: ColorResources.black,
                        style: TextStyle(
                          color: ColorResources.black,
                          fontSize: 16,
                          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                        ),
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CountryCodePicker(
                                  onChanged: print,
                                  initialSelection: 'SA',
                                  favorite: const ['+966', 'SA'],
                                  textStyle: TextStyle(
                                    fontFamily:
                                        TextFontFamily.AVENIR_LT_PRO_BOOK,
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
                          hintText: "Enter your phone number",
                          hintStyle: TextStyle(
                            color: ColorResources.greyA0A,
                            fontSize: 18,
                            fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                          ),
                          filled: true,
                          fillColor: ColorResources.whiteF6F,
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorResources.greyA0A, width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorResources.greyA0A, width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorResources.greyA0A, width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
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
                      Obx(
                        () => TextFormField(
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
                            filled: true,
                            fillColor: ColorResources.whiteF6F,
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyA0A, width: 1),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyA0A, width: 1),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyA0A, width: 1),
                            ),
                          ),
                        ),
                      ),
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
                            filled: true,
                            fillColor: ColorResources.whiteF6F,
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyA0A, width: 1),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyA0A, width: 1),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyA0A, width: 1),
                            ),
                          ),
                        ),
                      ),
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

final TextEditingController _pinPutController = TextEditingController();
final FocusNode _pinPutFocusNode = FocusNode();
BoxDecoration get _pinPutDecoration {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(12),
  );
}

Padding ThirdStep() {
  return Padding(
    padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 60),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        heavyText("OTP", ColorResources.green009, 24),
        const SizedBox(height: 15),
        bookText("Put the OTP number below sent to your email",
            ColorResources.greyA0A, 16),
        const SizedBox(height: 50),
        Container(
          color: ColorResources.whiteF6F,
          child: PinPut(
            fieldsCount: 4,
            textStyle: TextStyle(
              fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
              fontSize: 24,
              color: ColorResources.grey777,
            ),
            cursorColor: ColorResources.green009,
            eachFieldHeight: 55,
            eachFieldWidth: 55,
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorResources.greyA0A.withOpacity(0.2),
              ),
              color: ColorResources.white,
            ),
            selectedFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorResources.greyA0A.withOpacity(0.2),
              ),
              color: ColorResources.white,
            ),
            followingFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorResources.greyA0A.withOpacity(0.2),
              ),
              color: ColorResources.white,
            ),
            disabledDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(12),
              color: ColorResources.white,
              border: Border.all(
                color: ColorResources.greyA0A.withOpacity(0.2),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bookText("Code send in 0:29 ", ColorResources.grey777, 13),
            mediumText("Resend code", ColorResources.green009, 13)
          ],
        ),
      ],
    ),
  );
}
