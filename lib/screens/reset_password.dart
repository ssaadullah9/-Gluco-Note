import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../translations/locale_keys.g.dart';
//import 'package:get/get.dart';
import 'login.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.reset_password.tr,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  labelText: LocaleKeys.login_email.tr,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey,
              onPrimary: Colors.white,
            ),
            onPressed: () async {
              try {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: controller.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  Get.defaultDialog(
                    title: LocaleKeys.email_sent.tr,
                    titleStyle: TextStyle(fontSize: 15),
                    middleText: LocaleKeys.please_check_your_email.tr,
                    middleTextStyle: TextStyle(fontSize: 13),
                  );
                });
              } on FirebaseAuthException catch (e) {
                if (e.message != null) {
                  switch (e.code) {
                    case 'invalid-email':
                      Get.snackbar(LocaleKeys.invalid_email.tr,
                          LocaleKeys.please_enter_correct_account.tr,
                          snackPosition: SnackPosition.BOTTOM);
                      break;
                    case 'user-not-found':
                      Get.snackbar(LocaleKeys.user_not_fount.tr,
                          LocaleKeys.this_email_not_registered.tr,
                          snackPosition: SnackPosition.BOTTOM);
                      break;
                    default:
                      Get.snackbar(e.code, e.message!,
                          snackPosition: SnackPosition.BOTTOM);
                      break;
                  }

                  return;
                }
                Get.snackbar(e.code, LocaleKeys.error_occurred.tr,
                    snackPosition: SnackPosition.BOTTOM);
              } catch (e) {
                Get.snackbar(LocaleKeys.error.tr, e.toString(),
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Text(LocaleKeys.reset_password.tr),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
