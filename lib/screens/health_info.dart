import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_saja/const/colors.dart';
import 'package:test_saja/controller/healthinfo_controller.dart';

import '../widgets/navbar.dart';
import 'bottom_bar_screens/home.dart';

class HealthInfoScreen extends StatelessWidget {
  final controller = Get.put(HealthInfoController());
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  late String selectedSalutation ;



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
            Navigator.pop(context) ;
          },
        ),
        title: Text(
          'Health Information',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: controller.Health_info!.get(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return  Center(
              child: SpinKitCircle(
                color: Colors.amber,
              ),
            );
          }else{
            return ListView(
              padding: EdgeInsets.all(
                  Get.width * 0.03
              ),
              children: [

                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: "Gender:",
                      border: OutlineInputBorder()
                  ),
                  items: ["Male", "Female"]
                      .map((e) => DropdownMenuItem(
                    child: Text("$e"),
                    value: e,
                  ))
                      .toList(),
                  onChanged: (val) {
                    controller.g = val ;
                  },

                  hint: Text(
                      controller.g==null ?
                      'Gender:':
                      "${controller.g}"
                  ),
                ),
                SizedBox(height: Get.width * 0.05,),
                TextFormField(
                  initialValue: controller.w == 0?"": controller.w,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Weight",
                  ),
                  onChanged: (val){
                    controller.w= val  ;

                  },
                ),
                SizedBox(height: Get.width * 0.05,),
                TextFormField(
                  initialValue:  controller.h == null ? "": controller.h,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Height",
                  ),
                  onChanged: (val){
                    controller.h= val ;
                  },
                ),
                SizedBox(height: Get.width * 0.05,),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Diabetes Type:",
                      border: OutlineInputBorder()
                  ),
                  items: ["Type 1", "Type 2", "Gestational"]
                      .map((e) => DropdownMenuItem(
                    child: Text("$e"),
                    value: e,
                  ))
                      .toList(),
                  onChanged: (val) {
                    controller.DT = val ;
                  },

                  hint: Text(

                      controller.DT==null ?
                      'Diabetes Type:':
                      "${controller.DT}"
                  ),
                ),
                SizedBox(height: Get.width * 0.05,),

                SizedBox(height: Get.width * 0.05,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          if(  (controller.g!= null  &&  controller.w.isNotEmpty
                              &&controller.h.isNotEmpty   && controller.DT!= null  )){
                            addData() ;
                            Get.snackbar(
                                "Data Saved Successfully" ,
                                ""
                            );Timer(
                             Duration(
                                 seconds: 2
                             ) ,
                                 () {

                               Navigator.pop(context) ;
                             }
                         ) ;

                          }
                          else
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Error',
                              desc: 'You must fill all the information',
                              btnOkOnPress: () {},
                            )..show();
                        },
                        icon: Icon(Icons.done, size: 30),
                        label: Text("Save Information"),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFE5A9379),)
                    )

                  //  )

                )
              ],
            );
          }
        },
      ),
    );
  }

  addData() async{
    var user = FirebaseAuth.instance.currentUser ;
    CollectionReference Health_info = FirebaseFirestore.instance.collection("Health_Info") ;
    Health_info.doc(user!.uid).set(
        {
          "Email" : user.email.toString() ,
          "Gender" : controller.g,
          "Weight" : controller.w.toString(),
          "Height" : controller.h,
          "Diabetes_Type" : controller.DT,
        }
    ) ;

  }


}
