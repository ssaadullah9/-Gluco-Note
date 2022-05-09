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
//import package:firebase_database/firebase_database.dart';

class SignUpController extends GetxController {
  var isShow = true.obs;
  var myUserName = ''.obs;
  var myEmail = ''.obs;
  var myPassWord = ''.obs;
  var myPhoneNumber = ''.obs;
  final keyForm = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future register({email,password,phone,name,context}) async{
    try{
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password ,);
      if(user != null){
        Get.snackbar('SuccessFull', 'New User');
        Get.off(LoginScreen());
        addData(name , phone ) ;
      }
    }on FirebaseAuthException catch(e){
      Get.snackbar('Error', '${e.message}');
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
//d
  String? validationPassword(String val){
    if(val.trim().isEmpty || val.length < 8){
      return 'password is too short';
    }else{
      return null;
    }
  }


  String? validationNumberPhone(String value){
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }

    return null;
  }

  void stateShowPassword(){
    isShow.value = !isShow.value;
  }

  addData(name , phone ) async{
    var user = FirebaseAuth.instance.currentUser ;
    CollectionReference Health_info = FirebaseFirestore.instance.collection("Acounts") ;
    Health_info.doc(user!.uid).set(
        {
          "Email" : user.email.toString() ,
          "Name" : name.toString() ,
          "Phone" : phone.toString() ,
          "Date": "" ,

        }
    ) ;

  }
}