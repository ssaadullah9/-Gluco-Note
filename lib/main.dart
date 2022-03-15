

 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/screens/health_info.dart';
import 'package:test_saja/screens/logbook.dart';
import '/screens/logbook.dart';
import '/mainpage.dart';
import '/screens/signup.dart';
import '/screens/splash_screen.dart';
import 'health_record.dart';
import 'screens/reminder.dart';
import 'screens/profile.dart';


Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp() ;
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
      home: HealthRecordScreen(),
      // initialRoute: '/',
      //   routes: {
         //  '/': (context) => SplashScreen(),
         // '/mainpage': (context) => const main_page(),
         //  '/reminder': (context) => const alet(),
         //  '/new_reminder': (context) =>  AddnewReminder(),
         //  '/logbook': (context) =>  logbook(),
         //  '/health_info': (context) =>  health_info(),
         //  '/profile': (context) =>  profile(),
         //  '/intakes': (context) => intakes(),
         //  '/health_record': (context) => health_record(),
         //  // splash
         //  '/splash': (context) => SplashScreen(),
         //  // login
         //  '/login': (context) => LoginScreen(),
         //  //signup
         //  '/SignUp': (context) => SignUpScreen(),
         //  '/tests': (context) => MyPage(),
        // },
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
 const int _primaryColor = 0xffc5cda9;

