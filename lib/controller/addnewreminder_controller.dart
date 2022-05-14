import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewReminderController extends GetxController{
  var selectedType;
  final _formKey = GlobalKey<FormState>().obs;
  var selected_date = DateTime.now().obs;
  var focsed_date = DateTime.now().obs;
/*  var  selected_time = TimeOfDay.now().obs;*/
  var description /*= ''.obs*/ ;
  var time1;
  var time = TimeOfDay.now().obs;


/*  selectedTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input); // end of showpicker
    if (timeOfDay != null ) {
      selected_time.value = timeOfDay;
      update();
    }
  } // end of method*/
  void onTimeChanged(TimeOfDay newTime) {
    time.value = newTime;
  }
}