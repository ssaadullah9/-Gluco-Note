import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_saja/const/colors.dart';

class ProfileController extends GetxController{
  var name = 'Saja '.obs;
  var email = 'Saja1996@gmail.com'.obs;
  var phone = '+966 564207621'.obs;
  var password = '5878aAgghs'.obs;
  var readOnlyPassword = true.obs;
  var readOnlyPhone = true.obs;
  final formKey = GlobalKey<FormState>();
  var imageFile = null;
  void openCamera(BuildContext context)  async{
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
  }

  String? validatePassword(value){
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }
}