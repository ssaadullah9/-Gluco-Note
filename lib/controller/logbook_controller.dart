import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import '/model.dart';
class LogBookController extends GetxController{

  var currentSortColumn = 0.obs;
  var isAscending = true.obs;
  CollectionReference? Glucoref;
  CollectionReference? Calref;
  CollectionReference?  HGlucoref;
  CollectionReference?  HCalref;

  List<List<String>> Calrow  = [
  ];


  List<List<String>> Glurow =[

  ];
  List HighestGlu = [
  ] ;

  List HighestCal = [

  ] ;



  Future<void> createPDF(List column,List rows) async {
    PdfDocument document =  PdfDocument();
    PdfGrid pdfGrid1 = PdfGrid();
    pdfGrid1.style = PdfGridStyle(
        cellPadding: PdfPaddings(
            left: 5,
            top: 2,
            bottom: 2
        )
    );
    pdfGrid1.columns.add(count: column.length);
    pdfGrid1.headers.add(1);
    PdfGridRow header1 = pdfGrid1.headers[0];
    // header.cells[0].value = 'Hello';
    // header.cells[1].value = 'Hello1';
    // header.cells[2].value = 'Hello2';
    for(int i = 0 ; i < column.length ; i++){
      header1.cells[i].value = column[i];
    }
    PdfGridRow row1;
    for(int i = 0 ; i < rows.length ; i ++){
      row1 = pdfGrid1.rows.add();
      for(int j = 0 ; j < rows[i].length ; j++){
        row1.cells[j].value = rows[i][j];
      }
    }
    // PdfGridRow row = pdfGrid.rows.add();
    // row.cells[0].value =  'row1';
    // row.cells[1].value = 'row2';
    // row.cells[2].value = 'row3';
    //
    // row= pdfGrid.rows.add();
    // row.cells[0].value = 'row11';
    // row.cells[1].value = 'row22';
    // row.cells[2].value = 'row33';
    //
    // row= pdfGrid.rows.add();
    // row.cells[0].value = 'row111';
    // row.cells[1].value = 'row222';
    // row.cells[2].value = 'row333';

    pdfGrid1.draw(page: document.pages.add(),
        bounds:  Rect.fromLTWH( 0, 0, 0,0)
    );
    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  Future<void> getGtableData() async {
    Glucoref = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await Glucoref!.get().then((snapShot) {
      for (var i = 0; i < snapShot.docs.length; i++) {
        Glurow.add([]);
        for (var j = 0; j < 3; j++) {
          Glurow[i].add(snapShot.docs[i]['Result'].toString());
          Glurow[i].add(snapShot.docs[i]['Test_preiod'].toString());
          Glurow[i].add(snapShot.docs[i]['Time'].toString());
          Glurow[i].add(DateFormat.yMd().format(DateTime.parse(snapShot.docs[i]['Date'])).toString());

          break;
        }
      }
    });
    update();
  }

  Future<void> getGluData() async {
    HGlucoref  = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await HGlucoref!.orderBy("Result" ,descending: true).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        print(element["Result"]);
        HighestGlu.add(element['Result']);
      });

    });
  }

  Future<void> getCalData() async {
    HCalref = FirebaseFirestore.instance.collection("intakes");
    await HCalref!.orderBy("intakes_Cal" ,descending: true).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        print(element["intakes_Cal"]);
        HighestCal.add(element['intakes_Cal']);
      });

    });
  }
  Future<void> getCtableData() async{
    Calref = FirebaseFirestore.instance.collection("intakes");
    await Calref!.get().then((snapShot)
    {
      for(var i = 0 ; i < snapShot.docs.length ; i++){
        Calrow.add([]);
        for(var j = 0 ; j<4;j++ ){
          Calrow[i].add(snapShot.docs[i]['intakes_type'].toString());
          Calrow[i].add(snapShot.docs[i]['intakes_category'].toString());
          Calrow[i].add(snapShot.docs[i]['intakes_Quantity'].toString());
          Calrow[i].add(snapShot.docs[i]['intakes_Cal'].toString());



          break;
        }
      }
      print(Glurow);
    });
    update();
  }

  @override
  void onInit() {
    getGtableData();
    getGluData();
    getCalData();
    getCtableData();
    super.onInit();
  }
}