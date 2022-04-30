import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:test_saja/const/colors.dart';
import 'package:test_saja/controller/profile_controller.dart';
import 'package:test_saja/screens/bottom_bar_screens/home.dart';
import 'package:test_saja/screens/change_password.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
  var user = FirebaseAuth.instance.currentUser ;

  var selectedBirthDate = DateTime.now() ;
  var firstDate = DateTime(1970 , 1);
  var lastDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: FutureBuilder(
            future: controller.ProfileRef!.get(),
            builder: (context, AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else {
                return ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05
                    ),
                    children: [
                      SizedBox(height: 20,),
                      TextFormField(
                      //readOnly: true,
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: controller.Name.toString() == null ? "" : controller
                            .Name.toString(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Name'),
                        ),
                        maxLength: 30,
                        onChanged: (val) {
                          controller.name.value = val;
                        },
                        validator: (val) {
                          return val!.trim().isEmpty
                              ? 'can\'t be empty'
                              : null;
                        },
                      ),
                      SizedBox(height: Get.width * 0.05,),
                      TextFormField(
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: user!.email.toString(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Email'),
                        ),
                        onChanged: (val) {
                          controller.email.value = val;
                        },
                        validator: (val) {
                          return (val!.trim().isEmpty)
                              ? 'can\'t be empty'
                              : !val.isEmail ?
                          'email no\'t correct'
                              : null;
                        },
                      ),
                      SizedBox(height: Get.width * 0.05,),

                      TextFormField(
                        style: TextStyle(
                          color: Colors.black
                        ),
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.always,
                       // initialValue: "1999-04-17",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                       //   label: Text('Date of Birth'),
                        ),
                        onTap: () async{
                          DateTime? pickedDate = await showDatePicker(
                              context: context, //context of current state
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );

                          if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          }else{
                            print("Date is not selected");
                          }
                        },
                      ),
                      SizedBox(height: Get.width * 0.05,),
                      TextFormField(
                        readOnly: controller.readOnlyPhone.value,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: controller.Phone == null ? "" : controller
                            .Phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Phone'),
                        ),
                        onChanged: (val) {
                          controller.phone.value = val;
                        },
                        validator: (val) {
                          return (val!.trim().isEmpty)
                              ? 'can\'t be empty'
                              : !val.isPhoneNumber ?
                          'email no\'t correct'
                              : null;
                        },
                      ),

                      SizedBox(height: 60,),
                      /*  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){

                          controller.readOnlyPhone.value = false;
                        }, child: Text('change phone number' ,style: TextStyle(
                          color: Colors.black
                        ),))
                      ],
                    ),*/

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
                                // Respond to button press
                              },
                              icon: Icon(Icons.done, size: 30),
                              label: Text("Save Information"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFE5A9379),)
                          )

                        //  )

                      )
                    ]

                );



              }   })
    );
  }
  Widget _buildDateSelected({text, context, selectDate,isEdit}) {
    return TextFormField(
      style:TextStyle(
          color: isEdit?Colors.grey:Colors.black
      ) ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      controller: selectDate,
      decoration:
      InputDecoration(
        labelText: '$text', border: OutlineInputBorder(),


      ),
      onTap: isEdit?null:() async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2025),
        ).then((selectedDate) {
          if (selectedDate != null) {
            selectDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
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

}




