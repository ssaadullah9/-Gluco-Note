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
  CollectionReference? Glucoref;
  CollectionReference? Calref;
  CollectionReference? HGlucoref;
  CollectionReference? HCalref;

  List<List<String>> Calrow = [];
  List<List<String>> Glurow = [];
  List<GlocuMeasurement> glocuMeaurements = [];
  List? HighestGlu = [];
  List? HighestCal = [];

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
        page: document.pages.add(), bounds: Rect.fromLTWH(0, 0, 0, 0));
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
        print(FirebaseAuth.instance.currentUser!.email);
        print("snapShot!.docs.length: ${snapShot!.docs.length}");
        glocuMeaurements.clear();

        if (snapShot.docs.isNotEmpty) {
          print("snapShot.docs.length:${snapShot.docs.length}");
          for (var doc in snapShot.docs) {
            print('doc: ${doc.id}');

            var data = doc.data() as Map<String, dynamic>;
            print("data['Email']:${data['Email']}");
            glocuMeaurements.add(GlocuMeasurement.fromDoc(data));
          }
          print("glocuMeaurements[0].email:${glocuMeaurements[0].email}");
          return glocuMeaurements;
        }
        return [];

        /*for (var i = 0; i < snapShot.docs.length; i++) {
          Glurow.add([]);
          for (var j = 0; j < 3; j++) {
            Glurow[i].add(snapShot.docs[i]['Result'].toString());
            Glurow[i].add(snapShot.docs[i]['Test_preiod'].toString());
            Glurow[i].add(snapShot.docs[i]['Time'].toString());
            Glurow[i].add(DateFormat.yMd()
                .format(DateTime.parse(snapShot.docs[i]['Date']))
                .toString());
            break;
          }
        }*/
      });

  Future<void> getGtableData() async {
    Glucoref = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await Glucoref!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      print(snapShot.docs);
      for (var i = 0; i < snapShot.docs.length; i++) {
        Glurow.add([]);
        for (var j = 0; j < 3; j++) {
          Glurow[i].add(snapShot.docs[i]['Result'].toString());
          Glurow[i].add(snapShot.docs[i]['Test_preiod'].toString());
          Glurow[i].add(snapShot.docs[i]['Time'].toString());
          Glurow[i].add(DateFormat.yMd()
              .format(DateTime.parse(snapShot.docs[i]['Date']))
              .toString());
          break;
        }
      }
    });
    print('glurow is');
    print(Glurow);

    update();
  }

  Future<void> getGluData() async {
    HGlucoref = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await HGlucoref!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        print(element["Result"]);
        HighestGlu!.add(element['Result']);
      });
    });
    print("^^^^^^^^^^^^^^^^");
    print(HighestGlu);
    HighestGlu = HighestGlu!.map((e) => int.parse(e)).toList();

    print("Sorted");
    HighestGlu = HighestGlu!.sort() as List;
    print(HighestGlu);
  }

  Future<void> getCalData() async {
    HCalref = FirebaseFirestore.instance.collection("intakes");
    await HCalref!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        print(element["intakes_Cal"]);
        HighestCal!.add(element['intakes_Cal']);
      });
    });
    print("^^caal");
    print(HighestCal!.length);
    print(HighestCal);
    HighestCal = HighestCal!.map((e) {
      if (e != null) {
        int.parse(e);
      }
    }).toList();

    print("Sorted");
    HighestCal!.sort();
    print(HighestCal);
  }

  Future<void> getCtableData() async {
    Calref = FirebaseFirestore.instance.collection("intakes");
    await Calref!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      for (var i = 0; i < snapShot.docs.length; i++) {
        Calrow.add([]);
        for (var j = 0; j < 4; j++) {
          Calrow[i].add(snapShot.docs[i]['intakes_type'].toString());
          Calrow[i].add(snapShot.docs[i]['intakes_category'].toString());
          Calrow[i].add(snapShot.docs[i]['intakes_Quantity'].toString());
          Calrow[i].add(snapShot.docs[i]['intakes_Cal'].toString());
          break;
        }
      }
      print(Calrow);
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
