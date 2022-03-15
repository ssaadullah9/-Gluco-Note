// TODO Implement this library.
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:test_saja/const/colors.dart';

import 'addreminder.dart';

class ReminderScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Reminders',style: TextStyle(
          color: Colors.black , fontSize: 20,
        ),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed:(){
            Get.to(()=>AddnewReminder());
          },  icon: const Icon(Icons.add , color: Colors.green,)),

        ],
      ),
      body: Column(
        children: [
          Container(
            //margin: EdgeInsets.only(left: 140.0, top:3.0),
            width: double.infinity,
            height: Get.width * 0.25,
            child: Center(
              child: Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(fontSize: 15, color: Colors.black54,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: Get.width * 0.35,
            child: DatePicker(
              DateTime.now(),
                  initialSelectedDate: DateTime.now(),
              selectionColor: mainColor,
            ),
          ),

        ],
      ),
    );
  }
}

