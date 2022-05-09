import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HealthRecordController extends GetxController{
  var selectedTGDates= TextEditingController() ;
  var selectedLDLDates= TextEditingController() ;
  var selectedAlbuminDates = TextEditingController();
  var anti_diabteees = "".obs ;
  var insulin = "".obs ;
  var injectable = "".obs ;
  var nutrition =  "".obs ;
  var ldl =  "".obs ;
  var tg =  "".obs ;
  var albumin =  "".obs ;
  final keyForm = GlobalKey<FormState>();
  var user = FirebaseAuth.instance.currentUser;
  CollectionReference? HealthRef;
  var user_AntiD;
  var user_insulin ;
  var user_nutrition ;
  var user_injectable ;
  var user_LDL ;
  var user_LDLDate ;
  var user_TG ;
  var user_TGDate ;
  var user_ALBUMIN ;
  var user_ALBUMINDate ;


  Future<void>  getData() async {

    HealthRef = FirebaseFirestore.instance.collection("Health_Record") ;
    await HealthRef!.where("Email" , isEqualTo: user!.email.toString()).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        user_LDL = element['LDL '];
        user_LDLDate   = DateFormat.yMd().format(DateTime.parse(element['LDL Date '])).toString();
        user_TG   = element['TG '];
        user_TGDate = DateFormat.yMd().format(DateTime.parse(element['TG Date '])).toString();
        user_ALBUMIN = element['Albumin '];
        user_ALBUMINDate = DateFormat.yMd().format(DateTime.parse(element['Albumin Date '])).toString();
         user_AntiD = element['AntiDiabtees'] ;
         user_insulin =element['Insulin'] ;
         user_nutrition = element['Nutrition '] ;
         user_injectable = element['Injectable'] ;
      });
    });
    print(user_LDL) ;
    print(user_LDLDate) ;

  }
  @override
  void onInit() {
    getData();
    super.onInit();
  }
}

