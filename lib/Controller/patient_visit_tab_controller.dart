import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Upcomming'),
    const Tab(text: 'Previous'),
  ];

//  late TabController controller;
  TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
