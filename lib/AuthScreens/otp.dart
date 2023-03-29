import 'package:flutter/material.dart';
import 'package:medcore/AuthScreens/signup_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../Utiils/colors.dart';
import '../Utiils/common_widgets.dart';
import '../Utiils/text_font_family.dart';
import '../main.dart';

String emailController;
String role;
CountdownController controller = new CountdownController(autoStart: true);
final TextEditingController pinPutController = TextEditingController();
bool validateOTP;
bool finishTimer = false;
// bool startAgain = false;
final FocusNode pinPutFocusNode = FocusNode();
BoxDecoration get pinPutDecoration {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(12),
  );
}

class otpMail extends StatefulWidget {
  otpMail({Key key, String emailController2, String role2}) : super(key: key) {
    emailController = emailController2;
    role = role2;
    // startAgain = true;
    controller.start();
  }

  @override
  State<otpMail> createState() => _otpMailState();
}

class _otpMailState extends State<otpMail> {
  @override
  Widget build(BuildContext context) {
    print(role);
    if (role == "Physician") {
      HospitalsPhysician();
    } else if (role == "Lab specialist") {
      HospitalsLab();
    } else {
      print("third: " + role);
    }
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              heavyText("OTP", ColorResources.green009, 24),
              const SizedBox(height: 15),
              bookText(
                  "Your OTP has been send to your email. Please enter the number below",
                  ColorResources.greyA0A,
                  16),
              const SizedBox(height: 50),
              PinPut(
                fieldsCount: 6,
                fieldsAlignment: MainAxisAlignment.spaceBetween,
                textStyle: TextStyle(
                  fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                  fontSize: 24,
                  color: ColorResources.grey777,
                ),
                cursorColor: ColorResources.green009,
                eachFieldHeight: 50,
                eachFieldWidth: 50,
                focusNode: pinPutFocusNode,
                controller: pinPutController,
                submittedFieldDecoration: pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 16, 30, 161).withOpacity(0.2),
                  ),
                  color: ColorResources.white,
                ),
                selectedFieldDecoration: pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 11, 17, 73).withOpacity(0.2),
                  ),
                  color: ColorResources.white,
                ),
                followingFieldDecoration: pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 18, 30, 141).withOpacity(0.2),
                  ),
                  color: ColorResources.white,
                ),
                disabledDecoration: pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorResources.white,
                  border: Border.all(
                    color: ColorResources.greyA0A.withOpacity(0.2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bookText("Code send in ", ColorResources.grey777, 13),
                  Countdown(
                    seconds: 60,
                    controller: controller,
                    build: (_, double time) => Text(
                      time.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: ColorResources.grey777,
                      ),
                    ),
                    onFinished: () {
                      setState(() {
                        finishTimer = true;
                        // startAgain = false;
                      });
                    },

                    // interval: Duration(minutes: 1),
                  ),
                  finishTimer == false
                      ? TextButton(
                          child: const Text(
                            "Resend code",
                            style: TextStyle(
                                fontSize: 13, color: ColorResources.grey777),
                          ),
                          onPressed: () {
                            print(finishTimer);
                            if (finishTimer == true) {
                              sendOtp(emailController);
                              controller.restart();
                              setState(() {
                                finishTimer = false;
                              });
                            }
                          },
                        )
                      : TextButton(
                          child: const Text(
                            "Resend code",
                            style: TextStyle(
                                fontSize: 13, color: ColorResources.green009),
                          ),
                          onPressed: () {
                            print(finishTimer);
                            if (finishTimer == true) {
                              sendOtp(emailController);
                              controller.restart();
                              setState(() {
                                finishTimer = false;
                              });
                            }
                          },
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void sendOtp(email) async {
  bool result = await emailAuth.sendOtp(recipientMail: email, otpLength: 6);
  if (result) {
    print("OTP sent");
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
    content: const Text("Wrong OTP entered. Please try again"),
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

void verifyOtp(email, context) async {
  bool result = emailAuth.validateOtp(
      recipientMail: email, userOtp: pinPutController.value.text);
  if (result) {
    print("OTP verified");
    validateOTP = true;
  } else {
    showAlertDialog(context);
    validateOTP = false;
  }
}
