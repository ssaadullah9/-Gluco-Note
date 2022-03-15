import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/splash_controller.dart';
import '/screens/login.dart';



class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_){
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color:  Color(0xffffffff),
                gradient: LinearGradient(colors: [(
                    Color(0xffffffff)),
                  Color(0xffffffff)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
            child:  Image.asset("assets/app_icon.jpg"),
          );
        },
      ),
    );
  }
}