import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthRecordController extends GetxController{
  var isEdit = false.obs;
  var selectedTGDates = TextEditingController();
  var selectedLDLDates = TextEditingController();
  var selectedAlbuminDates = TextEditingController();
  var anti_diabteees = TextEditingController();
  var insulin = TextEditingController();
  var injectable = TextEditingController();
  var nutrition = TextEditingController();
  var ldl = TextEditingController();
  var tg = TextEditingController();
  var albumin = TextEditingController();
  final keyForm = GlobalKey<FormState>();
}