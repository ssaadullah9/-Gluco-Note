import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthInfoController extends GetxController{
  var keyForm = GlobalKey<FormState>().obs;
  var selectedGender = ''.obs;
  var selectedWeight = ''.obs;
  var selectedHeight = ''.obs;
  var selectedType = 'ff'.obs;
  var selectedBirthDate = DateTime.now().obs;
  var selectedDate= DateTime.now().obs;
  var firstDate = DateTime(1970 , 1).obs;
  var lastDate = DateTime.now().obs;
  var id = 1.obs;
  var radioButtonItem = 'Male'.obs;
  List HDate = [] ;
  CollectionReference? Health_info ;
   var w ;
 var h ;
  var user = FirebaseAuth.instance.currentUser ;

/*  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: firstDate.value,
        lastDate: lastDate.value);
    if (picked != null) {
      selectedBirthDate.value = picked;
    }
  }*/
   Future<void>  getData() async {

    Health_info = FirebaseFirestore.instance.collection("Health_Info") ;
    await Health_info!.where("Email" , isEqualTo: user!.email.toString()).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        w = element['Weight'];
        h = element['Height'];
      });
    });
    print(w) ;
    print(h) ;

  }
 @override
  void onInit() {
   getData() ;
    super.onInit();
  }
}