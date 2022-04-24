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
  var remindersref;
    List remindersDate = [

  ].obs;

  getData() async {
  final  snapshot = await FirebaseFirestore.instance.collection("Reminders").where("Email" , isEqualTo: user!.email).get();
    if(snapshot.docs.isNotEmpty){
      print(snapshot.docs.length);
      print('=====>' + snapshot.docs[0]['Reminder_Date']);
      snapshot.docs.forEach((element) {
        remindersDate.add(element['Reminder_Date']
            .toString()
            .substring(0, element['Reminder_Date'].toString().length - 1));
        remindersDate.add(element['Reminder_Time'].toString());
        remindersDate.add(element['Reminder_Type'].toString());
        remindersDate.add(element['Remindnder_Description'].toString());
      });
      print("###############") ;
      // print(remindersDate.length) ;
      remindersref = snapshot;
      return remindersref;
    };
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
