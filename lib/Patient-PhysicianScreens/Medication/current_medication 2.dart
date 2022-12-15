import '../../Utiils/colors.dart';
import '../../Utiils/common_widgets.dart';
import '../../Utiils/images.dart';
import 'package:flutter/material.dart';

class currentMedication extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF7F,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
              width: 160,
              child: Image.asset(
                Images.prescription2,
                color: ColorResources.greyA0A,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(height: 20),
            romanText("There is no medication", ColorResources.grey777, 18,
                TextAlign.center),
          ],
        ),
      ),
    );
  }
}
