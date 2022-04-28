import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../screens/bottom_bar_screens/logbook.dart';
import '/screens/bottom_bar_screens/home.dart';

import '../screens/bottom_bar_screens/test.dart';
import '../screens/bottom_bar_screens/reminder.dart';

class MainController extends GetxController{
  List<Map<dynamic,dynamic>>? pages;
  var currentIndex = 0.obs;
  var user = FirebaseAuth.instance.currentUser ;
  CollectionReference? ProfileRef ;
  var Name ;

  void onTabIconBottomBar(index){
    currentIndex.value = index;
  }
  @override
  void onInit() {
    pages = [
      {
        'page': Home(),
        'appBar':true
      },
      {
        'page': LogBookScreen(),
        'appBar':false
      },
      {
        'page': TestScreen(),
        'appBar':false
      },
      {
        'page': ReminderScreeen(),
        'appBar':false
      }
    ];
    getData() ;
    super.onInit();
  }

  Future<void>  getData() async {

    ProfileRef = FirebaseFirestore.instance.collection("Acounts") ;
    await ProfileRef!.where("Email" , isEqualTo: user!.email.toString()).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        Name = element['Name'];

      });
    });
    print(Name) ;

  }
}