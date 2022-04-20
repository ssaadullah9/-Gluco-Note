import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReminderController extends GetxController {
  RxString selectedRD = "".obs;
  var d=DateTime.now().obs;
  dynamic data;
  var listReminderDate;
  var user = FirebaseAuth.instance.currentUser ;
  CollectionReference? remindersref;

  List remindersDate = [

  ].obs;

  getData() async {
    remindersref = FirebaseFirestore.instance.collection("Reminders");
    await remindersref!.where("Email" , isEqualTo: user!.email.toString()).get().then((snapShot) {
      print(snapShot.docs.length);
      print('=====>' + snapShot.docs[0]['Reminder_Date']);
      snapShot.docs.forEach((element) {
        remindersDate.add(element['Reminder_Date']
            .toString()
            .substring(0, element['Reminder_Date'].toString().length - 1));
        remindersDate.add(element['Reminder_Time'].toString());
        remindersDate.add(element['Reminder_Type'].toString());
        remindersDate.add(element['Remindnder_Description'].toString());

        print("###############") ;
        print(remindersDate.length) ;
      });
    });
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
