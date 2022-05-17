import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthInfoController extends GetxController {
  var keyForm = GlobalKey<FormState>().obs;
  var selectedGender = ''.obs;
  var selectedWeight = ''.obs;
  var selectedHeight = ''.obs;
  var selectedType = 'Type 1'.obs;
  var selectedBirthDate = DateTime.now().obs;
  var selectedDate = DateTime.now().obs;
  var firstDate = DateTime(1970, 1).obs;
  var lastDate = DateTime.now().obs;
  var id = 1.obs;
  var radioButtonItem = 'Male'.obs;
  List hDate = [];
  CollectionReference? healthInfo;
  dynamic w;
  dynamic h;
  dynamic dT;
  dynamic g;
  var user = FirebaseAuth.instance.currentUser;

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
  Future<void> getData() async {
    healthInfo = FirebaseFirestore.instance.collection("Health_Info");
    await healthInfo!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      for (var element in snapShot.docs) {
        w = element['Weight'];
        h = element['Height'];
        dT = element['Diabetes_Type'].toString();
        g = element['Gender'].toString();
      }
    });
    // print(w);
    // print(h);
    // print(dT);
    // print(g);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
