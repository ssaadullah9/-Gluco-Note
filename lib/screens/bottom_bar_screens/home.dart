import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../mainpage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 25),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Daily Progress' , style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(90))),
          margin: EdgeInsets.only(top: 20 , left: 50 , right: 50),
          width: 30,
          height:90,
          child: Card(
              elevation: 4,
              color: Color(0xfffafafa),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Your glucose today' ,style: TextStyle(
                        fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
                    ), textAlign: TextAlign.center,),
                  ),
                  Container(
                    child: Text('10  mg/dl' ,style: TextStyle(
                        fontSize: 15 , color: Colors.orangeAccent , fontWeight: FontWeight.bold
                    ), textAlign: TextAlign.center,),
                  ),
                ],
              )

          ),

        ) ,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(90))),
          margin: EdgeInsets.only(top: 20 , left: 50 , right: 50),
          width: 30,
          height:190,
          child: Card(
              elevation: 4,
              color: Color(0xfffafafa),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Calories burnt ' ,style: TextStyle(
                        fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
                    ), textAlign: TextAlign.center,),
                  ),


                  Container(
                    child: Expanded(
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 10.0,
                        percent: 0.15,
                        animation: true,
                        animationDuration: 4000,
                        center: new Text('15.0 %' , style: TextStyle(
                            fontSize: 20
                        ),),
                        progressColor: Color(0xFFEA9363),

                      ), ),
                  ),
                ],
              )

          ),
        ) ,
        Divider(),
        Text('  Glucose, Week Average' , style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ), ),
        Spacer(),
        Container(
          height: 340,
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              series: <ChartSeries>[
                LineSeries<GlucoseDate,String>(

                    color: Color(0xFF9F87BF),
                    dataSource: getCulomnData(),
                    xValueMapper: (GlucoseDate data,_)=> data.GDay ,

                    yValueMapper: (GlucoseDate data,_)=> data.Glevel ,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside
                    )
                )
              ]
          ),
        ),
        Divider(),
      ],
    );
  }
}
