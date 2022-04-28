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
              Get.back();
            },
          ),
          title: Text('Profile', style: TextStyle(
              color: Colors.black, fontSize: 20
          ),),

        ),
        body: FutureBuilder(
            future: controller.ProfileRef!.get(),
            builder: (context,snapshot){
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
                        initialValue: controller.Name == null ? "" : controller
                            .Name,
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
                      /* _buildDateField(
                      hintText: "",
                      selectedFromDate: selectedBirthDate,
                      onTap: () {
                       selectBirthDate(context);
                      },
                    ),*/
                      TextFormField(
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: "1999-04-17",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Date of Birth'),
                        ),
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
  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year,
        helpText: "Date of Birth" ,
        firstDate: firstDate,
        lastDate: lastDate);
    if (picked != null) {
      selectedBirthDate = picked;
    }
  }
  Widget _buildDateField({required String hintText, DateTime? selectedFromDate, required VoidCallback onTap,}) {
    return GestureDetector(
        child: AbsorbPointer(
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(

              border: OutlineInputBorder(),

              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              // border: InputBorder.none,
              hintText: selectedFromDate == null
                  ? hintText
                  : DateFormat('yyy-MM-dd').format(
                selectedFromDate,
              ),

              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 138, 136, 136),
              ),
            ),
            onChanged: (v) {
              selectedFromDate = v as DateTime?;
            },
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        onTap: onTap);
  }

}




