import 'dart:async';
import 'package:medcore/index.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(
      const Duration(seconds: 2),
      () => Get.off(index()),
    );
    super.onInit();
  }
}
