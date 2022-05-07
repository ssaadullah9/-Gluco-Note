import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:test_saja/const/colors.dart';

class ProfileController extends GetxController{

  final formKey = GlobalKey<FormState>();
  var imageFile = null;
  DateTime? pickedDate ;
  var formattedDate ;
  DateTime DOB=DateTime.now() ;

  // Firebase ...
  CollectionReference? ProfileRef ;
  var UName = "";
  var UDOB  = "";
  var UPhone  = "";

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

  getData() async {

    ProfileRef =  FirebaseFirestore.instance.collection("Acounts") ;
    await ProfileRef!.where("Email" , isEqualTo: user!.email).get().then((snapShot) {
      print(snapShot.docs.length);
      UName = snapShot.docs[0]["Name"];
      UPhone = snapShot.docs[0]['Phone'];
      UDOB=  snapShot.docs[0]['Date'];
    });
    print(UName) ;
    print(UPhone) ;
    print(UDOB) ;


  }


  @override
  void onInit() {
    getData() ;
    super.onInit();
  }



}