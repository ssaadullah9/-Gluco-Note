import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthInfoController extends GetxController{
  var selectedGender = ''.obs;
  var selectedType = ''.obs;
  var selectedBirthDate = DateTime.now().obs;
  var selectedDate= DateTime.now().obs;
  var firstDate = DateTime(1970 , 1).obs;
  var lastDate = DateTime.now().obs;
  var id = 1.obs;
  var radioButtonItem = 'Male'.obs;

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: firstDate.value,
        lastDate: lastDate.value);
    if (picked != null) {
      selectedBirthDate.value = picked;
    }
  }

}