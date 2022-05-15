import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_saja/controller/navbar_controller.dart';
import 'package:test_saja/screens/about.dart';
import 'package:test_saja/translations/locale_keys.g.dart';
import '../screens/bottom_bar_screens/home.dart';
import '../screens/health_info.dart';
import '../screens/profile.dart';
import '../translation/language_controller.dart';
import '/screens/login.dart';
import 'package:get/get.dart';
import '../screens/health_record.dart';

class NavBar extends StatelessWidget {
 // const NavBar({Key? key}) : super(key: key);
  final controller = Get.put(NavBaRController());
  final languageController = Get.put(LanguageController());


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [  UserAccountsDrawerHeader(
      margin : const EdgeInsets.only(bottom: 8.0),
      accountName: Text('${controller.Name}'),
      accountEmail: Text(controller.user!.email.toString()),
      currentAccountPicture: CircleAvatar(
        child: ClipOval(
          child: Image.asset('assets/np.png' ,
            fit: BoxFit.cover,
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.blueGrey
      ),
    ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(LocaleKeys.home.tr),
            onTap:  (){
           //  Get.to(()=>Home());
              Navigator.pop(context) ;
            },
          ),
          Spacer() ,
          /*Divider(
            thickness: 1,
          ),*/
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text(LocaleKeys.profile.tr),
            onTap:  (){
              Navigator.push(context, MaterialPageRoute
                (builder: (ctx)=>ProfileScreen()));
            },
          ),
          Spacer() ,
          /*Divider(
            thickness: 1,
          ),*/
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text(LocaleKeys.health_record.tr),
            onTap:  (){
              Get.to(()=>HealthRecordScreen());
            },
          ),
          Spacer() ,
          /*Divider(
            thickness: 1,
          ),*/
          ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text(LocaleKeys.health_info.tr),
            onTap:  (){
              Get.to(()=>HealthInfoScreen());
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
              leading: Icon(Icons.info),
              title: Text(LocaleKeys.about.tr),
              onTap:() {
           Get.to(AboutScreen());

              }),
          Spacer() ,
          /*Divider(
            thickness: 1,
          ),*/
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(LocaleKeys.logout.tr),
            onTap:() {
            Get.off(()=>LoginScreen());
          }),
          Spacer() ,
          /*Divider(
            thickness: 1,
          ),
          */

          Row(
            children: [
              PopupMenuButton<int>(
                  onSelected: (item) => onSelected(context , item),
                  icon : Icon(Icons.language , color: Colors.grey, size: 25,),
                  itemBuilder:(context) => [
                    PopupMenuItem<int>(
                      child: Text("English"),
                      value:0,
                    ), PopupMenuItem<int>(
                      child: Text("العربية"),
                      value: 1,
                    ),

                  ]),
              Text( LocaleKeys.change_lang.tr , style: TextStyle(color: Colors.grey[600]),)
            ],
          ),]

      ),

    );
  }

  onSelected(BuildContext context, int item) {
    switch(item){
      case 0:
        languageController.changeLanguage('en', 'US');
        break;
      case 1:
        languageController.changeLanguage('ar', 'SA');
        break;

    }
  }

}
