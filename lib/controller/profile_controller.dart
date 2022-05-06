import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  DateTime? pickedDate ;
  var formattedDate ;
  DateTime DOB=DateTime.now() ;

  // Firebase ...
  CollectionReference? ProfileRef ;
  var UName ;
  var UDOB ;
  var UPhone ;
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
        UName = element['Name'];
        UPhone = element['Phone'];
        UDOB=  element['Date'];
      });
    });
    print(UName) ;
    print(UPhone) ;
    print(UDOB) ;


  }

  Future<Null> SelectDate (BuildContext context) async {
    pickedDate = await showDatePicker(
        context: context, //context of current state
        initialDate:DOB,
        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)

    );
    if(pickedDate != null ){
      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
      formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16

    }else{
      print("Date is not selected");
    }
  }
  @override
  void onInit() {
    getData() ;
    super.onInit();
  }



}