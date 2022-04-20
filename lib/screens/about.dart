import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/screens/profile.dart';
class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        centerTitle : true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios ,color: Colors.black54,),
          onPressed: (){
            Get.to(ProfileScreen());
          },
        ),
        title: Text('About', style: TextStyle(
            color: Colors.black, fontSize: 20
        ),),

      ),
      body: Container(
        child: Text(""),
      ),

    );
  }
}
