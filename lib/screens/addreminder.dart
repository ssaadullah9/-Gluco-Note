
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_saja/controller/addnewreminder_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../const/colors.dart';
import 'bottom_bar_screens/reminder.dart';

class AddnewReminder extends StatelessWidget {
  final controller = Get.put(AddNewReminderController());
  var data = Get.arguments;
  var user = FirebaseAuth.instance.currentUser ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Add New Reminder',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Obx(
              ()=>Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: Get.width*0.03,
              vertical: Get.width*0.03,
            ),
            child: ListView(
              children: [
                Container(
                  child: TableCalendar(
                    //  controller.selected_date ,
                    onDaySelected: (x, y) {
                      controller.selected_date.value = x;
                      controller.focsed_date.value = y;
                    },
                    focusedDay: controller.focsed_date.value,
                    selectedDayPredicate: (day) => isSameDay(
                        day, controller.selected_date.value),
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2025, 01, 01),
                    calendarStyle: CalendarStyle(
                      selectedTextStyle: TextStyle(color: Colors.black54),
                    ),
                    shouldFillViewport: false,
                    daysOfWeekHeight: 15.0,
                  ),
                ),
                SizedBox(height: Get.width*0.05,),
                TextFormField(
                  maxLines: null,
                  initialValue :data==null? "" : "Medicine Name: ${data[0]} \nHow often: ${data[1]} \nType: ${data[2]} \nAmount: ${data[3]}  " ,
                  decoration: InputDecoration(
                    label: Text('Reminder description'),
                    border: OutlineInputBorder(),
                    hintText: 'Reminder description',

                  ),

                  onChanged: (val){
                    controller.description=val ;
                  },
                ),
                SizedBox(height: Get.width * 0.05,),
                /*    TextFormField(
                                    onTap: (){
                    controller.selectedTime(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    label: Text('Reminder Time'),
                    hintText: "${controller.selected_time.value.format(context)}",
                    suffixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder()
                  ),
                  onChanged: (val){
                    controller.selected_time.value=val as TimeOfDay ;
                  },
                ),*/
                TextFormField(
                  readOnly: true,
                  onTap: () {
                    controller.time1 =
                        Navigator.of(context).push(
                          showPicker(
                            context: context,
                            value: controller.time.value,
                            onChange: controller.onTimeChanged,
                            minuteInterval: MinuteInterval.FIVE,
                            minHour: double.parse("${controller.time.value.hour}" ),
                          ), // showpicker
                        );
                    print(controller.time.value.hour);
                  },
                  decoration: InputDecoration(
                    //  label: Text('Select Reminder Time'),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.access_time),
                      hintText:
                      '${controller.time.value.format(context)}'),
                ),
                SizedBox(height: Get.width*0.05,),

                DropdownButtonFormField(
                   /* hint: Text("Reminder type",style: TextStyle(
                        color: Colors.black
                    ),),*/

                    decoration: InputDecoration(
                      labelText: "Reminder type",
                        border: OutlineInputBorder(

                        )
                    ),
                    items: [
                      "Medication",
                      "Exercise",
                      "Appointments"
                    ].map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )).toList(),
                    onChanged: (val) {
                      controller.selectedType = val ;
                    },
                    /*validator: (val){
                      if (val == null) {
                        return 'Selecting type is required';
                      }
                    }*/
                ),
                SizedBox(height: Get.width*0.05,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          if( controller.description!=null
                             && controller.selectedType!=null){
                            addReminder(context);
                            Get.snackbar(
                              "Reminder added successfully ! " ,
                              "You have to set the reminder on " ,

                            );
                            Timer(
                                Duration(
                                    seconds: 2
                                ) ,
                                    () {

                                  Navigator.pop(context ,ReminderScreeen()) ;
                                }
                            ) ;
                          }else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Error',
                              desc: 'You must fill all the information',
                              btnOkOnPress: () {},
                            )..show();
                          }
                        },
                        icon: Icon(Icons.done, size: 30),
                        label: Text("Save Information"),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFE5A9379),)
                    )

                  //  )

                )
              ],
            ),
          )
      ),
    );
  }


  addReminder(context) async{
    CollectionReference newReminder = FirebaseFirestore.instance.collection("Reminders");
    newReminder.add(
        {
          "Email":user!.email.toString(),
          "Reminder_Date" : controller.selected_date.value.toString(),
          "Remindnder_Description" : controller.description.toString(),
          "Reminder_Time" : controller.time.value.format(context).toString(),
          "Reminder_Type" : controller.selectedType.toString(),
        }
    ) ;

  }


} // end of the class
