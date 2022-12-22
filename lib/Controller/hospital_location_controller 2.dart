import 'package:get/get.dart';

class HospitalLocationController extends GetxController {
  var selectedValue;

  void setSelected(String value) {
    selectedValue = value;
    update();
  }

  List<String> hospital = [
    "King Khalid Hospital",
    "AlHabib Hospiital",
  ];
}
