import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_saja/controller/navbar_controller.dart';
import 'package:test_saja/screens/about.dart';
import '../screens/bottom_bar_screens/home.dart';
import '../screens/health_info.dart';
import '../screens/profile.dart';
import '/screens/login.dart';
import 'package:get/get.dart';
import '../screens/health_record.dart';

class NavBar extends StatelessWidget {
 // const NavBar({Key? key}) : super(key: key);
  final controller = Get.put(NavBaRController());


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          StreamBuilder(
            stream: controller.ProfileRef!.snapshots(),
            builder: (context, snapshot) {
              return UserAccountsDrawerHeader(
                margin : const EdgeInsets.only(bottom: 8.0),
                accountName: Text(controller.Name == null ? "" : controller.Name.toString()),
                accountEmail: Text(controller.user!.email.toString()),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset('assets/img.png' ,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey
              ),
              );
            }
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
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
            title: Text('Profile'),
            onTap:  (){
              Get.to(()=>ProfileScreen());
            },
          ),
          Spacer() ,
          /*Divider(
            thickness: 1,
          ),*/
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Health Record'),
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
            title: Text('Health Information'),
            onTap:  (){
              Get.to(()=>HealthInfoScreen());
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap:() {
                Get.off(()=>AboutScreen());
              }),
          Spacer() ,
          /*Divider(
            thickness: 1,
          ),*/
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap:() {
            Get.off(()=>LoginScreen());
          }),
          Spacer() ,
          /*Divider(
            thickness: 1,
          ),*/
        ],
      ),

    );
  }



}
