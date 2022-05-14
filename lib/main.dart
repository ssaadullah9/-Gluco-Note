

 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:test_saja/screens/bottom_bar_screens/home.dart';
import 'package:test_saja/screens/bottom_bar_screens/logbook.dart';
import 'package:test_saja/screens/bottom_bar_screens/reminder.dart';
import 'package:test_saja/screens/bottom_bar_screens/test.dart';
import 'package:test_saja/screens/change_password.dart';
import 'package:test_saja/screens/health_record.dart';
import 'package:test_saja/screens/in_taks_screen.dart';
import 'package:test_saja/screens/login.dart';
 import 'package:test_saja/screens/splash_screen.dart';
import 'package:test_saja/widgets/notificationService.dart';




 Future main() async {
   WidgetsFlutterBinding.ensureInitialized();
   NotificationService().initNotification();
   await  Firebase.initializeApp() ;

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home:  SplashScreen(),

      );

  }
}
 const MaterialColor primaryColor = MaterialColor(
   _primaryColor,
   <int, Color>{
     50: Color(0xFFE3F2FD),
     100: Color(0xFFBBDEFB),
     200: Color(0xFF90CAF9),
     300: Color(0xFF64B5F6),
     400: Color(0xFF42A5F5),
     500: Color(_primaryColor),
     600: Color(0xFF1E88E5),
     700: Color(0xFF1976D2),
     800: Color(0xFF1565C0),
     900: Color(0xFF0D47A1),
   },
 );
 const int _primaryColor = 0xff000000;


