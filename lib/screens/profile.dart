import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:test_saja/const/colors.dart';
import 'package:test_saja/controller/profile_controller.dart';
import 'package:test_saja/screens/bottom_bar_screens/home.dart';
import 'package:test_saja/screens/change_password.dart';

import '../widgets/navbar.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
  var user = FirebaseAuth.instance.currentUser ;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavBar(),
        appBar:   AppBar(
          centerTitle : true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios ,color: Colors.black54,),
            onPressed: (){
            //  Get.back();
              Navigator.pop(context) ;
            },
          ),
          title: Text('Profile', style: TextStyle(
              color: Colors.black, fontSize: 20
          ),),

        ),
    body: StreamBuilder(
     stream: controller.ProfileRef!.snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: SpinKitCircle(
              color: Colors.amber,
            ),
          );
        } else
          return ListView(
          padding: EdgeInsets.all(
              Get.width * 0.03
          ),
            children: [
              SizedBox(height: 20,),
              TextFormField(
                initialValue: controller.UName.toString() ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Name'),
                ),
                maxLength: 30,
                onChanged: (val) {
                  controller.name.value = val;
                controller.name.value = controller.UName ;
                },
              ),
              SizedBox(height: Get.width * 0.05,),
              TextFormField(
                readOnly: true,
                initialValue: user!.email.toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                ),
             /*   onChanged: (val) {
                  controller.email.value = val;
                },*/
              ),
              SizedBox(height: Get.width * 0.05,),
              TextFormField(
                readOnly: true,
                style: TextStyle(
                    color: Colors.black
                ),
                //initialValue: formattedDate,
                decoration: InputDecoration(
                  hintText: "${controller.UDOB}",
                  border: OutlineInputBorder(),
                  label: Text('Date of Birth '),
                  suffixIcon: IconButton(
                    onPressed: (){controller.SelectDate(context); } ,
                    icon: Icon(Icons.cake , color: Colors.amber,),
                  ),
                ),
                /*onTap: () {
                  controller.SelectDate(context) ;
                },*/
              ),
              SizedBox(height: Get.width * 0.05,),
              TextFormField(
                readOnly: false,
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.always,
                initialValue: controller.UPhone ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Phone'),
                ),
                onChanged: (val) {
                  controller.phone.value = val;
                  controller.phone=controller.UPhone ;
                },

              ),
              SizedBox(height: 60,),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width *
                      0.08),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => ChangePassword());
                      },
                      icon: Icon(Icons.settings, size: 30),
                      label: Text("change Password"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFE5A9379),)
                  )

                //  )

              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width *
                      0.08),
                  child: ElevatedButton.icon(
                      onPressed: () {
                    //    addData();
                        print(controller.name);
                      },
                      icon: Icon(Icons.done, size: 30),
                      label: Text("Save Information"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFE5A9379),)
                  )

                //  )

              )

            ]
        ) ;
      },
    ),
    );
  }
  addData() async{
    var user = FirebaseAuth.instance.currentUser ;
    CollectionReference Date_ref = FirebaseFirestore.instance.collection("Acounts") ;
    Date_ref.doc(user!.uid).set(
        {
          "Email" : user.email.toString() ,
          "Name" : controller.name.toString() ,
          "Phone" :controller.phone.toString() ,
          "Date" : controller.formattedDate ,

        }
    ) ;

  }
}




