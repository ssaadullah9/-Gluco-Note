// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SignUpController extends GetxController {
//   var isShow = true.obs;
//   var userName = ''.obs;
//   var email = ''.obs;
//   var passWord = ''.obs;
//   final keyForm = GlobalKey<FormState>();
//
//   String? validationUserName(String val){
//     if(val.trim().isEmpty){
//       return 'username is not correct';
//     }else{
//       return null;
//     }
//   }
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/screens/login.dart';
import 'package:test_saja/translations/locale_keys.g.dart';
//import package:firebase_database/firebase_database.dart';

class SignUpController extends GetxController {
  var isShow = true.obs;
  var myUserName = ''.obs;
  var myEmail = ''.obs;
  var myPassWord = ''.obs;
  var myConfirmPassWord = ''.obs;
  var myPhoneNumber = ''.obs;
  final keyForm = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future register({email, password, phone, name, context}) async {
    try {
      UserCredential user =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        Get.snackbar(LocaleKeys.successful.tr, LocaleKeys.new_user.tr);
        Get.off(LoginScreen());
        addData(name, phone);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(LocaleKeys.error.tr, '${e.message}');
    }
  }

  String? validationUserName(String val) {
    if (val.trim().isEmpty) {
      return LocaleKeys.username_must_entered.tr;
    } else {
      return null;
    }
  }

  String? validationEmail(String val) {
    if (val.trim().isEmpty || !(val.isEmail)) {
      return LocaleKeys.email_must_entered.tr;
    } else {
      return null;
    }
  }

//d
  String? validationPassword(String val) {
    if(val.trim().isEmpty) {
      return LocaleKeys.pass_must_entered.tr;
    }
    if ( val.length < 8) {
      return LocaleKeys.password_is_too_short.tr;
    }
    else null ;
  }

  String? validationNumberPhone(String value) {
    if (value.length == 0) {
      return LocaleKeys.mobile_must_entered.tr;
    }
    if (!(value.isPhoneNumber)) {
      return LocaleKeys.enter_valid_mobile.tr;
    }
    if (value.substring(0, 2) != "05") {
      return LocaleKeys.mobile_should_start_05.tr;
    }

    return null;
  }

  void stateShowPassword() {
    isShow.value = !isShow.value;
  }

  addData(name, phone) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference Health_info =
    FirebaseFirestore.instance.collection("Acounts");
    Health_info.doc(user!.uid).set({
      "Email": user.email.toString(),
      "Name": name.toString(),
      "Phone": phone.toString(),
      "Date": "",
    });
  }
}
