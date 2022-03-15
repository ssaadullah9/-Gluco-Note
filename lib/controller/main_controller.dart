import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../screens/bottom_bar_screens/logbook.dart';
import '/screens/bottom_bar_screens/home.dart';

import '../screens/bottom_bar_screens/test.dart';
import '../screens/bottom_bar_screens/reminder.dart';

class MainController extends GetxController{
  List<Map<dynamic,dynamic>>? pages;
  var currentIndex = 0.obs;

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
    super.onInit();
  }

}