import 'package:medcore/Controller/gender_location_controller.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPhysicianProfileScreen extends StatefulWidget {
  // EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditPhysicianProfileScreen> createState() =>
      _EditPhysicianProfileScreen();
}

class _EditPhysicianProfileScreen extends State<EditPhysicianProfileScreen> {
  final GenderLocationController locationController =
      Get.put(GenderLocationController());

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  // ignore: prefer_typing_uninitialized_variables
  var fileImage;

  bool isImageChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF7F,
      appBar: AppBar(
        backgroundColor: ColorResources.whiteF7F,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18, top: 8, bottom: 8),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: ColorResources.whiteF6F,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorResources.greyA0A.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: const Center(
                child: Icon(Icons.arrow_back, color: ColorResources.grey777),
              ),
            ),
          ),
        ),
        title: mediumText("Edit profile", ColorResources.grey777, 24),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 45),
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Container(
                        height: 125,
                        width: 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorResources.greyEDE,
                        ),
                        child: Center(
                          child: Image.asset('assets/images/profile.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/user.png',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 15),
                    mediumText("Name", ColorResources.grey777, 16),
                  ],
                ),
                textField1("John Doe", nameController, TextInputType.text),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/email.png',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 15),
                    mediumText("Email", ColorResources.grey777, 16),
                  ],
                ),
                textField1("johndoe@gmail.com", emailController,
                    TextInputType.emailAddress),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/phoneNo.png',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 15),
                    mediumText("Phone No", ColorResources.grey777, 16),
                  ],
                ),
                textField1(
                    "0555774474", emailController, TextInputType.emailAddress),
                const SizedBox(height: 60),
                commonButton(() {
                  showAlertDialog1(context);
                }, "Save", ColorResources.green009, ColorResources.white),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog1(BuildContext context) {
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
        "Save",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        // Get.to(LabHomePage1());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Save changes"),
      content: const Text("Are you sure you want to edit your information?"),
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
}
