import 'dart:async';

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

class HealthRecordScreen extends StatefulWidget {
  @override
  State<HealthRecordScreen> createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
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
                      controller.user_AntiD = val as String;
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
                      controller.user_insulin = val as String;
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
                      controller.user_injectable = val as String;
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
                      controller.user_nutrition = val as String;
                    },

                    hint: Text(
                      controller.user_nutrition== null ? "" : "${controller.user_nutrition}" ,
                    ),
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  TextFormField(
                    initialValue: controller.user_LDL==null ? "": controller.user_LDL ,
                    style: TextStyle(
                    color:Colors.black
                    ) ,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "LDL",
                    ),
                   /* validator: (val) {
                      return val!.trim().isEmpty ? 'can\'t be empty' : null;
                    },*/
                    onChanged: (val) {
                      controller.user_LDL = val;
                    },),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  _buildDateSelected(
                      text: "LDL Date",
                      context: context,
                      selectDate: controller.selectedLDLDates,
                    showText:  controller.user_LDLDate == null ?null :  controller.user_LDLDate
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  TextFormField(
                    initialValue: controller.user_TG==null ? " ": controller.user_TG,
                    style: TextStyle(
                        color:Colors.black
                    ) ,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "TG",
                    ),
                   /* validator: (val) {
                      return val!.trim().isEmpty ? 'can\'t be empty' : null;
                    },*/
                    onChanged: (val) {
                      controller.user_TG = val;
                      // print(controller.tg.value);
                    },
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  _buildDateSelected(
                      text: 'TG Date',
                      context: context,
                      selectDate: controller.selectedTGDates,
                      showText: controller.user_TGDate == null ?null :  controller.user_TGDate
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  TextFormField(
                    initialValue: controller.user_ALBUMIN==null ? " ": controller.user_ALBUMIN,
                    style: TextStyle(
                        color: Colors.black
                    ) ,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Albumin",
                    ),
                 /*   validator: (val) {
                      return val!.trim().isEmpty ? 'can\'t be empty' : null;
                    },*/
                    onChanged: (val) {
                      controller.user_ALBUMIN = val;
                      //  print(controller.albumin.value);
                    },
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  _buildDateSelected(
                      text:'Albumin Date',
                      context: context,
                      selectDate: controller.selectedAlbuminDates,
                    showText:  controller.user_ALBUMINDate == null ?null :  controller.user_ALBUMINDate
                  ),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: ElevatedButton.icon(
                          onPressed: () {/*
                            if (controller.keyForm.currentState!.validate()) {
                             add_record();
                            }*/
                            add_record();
                            Get.snackbar(
                                "Data Saved Successfully" ,
                                ""
                            );
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

  Widget _buildDateSelected({text, context, selectDate,showText}) {
    return TextFormField(
      readOnly: true,
      style:TextStyle(
          color: Colors.black
      ) ,

      controller: TextEditingController(
        text: showText == null?selectDate.text:showText
      ),
      decoration:
      InputDecoration(
       labelText: '$text',
        border: OutlineInputBorder(),


      ),
      onTap:() async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2025),
        ).then((selectedDate) {
          if (selectedDate != null) {
            selectDate.text = DateFormat('yyyy-MM-dd').
            format(selectedDate);
            setState(() {

            });
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
      "AntiDiabtees": controller.user_AntiD,
      "Insulin":  controller.user_insulin,
      "Injectable":  controller.user_injectable,
      "Nutrition ": controller.user_nutrition,
      "LDL ": controller.user_LDL,
      "LDL Date ": controller.selectedLDLDates.text,
      "TG ": controller.user_TG,
      "TG Date ": controller.selectedTGDates.text,
      "Albumin ": controller.user_ALBUMIN,
      "Albumin Date ": controller.selectedAlbuminDates.text,
    });
    // Get.snackbar('Hello', 'successfully add data');
  }
}
