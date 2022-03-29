import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/bmi.dart';
import 'package:test_saja/const/colors.dart';

class TestBMIController extends GetxController{
var keyForm = GlobalKey<FormState>().obs;
var index = 0.obs;
var controllerPageView = PageController(initialPage: 0).obs;
var  bmiModel = BMIModel(bmi: 0, isNormal:false, comments: '').obs;
var  comments = "".obs;
var heightOfUser = 5.0.obs;
var weightOfUser = 5.0.obs;
var date;
var time = TimeOfDay.now().obs;
var Date = DateTime.now().obs;
var selectedval = ''.obs;
var valueHolder = 20.obs;
var bmi1 = 0.0.obs;
var bmi = 0.0.obs;
CollectionReference? Bmiref;
List<List<String>> Bmirow =[];


void onTimeChanged(TimeOfDay newTime) {
  time.value = newTime;
}
@override
  void onInit() {
  getData();
  controllerPageView.value = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
  controllerPageView.value.dispose();
    super.onClose();
  }

Future<void> getData() async{
  Bmiref = FirebaseFirestore.instance.collection("BMI");
  await Bmiref!.get().then((snapShot)
      {
        for(var i = 0 ; i < snapShot.docs.length ; i++ ){
          Bmirow.add([]);
          for (var j = 0 ; j < 3 ; j++)
            {

              Bmirow[i].add(snapShot.docs[i]['Date']);
              Bmirow[i].add(snapShot.docs[i]['Result']);
              Bmirow[i].add(snapShot.docs[i]['Status']);
              break;
            }

        }
        print(Bmirow);
      });
  update();
}
/*
@override
void onInit() {
  getData();
  super.onInit();
}
*/
/*.Dateformate().ymd().format(DateTime.parse(toString()))*/
}