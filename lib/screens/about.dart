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
            Get.back();
          },
        ),
        title: Text('About', style: TextStyle(
            color: Colors.black, fontSize: 20
        ),),

      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 90,) ,
          Center(
            child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: false,
                    readOnly: true,
                    maxLines: 11,
                    decoration: InputDecoration(
                        hintMaxLines: null ,
                        hintText: "Diabetic patients often are too busy to go to clinics to monitor blood glucose levels or forget"
                       " take their medicine, which can adversely affect their health. Thus, the idea of application is to"
                       " develop a mobile application in order to assess diabetic patients managing their  blood sugar .\n"
                     "   GlucoNote is a simple and straightforward app that allows you to log your blood sugar readings"
                        " and keep track of them from the convenience of your phone."
                    ,
                  ),
                ) ,

            )
            ),

          ) ,
          SizedBox(height: 100,) ,
          Center(child: Text(" GlucoNote Team." , style: TextStyle(
            color: Colors.black , fontSize: 12
          ),)) ,
        ],
      )

    );
  }
}
