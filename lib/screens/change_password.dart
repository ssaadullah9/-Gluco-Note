import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/screens/login.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    String userEmail = user!.email.toString();

    String? email;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context); // return to the profile screen
          },
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/pass.png'),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(LocaleKeys.login_email.tr),
            ),
            onChanged: (val) {
              email = val;
            },
          ),
          const SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
              child: ElevatedButton.icon(
                  onPressed: () async {
                    // print(Email);
                    //checking the Email
                    if (email == userEmail) {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: userEmail)
                          .then((value) {
                        Get.snackbar(LocaleKeys.pass_change_success.tr,
                            LocaleKeys.please_check_your_email);
                        Timer(const Duration(seconds: 2), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        });
                      });
                    } else if (email == null) {
                      Get.snackbar(LocaleKeys.field_required.tr,
                          LocaleKeys.please_enter_email.tr);
                    } else if (email != userEmail) {
                      Get.snackbar(
                          LocaleKeys.wrong_entry.tr, LocaleKeys.try_again.tr);
                    }
                  },
                  icon: const Icon(Icons.done, size: 30),
                  label: Text(LocaleKeys.change_password.tr),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFE5A937),
                  ))

              //  )

              )
        ],
      ),
    );
  }
}
