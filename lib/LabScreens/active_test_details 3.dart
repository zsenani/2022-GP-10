import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/LabScreens/lab_home_screen.dart';
import 'package:medcore/Utiils/images.dart';

class ActiveTestDetails extends StatelessWidget {
  // OnlineAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF6F,
      appBar: AppBar(
        backgroundColor: ColorResources.whiteF6F,
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
        title: mediumText("Test Request", ColorResources.grey777, 24),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                mediumText("Request No. 234224",
                                    ColorResources.grey777, 24),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: ColorResources.greyD4D.withOpacity(0.4),
                  thickness: 1,
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Image.asset(
                        Images.doctor1,
                        height: 27,
                        width: 27,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText("Physician information",
                            ColorResources.grey777, 18),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            bookText("Name   :   ", ColorResources.greyA0A, 16),
                            mediumText(
                                "Dr. Tierra Riley", ColorResources.grey777, 16),
                          ],
                        ),
                        const SizedBox(height: 10),
                        romanText(
                            "Cardiologist - Accra Medical College Hospital",
                            ColorResources.greyA0A,
                            14),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/clock.png',
                      height: 27,
                      width: 27,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText("Visit time", ColorResources.grey777, 18),
                        const SizedBox(height: 10),
                        romanText("Today - 10 June, 2022",
                            ColorResources.green009, 16),
                        const SizedBox(height: 10),
                        romanText(
                            "10:00 AM - 11:00 AM", ColorResources.green009, 16),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/user.png',
                      height: 27,
                      width: 27,
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText(
                            "Patient information", ColorResources.grey777, 18),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            bookText("Name   :   ", ColorResources.greyA0A, 16),
                            mediumText("John Doe", ColorResources.grey777, 16),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            bookText(
                                "Age      :   ", ColorResources.greyA0A, 16),
                            mediumText("21", ColorResources.grey777, 16),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            bookText(
                                "Phone   :   ", ColorResources.greyA0A, 16),
                            mediumText(
                                "+966 5668 44776", ColorResources.grey777, 16),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/lab.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText(
                                "Required Tests", ColorResources.grey777, 18),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                    DataTable(
                      columns: const [
                        DataColumn(
                          label: Text('MPV',
                              style: TextStyle(
                                fontSize: 19,
                              )),
                        ),
                        DataColumn(
                          label: Text('MCH',
                              style: TextStyle(
                                fontSize: 19,
                              )),
                        ),
                      ],
                      rows: const [
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                'RDW',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'MCHC',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                'RBC',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'Hgb',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                'Hct',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'Phosphoru s',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                'MCV',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'Potassium',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                'Uric Acid',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'Sodium',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/file.png',
                          height: 27,
                          width: 27,
                          alignment: Alignment.centerLeft,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              child: const Text(
                                'select results file here',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: () async {
                                FilePickerResult resultFile =
                                    await FilePicker.platform.pickFiles();
                                //   if (resultFile == null) {
                                //     print("No file selected");
                                //   } else {
                                //     print(resultFile.files.single.name);
                                //   }
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    commonButton(() {
                      showAlertDialog(context);
                    }, "Upload", const Color.fromRGBO(19, 156, 140, 1),
                        ColorResources.white),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
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
        "Upload",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: () {
        Get.to(LabHomePage1());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Upload Results"),
      content: const Text("Are you sure you want to upload results?"),
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
