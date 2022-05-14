// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:test_saja/translations/locale_keys.g.dart';
import 'package:test_saja/widgets/notificationService.dart';
import '../../controller/reminder_controller.dart';
import '../addreminder.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;



class ReminderScreeen extends StatefulWidget {
  @override
  State<ReminderScreeen> createState() => _ReminderScreeenState();
}

class _ReminderScreeenState extends State<ReminderScreeen> {
  final controller = Get.put(ReminderController());
  int SelectedMineuts=1  ;
  Duration _duration = Duration(hours: 0, minutes: 0);
  bool isSwitched = false;

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
        title: Text(LocaleKeys.reminders.tr,style: TextStyle(
          color: Colors.black , fontSize: 20,
        ),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed:(){
            Get.to(()=>AddnewReminder());

          },  icon: const Icon(Icons.add , color: Colors.green,)),

        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: TextStyle(fontSize: 15, color: Colors.black54,fontWeight: FontWeight.bold),
            ),
          ),
          DatePicker(
            DateTime.parse(DateTime.now().toString()),
            initialSelectedDate: DateTime.now(),
            onDateChange: (date){
              print('============');
              controller.d.value=date;
              print(controller.d.value);
              setState(() {

              });
              print('============');
            },
            selectionColor: Color(0xffEA9363),
          ),
          FutureBuilder(
            future: controller.getData(),
            builder: (context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(
                  child:SpinKitCircle(
                    color: Colors.amber,
                  ),
                );
              }
              else{
                List<int> numReminder=[];

                // Checling if the selected date = reminder date
                for(int i=0;i<controller.remindersref.docs.length;i++){
                  if(DateFormat.yMd().format(controller.d.value)==DateFormat.yMd().format(
                      DateTime.parse(controller.remindersref.docs[i]
                      ['Reminder_Date'])
                  )
                  ){
                    numReminder.add(i);

                  }
                }
                print(numReminder);
                // check if the list is empty or not
                return numReminder.isEmpty
                    ?Center(child: Column(
                  children: [
                    SizedBox(height: Get.width * 0.5,),
                    Text(LocaleKeys.no_reminder.tr,style: TextStyle(
                        fontSize: Get.width * 0.1
                    ),),
                  ],
                ),)
                    :Expanded(
                  child: ListView.builder(
                    itemCount: numReminder.length,
                    itemBuilder: (context, index) {return ExpansionTile(
                      title: Text('${snapshot.data!.docs[numReminder[index]]['Reminder_Type']}' , style: TextStyle(
                        color: Colors.black
                      ),),
                      children: [
                        Card(
                          margin: EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            color:  Colors.grey[200],
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    minLeadingWidth: 10 ,
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor :Color(0xffEA9363),
                                      child: Text(
                                        '${
                                            (
                                                snapshot.data!.docs[index]['Reminder_Time']
                                            )
                                        }' , style: TextStyle(
                                        fontSize: 14 , color: Colors.white ,
                                      ), textAlign: TextAlign.center, ),

                                    ),
                                    title: Text(

                                        '${snapshot.data!.docs[numReminder[index]]['Remindnder_Description']}' , style: TextStyle(
                                      fontSize: 13 ,
                                    ) , textAlign: TextAlign.left,),

                                  ),
                                ),
                                Column(
                                  children: [

                                    IconButton(onPressed: () async{
                                      var  c= FirebaseFirestore.instance.collection("Reminders");
                                      c.get().then((value){
                                        value.docs.forEach((element) {
                                          if(
                                          element['Remindnder_Description'] == snapshot.data!.docs[numReminder[index]]['Remindnder_Description']){
                                            print('Delete');
                                            c.doc(element.id) // <-- Doc ID to be deleted.
                                                .delete() // <-- Delete
                                                .then((_) {
                                              Get.snackbar(LocaleKeys.msg_delete_reminder, '');
                                            })
                                                .catchError((error) => print('Delete failed: $error'));
                                            setState(() {

                                            });
                                          }else{
                                            print('Cant Delete');
                                          }
                                        });
                                      });}, icon: Icon(Icons.delete, color: Colors.red)),
                                    Builder(
                                        builder: (BuildContext context) => GestureDetector(
                                          onTap: () async {

                                            var resultingDuration = await showDurationPicker(
                                              context: context,
                                              initialTime: Duration(minutes: _duration.inMinutes),

                                            );
                                            _duration = resultingDuration!;
                                            SelectedMineuts = resultingDuration.inMinutes  ;
                                            print(SelectedMineuts) ;
                                            // Taking reminder details AND (Selected Mins to start the notification)
                                            NotificationService().showNotification(
                                                2, '${snapshot.data!.docs[numReminder[index]]['Reminder_Type']} Reminder',
                                                '${snapshot.data!.docs[numReminder[index]]['Remindnder_Description']}', SelectedMineuts  );
                                            setState(() {

                                            });
                                          },
                                          child: Container(
                                              width: 100,
                                              height: 50,
                                              child: Icon(Icons.notifications , color: Colors.teal)),
                                        ))


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