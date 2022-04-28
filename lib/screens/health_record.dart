import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:test_saja/controller/health_record_controller.dart';

import '../const/colors.dart';

class HealthRecordScreen extends StatelessWidget {
  final controller = Get.put(HealthRecordController());
  var user = FirebaseAuth.instance.currentUser ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Obx(
                  ()=> IconButton(
                onPressed: (){
                  controller.isEdit.value = false;
                }, icon: Icon(Icons.edit, color: Colors.black,),tooltip: '${controller.isEdit.toString().substring(0,0)}Edit',)
          )
        ],
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
          'Health Record',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),

      // start body
      body: StreamBuilder(
        stream: controller.HealthRef!.snapshots(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Get.width * 0.05),
              child: Obx(
                      ()=>Form(
                    key: controller.keyForm,
                    child: Column(
                      children: [
                        DropDownFromFiled(
                            isEdit: controller.isEdit.value,

                            hintText: 'AntiDiabtees',
                            result: controller.anti_diabteees),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        DropDownFromFiled(
                            isEdit: controller.isEdit.value,
                            hintText: 'Insulin',
                            result: controller.insulin),

                        SizedBox(
                          height: Get.width * 0.06,
                        ),

                        DropDownFromFiled(
                            isEdit: controller.isEdit.value,

                            hintText: 'Injectable', result: controller.injectable),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),

                        DropDownFromFiled(
                            isEdit: controller.isEdit.value,
                            hintText: 'Nutrition', result: controller.nutrition),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        TextFormField(
                          initialValue: controller.user_LDL==null ? " ": controller.user_LDL ,
                          style: TextStyle(
                              color: controller.isEdit.value?Colors.grey:Colors.black
                          ) ,
                          readOnly: controller.isEdit.value?true:false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "LDL",

                          ),
                          validator: (val) {
                            return val!.trim().isEmpty ? 'can\'t be empty' : null;
                          },
                          onChanged: (val) {
                            controller.ldl.text = val;
                          },
                        ),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        _buildDateSelected(
                            isEdit: controller.isEdit.value,
                            text: 'LDL Date',
                            context: context,
                            selectDate: controller.selectedLDLDates),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        TextFormField(
                          initialValue: controller.user_TG==null ? " ": controller.user_TG,
                          style: TextStyle(
                              color: controller.isEdit.value?Colors.grey:Colors.black
                          ) ,
                          readOnly: controller.isEdit.value?true:false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "TG",
                          ),
                          validator: (val) {
                            return val!.trim().isEmpty ? 'can\'t be empty' : null;
                          },
                          onChanged: (val) {
                            controller.tg.text = val;
                            // print(controller.tg.value);
                          },
                        ),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),

                        /// 2
                        _buildDateSelected(

                            isEdit: controller.isEdit.value,
                            text: 'TG Date',
                            context: context,
                            selectDate: controller.selectedTGDates),

                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        TextFormField(
                          initialValue: controller.user_ALBUMIN==null ? " ": controller.user_ALBUMIN,
                          style: TextStyle(
                              color: controller.isEdit.value?Colors.grey:Colors.black
                          ) ,
                          readOnly: controller.isEdit.value?true:false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Albumin",
                          ),
                          validator: (val) {
                            return val!.trim().isEmpty ? 'can\'t be empty' : null;
                          },
                          onChanged: (val) {
                            controller.albumin.text = val;
                            //  print(controller.albumin.value);
                          },
                        ),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),

                        /// 3
                        _buildDateSelected(
                            isEdit: controller.isEdit.value,
                            text: 'Albumin Date',
                            context: context,
                            selectDate: controller.selectedAlbuminDates),

                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  if (controller.keyForm.currentState!.validate()) {
                                    add_record();
                                    controller.isEdit.value = true;
                                    print(
                                        '${controller.anti_diabteees.text}' +
                                            '\n' +
                                            '${controller.insulin.text}' +
                                            '\n' +
                                            '${controller.injectable.text}' +
                                            '\n' +
                                            '${controller.nutrition.text}' +
                                            '\n' +
                                            '${controller.ldl.text}' +
                                            '\n' +
                                            '${controller.selectedLDLDates.text}' +

                                            '\n' +
                                            '${controller.tg.text}' +
                                            '\n' +
                                            '${controller.selectedTGDates.text}' +
                                            '\n' +
                                            '${controller.albumin.text}'+
                                            '\n' +
                                            '${controller.selectedAlbuminDates.text}');
                                  }
                                },
                                icon: Icon(Icons.done, size: 30),
                                label: Text("Save Information"),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFE5A9379),
                                ))

                          //  )

                        )
                      ],
                    ),
                  )
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildDateSelected({text, context, selectDate,isEdit}) {
    return TextFormField(
      style:TextStyle(
          color: isEdit?Colors.grey:Colors.black
      ) ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      controller: selectDate,
      decoration:
      InputDecoration(
        labelText: '$text', border: OutlineInputBorder(),


      ),
      onTap: isEdit?null:() async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2025),
        ).then((selectedDate) {
          if (selectedDate != null) {
            selectDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter date.';
        }
        return null;
      },
    );
  }

  Future<void> add_record() async {
    CollectionReference helth_record =
    FirebaseFirestore.instance.collection("Health_Record");
    helth_record.doc(user!.uid).set({
      "Email": controller.user!.email.toString(),
      "AntiDiabtees": controller.anti_diabteees.text,
      "Insulin": controller.insulin.text,
      "Injectable": controller.injectable.text,
      "Nutrition ": controller.nutrition.text,
      "LDL ": controller.ldl.text,
      "LDL Date ": controller.selectedLDLDates.text,
      "TG ": controller.tg.text,
      "TG Date ": controller.selectedTGDates.text,
      "Albumin ": controller.albumin.text,
      "Albumin Date ": controller.selectedAlbuminDates.text,
    });
    // Get.snackbar('Hello', 'successfully add data');
  }
}

class DropDownFromFiled extends StatefulWidget {
  final String? hintText;
  var result;
  var isEdit;

  DropDownFromFiled({Key? key, this.hintText, this.result,this.isEdit}) : super(key: key);

  @override
  _DropDownFromFiledState createState() => _DropDownFromFiledState();
}

class _DropDownFromFiledState extends State<DropDownFromFiled> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: Icon(Icons.keyboard_arrow_down),
      onTap: null,
      decoration: InputDecoration(
          label: Text('${widget.hintText}'),
          //هنا يجب أن نجلب القيم من الفاير بيز ونضعها في مكانها
          hintText: '${widget.hintText}', border: OutlineInputBorder()),
      items: ["Yes", "No"]
          .map((e) => DropdownMenuItem(
        child: Text("$e"),
        value: e,
      ))
          .toList(),
      onChanged: widget.isEdit?null:(val) {
        widget.result.text = val.toString();
        setState(() {});
      },
      validator: (String? val) {
        if (val == null) {
          return 'can\'t be empty';
        }
      },
    );
  }
}
