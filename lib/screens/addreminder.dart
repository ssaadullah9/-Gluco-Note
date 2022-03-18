import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_saja/controller/addnewreminder_controller.dart';
import 'package:test_saja/screens/bottom_bar_screens/reminder.dart';

import '../const/colors.dart';

class AddnewReminder extends StatelessWidget {
  final controller = Get.put(AddNewReminderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          onPressed: () {
            Get.to(() => ReminderScreeen());
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
                    decoration: InputDecoration(
                    label: Text('Reminder description'),
                    border: OutlineInputBorder(),
                    hintText: 'Reminder description',
                  ),
                  onChanged: (val){
                  controller.description.value=val ;
                  },
                ),
                SizedBox(height: Get.width * 0.05,),
                TextFormField(
                  onTap: (){
                    controller.selectedTime(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    label: Text('Reminder Time'),
                    hintText: TimeOfDay.now().format(context).toString(),
                    suffixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder()
                  ),
                  onChanged: (val){
                    controller.selected_time.value=val as TimeOfDay ;
                  },
                ),
                SizedBox(height: Get.width*0.05,),

                DropdownButtonFormField(
                  hint: Text(controller.selectedType.value,style: TextStyle(
                      color: Colors.black
                  ),),
                  decoration: InputDecoration(

                      border: OutlineInputBorder(

                      )
                  ),
                  items: [
                    "Medication",
                    "Exercise",
                    "Liquid",
                    "Solid",
                    "Appointments"
                  ].map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  )).toList(),
                  onChanged: (val) {
                    controller.selectedType.value = val as String;
                  },
                ),
                SizedBox(height: Get.width*0.05,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          addReminder();
                          Get.snackbar(
                              "Reminder added succesfully ! " ,
                              ""

                          );
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


  addReminder() async{
    CollectionReference newReminder = FirebaseFirestore.instance.collection("Reminders") ;
    newReminder.add(
        {
          "Reminder_Date" : controller.selected_date.value.toString(),
          "Remindnder_Description" : controller.description.value.toString(),
          "Reminder_Time" : controller.selected_time.value.toString(),
          "Reminder_Type" : controller.selectedType.value.toString(),
        }
    ) ;

  }


} // end of the class
