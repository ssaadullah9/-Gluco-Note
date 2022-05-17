// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_saja/translations/locale_keys.g.dart';
import 'package:test_saja/widgets/notificationService.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../controller/reminder_controller.dart';
import '../add_reminder.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final controller = Get.put(ReminderController());
  int selectedMineuts = 1;
  Duration _duration = const Duration(hours: 0, minutes: 0);
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          LocaleKeys.reminders.tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.to(() => AddnewReminder());
              },
              icon: const Icon(
                Icons.add,
                color: Colors.green,
              )),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
          DatePicker(
            DateTime.parse(DateTime.now().toString()),
            initialSelectedDate: DateTime.now(),
            onDateChange: (date) {
              // print('============');
              controller.d.value = date;
              // print(controller.d.value);
              setState(() {});
              // print('============');
            },
            selectionColor: const Color(0xffEA9363),
          ),
          FutureBuilder(
            future: controller.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.amber,
                  ),
                );
              } else {
                List<int> numReminder = [];

                // Checking if the selected date = reminder date
                for (int i = 0; i < controller.remindersref.docs.length; i++) {
                  if (DateFormat.yMd().format(controller.d.value) ==
                      DateFormat.yMd().format(DateTime.parse(
                          controller.remindersref.docs[i]['Reminder_Date']))) {
                    numReminder.add(i);
                  }
                }
                // print(numReminder);
                // check if the list is empty or not
                return numReminder.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.width * 0.5,
                            ),
                            Text(
                              LocaleKeys.no_reminder.tr,
                              style: TextStyle(fontSize: Get.width * 0.1),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: numReminder.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text(
                                '${snapshot.data!.docs[numReminder[index]]['Reminder_Type']}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              children: [
                                Card(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    color: Colors.grey[200],
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            minLeadingWidth: 10,
                                            leading: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  const Color(0xffEA9363),
                                              child: Text(
                                                '${(snapshot.data!.docs[index]['Reminder_Time'])}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            title: Text(
                                              '${snapshot.data!.docs[numReminder[index]]['Remindnder_Description']}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  var c = FirebaseFirestore
                                                      .instance
                                                      .collection("Reminders");
                                                  c.get().then(
                                                    (value) {
                                                      for (var element
                                                          in value.docs) {
                                                        if (element[
                                                                'Remindnder_Description'] ==
                                                            snapshot.data!.docs[
                                                                    numReminder[
                                                                        index]][
                                                                'Remindnder_Description']) {
                                                          // Todo: Delete
                                                          c
                                                              .doc(element
                                                                  .id) // <-- Doc ID to be deleted.
                                                              .delete() // <-- Delete
                                                              .then((_) {
                                                            Get.snackbar(
                                                                LocaleKeys
                                                                    .msg_delete_reminder
                                                                    .tr,
                                                                '');
                                                          }).catchError((error) =>
                                                                  throw error);
                                                          setState(() {});
                                                        } else {
                                                          // Todo: Can't Delete
                                                        }
                                                      }
                                                    },
                                                  );
                                                },
                                                icon: const Icon(Icons.delete,
                                                    color: Colors.red)),
                                            Builder(
                                              builder: (BuildContext context) =>
                                                  GestureDetector(
                                                onTap: () async {
                                                  var resultingDuration =
                                                      await showDurationPicker(
                                                    context: context,
                                                    initialTime: Duration(
                                                      minutes:
                                                          _duration.inMinutes,
                                                    ),
                                                  );
                                                  _duration =
                                                      resultingDuration!;
                                                  selectedMineuts =
                                                      resultingDuration
                                                          .inMinutes;
                                                  // print(SelectedMineuts);
                                                  // Taking reminder details AND (Selected Mins to start the notification)
                                                  NotificationService()
                                                      .showNotification(
                                                          2,
                                                          '${snapshot.data!.docs[numReminder[index]]['Reminder_Type']} ${LocaleKeys.reminder.tr}',
                                                          '${snapshot.data!.docs[numReminder[index]]['Remindnder_Description']}',
                                                          selectedMineuts);
                                                  setState(() {});
                                                },
                                                child: const SizedBox(
                                                  width: 100,
                                                  height: 50,
                                                  child: Icon(
                                                      Icons.notifications,
                                                      color: Colors.teal),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      );
              }

              //Text("") ;
            },
          ),
        ],
      ),
    );
  }
}
