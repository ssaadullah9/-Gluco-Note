import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_saja/controller/logbook_controller.dart';
import 'package:test_saja/model.dart';

import '../widgets/build_section_calorises.dart';

class LogBookScreen extends StatelessWidget {
  final controller = Get.put(LogBookController());
  final divider= Divider(
  color: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                       firstDate: DateTime.now(),
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
                           controller.createPDF();
                         }
                   });
                  },
                  icon: const Icon(Icons.upload_file)))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding:const EdgeInsets.all(12.0),
            height: Get.width * 0.3,
            child: Row(
              children: [
                BuildCaloriseAndClucoseWidget(
                  label: 'Lowest Caloriess',
                  amount: '100 cal',
                  color: Colors.green,
                ),
                SizedBox(width: size.width *0.05,),
                BuildCaloriseAndClucoseWidget(
                  label: 'Highest Caloriess',
                  amount: '300 cal',
                  color: Colors.red,
                ),
              ],
            ),
          ),
            // DataTable part
          // for bisrcollable You can use two SingleChildScrollView or one InteractiveViewer.
          Container(
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
              title: Text('Caloriess'),
            trailing: FlatButton.icon(
                onPressed: null, icon: Icon(Icons.keyboard_arrow_down_outlined), label: Text('show')),
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    columnSpacing: size.width *0.08 ,
                    sortColumnIndex: controller.currentSortColumn.value,
                    sortAscending: controller.isAscending.value,
                    headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
                    columns:
                    //send column List
                    column.map((e) => DataColumn(
                      label: Text(e),
                    )).toList(),
                    rows:
                    // get Rows List
                    row.map((e) => DataRow(
                        cells: e.map((e) => DataCell(
                            Text(e)
                        )).toList()
                    )).toList()
                ),
/*
DataRow(cells: [
                        DataCell(Text('Solid Intake')),
                        DataCell(Text('10:20 ')),
                        DataCell(Text('12/12/2022')),
                        DataCell(Text('100 Cal')),
                        DataCell(Text('Egg')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Solid Intake')),
                        DataCell(Text('17:00 ')),
                        DataCell(Text('12/12/2022')),
                        DataCell(Text('300 Cal')),
                        DataCell(Text('Meat')),

                      ]),
 */
              ),
            ],
            ),
          ),
          // Glucose Part
          Container(
            padding:const EdgeInsets.all(12.0),
            height: Get.width * 0.3,
            child: Row(
              children: [
                BuildCaloriseAndClucoseWidget(
                  label: 'Lowest Glucose Level',
                  amount: '5.6 mg/dl',
                  color: Colors.green,
                ),
                SizedBox(width: size.width *0.05,),
                BuildCaloriseAndClucoseWidget(
                  label: 'Highest Glucose Level',
                  amount: '10 mg/dl',
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Container(
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
              title: Text('Clucose'),
              trailing: FlatButton.icon(
                  onPressed: null, icon: Icon(Icons.keyboard_arrow_down_outlined), label: Text('show')),
              children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Container(
                  color: Colors.white,
                  child: DataTable(
                      columnSpacing: 30.0 ,
                      sortColumnIndex: controller.currentSortColumn.value,
                      sortAscending: controller.isAscending.value,
                      headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
                      columns: [
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Time')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Glucose Level')),

                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Low')),
                          DataCell(Text('10:20 ')),
                          DataCell(Text('12/12/2022')),
                          DataCell(Text('5.6  mg/dl ')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('High')),
                          DataCell(Text('16:33 ')),
                          DataCell(Text('12/12/2022')),
                          DataCell(Text('10 mg/dl ')),
                        ]),

                      ]
                  ),
                ),

              ),
            ],),
          ),
        ],

      ),

    );
  }
List<String> column = [
  'Type',
  'Time',
  'Date',
  'Calories',
  'Details',
];
  List<List<String>> row  = [
    ['Solid','10','${intl.DateFormat.yMd().format(DateTime.now())}','100 Cal','Egg'],
    ['Solid','06','${intl.DateFormat.yMd().format(DateTime.now())}','120 Cal','Bread'],
    ['Solid','12','${intl.DateFormat.yMd().format(DateTime.now())}','160 Cal','Oil'],
    ['Solid','15','${intl.DateFormat.yMd().format(DateTime.now())}','10 Cal','Meat'],
  ];
}