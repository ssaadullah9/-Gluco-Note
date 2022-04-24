import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:test_saja/controller/logbook_controller.dart';
import 'package:test_saja/model.dart';

import '../../widgets/build_section_calorises.dart';

class LogBookScreen extends StatelessWidget {
  final controller = Get.put(LogBookController());
  List<List<String>>  Finish_PDF_LIST = [];

  final divider= Divider(
    color: Colors.blueGrey,
  );


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: null,
          backgroundColor: Colors.blueGrey,
          title: Text('Logbook', style: TextStyle(
              color: Colors.white
          ),),
          actions: <Widget>[
            GetBuilder<LogBookController>(
              init: LogBookController(),
              builder: (_)=>IconButton(
                onPressed:(){
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2050)).then((value){
                    if(value==null){
                      Get.dialog(
                          Center(
                            child:Card(
                              child: Container(
                                width: Get.width - 80,
                                height: Get.width *0.35,
                                padding: EdgeInsets.only(
                                    left: size.width *0.05
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12.0)
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(child: Image.asset('assets/nodata.png')),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(onPressed: (){
                                          Get.back();
                                        },
                                            child: Text("OK",style: TextStyle(
                                                color: Colors.black
                                            ),))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      );
                    }else{
                      var c;
                      print(value);

               controller.Glurow.forEach((element) {
                 for(var i =0 ; i < element.length ; i++){
                   if(DateFormat.yMd().format(value)==DateTime.parse(element[3])){
                    Finish_PDF_LIST.add(controller.Glurow[i]) ;
                   }
                 }
               }) ;
                      controller.createPDF(
                          Glucolumn,
                          /*controller.Glurow*/
                        Finish_PDF_LIST
                      );
                    }
                  });
                },
                icon:  Icon(Icons.upload_file, color: Colors.white70,),
                tooltip: 'Export pdf',
              ),),
          ],
        ),
        body: ListView(
          children: <Widget>[

            FutureBuilder(
              future: controller.HCalref!.get(),
              builder: (context,AsyncSnapshot snapshot)
              {
                if(!snapshot.hasData){
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.amber,
                    ),
                  );
                } else{
                  return Container(
                    padding:const EdgeInsets.all(12.0),
                    height: Get.width * 0.3,
                    child: Row(
                      children: [

                        BuildCaloriseAndClucoseWidget(
                          label: 'Lowest Caloriess',
                         /* amount:  controller.HighestCal.last.toString().isEmpty ?"" :'${
                              controller.HighestCal.last.toString()
                          } Cal',*/
                          color: Colors.green,
                        ),
                        SizedBox(width: size.width *0.05,),
                        BuildCaloriseAndClucoseWidget(
                          label: 'Highest Caloriess',
                         /* amount: controller.HighestCal[0].toString().isEmpty ?"" :'${
                              controller.HighestCal[0].toString()
                          } Cal',*/
                          color: Colors.red,
                        ),
                      ],
                    ),
                  );
                }
              } , ) ,
           // Cal Table
            FutureBuilder(
              future: controller.Calref!.get(),
              builder: (context,AsyncSnapshot snapshot)
              {
                if(!snapshot.hasData){
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.amber,
                    ),
                  );
                } else{
                  return       Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Colors.blueGrey,
                              width: 2
                          ),
                        )
                    ),
                    child: ExpansionTile(
                      title: Text('Calories', style: TextStyle(
                          color: Colors.black
                      )),
                      trailing: FlatButton.icon(
                          onPressed: null, icon: Icon(Icons.keyboard_arrow_down_outlined), label: Text('Show')),
                      children: [
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:DataTable(
                                headingRowColor:
                                MaterialStateProperty
                                    .all(Colors
                                    .blueGrey),
                                //ToDO Firebase
                                columns:  Calcolumn.map((e) => DataColumn(
                                  label: Text(e),
                                )).toList(),

                                rows: controller.Calrow.map((e) {
                                  return DataRow(
                                      cells: e.map((e){
                                        return DataCell(
                                            Text('$e')
                                        );
                                      }).toList()
                                  );
                                }).toList()

                            )
                        ),
                      ],
                    ),
                  );
                }
              } , ) ,

              // Glucose Number
            StreamBuilder(
              stream: controller.HGlucoref!.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return Container(
                  padding:const EdgeInsets.all(12.0),
                  height: Get.width * 0.3,
                  child: Row(
                    children: [
                      BuildCaloriseAndClucoseWidget(
                        label: 'Lowest Glucose Level',
                    /*    amount:controller.HighestGlu[0].toString().isEmpty ?"" :controller.HighestGlu[0].toString()+  'mg/dl',*/
                        color: Colors.green,
                      ),
                      SizedBox(width: size.width *0.05,),
                      BuildCaloriseAndClucoseWidget(
                        label: 'Highest Glucose Level' ,
                       /* amount:controller.HighestGlu.last.toString().isEmpty ?""
                            :controller.HighestGlu.last.toString()+  'mg/dl',*/
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              }
            ),
              // Glucose Table
         /*   FutureBuilder(
              future: controller.Glucoref!.get(),
              builder: (context,AsyncSnapshot snapshot)
              {
                if(!snapshot.hasData){
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.amber,
                    ),
                  );
                } else{
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10.0
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Colors.blueGrey,
                              width: 2
                          ),
                        )
                    ),

                    child: ExpansionTile(
                      title: Text('Glucose'),
                      trailing: FlatButton.icon(
                          onPressed: null, icon: Icon(Icons.keyboard_arrow_down_outlined), label: Text('Show')),
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            color: Colors.white,
                            child: DataTable(
                                columnSpacing: size.width *0.08 ,
                                sortColumnIndex: controller.currentSortColumn.value,
                                sortAscending: controller.isAscending.value,
                                headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
                                columns:
                                //send column List
                                Glucolumn.map((e) => DataColumn(
                                  label: Text('$e'),
                                )).toList(),
                                rows:
                                // get Rows List
                                //fireBAse
                                controller.Glurow.map((ee) {
                                  return DataRow(
                                      cells: ee.map((el){
                                        return DataCell(
                                            Text('$el')
                                        );
                                      }).toList()
                                  );
                                }).toList()
                            ),
                          ),
                        ),
                      ],),
                  );
                }
              } , ) ,*/
    StreamBuilder(
      stream: controller.Glucoref!.snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
    if(!snapshot.hasData){
    return Center(
    child: SpinKitCircle(
    color: Colors.amber,
    ),
    );
    } else{
        return Container(
        margin: EdgeInsets.symmetric(
        vertical: 10.0
        ),
        decoration: BoxDecoration(
        border: Border(
        top: BorderSide(
        color: Colors.blueGrey,
        width: 2
        ),
        )
        ),

        child: ExpansionTile(
        title: Text('Glucose' , style: TextStyle(
          color: Colors.black
        ),),
        trailing: FlatButton.icon(
        onPressed: null, icon: Icon(Icons.keyboard_arrow_down_outlined), label: Text('Show')),
        children: [
        SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
        color: Colors.white,
        child: DataTable(
        columnSpacing: size.width *0.08 ,
        sortColumnIndex: controller.currentSortColumn.value,
        sortAscending: controller.isAscending.value,
        headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
        columns:
        //send column List
        Glucolumn.map((e) => DataColumn(
        label: Text('$e'),
        )).toList(),
        rows:
        // get Rows List
        //fireBAse
        controller.Glurow.map((ee) {
        return DataRow(
        cells: ee.map((el){
        return DataCell(
        Text('$el')
        );
        }).toList()
        );
        }).toList()
        ),
        ),
        ),
        ],),
        );
      } }
    ) ,


          ],

        )

    );
  }

  List<String> Calcolumn = [
    'Type',
    'category',
    'Quantity',
    'Calories',
  ].obs;
  List<String> Glucolumn = [
    'Result',
    'Test_preiod',
    'Time',
    'Date'
  ].obs;

}