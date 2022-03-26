import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/screens/login.dart';

class SplashController extends GetxController {

  void startTimer(){
    Timer(Duration(seconds: 250), () {
      Get.off(()=>LoginScreen());
    });

  }
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }
}