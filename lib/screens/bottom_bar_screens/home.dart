import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/home_controller.dart';
import '../mainpage.dart';

class Home extends StatelessWidget {
  final controller = Get.put(HomeController());



  @override

  Widget build(BuildContext context) {
    double perc = controller.CalVal.last;
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

            child: FutureBuilder(
              future: controller.Glucose!.get() ,
              builder: ( context, AsyncSnapshot snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child:SpinKitCircle(
                      color: Colors.amber,
                    ),
                  );
                }
                else{
                  return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Your glucose today' ,style: TextStyle(
                fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
                ),),
                SizedBox(height: Get.width * 0.015,),
                Text(controller.GlucoseVal.last.toString()+' mg/dl' ,style: TextStyle(
                fontSize: 15 , color: Colors.orangeAccent , fontWeight: FontWeight.bold
                )),

                ],
                );
                }
              },
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
              Text('Calories burned ' ,style: TextStyle(
                  fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
              )),

              StreamBuilder(
                stream: controller.IndecatorRef!.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if(!snapshot.hasData){
                    return Center(
                      child:SpinKitCircle(
                        color: Colors.amber,
                      ),
                    );
                  }
                  else
                  return Expanded(
                    child: CircularPercentIndicator(
                      radius: Get.width * 0.15,
                      lineWidth: 10.0,
                     percent: double.parse(controller.CalPer[0].toString()),     //FireBase
                      animation: true,
                      animationDuration: 2000,
                      center:  Text(perc.toStringAsFixed(2), style: TextStyle(
                          fontSize: 20
                      ),),
                      progressColor: Color(0xFFEA9363),

                    ), );
                }
              )
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
              xAxisName : "ssss",
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
