import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

import '../../controller/home_controller.dart';
import '../../models/glocu_measurement.dart';

class Home extends StatelessWidget {
  final controller = Get.put(HomeController());
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(bottom: Get.width * 0.05),
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02, vertical: Get.width * 0.05),
            child: Text(
              LocaleKeys.daily_progress.tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: Get.width * 0.1,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.width * 0.05),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.23),
                      offset: const Offset(0, 8),
                      blurRadius: 5.0)
                ]),
            child: StreamBuilder(
              stream: controller.getHighGlu,
              builder:
                  (context, AsyncSnapshot<List<GlocuMeasurement>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.amber,
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.glucos_today.tr,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.width * 0.015,
                      ),
                      // To check if the Value is zero or no
                      Text(
                          snapshot.data!.length == 0
                              ? "0 mg/dl"
                              : snapshot.data![snapshot.data!.length - 1].result
                                      .toString() +
                                  ' mg/dl',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold)),
                    ],
                  );
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.1, vertical: Get.width * 0.05),
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.width * 0.06),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.23),
                      offset: const Offset(0, 8),
                      blurRadius: 5.0)
                ]),
            height: Get.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.cal_burned.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                StreamBuilder(
                    stream: controller.IndecatorRef!.snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: SpinKitCircle(
                            color: Colors.amber,
                          ),
                        );
                      } else {
                        print(snapshot);
                        return Expanded(
                          child: CircularPercentIndicator(
                            radius: Get.width * 0.15,
                            lineWidth: 10.0,
                            // Retrieve the data from firebase , checking if Calories per is zero or no
                            percent: controller.CalPer.length == 0
                                ? 0
                                : double.parse(
                                    controller.CalPer.last.toString()),
                            animation: true,
                            animationDuration: 2000,
                            center: Text(
                              controller.CalVal.length == 0
                                  ? "0"
                                  : controller.CalVal.last.toStringAsFixed(2),
                              style: TextStyle(fontSize: 20),
                            ),
                            progressColor: Color(0xFFEA9363),
                          ),
                        );
                      }
                    })
              ],
            ),
          ),
          const Divider(),
          Text(
            LocaleKeys.glu_week.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: Get.width * 0.8,
            child: StreamBuilder(
                stream: controller.getChartData(),
                builder: (context, AsyncSnapshot<List<GlucoseData>> snapshot) {
                  print("snapshot.data?.length => ${snapshot.data?.length}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.amber,
                      ),
                    );
                  } else {
                    return SfCartesianChart(
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                        ),
                        tooltipBehavior: controller.tooltipBehavior,
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                        series: <ChartSeries>[
                          ScatterSeries<GlucoseData, dynamic>(
                            name: LocaleKeys.glu_level.tr,
                            enableTooltip: true,
                            color: const Color(0xFF9F87BF),
                            dataSource: controller.ChartList,
                            xValueMapper: (GlucoseData data, _)
                                // EEE = dispalying only weekdays
                                =>
                                intl.DateFormat.EEEE()
                                    .format(DateTime.parse(data.GDay)),
                            yValueMapper: (GlucoseData data, _) =>
                                int.tryParse(data.Glevel),
                          ),
                        ]);
                  }
                }),
          )
        ],
      ),
    );
  }
}

class GlucoseData {
  var GDay;
  var Glevel;
  GlucoseData(this.GDay, this.Glevel);
}
