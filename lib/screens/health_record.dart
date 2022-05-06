import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:test_saja/controller/health_record_controller.dart';
import 'package:test_saja/widgets/navbar.dart';

import '../const/colors.dart';

class HealthRecordScreen extends StatelessWidget {
  final controller = Get.put(HealthRecordController());
  var user = FirebaseAuth.instance.currentUser ;
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
                Get.back();
              },
            ),
            title: Text(
              'Health Record',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),

          body: FutureBuilder(
            future: controller.HealthRef!.get(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return  Center(
                  child: SpinKitCircle(
                    color: Colors.amber,
                  ),
                ) ;
              }else return ListView(
                padding: EdgeInsets.all(
                    Get.width * 0.03
                ),
                children: [

                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "AntiDiabtees:",
                        border: OutlineInputBorder()
                    ),
                    items: ["Yes", "No"]
                        .map((e) => DropdownMenuItem(
                      child: Text("$e"),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (val) {
                      controller.anti_diabteees.value = val as String;
                    },

                    hint: Text(
                      controller.user_AntiD== null ? "" : "${controller.user_AntiD}" ,
                    ),
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Insulin:",
                        border: OutlineInputBorder()
                    ),
                    items: ["Yes", "No"]
                        .map((e) => DropdownMenuItem(
                      child: Text("$e"),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (val) {
                      controller.insulin.value = val as String;
                    },

                    hint: Text(
                      controller.user_insulin== null ? "" : "${controller.user_insulin}" ,
                    ),
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Injectable:",
                        border: OutlineInputBorder()
                    ),
                    items: ["Yes", "No"]
                        .map((e) => DropdownMenuItem(
                      child: Text("$e"),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (val) {
                      controller.injectable.value = val as String;
                    },

                    hint: Text(
                      controller.user_injectable== null ? "" : "${controller.user_injectable}" ,
                    ),
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Nuttition:",
                        border: OutlineInputBorder()
                    ),
                    items: ["Yes", "No"]
                        .map((e) => DropdownMenuItem(
                      child: Text("$e"),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (val) {
                      controller.nutrition.value = val as String;
                    },

                    hint: Text(
                      controller.user_nutrition== null ? "" : "${controller.user_nutrition}" ,
                    ),
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  TextFormField(
                    initialValue: controller.user_LDL==null ? "0": controller.user_LDL ,
                    style: TextStyle(
                    color:Colors.black
                    ) ,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "LDL",
                    ),
                    validator: (val) {
                      return val!.trim().isEmpty ? 'can\'t be empty' : null;
                    },
                    onChanged: (val) {
                      controller.ldl.value = val;
                    },),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  _buildDateSelected(
                      text: controller.user_LDLDate == null ?'LDL Date' :  controller.user_LDLDate,
                      context: context,
                      selectDate: controller.selectedLDLDates),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  TextFormField(
                    initialValue: controller.user_TG==null ? "0 ": controller.user_TG,
                    style: TextStyle(
                        color:Colors.black
                    ) ,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "TG",
                    ),
                    validator: (val) {
                      return val!.trim().isEmpty ? 'can\'t be empty' : null;
                    },
                    onChanged: (val) {
                      controller.tg.value = val;
                      // print(controller.tg.value);
                    },
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  _buildDateSelected(
                      text: controller.user_TGDate == null ?'TG Date' :  controller.user_TGDate,
                      context: context,
                      selectDate: controller.selectedTGDates),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  TextFormField(
                    initialValue: controller.user_ALBUMIN==null ? "0 ": controller.user_ALBUMIN,
                    style: TextStyle(
                        color: Colors.black
                    ) ,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Albumin",
                    ),
                    validator: (val) {
                      return val!.trim().isEmpty ? 'can\'t be empty' : null;
                    },
                    onChanged: (val) {
                      controller.albumin.value = val;
                      //  print(controller.albumin.value);
                    },
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  _buildDateSelected(
                      text: controller.user_ALBUMINDate == null ?'Albumin Date' :  controller.user_ALBUMINDate,
                      context: context,
                      selectDate: controller.selectedAlbuminDates),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (controller.keyForm.currentState!.validate()) {
                            //  add_record();
                            }
                          },
                          icon: Icon(Icons.done, size: 30),
                          label: Text("Save Information"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFE5A9379),
                          ))

                    //  )

                  )
                ],
              );
            },
          ),
        ) ;


}
  Widget _buildDateSelected({text, context, selectDate}) {
    return TextFormField(
      readOnly: true,
      style:TextStyle(
          color: Colors.black
      ) ,

      controller: selectDate,
      decoration:
      InputDecoration(
       labelText: '$text', border: OutlineInputBorder(),


      ),
      onTap:() async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2025),
        ).then((selectedDate) {
          if (selectedDate != null) {
            selectDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter date.';
        }
        return null;
      },
    );
  }
  Future<void> add_record() async {
    CollectionReference helth_record =
    FirebaseFirestore.instance.collection("Health_Record");
    helth_record.doc(user!.uid).set({
      "Email": controller.user!.email.toString(),
      "AntiDiabtees": controller.anti_diabteees.value,
      "Insulin": controller.insulin.value,
      "Injectable": controller.injectable.value,
      "Nutrition ": controller.nutrition.value,
      "LDL ": controller.ldl.value,
      "LDL Date ": controller.selectedLDLDates.text,
      "TG ": controller.tg.value,
      "TG Date ": controller.selectedTGDates.text,
      "Albumin ": controller.albumin.value,
      "Albumin Date ": controller.selectedAlbuminDates.text,
    });
    // Get.snackbar('Hello', 'successfully add data');
  }
}
