import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_saja/bmi.dart';
import 'package:test_saja/models/bmi-model.dart';

class TestBMIController extends GetxController {
  var keyForm = GlobalKey<FormState>().obs;
  var index = 0.obs;
  var controllerPageView = PageController(initialPage: 0).obs;
  var bmiModel = BMIModel(bmi: 0, isNormal: false, comments: '').obs;
  var comments = "".obs;
  var heightOfUser = 5.0.obs;
  var weightOfUser = 5.0.obs;
  dynamic date;
  var time = TimeOfDay.now().obs;
  var Date = DateTime.now().obs;
  var Date1 = DateTime.now().obs;
  var selectedval = ''.obs;
  var valueHolder = 0.obs;
  var bmi1 = 0.0.obs;
  var bmi = 0.0.obs;
  CollectionReference? Bmiref;
  var user = FirebaseAuth.instance.currentUser;
  List<List<String>> Bmirow = [];
  List<BMI> bmiList = [];

  void onTimeChanged(TimeOfDay newTime) {
    time.value = newTime;
  }

  @override
  void onInit() {
    getData();
    controllerPageView.value = PageController(initialPage: 0);
    super.onInit();
  }

/*  @override
  void onClose() {
  controllerPageView.value.dispose();
    super.onClose();
  }*/

  Future<void> getData() async {
    Bmiref = FirebaseFirestore.instance.collection("BMI");
    await Bmiref!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      for (var i = 0; i < snapShot.docs.length; i++) {
        Bmirow.add([]);
        for (var j = 0; j < 3; j++) {
          Bmirow[i].add(DateFormat.yMd()
              .format(DateTime.parse(snapShot.docs[i]['Date'])));
          Bmirow[i].add(snapShot.docs[i]['Result']);
          Bmirow[i].add(snapShot.docs[i]['Status']);
          break;
        }
      }
      // print(Bmirow);
    });
    update();
  }

  Stream<List<BMI>>? get bmiTableData => FirebaseFirestore.instance
          .collection("BMI")
          .where("Email",
              isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
          .snapshots()
          .map((QuerySnapshot? snapShot) {
        bmiList.clear();

        if (snapShot != null && snapShot.docs.isNotEmpty) {
          for (var doc in snapShot.docs) {
            var data = doc.data() as Map<String, dynamic>;

            bmiList.add(BMI.fromDoc(data));
          }

          return bmiList;
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

/*
@override
void onInit() {
  getData();
  super.onInit();
}
*/
/*.Dateformate().ymd().format(DateTime.parse(toString()))*/
}
