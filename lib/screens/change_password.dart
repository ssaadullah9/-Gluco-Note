import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_saja/screens/login.dart';
class ChangePassword extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var user = FirebaseAuth.instance.currentUser ;
    String userEmail = user!.email.toString() ;



    final keyForm = GlobalKey<FormState>();
    late String oldpassword= "";
   late String Newpassword="";
    String CheckNewpassword;


    RegExp numReg = RegExp(r".*[0-9].*");
    RegExp letterReg = RegExp(r".*[A-Za-z].*");
    return Scaffold(
      backgroundColor: Colors.white,
      body:  ListView(
          children: [
            SizedBox(height: 20,) ,
            Image.asset('assets/pass.png') ,
            SizedBox(height: 20,) ,

           /* TextField(

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Old Password'),
              ),

              onChanged: (val){
                oldpassword = val;
              },
              *//*validator: (val){
                return val!.trim().isEmpty
                    ? 'can\'t be empty'
                    : null;
              },*//*
            ),*/

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('User Email'),
              ),

              onChanged: (val){
                oldpassword = val;
              }, ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('New Password'),
              ),

              onChanged: (val){
                Newpassword = val;
              }, ),
             /* validator: (val){
                return validatePassword(val);
              },
            ),*/
            /*TextFormField(

              autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Confirm Password'),
              ),

              onChanged: (val){
               CheckNewpassword = val;
              },
              validator: (val){
                return val!.trim().isEmpty
                    ? 'can\'t be empty'
                    : null;
              },
            ),*/

            Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                child: ElevatedButton.icon(
                    onPressed: () {
                   //   checkUserEmail(oldpassword ,userEmail, Newpassword ) ;
                      user.reauthenticateWithCredential(
                        EmailAuthProvider.credential(email: userEmail, password: Newpassword)

                      );

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
  String? validatePassword(value){
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 8) {
      return "Password should be at least 8 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }
  String? checkUserEmail(String EnterdE , String E , String P){
    var user = FirebaseAuth.instance.currentUser ;
    if(E == EnterdE )
      {
        user!.updatePassword(P) ;
        Get.to(LoginScreen()) ;
      }
      else
    return " the Email is deffirnt" ;
  }

}
