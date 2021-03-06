import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_saja/controller/logbook_controller.dart';
import 'package:test_saja/models/glocu_measurement.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

import '../../models/intakes_model.dart';
import '../../widgets/build_section_calorises.dart';

class LogBookScreen extends StatefulWidget {
  @override
  State<LogBookScreen> createState() => _LogBookScreenState();
}

class _LogBookScreenState extends State<LogBookScreen> {
  final controller = Get.put(LogBookController());

  List<List<String>> Finish_PDF_LIST = [];
  var x;
  final divider = const Divider(
    color: Colors.blueGrey,
  );

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: null,
        backgroundColor: Colors.blueGrey,
        title: Text(
          LocaleKeys.logbook.tr,
          style: const TextStyle(color: Colors.white),
        ),

        // PDF PART
        actions: <Widget>[
          GetBuilder<LogBookController>(
            init: LogBookController(),
            builder: (_) => IconButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2050))
                    .then((value) {
                  if (value == null) {
                    Get.dialog(Center(
                      child: Card(
                        child: Container(
                          width: Get.width - 80,
                          height: Get.width * 0.35,
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: Image.asset('assets/nodata.png')),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        LocaleKeys.ok.tr,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
                  } else {
                    var c;
                    print(DateFormat.yMd().format(value));
                    for (var i = 0; i < controller.gluRow.length; i++) {
                      if (DateFormat.yMd().format(value) ==
                          controller.gluRow[i][3]) {
                        Finish_PDF_LIST.add(controller.gluRow[i]);
                        print(controller.gluRow[i]);
                        x = controller.gluRow[i][3];
                        continue;
                      }
                    }
                    if (Finish_PDF_LIST.isNotEmpty) {
                      print(Finish_PDF_LIST);
                      controller.createPDF(Glucolumn, Finish_PDF_LIST);
                      Finish_PDF_LIST.clear();
                    } else {
                      Get.dialog(Center(
                        child: Card(
                          child: Container(
                            width: Get.width - 80,
                            height: Get.width * 0.35,
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: Image.asset('assets/nodata.png')),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          LocaleKeys.ok.tr,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                    }
                  }
                });
              }, // on pressed
              icon: const Icon(
                Icons.upload_file,
                color: Colors.white70,
              ),
              tooltip: 'Export pdf',
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          children: <Widget>[
            // Calories Numbers
            StreamBuilder(
                stream: controller.getHighCal,
                builder: (context, AsyncSnapshot<List<Intakes>> snapshot) {
                  print("snapshot.data?.length => ${snapshot.data?.length}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.amber,
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      height: Get.width * 0.3,
                      child: Row(
                        children: [
                          BuildCaloriseAndClucoseWidget(
                            label: LocaleKeys.lowest_calories.tr,
                            // To check if zreo or display the accurate value
                            amount: snapshot.data!.length == 0
                                ? "0 mg/dl"
                                : snapshot.data![0].cal.toString() + 'mg/dl',
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          BuildCaloriseAndClucoseWidget(
                            label: LocaleKeys.highest_calories.tr,
                            // To check if zreo or display the accurate value
                            amount: snapshot.data!.length == 0
                                ? "0 mg/dl"
                                : snapshot.data![snapshot.data!.length - 1].cal
                                        .toString() +
                                    'mg/dl',
                            color: Colors.red,
                          ),
                        ],
                      ),
                    );
                  }
                }),
            // Calories  Table
            StreamBuilder(
                stream: controller.calTableData,
                builder: (context, AsyncSnapshot<List<Intakes>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print(
                        "snapshot.data:${snapshot.connectionState == ConnectionState.active}");
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.amber,
                      ),
                    );
                  } else {
                    print("snapshot.data:$snapshot");
                    print("snapshot.data:${snapshot.data?.length}");
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.blueGrey, width: 2),
                        ),
                      ),
                      child: ExpansionTile(
                        title: Text(LocaleKeys.glucose.tr),
                        trailing: TextButton.icon(
                            onPressed: null,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            label: Text(LocaleKeys.show.tr)),
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              color: Colors.white,
                              child: DataTable(
                                  columnSpacing: size.width * 0.08,
                                  sortColumnIndex:
                                      controller.currentSortColumn.value,
                                  sortAscending: controller.isAscending.value,
                                  headingRowColor: MaterialStateProperty.all(
                                    Colors.blueGrey,
                                  ),
                                  columns:
                                      //send column List
                                      Calcolumn.map(
                                    (e) => DataColumn(
                                      label: Text('$e'),
                                    ),
                                  ).toList(),
                                  rows:
                                      // get Rows List
                                      //fireBAse
                                      snapshot.data!
                                          .map(
                                            (cal) => DataRow(
                                              cells: [
                                                DataCell(Text(cal.type ?? '')),
                                                DataCell(
                                                    Text(cal.category ?? '')),
                                                DataCell(
                                                    Text("${cal.quantity}")),
                                                DataCell(Text("${cal.cal}")),
                                              ],
                                            ),
                                          )
                                          .toList()
                                  /*  controller.Glurow.map((ee) {
                                    return DataRow(
                                        cells: ee.map((el) {
                                      return DataCell(Text('$el'));
                                    }).toList());
                                  }).toList()),*/
                                  ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),

// ######################################################################################

// Glucose Numbers
            StreamBuilder(
                stream: controller.getHighGlu,
                builder:
                    (context, AsyncSnapshot<List<GlocuMeasurement>> snapshot) {
                  print("snapshot.data?.length => ${snapshot.data?.length}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.amber,
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      height: Get.width * 0.3,
                      child: Row(
                        children: [
                          BuildCaloriseAndClucoseWidget(
                            label: LocaleKeys.lowest_glucose_level.tr,
                            // To check if zreo or display the accurate value
                            amount: snapshot.data!.length == 0
                                ? "0 mg/dl"
                                : snapshot.data![0].result.toString() + 'mg/dl',
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          BuildCaloriseAndClucoseWidget(
                            label: LocaleKeys.highest_glucose.tr,
                            // To check if zreo or display the accurate value
                            amount: snapshot.data!.length == 0
                                ? "0 mg/dl"
                                : snapshot
                                        .data![snapshot.data!.length - 1].result
                                        .toString() +
                                    'mg/dl',
                            color: Colors.red,
                          ),
                        ],
                      ),
                    );
                  }
                }),

            // Glucose Table
            StreamBuilder(
                stream: controller.glucoTableData,
                builder:
                    (context, AsyncSnapshot<List<GlocuMeasurement>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print(
                        "snapshot.data:${snapshot.connectionState == ConnectionState.active}");
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.amber,
                      ),
                    );
                  } else {
                    print("snapshot.data:$snapshot");
                    print("snapshot.data:${snapshot.data?.length}");
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.blueGrey, width: 2),
                        ),
                      ),
                      child: ExpansionTile(
                        title: Text(LocaleKeys.glucose.tr),
                        trailing: TextButton.icon(
                            onPressed: null,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            label: Text(LocaleKeys.show.tr)),
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              color: Colors.white,
                              child: DataTable(
                                  columnSpacing: size.width * 0.08,
                                  sortColumnIndex:
                                      controller.currentSortColumn.value,
                                  sortAscending: controller.isAscending.value,
                                  headingRowColor: MaterialStateProperty.all(
                                    Colors.blueGrey,
                                  ),
                                  columns:
                                      //send column List
                                      Glucolumn.map(
                                    (e) => DataColumn(
                                      label: Text('$e'),
                                    ),
                                  ).toList(),
                                  rows:
                                      // get Rows List
                                      //fireBAse
                                      snapshot.data!
                                          .map(
                                            (glocu) => DataRow(
                                              cells: [
                                                DataCell(
                                                    Text(glocu.result ?? '')),
                                                DataCell(Text(
                                                    glocu.testPeriod ?? '')),
                                                DataCell(
                                                    Text(glocu.time ?? '')),
                                                DataCell(
                                                    Text(glocu.date ?? '')),
                                              ],
                                            ),
                                          )
                                          .toList()
                                  /*  controller.Glurow.map((ee) {
                                    return DataRow(
                                        cells: ee.map((el) {
                                      return DataCell(Text('$el'));
                                    }).toList());
                                  }).toList()),*/
                                  ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  List<String> Calcolumn = [
    LocaleKeys.type.tr,
    LocaleKeys.category.tr,
    LocaleKeys.quantity.tr,
    LocaleKeys.calories.tr,
  ].obs;

  List<String> Glucolumn = [
    LocaleKeys.result.tr,
    LocaleKeys.test_period.tr,
    LocaleKeys.time.tr,
    LocaleKeys.date.tr
  ].obs;
}
