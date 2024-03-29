import 'package:medcore/Controller/rout_controller.dart';
import 'package:medcore/Patient-PhysicianScreens/SearchSymptoms/search_screen.dart';
import 'package:medcore/Patient-PhysicianScreens/home_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/common_widgets.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:medcore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class SearchResults extends StatefulWidget {
  @override
  State<SearchResults> createState() => SearchResultsState();
}

final colorList = <Color>[
  // ColorResources.orange,
  ColorResources.lightBlue2,
  ColorResources.green009,
  const Color.fromRGBO(26, 217, 194, 1),
  const Color.fromRGBO(142, 209, 206, 1),
  const Color.fromRGBO(23, 186, 167, 1),
  const Color.fromRGBO(15, 126, 113, 1),
];

class SearchResultsState extends State<SearchResults> {
  //  SpeciaListScreen({Key? key}) : super(key: key);
  String Id = Get.arguments;
  void initState() {
    super.initState();
  }

  Widget loadingPage() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.grey777,
      ),
    );
  }

  final RoutController routController = Get.put(RoutController());

  Widget HeaderWidget2() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(80),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorResources.green.withOpacity(0.2),
                ColorResources.lightBlue.withOpacity(0.2),
              ],
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    loading1 = true;
                    loadingSearch = true;
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back,
                      color: ColorResources.grey777),
                ),
              ),
              const SizedBox(width: 90),
              heavyText(
                  "Search Results", ColorResources.green, 22, TextAlign.center),
              const SizedBox(width: 70),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 3),
                child: InkWell(
                  onTap: () {
                    selectedSymptoms = [];
                    commonSymptoms = [];
                    Get.to(HomeScreen(id: Id));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: const Icon(Icons.home_outlined,
                        color: ColorResources.grey777),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.whiteF6F,
        body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
                child: Column(children: [
              HeaderWidget2(),
              Column(
                children: [
                  const Text(
                    "Predicted Diagnosis :",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    diagnosis,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: ColorResources.orange,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Patient’s symptoms diagnosed by $diagnosis :",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: PieChart(
                      dataMap: pieCH,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 40,
                      chartRadius: MediaQuery.of(context).size.width / 3,
                      colorList: colorList,
                      initialAngleInDegree: 0,
                      chartType: ChartType.disc,
                      ringStrokeWidth: 32,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: true,
                        decimalPlaces: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Physicians who diagnosed $diagnosis :",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 20, bottom: 80),
                    shrinkWrap: true,
                    itemCount: results1.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorResources.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.asset('assets/images/doctor3.png',
                                  height: 40, width: 40),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    mediumText(results1[index][0],
                                        ColorResources.grey777, 18),
                                    const SizedBox(height: 3),
                                    RichText(
                                      text: TextSpan(
                                        text: "E-mail: ${results1[index][1]}",
                                        style: TextStyle(
                                          fontFamily:
                                              TextFontFamily.AVENIR_LT_PRO_BOOK,
                                          fontSize: 15,
                                          color: ColorResources.grey777,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "Phone Number: 0${results1[index][2]}",
                                        style: TextStyle(
                                          fontFamily:
                                              TextFontFamily.AVENIR_LT_PRO_BOOK,
                                          fontSize: 15,
                                          color: ColorResources.grey777,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]))));
  }
}
