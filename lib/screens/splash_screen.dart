import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/controller/splash_controller.dart';
import '/screens/login.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState(){
  super.initState();
  controller= AnimationController(
  duration: Duration( seconds: 3),
  vsync: this,
  );
  controller.repeat();
  }

  @override
  void dispose(){
  controller.dispose();
  super.dispose();
  }

  Widget build(BuildContext context)=>Scaffold(
  body: GetBuilder<SplashController>(
         init: SplashController(),
           builder: (_){
  return ListView(
      children: [
       SizedBox(height: MediaQuery.of(context).size.height * 0.60,) ,
 Center(child: Lottie.asset('assets/Animation/lf30_editor_7ywx8uon.json' , repeat: false ,width: 150 ,height: 150)),

        Center(
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText('GlucoNote' , textStyle: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold ),)

            ],
            onTap: () {
              print("Tap Event");
            },

          ),
        )


    ],

  );

  }));
  }







// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//  // AnimationController? _controller;
//   @override
//   void initState() {
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//     _controller!.repeat();
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<SplashController>(
//         init: SplashController(),
//         builder: (_){
//           return Container(
//             alignment: Alignment.center,
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//                 color:  Color(0xffffffff),
//                 gradient: LinearGradient(colors: [(
//                     Color(0xffffffff)),
//                   Color(0xffffffff)],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter
//                 )
//             ),
//             child:  Stack(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     RotationTransition(
//                       turns: Tween(begin: 0.0, end: 1.0).animate(_controller!),
//                       child: Stack(
//                         children: [
//                           SvgPicture.asset('assets/line1.svg'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }