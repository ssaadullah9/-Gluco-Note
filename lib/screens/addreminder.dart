import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_saja/controller/addnewreminder_controller.dart';
import 'package:test_saja/screens/reminder.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TableCalendar(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Reminder Time: ',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onTap: (){
                          controller.selectedTime(context);
                        },
                        readOnly: true,
                        initialValue: TimeOfDay.now().format(context).toString(),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.access_time),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05
                            ),
                            border: OutlineInputBorder()
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width*0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Reminder Type:',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        hint: Text(controller.selectedType.value,style: TextStyle(
                            color: Colors.black
                        ),),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Get.width*0.05
                            ),
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
                    ),
                  ],
                ),
                SizedBox(height: Get.width*0.05,),
                InkWell(
                  onTap: (){
                    Get.back();
                    Get.snackbar('Done', 'Add NewReminder Successfully');
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),

                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.add),
                        Text('Add New Reminder',style: TextStyle(
                            fontSize: Get.width * 0.05
                        ),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
} // end of the class
