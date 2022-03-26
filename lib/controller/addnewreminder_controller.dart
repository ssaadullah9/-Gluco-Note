import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewReminderController extends GetxController{
  var selectedType = 'type'.obs;
  var selected_date = DateTime.now().obs;
  var focsed_date = DateTime.now().obs;
  var  selected_time = TimeOfDay.now().obs;
  var description = ''.obs ;

  selectedTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input); // end of showpicker
    if (timeOfDay != null && timeOfDay != selected_time) {
      selected_time.value = timeOfDay;
    }
  } // end of method

}