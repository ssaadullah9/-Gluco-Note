// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:test_saja/const/colors.dart';

import '../../controller/reminder_controller.dart';
import '../addreminder.dart';



class ReminderScreeen extends StatelessWidget {
  final controller = Get.put(ReminderController());
  CollectionReference remindersref = FirebaseFirestore.instance.collection("Reminders");



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
            DateTime.now(),
                initialSelectedDate: DateTime.now(),

                //ToDO Convert Color To HexaDecimal
            selectionColor: Colors.orangeAccent.withOpacity(.8),
          ),
          //ToDo DateTime From FireBase Has Data And DateTime From FireBase == DateTime Swelected
          if ( 1== 1)
            Expanded(
                child: FutureBuilder(
                future:remindersref.get() ,
                  builder: (context,AsyncSnapshot snapshot){
                    return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          // title: Text('${reminderList[index]['Reminder_Date']}'),
                          title: Text('${snapshot.data!.docs[index]['Reminder_Type']}'),

                          children: [
                            Card(
                              margin: EdgeInsets.all(20.0),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                color:  Colors.grey[200],
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                     //   '${reminderList[index]['Reminder_Date']}'),
                                   '${snapshot.data!.docs[index]['Reminder_Date']}'),
                                  //  backgroundColor: Colors.grey[200],
                                  ),
                                  title: Text(
                                     // '${reminderList[index]['Reminder_Date']}'),
                                   '${snapshot.data!.docs[index]['Remindnder_Description']}'),

                        trailing: IconButton(
                                    onPressed: () {
                                   snapshot.data.docs[index].delete().await() ;
                                    },
                                    icon: Icon(Icons.delete_forever , color: Colors.red,),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },

                    );

                    //Text("") ;
            },

          ),
              ) else Column(
                children: [
                  SizedBox(height: Get.width * 0.5,),
                  Text('No Reminders Yet!!',style: TextStyle(
                    fontSize: Get.width * 0.08
                  ),),
                ],
              )


        ],
      ),
    );
  }
}

