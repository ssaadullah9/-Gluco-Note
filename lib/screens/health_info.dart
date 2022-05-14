import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:test_saja/controller/healthinfo_controller.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

import '../widgets/navbar.dart';

class HealthInfoScreen extends StatelessWidget {
  final controller = Get.put(HealthInfoController());

  late String selectedSalutation;

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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context); // return to the Nav bar
          },
        ),
        title: Text(
          LocaleKeys.health_info.tr,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: controller.Health_info!.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
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
                      border: OutlineInputBorder()),
                  items: [LocaleKeys.male.tr, LocaleKeys.female.tr]
                      .map((e) => DropdownMenuItem(
                    child: Text("$e"),
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
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
                  initialValue: controller.h == null ? "" : controller.h,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
                      border: OutlineInputBorder()),
                  items: [
                    LocaleKeys.type1.tr,
                    LocaleKeys.type2.tr,
                    LocaleKeys.gestational.tr
                  ]
                      .map((e) => DropdownMenuItem(
                    child: Text("$e"),
                    value: e,
                  ))
                      .toList(),
                  onChanged: (val) {
                    controller.DT = val;
                  },
                  hint: Text(
                    // checking if its the first time or display the saved info
                      controller.DT == null
                          ? LocaleKeys.diabetes_type.tr
                          : "${controller.DT}"),
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
                              controller.DT != null)) {
                            addData();
                            Get.snackbar(
                                LocaleKeys.data_saved_successfully.tr, "");
                            Timer(Duration(seconds: 2), () {
                              Navigator.pop(context); // return to the main page
                            });
                          } else
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              title: LocaleKeys.error.tr,
                              desc: LocaleKeys.you_must_fill_fields.tr,
                              btnOkOnPress: () {},
                            )..show();
                        },
                        icon: Icon(Icons.done, size: 30),
                        label: Text(LocaleKeys.data_saved_successfully.tr),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFE5A9379),
                        )))
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
    CollectionReference Health_info =
    FirebaseFirestore.instance.collection("Health_Info");
    Health_info.doc(user!.uid).set({
      "Email": user.email.toString(),
      "Gender": controller.g,
      "Weight": controller.w,
      "Height": controller.h,
      "Diabetes_Type": controller.DT,
    });
  }
}
