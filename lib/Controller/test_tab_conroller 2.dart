import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcore/Utiils/common_widgets.dart';

class LabTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Active'),
    Tab(text: 'Previous'),
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

  // void button() {
  //   Container(
  //     child:
  //         labTests.role == 'physician' && tabBarController.controller.index == 0
  //             ? Flexible(
  //                 flex: 2,
  //                 child: InkWell(
  //                   onTap: () {
  //                     _startAdd(context);
  //                   },
  //                   child: Padding(
  //                     padding: EdgeInsets.only(
  //                       right: 20,
  //                     ),
  //                     child: Container(
  //                       padding: EdgeInsets.only(right: 24, left: 7),
  //                      height: 40,
  //                       width: 40,
  //                       decoration: BoxDecoration(
  //                         color: ColorResources.green009.withOpacity(0.8),
  //                         borderRadius: BorderRadius.circular(10),
  //                         border: Border.all(
  //                           color: ColorResources.green009.withOpacity(0.2),
  //                           width: 1,
  //                         ),
  //                       ),
  //                       child: Center(
  //                         child: Icon(Icons.add, color: ColorResources.white),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             : labTests.role == 'physician' &&
  //                     tabBarController.controller.index == 1
  //                 ? InkWell(
  //                     onTap: () {
  //                       _startAdd2(context);
  //                     },
  //                     child: Flexible(
  //                       flex: 1,
  //                       child: Container(
  //                         height: 40,
  //                         width: 40,
  //                         decoration: BoxDecoration(
  //                           color: ColorResources.whiteF6F,
  //                           borderRadius: BorderRadius.circular(10),
  //                           border: Border.all(
  //                             color: ColorResources.white.withOpacity(0.2),
  //                             width: 1,
  //                           ),
  //                         ),
  //                         child: Center(
  //                           child: Icon(Icons.filter_alt,
  //                               color: ColorResources.grey777),
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                 : Container(),
  //   );
  // }
}
