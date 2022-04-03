import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/home_controller.dart';
import '../mainpage.dart';

class Home extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override

  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: Get.width*0.05),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02,
            vertical: Get.width * 0.05
          ),
          child: Text('Daily Progress' , style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
              horizontal: Get.width * 0.1,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05,
              vertical: Get.width * 0.05
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.23),
                offset: Offset(0,8),
                blurRadius: 5.0
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your glucose today' ,style: TextStyle(
                  fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
              ),),
              SizedBox(height: Get.width * 0.015,),
              Text(controller.GlucoseVal[controller.GlucoseVal.length-1].toString()+' mg/dl' ,style: TextStyle(
                  fontSize: 15 , color: Colors.orangeAccent , fontWeight: FontWeight.bold
              )),
            ],
          ),
        ) ,
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.1,
            vertical: Get.width * 0.05
          ),
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05,
              vertical: Get.width * 0.06
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.23),
                    offset: Offset(0,8),
                    blurRadius: 5.0
                )
              ]
          ),
          height: Get.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Calories burnt ' ,style: TextStyle(
                  fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
              )),
              Expanded(
                child: CircularPercentIndicator(
                  radius: Get.width * 0.15,
                  lineWidth: 10.0,
                  percent: 0.55,                  //FireBase
                  animation: true,
                  animationDuration: 2000,
                  center:  Text('15.0 %' , style: TextStyle(
                      fontSize: 20
                  ),),
                  progressColor: Color(0xFFEA9363),

                ), )
            ],
          ),
        ) ,
        Divider(),
        Text('  Glucose, Week Average' , style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ), ),
        Container(
          height: Get.width * 0.8,
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              series: <ChartSeries>[
                LineSeries<GlucoseDate,String>(
                    color: Color(0xFF9F87BF),
                    dataSource: getCulomnData(),
                    xValueMapper: (GlucoseDate data,_)=> data.GDay ,
                    yValueMapper: (GlucoseDate data,_)=> data.Glevel,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside
                    )
                )
              ]
          ),
        ),
      ],
    );

  }
}
