import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/screens/splash_screen.dart';
import 'package:test_saja/translation/change_language.dart';
import 'package:test_saja/widgets/notificationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await EasyLocalization.ensureInitialized();

  NotificationService().initNotification();
  await Firebase.initializeApp();
  runApp(
    /* EasyLocalization(

  path: 'assets/translations',
  supportedLocales: [
    Locale('ar'),
    Locale('en')
  ],
   fallbackLocale: Locale('en'),
  assetLoader: CodegenLoader(),
  child: */
      MyApp()
    //)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: ChangeLanguage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: SplashScreen(),

      //localizationsDelegates: context.localizationDelegates,localizationDelegates
      //supportedLocales: context.supportedLocales,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
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
