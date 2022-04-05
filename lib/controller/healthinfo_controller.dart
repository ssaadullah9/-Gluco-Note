import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthInfoController extends GetxController{
  var keyForm = GlobalKey<FormState>().obs;
  var selectedGender = ''.obs;
  var selectedWeight = ''.obs;
  var selectedHeight = ''.obs;
  var selectedType = 'ff'.obs;
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