import 'package:country_code_picker/country_code_picker.dart';
import 'package:medcore/Controller/gender_location_controller.dart';
import 'package:medcore/LabScreens/lab_home_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/mysqlDatabase.dart';

String Id;

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key, String id}) : super(key: key) {
    Id = id;
  }

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

  void edit() {
    print(Id);
    mysqlDatabase.editProfile("Lab specialist", nameController.text,
        emailController.text, phoneController.text, int.parse(Id));
  }

  @override
  void initState() {
    super.initState();
    getLabProfileData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLabProfileData();
  }

  void getLabProfileData() async {
    var user = await conn.query(
        'select name,NationalID,DOB,email,gender,mobileNo from LabSpecialist where NationalID=?',
        [int.parse(Id)]);
    for (var row in user) {
      setState(() {
        lname = '${row[0]}';
        lnationalId = '${row[1]}';
        lDOB = '${row[2]}'.split(' ')[0];
        lemail = '${row[3]}';
        lgender = '${row[4]}';
        lmobileNo = '${row[5]}';
      });
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
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
                const SizedBox(height: 20),
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
                textField1(lname, nameController, TextInputType.text,
                    error: errorName),
                const SizedBox(height: 5),
                if (errorName == true)
                  mediumText(
                    "Enter a valid Name",
                    Colors.red,
                    16,
                  ),
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
                textField1(lemail, emailController, TextInputType.emailAddress,
                    error: errorEmail || errorEmail2),
                const SizedBox(height: 5),
                if (errorEmail == true)
                  mediumText("Enter a valid Email", Colors.red, 16),
                if (errorEmail2 == true)
                  mediumText("Email Already used", Colors.red, 16),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(Icons.phone,
                        color: Color.fromRGBO(241, 94, 34, 0.7), size: 25),
                    const SizedBox(width: 15),
                    mediumText("Phone Number", ColorResources.grey777, 16),
                  ],
                ),
                phoneValidator(),
                const SizedBox(height: 5),
                if (errorPhone == true)
                  mediumText("Enter a valid phone number", Colors.red, 16),
                const SizedBox(height: 40),
                commonButton(() {
                  check();
                }, "Save", ColorResources.green009, ColorResources.white),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String number = "966";
  bool errorPhone = false;
  bool errorName = false;
  bool errorEmail = false;
  bool errorEmail2 = false;

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
                  showFlag: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          hintText: lmobileNo,
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

  bool validateMyName(String value) {
    Pattern pattern = r"^([a-zA-Z]{2,}\s[a-zA-Z]{2,})";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value != "") {
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

  bool validateMyPhone(String value) {
    Pattern pattern = r'^[0-9]{9}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value != "") {
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

  bool validateEmail(String value) {
    Pattern pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
    // Pattern pattern = r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$";
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value) || value == "") {
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

  bool allValid2 = false;
  bool isFound = false;

  Future<void> check() async {
    isFound = await mysqlDatabase.checkExisting(
        emailController.text, "Physician", "email");
    setState(() {
      allValid2 = false;
    });
    validateMyName(nameController.text);
    validateEmail(emailController.text);
    validateMyPhone(phoneController.text);

    if (!errorEmail && !errorName && !errorPhone) {
      setState(() {
        allValid2 = true;
      });
    }
    if (isFound == true) {
      setState(() {
        errorEmail2 = true;
      });
    } else if (isFound == false) {
      errorEmail2 = false;
    }
    if (nameController.text == "" &&
        emailController.text == "" &&
        phoneController.text == "") {
      showAlertDialog2(context);
    } else if (isFound == false && allValid2) {
      showAlertDialog1(context);
    }
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
        edit();
        Navigator.pop(context, 'refresh');
        //Navigator.pop(context);
        Get.to(LabHomePage1(
          id: Id,
          page: 'edit',
        ));
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

  showAlertDialog2(BuildContext context) {
    String content = "There is nothing changed";

    Widget OKButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(content),
      actions: [OKButton],
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
