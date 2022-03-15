import 'dart:async';

import 'package:get/get.dart';
import '/screens/login.dart';

class SplashController extends GetxController{

  void startTimer(){
    Timer(Duration(seconds: 4), () {
      Get.off(()=>LoginScreen());
    });

  }
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }
}