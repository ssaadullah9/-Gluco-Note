// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class LoginController extends GetxController{
//   var isShow = true.obs;
//   var email = ''.obs;
//   var passWord = ''.obs;
//   final keyForm = GlobalKey<FormState>();
//
//   String? validationEmail(String val){
//     if(val.trim().isEmpty || !(val.isEmail)){
//       return 'email is not correct';
//     }else{
//       return null;
//     }
//   }
//
//   String? validationPassword(String val){
//     if(val.trim().isEmpty || val.length < 8){
//       return 'password is too short';
//     }else{
//       return null;
//     }
//   }
//
//   void stateShowPassword(){
//     isShow.value = !isShow.value;
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/screens/mainpage.dart';
//done
class LoginController extends GetxController{
  var isShow = true.obs;
  var email = ''.obs;
  var passWord = ''.obs;
  final keyForm = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future login({email , password}) async {
    try {
      UserCredential _user = await firebaseAuth.signInWithEmailAndPassword(
          email: email!,
          password: password!);
      if (_user != null) {
        Get.off(MainScreen());
      }
    }on FirebaseAuthException catch(e){
      Get.snackbar('Error', '${e.message}',backgroundColor: Colors.red);
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