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

     String? Email;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios ,color: Colors.black54,),
          onPressed: (){
           // Get.to(ProfileScreen());
            Navigator.pop(context) ;
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
                      print(Email) ;
            if(Email== userEmail){
                      await FirebaseAuth.instance.sendPasswordResetEmail(email:userEmail).then((value) {
                     Get.snackbar("Changing Password Succefully ", "Check your Email ");
                        Timer(
                            Duration(
                                seconds: 2
                            ) ,
                                () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                            }
                        ) ;
                      });
          }
            else if(Email!.isEmpty){
              Get.snackbar("Wrong entry", "please Enter the Email ") ;
            }
            else if(Email== null ) {
              Get.snackbar("Wrong entry", "please try again ") ;
            }
            else {
              Get.snackbar("wrong", "message") ;
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
