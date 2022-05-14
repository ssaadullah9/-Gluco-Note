import 'dart:ui';

import 'package:get/get.dart';


class LanguageController extends GetxController{
  void changeLanguage(var parameter1,  parameter2){
    var locale = Locale(parameter1, parameter2);
    Get.updateLocale(locale);
  }
}