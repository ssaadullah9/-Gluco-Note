            // TODO Implement this library.
            import 'package:cloud_firestore/cloud_firestore.dart';
            import 'package:date_picker_timeline/date_picker_timeline.dart';
            import 'package:flutter/cupertino.dart';
            import 'package:flutter/material.dart';
            import 'package:get/get.dart';
            import 'package:intl/intl.dart';
            import 'package:flutter_speed_dial/flutter_speed_dial.dart';
            import 'package:test_saja/const/colors.dart';
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
                    title: Text('Reminders',style: TextStyle(
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
                future: controller.remindersref!.get() ,
                builder: (context,AsyncSnapshot snapshot){
                if(!snapshot.hasData){
                return Center(
                child: CircularProgressIndicator(),
                );
                }
                else{
                bool dontFound = false;
                List<int> numReminder=[];
                for(int i=0;i<snapshot.data.docs.length;i++){
                if(DateFormat.yMd().format(controller.d.value)==DateFormat.yMd().format(
                DateTime.parse(snapshot.data!.docs[i]
                ['Reminder_Date'])
                )
                ){
                numReminder.add(i);
                // remiderData.add(snapshot.data!.docs[i]);
                }
                }
                print(numReminder);
                return numReminder.isEmpty
                ?Center(child: Column(
                children: [
                SizedBox(height: Get.width * 0.5,),
                Text('No Reminders ',style: TextStyle(
                fontSize: Get.width * 0.1
                ),),
                ],
                ),)
                    :Expanded(
                child: ListView.builder(
                itemCount: numReminder.length,
                itemBuilder: (context, index) {return ExpansionTile(
                title: Text('${snapshot.data!.docs[numReminder[index]]['Reminder_Type']}'),
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
                backgroundColor : Colors.blueGrey ,
                child: Text(
                //   '${reminderList[index]['Reminder_Date']}'),
                '${
                (
                snapshot.data!.docs[index]['Reminder_Time']
                )
                }' , style: TextStyle(
                fontSize: 14 , color: Colors.white ,
                ), textAlign: TextAlign.center, ),
                //  backgroundColor: Colors.grey[200],
                ),
                title: Text(
                // '${reminderList[index]['Reminder_Date']}'),
                '${snapshot.data!.docs[numReminder[index]]['Remindnder_Description']}'),

                ),
                ),
                Column(
                children: [
                //IconButton(onPressed: () {}, icon: Icon(Icons.edit, color)),
                IconButton(onPressed: () async{
                var  c= FirebaseFirestore.instance.collection("Reminders");
                c.get().then((value){
                value.docs.forEach((element) {
                if(
                element['Remindnder_Description'] == snapshot.data!.docs[numReminder[index]]['Remindnder_Description']){
                print('Yesss');
                c.doc(element.id) // <-- Doc ID to be deleted.
                    .delete() // <-- Delete
                    .then((_) {
                Get.snackbar("Reminder Deleted Successfully", '');
                })
                    .catchError((error) => print('Delete failed: $error'));
                setState(() {

                });
                }else{
                print('Nooo');
                }
                });
                });}, icon: Icon(Icons.delete, color: Colors.red)),
                  IconButton(onPressed: () {
                    NotificationService().showNotification(1, "title", "body", 10);
                  }, icon: Icon(Icons.edit, color: Colors.black54)),
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