import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthRecordController extends GetxController{
  var isEdit = false.obs;
  var selectedTGDates = TextEditingController();
  var selectedLDLDates = TextEditingController();
  var selectedAlbuminDates = TextEditingController();
  var anti_diabteees = TextEditingController();
  var insulin = TextEditingController();
  var injectable = TextEditingController();
  var nutrition = TextEditingController();
  var ldl = TextEditingController();
  var tg = TextEditingController();
  var albumin = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  var user = FirebaseAuth.instance.currentUser;
  CollectionReference? HealthRef;

  Future<void> getData() async{
     HealthRef= FirebaseFirestore.instance.collection("Health_Record");
    await HealthRef!.where("Email", isEqualTo: user!.email.toString()).get().then((snapShot)
    {

    });
    update();
  }
  @override
  void onInit() {
    getData();
    super.onInit();
  }
}

