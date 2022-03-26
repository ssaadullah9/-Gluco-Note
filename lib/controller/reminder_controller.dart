import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController{
  RxString selectedRD = "".obs  ;
  dynamic data;
  var listReminderDate;
  CollectionReference? remindersref;
  @override
  void onInit() {
    remindersref = FirebaseFirestore.instance.collection("Reminders");
    print(remindersref!.parent);


    super.onInit();
  }


}