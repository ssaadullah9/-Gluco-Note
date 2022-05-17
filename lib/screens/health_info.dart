import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:test_saja/controller/healthinfo_controller.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

import '../widgets/navbar.dart';

class HealthInfoScreen extends StatelessWidget {
  final controller = Get.put(HealthInfoController());

  late final String selectedSalutation;

  HealthInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context); // return to the Nav bar
          },
        ),
        title: Text(
          LocaleKeys.health_info.tr,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: controller.healthInfo!.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SpinKitCircle(
                color: Colors.amber,
              ),
            );
          } else {
            return ListView(
              padding: EdgeInsets.all(Get.width * 0.03),
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: LocaleKeys.gender.tr,
                      border: const OutlineInputBorder()),
                  items: [LocaleKeys.male.tr, LocaleKeys.female.tr]
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    controller.g = val;
                  },
                  // checking if its the first time or display the saved info
                  hint: Text(controller.g == null
                      ? LocaleKeys.gender.tr
                      : "${controller.g}"),
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                TextFormField(
                  initialValue: controller.w == 0 ? "" : controller.w,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: LocaleKeys.weight.tr,
                  ),
                  onChanged: (val) {
                    controller.w = val;
                  },
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                TextFormField(
                  initialValue: controller.h ?? "",
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: LocaleKeys.height.tr,
                  ),
                  onChanged: (val) {
                    controller.h = val;
                  },
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: LocaleKeys.diabetes_type.tr,
                      border: const OutlineInputBorder()),
                  items: [
                    LocaleKeys.type1.tr,
                    LocaleKeys.type2.tr,
                    LocaleKeys.gestational.tr
                  ]
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    controller.dT = val;
                  },
                  hint: Text(
                      // checking if its the first time or display the saved info
                      controller.dT == null
                          ? LocaleKeys.diabetes_type.tr
                          : "${controller.dT}"),
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if ((controller.g != null &&
                          controller.w.isNotEmpty &&
                          controller.h.isNotEmpty &&
                          controller.dT != null)) {
                        addData();
                        Get.snackbar(LocaleKeys.data_saved_successfully.tr, "");
                        Timer(const Duration(seconds: 2), () {
                          Navigator.pop(context); // return to the main page
                        });
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.BOTTOMSLIDE,
                          title: LocaleKeys.error.tr,
                          desc: LocaleKeys.you_must_fill_fields.tr,
                          btnOkOnPress: () {},
                        ).show();
                      }
                    },
                    icon: const Icon(Icons.done, size: 30),
                    label: Text(LocaleKeys.save_info.tr),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFE5A937),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

// Sending the data to firebase
  addData() async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference healthInfo =
        FirebaseFirestore.instance.collection("Health_Info");
    healthInfo.doc(user!.uid).set({
      "Email": user.email.toString(),
      "Gender": controller.g,
      "Weight": controller.w,
      "Height": controller.h,
      "Diabetes_Type": controller.dT,
    });
  }
}
