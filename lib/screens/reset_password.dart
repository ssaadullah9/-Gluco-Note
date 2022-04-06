import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart';
import 'mainpage.dart';
import '/screens/signup.dart';

import '../const/colors.dart';
import '../controller/login_controller.dart';
import '../widgets/textformfiled_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatelessWidget{
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Reset Password", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold ),),
            Padding(
              padding:const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: "Enter your Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            ElevatedButton(onPressed: () async {

              await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text).then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
              });

            }, child: Text("Reset Password"))
          ],
        )

    );

  }

}