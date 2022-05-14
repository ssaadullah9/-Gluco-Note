import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewReminderController extends GetxController{
  var selectedType;
  final _formKey = GlobalKey<FormState>().obs;
  var selected_date = DateTime.now().obs;
  var focsed_date = DateTime.now().obs;
  var description= TextEditingController() ;
  var time1;
  var time = TimeOfDay.now().obs;


  void onTimeChanged(TimeOfDay newTime) {
    time.value = newTime;
  }
}