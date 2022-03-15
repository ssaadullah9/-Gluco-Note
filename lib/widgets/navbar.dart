import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../screens/health_info.dart';
import '../screens/profile.dart';
import '/screens/login.dart';
import 'package:get/get.dart';

import '../screens/health_record.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('User Name'),
            accountEmail: Text('user@email.com' ),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.asset('assets/moon.png' ,
                fit: BoxFit.cover,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blueGrey
          ),
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Profile'),
            onTap:  (){
              Get.to(()=>ProfileScreen());
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Health Record'),
            onTap:  (){
              Get.to(()=>HealthRecordScreen());
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Health Information'),
            onTap:  (){
              Get.to(()=>HealthInfoScreen());
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap:() {
            Get.off(()=>LoginScreen());
          }),
          Divider(
            thickness: 1,
          ),
        ],
      ),

    );
  }
}
