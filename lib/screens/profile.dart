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

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.ProfileRef!.get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //drawer: NavBar(),
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
    body:

    StreamBuilder(
     stream: controller.ProfileRef!.snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: SpinKitCircle(
              color: Colors.amber,
            ),
          );
        }
        else{

          return ListView(
              padding: EdgeInsets.all(
                  Get.width * 0.03
              ),
                children: [
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: TextEditingController(
                        text: controller.UName
                    ),

                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name'
                    ),

                    maxLength: 30,
                    onChanged: (val) {
                      controller.UName = val;
                      setState(() {

                      });
                    },
                  ),
                  SizedBox(height: Get.width * 0.05,),

                  TextFormField(
                    controller: TextEditingController(
                        text: controller.user!.email
                    ),
                    readOnly: true,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email'

                    ),
                    /*   onChanged: (val) {
                      controller.email.value = val;
                    },*/
                  ),

                  SizedBox(height: Get.width * 0.05,),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: controller.UDOB
                    ),
                    style: TextStyle(
                        color: Colors.black
                    ),
                    //initialValue: formattedDate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // label: Text('Date of Birth '),
                      labelText: 'Date of Birth',

                      suffixIcon: IconButton(
                        onPressed: ()async{

                          var pickedDate = await showDatePicker(
                              context: context, //context of current state
                              initialDate:DateTime.now(),
                              firstDate: DateTime(1970), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)

                          );
                          if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            controller.UDOB = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {

                            });
                            print(controller.UDOB); //formatted date output using intl package =>  2021-03-16

                          }else{
                            print("Date is not selected");
                          }
                        } ,
                        icon: Icon(Icons.cake , color: Colors.amber,),
                      ),
                    ),
                    /*onTap: () {
                      controller.SelectDate(context) ;
                    },*/
                  ),
                  SizedBox(height: Get.width * 0.05,),
                  TextFormField(
                    controller: TextEditingController(
                        text: controller.UPhone
                    ),
                    keyboardType: TextInputType.phone,
                    //autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone'
                    ),
                    maxLength: 10,
                    onChanged: (val) {
                      controller.UPhone = val;
                      setState(() {

                      });
                    },

                  ),
                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
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
                  SizedBox(height: 10,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            addData();
                            Get.snackbar("Data changed Successfully", "");
                          },
                          icon: Icon(Icons.done, size: 30),
                          label: Text("Save Information"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFE5A9379),)
                      )

                    //  )

                  ) ,
                ],

          );

        }

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
          "Name" : controller.UName ,
          "Phone" :controller.UPhone ,
          "Date" : controller.UDOB ,

        }
    ) ;

  }
}




