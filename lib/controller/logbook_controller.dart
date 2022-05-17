import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:test_saja/models/glocu_measurement.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

import '/model.dart';

class LogBookController extends GetxController {
  var user = FirebaseAuth.instance.currentUser;
  var currentSortColumn = 0.obs;
  var isAscending = true.obs;
  CollectionReference? glucoRef;
  CollectionReference? calRef;
  CollectionReference? hGlucoRef;
  CollectionReference? hCalRef;

  List<List<String>> calRow = [];
  List<List<String>> gluRow = [];
  List<GlocuMeasurement> glocuMeasurements = [];
  List<GlocuMeasurement> gHigh = [];
  List? highestGlu = [];
  List? highestCal = [];

  Future<void> createPDF(List column, List rows) async {
    PdfDocument document = PdfDocument();
    PdfGrid pdfGrid1 = PdfGrid();
    pdfGrid1.style =
        PdfGridStyle(cellPadding: PdfPaddings(left: 5, top: 2, bottom: 2));
    pdfGrid1.columns.add(count: column.length);
    pdfGrid1.headers.add(1);
    PdfGridRow header1 = pdfGrid1.headers[0];

    for (int i = 0; i < column.length; i++) {
      header1.cells[i].value = column[i];
    }
    PdfGridRow row1;
    for (int i = 0; i < rows.length; i++) {
      row1 = pdfGrid1.rows.add();
      for (int j = 0; j < rows[i].length; j++) {
        row1.cells[j].value = rows[i][j];
      }
    }

    pdfGrid1.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
    Get.snackbar(LocaleKeys.loading_file.tr, "", showProgressIndicator: true);
  }

  Stream<List<GlocuMeasurement>>? get tableData => FirebaseFirestore.instance
          .collection("Gluco_Measurment")
          .where("Email",
              isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
          .snapshots()
          .map((QuerySnapshot? snapShot) {
        // print(FirebaseAuth.instance.currentUser!.email);
        // print("snapShot!.docs.length: ${snapShot!.docs.length}");
        glocuMeasurements.clear();

        if (snapShot != null && snapShot.docs.isNotEmpty) {
          // print("snapShot.docs.length:${snapShot.docs.length}");
          for (var doc in snapShot.docs) {
            // print('doc: ${doc.id}');

            var data = doc.data() as Map<String, dynamic>;
            // print("data['Email']:${data['Email']}");
            glocuMeasurements.add(GlocuMeasurement.fromDoc(data));
          }
          // print("glocuMeasurements[0].email:${glocuMeasurements[0].email}");
          return glocuMeasurements;
        }
        return [];

        // for (var i = 0; i < snapShot.docs.length; i++) {
        //   gluRow.add([]);
        //   for (var j = 0; j < 3; j++) {
        //     gluRow[i].add(snapShot.docs[i]['Result'].toString());
        //     gluRow[i].add(snapShot.docs[i]['Test_preiod'].toString());
        //     gluRow[i].add(snapShot.docs[i]['Time'].toString());
        //     gluRow[i].add(DateFormat.yMd()
        //         .format(DateTime.parse(snapShot.docs[i]['Date']))
        //         .toString());
        //     break;
        //   }
        // }
      });
  Stream<List<GlocuMeasurement>>? get getHighGlu => FirebaseFirestore.instance
          .collection("Gluco_Measurment")
          .where("Email",
              isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
          .snapshots()
          .map((QuerySnapshot? snapShot) {
        // print(FirebaseAuth.instance.currentUser!.email);
        // print("snapShot!.docs.length: ${snapShot!.docs.length}");
        gHigh.clear();

        if (snapShot != null && snapShot.docs.isNotEmpty) {
          // print("snapShot.docs.length:${snapShot.docs.length}");
          for (var doc in snapShot.docs) {
            // print('doc: ${doc.id}');

            var data = doc.data() as Map<String, dynamic>;
            print("data['Email']:${data['Email']}");
            gHigh.add(GlocuMeasurement.fromDoc(data));
          }
          // print("gHigh[0].email:${gHigh[0].email}");
          print("gHigh[0].result: ${gHigh[0].result}");
          gHigh.sort((x, y) => x.result!.compareTo(y.result!));

          return gHigh;
        }
        return [];

        // for (var i = 0; i < snapShot.docs.length; i++) {
        //   gluRow.add([]);
        //   for (var j = 0; j < 3; j++) {
        //     gluRow[i].add(snapShot.docs[i]['Result'].toString());
        //     gluRow[i].add(snapShot.docs[i]['Test_preiod'].toString());
        //     gluRow[i].add(snapShot.docs[i]['Time'].toString());
        //     gluRow[i].add(DateFormat.yMd()
        //         .format(DateTime.parse(snapShot.docs[i]['Date']))
        //         .toString());
        //     break;
        //   }
        // }
      });

  Future<void> getGtableData() async {
    glucoRef = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await glucoRef!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      // print(snapShot.docs);
      for (var i = 0; i < snapShot.docs.length; i++) {
        gluRow.add([]);
        for (var j = 0; j < 3; j++) {
          gluRow[i].add(snapShot.docs[i]['Result'].toString());
          gluRow[i].add(snapShot.docs[i]['Test_preiod'].toString());
          gluRow[i].add(snapShot.docs[i]['Time'].toString());
          gluRow[i].add(DateFormat.yMd()
              .format(DateTime.parse(snapShot.docs[i]['Date']))
              .toString());
          break;
        }
      }
    });
    // print('gluRow is');
    // print(gluRow);

    update();
  }

  Future<void> getGluData() async {
    hGlucoRef = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await hGlucoRef!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      // print(snapShot.docs.length);
      for (var element in snapShot.docs) {
        // print(element["Result"]);
        highestGlu!.add(element['Result']);
      }
    });
    // print("^^^^^^^^^^^^^^^^");
    // print(highestGlu);
    highestGlu = highestGlu!.map((e) => int.parse(e)).toList();

    // print("Sorted");
    highestGlu = highestGlu!.sort() as List;
    // print(highestGlu);
  }

  Future<void> getCalData() async {
    hCalRef = FirebaseFirestore.instance.collection("intakes");
    await hCalRef!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      // print(snapShot.docs.length);
      for (var element in snapShot.docs) {
        // print(element["intakes_Cal"]);
        highestCal!.add(element['intakes_Cal']);
      }
    });
    // print("^^cal");
    // print(highestCal!.length);
    // print(highestCal);
    highestCal = highestCal!.map((e) {
      if (e != null) {
        int.parse(e);
      }
    }).toList();

    // print("Sorted");
    highestCal!.sort();
    // print(highestCal);
  }

  Future<void> getCtableData() async {
    calRef = FirebaseFirestore.instance.collection("intakes");
    await calRef!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      for (var i = 0; i < snapShot.docs.length; i++) {
        calRow.add([]);
        for (var j = 0; j < 4; j++) {
          calRow[i].add(snapShot.docs[i]['intakes_type'].toString());
          calRow[i].add(snapShot.docs[i]['intakes_category'].toString());
          calRow[i].add(snapShot.docs[i]['intakes_Quantity'].toString());
          calRow[i].add(snapShot.docs[i]['intakes_Cal'].toString());
          break;
        }
      }
      // print(calRow);
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
