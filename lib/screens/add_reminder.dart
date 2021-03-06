import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_saja/controller/addnewreminder_controller.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

import 'bottom_bar_screens/reminder.dart';

class AddnewReminder extends StatefulWidget {
  @override
  State<AddnewReminder> createState() => _AddnewReminderState();
}

class _AddnewReminderState extends State<AddnewReminder> {
  final controller = Get.put(AddNewReminderController());

  var data = Get.arguments; // Recieving the data from Midication Sceen
  var user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    controller.description.text = data == null
        ? ""
        : "Medicine Name: ${data[0]} \nHow often: ${data[1]} \nType: ${data[2]} \nAmount: ${data[3]}.";
  }

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
          LocaleKeys.add_new_reminder.tr,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.03,
              vertical: Get.width * 0.03,
            ),
            child: ListView(
              children: [
                Container(
                  child: TableCalendar(
                    onDaySelected: (x, y) {
                      controller.selected_date.value = x;
                      controller.focsed_date.value = y;
                    },
                    focusedDay: controller.focsed_date.value,
                    selectedDayPredicate: (day) =>
                        isSameDay(day, controller.selected_date.value),
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2025, 01, 01),
                    calendarStyle: CalendarStyle(
                      selectedTextStyle: TextStyle(color: Colors.black54),
                    ),
                    shouldFillViewport: false, // Not to fill the entire screen
                    daysOfWeekHeight: 15.0,
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                TextFormField(
                  controller: TextEditingController(
                      text: data == null
                          ? ""
                          : "Medicine Name: ${data[0]} \nHow often: ${data[1]} \nType: ${data[2]} \nAmount: ${data[3]}."),
                  maxLines: data == null ? null : 4,
                  // initialValue :data== null? " " : "Medicine Name: ${data[0]} \nHow often: ${data[1]} \nType: ${data[2]} \nAmount: ${data[3]}." ,
                  decoration: InputDecoration(
                    label: Text(LocaleKeys.reminder_discription.tr),
                    border: OutlineInputBorder(),
                    hintText: LocaleKeys.reminder_discription.tr,
                  ),

                  onChanged: (val) {
                    controller.description.text = val;
                  },
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                TextFormField(
                  readOnly: true,
                  onTap: () {
                    controller.time1 = Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: controller.time.value,
                        onChange: controller.onTimeChanged,
                        minuteInterval: MinuteInterval.FIVE,
                      ), // showpicker
                    );
                    print(controller.time.value.hour);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.access_time),
                      hintText: '${controller.time.value.format(context)}'),
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: LocaleKeys.reminder_type.tr,
                      border: OutlineInputBorder()),
                  items: [
                    LocaleKeys.medication.tr,
                    LocaleKeys.exercise.tr,
                    LocaleKeys.appointment.tr
                  ]
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    controller.selectedType = val;
                  },
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          if (controller.description.text != null &&
                              controller.selectedType != null) {
                            print("${controller.description.text}");
                            addReminder(context);
                            Get.snackbar(
                              LocaleKeys.msg_add_reminder.tr,
                              LocaleKeys.msg_set_notification.tr,
                            );
                            Timer(Duration(seconds: 2), () {
                              Navigator.pop(context, ReminderScreen());
                            });
                          } else {
                            print(controller.description.text);
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              title: LocaleKeys.error_occurred.tr,
                              desc: LocaleKeys.you_must_fill_fields.tr,
                              btnOkOnPress: () {},
                            )..show();
                          }
                        },
                        icon: Icon(Icons.done, size: 30),
                        label: Text(LocaleKeys.save_info.tr),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFE5A9379),
                        ))

                    //  )

                    )
              ],
            ),
          )),
    );
  }

// Sending the data to firebase
  addReminder(context) async {
    CollectionReference newReminder =
        FirebaseFirestore.instance.collection("Reminders");
    newReminder.add({
      "Email": user!.email.toString(),
      "Reminder_Date": controller.selected_date.value.toString(),
      "Remindnder_Description": controller.description.text.toString(),
      "Reminder_Time": controller.time.value.format(context).toString(),
      "Reminder_Type": controller.selectedType.toString(),
    });
  }
} // end of the class
