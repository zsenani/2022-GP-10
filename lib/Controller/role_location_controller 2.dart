import 'package:get/get.dart';

class RoleLocationController extends GetxController {
  var selectedValue;

  void setSelected(String value) {
    selectedValue = value;
    update();
  }

  List<String> role = [
    "Physician",
    "Lab specialist",
  ];
}
