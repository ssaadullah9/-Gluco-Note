import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_saja/screens/login.dart';
import 'package:test_saja/screens/profile.dart';
class ChangePassword extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var user = FirebaseAuth.instance.currentUser ;
    String userEmail = user!.email.toString() ;

    late String Email;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios ,color: Colors.black54,),
          onPressed: (){
            Get.to(ProfileScreen());
          },
        ),
      ),
      body:  ListView(
          children: [
            SizedBox(height: 20,) ,
            Image.asset('assets/pass.png') ,
            SizedBox(height: 20,) ,



            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('User Email'),
              ),

              onChanged: (val){
                Email = val;
              }, ),
            SizedBox(height: 20) ,

            Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                child: ElevatedButton.icon(
                    onPressed: () async{
            if(Email== userEmail){
                      await FirebaseAuth.instance.sendPasswordResetEmail(email:userEmail).then((value) {
                     Get.snackbar("Chnging Password Succefully ", "Check your Email ");
                        Timer(
                            Duration(
                                seconds: 2
                            ) ,
                                () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                            }
                        ) ;
                      }); }
            else if(Email.isEmpty){
              Get.snackbar("Wrong entry", "please Enter the Email ") ;
            }
            else {
              Get.snackbar("Wrong entry", "please try again ") ;
            }
                    },
                    icon: Icon(Icons.done, size: 30),
                    label: Text("Change Password"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE5A9379),)
                )

              //  )

            )

          ],
        ),

    );
  }
/*  String? validatePassword (String email , String uE){
    if (email.isEmpty) {
      Get.snackbar("Wrong entry", "please Enter the Email ") ;
    } else if (!email.isEmail) {
      Get.snackbar("Wrong entry", "please try again ") ;
    } else if (email==uE) async {
     await FirebaseAuth.instance.sendPasswordResetEmail(email:userEmail).then((value) {
        Timer(
            Duration(
                seconds: 2
            ) ,
                () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            }
        ) ;

      });
    } else
      return null;
  }*/


}
