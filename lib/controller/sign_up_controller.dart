import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var isShow = true.obs;
  var userName = ''.obs;
  var email = ''.obs;
  var passWord = ''.obs;
  final keyForm = GlobalKey<FormState>();

  String? validationUserName(String val){
    if(val.trim().isEmpty){
      return 'username is not correct';
    }else{
      return null;
    }
  }

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