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
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/screens/login.dart';
//import package:firebase_database/firebase_database.dart';

class SignUpController extends GetxController {
  var isShow = true.obs;
  var myUserName = ''.obs;
  var myEmail = ''.obs;
  var myPassWord = ''.obs;
  var myNumberPhone = ''.obs;
  final keyForm = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  Future register({email,password,phone,name,context}) async{
    try{
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if(user != null){
        Get.snackbar('SuccessFull', 'New User',backgroundColor: Colors.green);
        Get.off(LoginScreen());
      }
    }on FirebaseAuthException catch(e){
      Get.snackbar('Error', '${e.message}',backgroundColor: Colors.red);
    }
  }
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

  String? validationNumberPhone(String val){
    if(val.trim().isEmpty || (!val.isPhoneNumber)){
      return 'NumberPhone is not correct';
    }else{
      return null;
    }
  }

  void stateShowPassword(){
    isShow.value = !isShow.value;
  }
}