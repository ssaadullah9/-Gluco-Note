import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/screens/logbook.dart';
import '/screens/bottom_bar_screens/home.dart';

import '../Tests.dart';
import '../screens/reminder.dart';

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
        'page': Home()
      },
      {
        'page': LogBookScreen()
      },
      {
        'page': MyPage()
      },
      {
        'page': ReminderScreeen()
      }
    ];
    super.onInit();
  }

}