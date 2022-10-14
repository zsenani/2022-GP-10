import 'package:get/get.dart';

class GenderLocationController extends GetxController {
  var selectedValue;

  void setSelected(String value) {
    selectedValue = value;
    update();
  }

  List<String> gender = [
    "FEMALE",
    "MALE",
  ];
}
