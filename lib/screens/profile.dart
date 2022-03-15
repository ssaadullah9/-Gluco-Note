import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_saja/const/colors.dart';
import 'package:test_saja/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
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
      body: Obx(
          ()=>Column(
            children: [
              GetBuilder<ProfileController>(
                  init: ProfileController(),
                  builder: (_){
                    return Stack(
                      children: [
                        ClipOval(
                          child: Container(
                              width: Get.width * 0.35,
                              height: Get.width * 0.35,
                              child: controller.imageFile == null
                                  ?Image.asset(
                                  'assets/person.jpg',
                                fit: BoxFit.cover,
                              )
                                  : Image.file(
                                  File('${controller.imageFile.path}'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: (){
                              controller.showChoiceDialog(context);
                            },
                            child: CircleAvatar(
                                child: Icon(Icons.add_a_photo,size: Get.width * 0.05,)),
                          ),
                        )
                      ],
                    );}),
              SizedBox(height: 10,),
              Expanded(
                child: Form(
                  key: controller.formKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05
                    ),
                    children: <Widget>[
                      TextFormField(
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: '${controller.name}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Name'),
                        ),
                        maxLength: 30,
                        onChanged: (val){
                          controller.name.value = val;
                        },
                        validator: (val){
                          return val!.trim().isEmpty
                              ? 'can\'t be empty'
                              : null;
                        },
                      ),
                      SizedBox(height: Get.width*0.05,),
                      TextFormField(
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: '${controller.email}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Email'),
                        ),
                        onChanged: (val){
                          controller.email.value = val;
                        },
                        validator: (val){
                          return (val!.trim().isEmpty)
                              ? 'can\'t be empty'
                          :!val.isEmail?
                              'email no\'t correct'
                              : null;
                        },
                      ),
                      SizedBox(height: Get.width*0.05,),
                      TextFormField(
                        readOnly: controller.readOnlyPhone.value,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: '${controller.phone}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Phone'),
                        ),
                        onChanged: (val){
                          controller.phone.value = val;
                        },
                        validator: (val){
                          return (val!.trim().isEmpty)
                              ? 'can\'t be empty'
                          :!val.isPhoneNumber?
                              'email no\'t correct'
                              : null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){
                            controller.readOnlyPhone.value = false;
                          }, child: Text('change phone number'))
                        ],
                      ),
                      TextFormField(
                        readOnly: controller.readOnlyPassword.value,
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: '${controller.password}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Password'),
                        ),
                        onChanged: (val){
                          controller.password.value = val;
                        },
                        validator: (val){
                          return controller.validatePassword(val);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){
                            controller.readOnlyPassword.value = false;
                          }, child: Text('change Password'))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
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

                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

   // creatUser()  async
   // {
   //    await firebase.collection('User').
   //    doc(controllerEmail.text).
   //    set({
   //      "name": controllerName.text,
   //      "email": controllerEmail.text,
   //      "phone": int.parse(controllerPhone.text),
   //      "password": controllerPassword.text ,
   //
   //    });
   //
   //     // final json= user.ToJson() ;
   //      //await docUser.set(json) ;
   // }
  // Widget bottomsheet(){
  //   return Container(
  //       height: 100,
  //       width: MediaQuery.of(context).size.width,
  //         margin: EdgeInsets.symmetric(
  //           horizontal: 20 , vertical: 20
  //         ),
  //     child: Column(
  //       children: <Widget>[
  //         Text("Choose profile photo",
  //         style: TextStyle(fontSize: 20),
  //         ),
  //         SizedBox(height: 20),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             TextButton.icon(onPressed: () {
  //               _getFromCamera();
  //             },
  //               label: Text('Camera'),
  //               icon: Icon(Icons.camera_alt),
  //             ),
  //             TextButton.icon(onPressed: () {
  //
  //               _getFromGallery();
  //             },
  //               label: Text('Gallery'),
  //               icon: Icon(Icons.image),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  //
  //

}




