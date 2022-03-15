import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:test_saja/controller/health_record_controller.dart';

import 'const/colors.dart';





class HealthRecordScreen extends StatelessWidget {
  final controller = Get.put(HealthRecordController());
  var selectedTGDates = TextEditingController();
  var selectedLDLDates = TextEditingController();
  var selectedAlbuminDates = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //AppBar

    return Scaffold(
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
          'Health Record',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),

      // start body
      body: Obx(
          ()=>Form(
            key: controller.keyForm,
            child: ListView(
              padding: EdgeInsets.all(Get.width * 0.05),
              children: [
                _buildDropDown(
                    hintText: 'AntiDiabteees',
                    value: controller.anti_diabteees.value
                ),
                SizedBox(height: Get.width * 0.06,),
                _buildDropDown(
                    hintText: 'Insulin',
                    value: controller.insulin.value
                ),
                SizedBox(height: Get.width * 0.06,),

                _buildDropDown(
                    hintText: 'Injectable',
                    value: controller.injectable.value
                ),
                SizedBox(height: Get.width * 0.06,),

                _buildDropDown(
                    hintText: 'Nutrition',
                    value: controller.nutrition.value
                ),
                SizedBox(height: Get.width * 0.06,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "LDL",
                  ),
                  validator: (val){
                    return val!.trim().isEmpty
                        ? 'can\'t be empty'
                        : null;
                  },
                  onChanged: (val){
                    controller.ldl.value = val;
                  },
                ),
                SizedBox(height: Get.width * 0.06,),
                _buildDateSelected(
                    text: 'LDL Date',
                    context: context,
                    selectDate: selectedLDLDates
                ),
                SizedBox(height: Get.width * 0.06,),

                //SizedBox(width: 10),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "TG",
                  ),
                  validator: (val){
                    return val!.trim().isEmpty
                        ? 'can\'t be empty'
                        : null;
                  },
                  onChanged: (val){
                    controller.tg.value = val;
                  },
                ),
                SizedBox(height: Get.width * 0.06,),
                /// 2
                _buildDateSelected(
                    text: 'TG Date',
                    context: context,
                    selectDate: selectedTGDates
                ),
                SizedBox(height: Get.width * 0.06,),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Albumin",
                  ),
                  validator: (val){
                    return val!.trim().isEmpty
                        ? 'can\'t be empty'
                        : null;
                  },
                  onChanged: (val){
                    controller.albumin.value = val;
                  },
                ),
                SizedBox(height: Get.width * 0.06,),

                /// 3
                _buildDateSelected(
                  text: 'Albumin Date',
                  context: context,
                  selectDate: selectedAlbuminDates
                ),
                SizedBox(height: Get.width * 0.06,),

                InkWell(
                  onTap: (){
                    if(controller.keyForm.currentState!.validate()){
                      Get.back();
                      Get.snackbar('Done', 'Update Information Successfully');
                    }else{

                    }
                     },
                  child: Container(
                    padding: EdgeInsets.all(15.0),

                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.done),
                        Text('Save Information',style: TextStyle(
                            fontSize: Get.width * 0.05
                        ),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),

      //  Start BottomAppBar
     /* floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () { Navigator.pushNamed(context, '/intakes')  ;},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // left icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){ Navigator.pushNamed(context, '/');},

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_filled),
                        Text('Home')
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){ Navigator.pushNamed(context, '/logbook');},

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_chart_rounded),
                        Text('LogBook')
                      ],
                    ),
                  )
                ],
              ),
              // right icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){},

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calculate_outlined ),
                        Text('Tests')
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){ Navigator.pushNamed(context, '/reminder');},

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notification_important),
                        Text('Reminder')
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),*/
      // end BottomAoppBar

    );
  }
Widget _buildDateSelected({text,context,selectDate}){
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      controller: selectedAlbuminDates,
      decoration: InputDecoration(
        labelText: '$text',
        border: OutlineInputBorder()
      ),
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2025),
        ).then((selectedDate) {
          if (selectedDate != null) {
          selectDate.text =
                DateFormat('yyyy-MM-dd').format(selectedDate);
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
//DropDown Methods
Widget _buildDropDown({hintText,value}){
    return DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: Icon(Icons.keyboard_arrow_down),
      decoration: InputDecoration(
        border: OutlineInputBorder()
      ),
      items: ["Yes", "No"]
          .map((e) => DropdownMenuItem(
        child: Text("$e"),
        value: e,
      ))
          .toList(),
      onChanged: (val) {
        value = val as String;
      },
      validator: (String? val){
       if(val==null){
         return 'can\'t be empty';
       }
      },
      hint: Text('$hintText'),
    );
}
}