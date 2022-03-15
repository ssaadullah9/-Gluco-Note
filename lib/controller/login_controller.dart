import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  var isShow = true.obs;
  var email = ''.obs;
  var passWord = ''.obs;
  final keyForm = GlobalKey<FormState>();

  String? validationEmail(String val){
    if(val.trim().isEmpty || !(val.isEmail)){
      return 'email is not correct';
    }else{
      return null;
    }
  }

  String? validationPassword(String val){
    if(val.trim().isEmpty || val.length < 8){
      return 'password is too short';
    }else{
      return null;
    }
  }

  void stateShowPassword(){
    isShow.value = !isShow.value;
  }
}