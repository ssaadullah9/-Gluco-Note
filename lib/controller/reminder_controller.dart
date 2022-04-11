import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReminderController extends GetxController {
  RxString selectedRD = "".obs;
  var d=DateTime.now().obs;
  dynamic data;
  var listReminderDate;

  CollectionReference? remindersref;

  List remindersDate = [

  ].obs;

  Future<void> getData() async {
    remindersref = FirebaseFirestore.instance.collection("Reminders");
    await remindersref!.get().then((snapShot) {
      print(snapShot.docs.length);
      print('=====>' + snapShot.docs[0]['Reminder_Date']);
      snapShot.docs.forEach((element) {
        remindersDate.add(element['Reminder_Date']
            .toString()
            .substring(0, element['Reminder_Date'].toString().length - 1));
      });
    });
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
