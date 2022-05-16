import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '/screens/login.dart';
import '../screens/mainpage.dart';

class SplashController extends GetxController {
  void startTimer() {
    Timer(Duration(seconds: 6), () {
      Get.off(() => FirebaseAuth.instance.currentUser?.uid != null
          ? MainScreen()
          : LoginScreen());
    });
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }
}
