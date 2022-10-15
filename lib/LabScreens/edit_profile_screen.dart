import 'package:medcore/Controller/gender_location_controller.dart';
import 'package:medcore/LabScreens/lab_home_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medcore/LabScreens/lab_profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  // EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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

  _getImageGallery() async {
    //  XFile? image = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    XFile image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      fileImage = image;
      isImageChange = true;
    });
  }

  _getImageCamera() async {
    var image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      fileImage = image;
      isImageChange = true;
    });
  }

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
                    Positioned(
                      right: 80,
                      top: -10,
                      child: InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              height: 100,
                              width: Get.width,
                              color: ColorResources.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _getImageCamera();

                                            Get.back();
                                          },
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: ColorResources.green009,
                                            size: 28,
                                          ),
                                        ),
                                        Text(
                                          "Camera",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: ColorResources.black,
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_BOOK,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _getImageGallery();
                                            Get.back();
                                          },
                                          child: const Icon(
                                            Icons.image_outlined,
                                            color: ColorResources.green009,
                                            size: 28,
                                          ),
                                        ),
                                        Text(
                                          "Gallery",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: ColorResources.black,
                                            fontFamily: TextFontFamily
                                                .AVENIR_LT_PRO_BOOK,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
                      'assets/images/location-pin.png',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 15),
                    mediumText("Adress", ColorResources.grey777, 16),
                  ],
                ),
                textField1("Saudi Arabia,Riyadh", emailController,
                    TextInputType.emailAddress),
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
