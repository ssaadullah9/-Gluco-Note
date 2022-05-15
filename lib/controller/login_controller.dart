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
import 'package:test_saja/translations/locale_keys.g.dart';
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
        Get.snackbar(LocaleKeys.logged_in_successfully.tr, "",
            showProgressIndicator: true
        ) ;
        Get.off(MainScreen());
      }
    }on FirebaseAuthException catch(e){
      Get.snackbar(LocaleKeys.error.tr, '${e.message}',backgroundColor: Colors.red);
    }
  }
  String? validationEmail(String val){
    if(val.trim().isEmpty || !(val.isEmail)){
      return LocaleKeys.error_message_email.tr;
    }else{
      return null;
    }
  }

  String? validationPassword(String val) {
    if(val.trim().isEmpty) {
      return LocaleKeys.pass_must_entered.tr;
    }
    if ( val.length < 8) {
      return LocaleKeys.password_is_too_short.tr;
    }
    else null ;
  }

  void stateShowPassword(){
    isShow.value = !isShow.value;
  }
}