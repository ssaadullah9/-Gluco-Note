import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_saja/const/colors.dart';
import 'package:test_saja/controller/healthinfo_controller.dart';

import '../widgets/navbar.dart';

class HealthInfoScreen extends StatelessWidget {
  final controller = Get.put(HealthInfoController());




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Health Information',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Obx(
          ()=>ListView(
            padding: EdgeInsets.all(
              Get.width * 0.03
            ),
            children: [
              Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(children: <Widget>[
                    Text('Gender: ',style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    Radio(
                      activeColor: mainColor,
                      value: 1,
                      groupValue: controller.id.value,
                      onChanged: (val) {
                          controller.radioButtonItem.value = 'Male';
                          controller.id.value = 1;
                      },
                    ),
                    Text(
                      'Male',
                      style: new TextStyle(fontSize: 15.0),
                    ),
                    Radio(
                    activeColor: mainColor,
                      value: 2,
                      groupValue: controller.id.value,
                      onChanged: (val) {
                          controller.radioButtonItem.value = 'Female';
                          controller.id.value = 2;
                      },
                    ),
                    Text(
                      'Female',
                      style: new TextStyle(fontSize: 15.0),
                    ),
                  ])),
              SizedBox(height: Get.width * 0.05,),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Weight",
                ),
                onChanged: (val){
                  controller.selectedWeight.value= val ;
                },
              ),
              SizedBox(height: Get.width * 0.05,),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
                items: ["Type 1", "Type 2", "Gestational"]
                    .map((e) => DropdownMenuItem(
                  child: Text("$e"),
                  value: e,
                ))
                    .toList(),
                onChanged: (val) {
                    controller.selectedType.value = val as String;
                },
                hint: Text('Diabetes Type:'),
              ),
              SizedBox(height: Get.width * 0.05,),
              _buildDateField(
                hintText: 'Date of birth ',
                selectedFromDate: controller.selectedBirthDate.value,
                onTap: () {
                  controller.selectBirthDate(context);
                },
              ),
              SizedBox(height: Get.width * 0.05,),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if(  (controller.radioButtonItem.value.isNotEmpty  &&  controller.selectedWeight.value.isNotEmpty
                            && controller.selectedBirthDate != null && controller.selectedType.value != null)){
                         addData() ;
                         Get.snackbar(
                             "Data Saved " ,
                             ""
                         ); }
                        else
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Error',
                            desc: 'You must fill all the information',
                            btnOkOnPress: () {},
                          )..show();
                      },
                      icon: Icon(Icons.done, size: 30),
                      label: Text("Save Information"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFE5A9379),)
                  )

                //  )

              )
            ],
          )
      ),
    );
  }

  Widget _buildDateField({required String hintText, DateTime? selectedFromDate, required VoidCallback onTap,}) {
    return GestureDetector(
        child: AbsorbPointer(
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              // border: InputBorder.none,
              hintText: selectedFromDate == null
                  ? hintText
                  : DateFormat('yyy-MM-dd').format(
                      selectedFromDate,
                    ),
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 138, 136, 136),
              ),
            ),
            onChanged: (v) {
                selectedFromDate = v as DateTime?;
            },
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        onTap: onTap);
  }
  addData() async{
    CollectionReference Health_info = FirebaseFirestore.instance.collection("Health_Info") ;
    Health_info.add(
      {
        "Gender" : controller.radioButtonItem.value.toString(),
        "Weight" : controller.selectedWeight.value,
        "Diabetes_Type" : controller.selectedType.value,
        "DOB" :DateFormat('dd-MM-yyyy').format(DateTime.parse(controller.selectedBirthDate.value.toString())) ,
      }
    ) ;

  }

}
