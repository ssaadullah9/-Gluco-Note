import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_saja/const/colors.dart';

class ProfileController extends GetxController{
  var name ;
  var email ;
  var phone;
  var DateOfBitrth ;
  var readOnlyPassword = true.obs;
  var readOnlyPhone = true.obs;
  final formKey = GlobalKey<FormState>();
  var imageFile = null;


  // Firebase ...
  CollectionReference? ProfileRef ;
  var Name ;
  var DOB ;
  var Phone ;
  var user = FirebaseAuth.instance.currentUser ;
/*  void openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera ,);
          imageFile = pickedFile!;
          Navigator.pop(context);
    update();
  }
  void openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery );
          imageFile = pickedFile!;
          Navigator.pop(context);
    update();
  }
  showChoiceDialog(BuildContext context) {
       Get.bottomSheet( SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Choose Image From",
                 textAlign: TextAlign.start,
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: Get.width * 0.04,
                   color: mainColor
                 ),),
              ListBody(
                children: [
                  SizedBox(height: Get.width*0.05,),
                  Divider(height: 1,color: mainColor,),
                  ListTile(
                    onTap: (){
                      openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(Icons.account_box,
                      color: mainColor,),
                  ),

                  Divider(height: 1,color: mainColor,),
                  ListTile(
                    onTap: (){
                      openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(Icons.camera,
                      color: mainColor,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
  }*/

  Future<void>  getData() async {

    ProfileRef = FirebaseFirestore.instance.collection("Acounts") ;
    await ProfileRef!.where("Email" , isEqualTo: user!.email.toString()).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        Name = element['Name'];
        Phone = element['Phone'];
      });
    });
    print(Name) ;
    print(Phone) ;


  }
  @override
  void onInit() {
    getData() ;
    super.onInit();
  }



}