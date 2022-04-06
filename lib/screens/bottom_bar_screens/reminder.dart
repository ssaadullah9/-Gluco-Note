// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:test_saja/const/colors.dart';

import '../../controller/reminder_controller.dart';
import '../addreminder.dart';



class ReminderScreeen extends StatefulWidget {
  @override
  State<ReminderScreeen> createState() => _ReminderScreeenState();
}

class _ReminderScreeenState extends State<ReminderScreeen> {
  final controller = Get.put(ReminderController());

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
                  child: SpinKitCircle(
                    color: Colors.amber,
                  ),
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
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text('${snapshot.data!.docs[numReminder[index]]['Reminder_Type']}'),
                        children: [
                          Card(
                            margin: EdgeInsets.all(20.0),
                            child: Container(
                              padding: EdgeInsets.all(30.0),
                              color:  Colors.grey[200],
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
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        // '${reminderList[index]['Reminder_Date']}'),
                                          '${snapshot.data!.docs[numReminder[index]]['Remindnder_Description']}'),

                                    ),

                                  ],
                                ),

                                trailing: SizedBox(
                                  width: 10,
                                  child: Column(
                                   // crossAxisAlignment : CrossAxisAlignment.start,
                                    mainAxisAlignment : MainAxisAlignment.start,
                                    children: [
                                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                                      IconButton(onPressed: ()  {
                                        FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                        await myTransaction.delete(snapshot.data.documents[index].reference);
                                      });}, icon: Icon(Icons.delete, color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                      // print(DateFormat.yMd().format(controller.d.value));
                      // print('\n');
                      // print( DateFormat.yMd().format(
                      //   DateTime.parse(snapshot.data!.docs[index]
                      //   ['Reminder_Date'])
                      // ));
                      // if(DateFormat.yMd().format(controller.d.value)==DateFormat.yMd().format(
                      //     DateTime.parse(snapshot.data!.docs[numReminder[index]]
                      //     ['Reminder_Date'])
                      //     )
                      // ){
                      //   if(!dontFound)
                      //     dontFound = true;
                      //   //print("Oooook");
                      //   return
                      // }else{
                      //   print("Noooooooo");
                      //   return SizedBox();
                      // }
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

