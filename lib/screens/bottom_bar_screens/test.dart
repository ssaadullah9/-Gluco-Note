import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:test_saja/const/colors.dart';
import 'package:test_saja/controller/logbook_controller.dart';
import 'package:test_saja/controller/test_controller.dart';
import 'package:test_saja/screens/bottom_bar_screens/logbook.dart';
import '/Custom_Dialog.dart';
import '/bmi.dart';
import 'package:flutter/cupertino.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final controller = Get.put(TestBMIController());

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
        // first tab content
          children: [
            Expanded(
              child: Container(
                height: Get.width * 0.12,
                color: Colors.blueGrey,
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.index.value = 0;
                            controller.controllerPageView.value
                                .jumpToPage(0);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            alignment: Alignment.center,
                            child: Text(
                              'BMI',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: controller.index.value == 0
                                            ? mainColor1
                                            : Colors.transparent,
                                        width: 3))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.index.value = 1;
                            controller.controllerPageView.value
                                .jumpToPage(1);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            alignment: Alignment.center,
                            child: Text(
                              'Glucose Measurement',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: controller.index.value == 1
                                            ? mainColor1
                                            : Colors.transparent,
                                        width: 3))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 8,
                child: PageView(
                  controller: controller.controllerPageView.value,
                  onPageChanged: (val) {
                    controller.index.value = val;
                  },
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: Get.width * 0.35,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        Obx(() => Column(
                          children: [
                            SizedBox(
                              height: Get.width * 0.35,
                            ),
                            Expanded(
                              child: Form(
                                key: controller.keyForm.value,
                                child: ListView(
                                  shrinkWrap: true,
                                  padding:
                                  EdgeInsets.all(Get.width * 0.05),
                                  children: [
                                    TextFormField(
                                      keyboardType:
                                      TextInputType.number,
                                      autovalidateMode: AutovalidateMode
                                          .onUserInteraction,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Height (cm)",
                                      ),
                                      validator: (val) {
                                        return val!.trim().isEmpty
                                            ? 'can\'t be empty'
                                            : null;
                                      },
                                      onChanged: (val) {
                                        controller.heightOfUser.value =
                                            double.parse(val);
                                        //ToDO Firebase
                                      },
                                    ),
                                    SizedBox(height: Get.width * 0.05),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode
                                          .onUserInteraction,
                                      keyboardType:
                                      TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Weight (kg)",
                                      ),
                                      validator: (val) {
                                        return val!.trim().isEmpty
                                            ? 'can\'t be empty'
                                            : null;
                                      },
                                      onChanged: (value1) {
                                        controller.weightOfUser.value =
                                            double.parse(value1);
                                        //ToDO Firebase
                                      },
                                    ),
                                    SizedBox(height: Get.width * 0.05),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.1),
                                      child: ElevatedButton.icon(
                                          onPressed: () {

                                            /*if (controller.weightOfUser.value.toString().trim().isEmpty && controller.heightOfUser.value.toString().trim().isEmpty )
                                                     {
                                                       Get.snackbar(
                                                           " added successfully ! " ,
                                                           ""
                                                       );
                                                     }else {
                                                     AwesomeDialog(
                                                       context: context,
                                                       dialogType: DialogType.ERROR,
                                                       animType: AnimType.BOTTOMSLIDE,
                                                       title: 'Error',
                                                       desc: 'You must fill all the information',
                                                       btnOkOnPress: () {},
                                                     )..show();
                                                   }*/


                                            if (controller.keyForm.value.currentState!.validate()) {
                                              controller.bmi1
                                                  .value = controller
                                                  .weightOfUser
                                                  .value /
                                                  ((controller.heightOfUser
                                                      .value /
                                                      100) *
                                                      (controller
                                                          .heightOfUser
                                                          .value /
                                                          100));

                                              if (controller
                                                  .bmi.value >=
                                                  18.5 &&
                                                  controller
                                                      .bmi.value <=
                                                      25) {
                                                controller.bmiModel
                                                    .value =
                                                    BMIModel(
                                                        bmi: controller
                                                            .bmi1.value,
                                                        isNormal: true,
                                                        comments:
                                                        " Normal");
                                              } else if (controller
                                                  .bmi1.value <
                                                  18.5) {
                                                controller.bmiModel
                                                    .value =
                                                    BMIModel(
                                                        bmi: controller
                                                            .bmi1.value
                                                            .roundToDouble(),
                                                        isNormal: false,
                                                        comments:
                                                        " Underweighted");
                                              } else {
                                                controller.bmiModel
                                                    .value =
                                                    BMIModel(
                                                        bmi: controller
                                                            .bmi1.value,
                                                        isNormal: false,
                                                        comments:
                                                        " Overweighted");
                                              }
                                              Get.dialog(
                                                  Center(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        height: Get.width*0.4,
                                                        margin: EdgeInsets.symmetric(horizontal: Get.width *0.1),
                                                        padding: EdgeInsets.all(10.0),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(12.0)
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text('Result',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 20.0
                                                              ),),
                                                            SizedBox(height: 10,),
                                                            Text("Your BMI is ${controller.bmiModel.value.bmi.toStringAsFixed(2)} \n ${controller.bmiModel.value.comments}",textAlign: TextAlign.center,style: TextStyle(
                                                                fontSize: 18.0
                                                            ),),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                TextButton(onPressed: (){
                                                                  /*  add_bmi();
                                                                  controller
                                                                      .keyForm.value
                                                                      .currentState
                                                                  !.reset();
                                                                  Get.back();*/
                                                                  Get.back();
                                                                }, child: Text('ok',style: TextStyle(
                                                                    color: Colors.black
                                                                ),))
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              );
                                              // showDialog(
                                              //   context: context,
                                              //   builder: (context) =>
                                              //       CustomDialogBox(
                                              //     title: " RESULT",
                                              //     descriptions:
                                              //         "Your BMI is ${controller.bmiModel.value.bmi.toStringAsFixed(2)} \n ${controller.bmiModel.value.comments}",
                                              //     text: "Ok",
                                              //     actions: [
                                              //       ElevatedButton(
                                              //           onPressed: () {
                                              //             /*       add_bmi();
                                              //       print(controller.bmiModel
                                              //           .value.comments);
                                              //       print(controller.time.value);
                                              //       print(controller.bmiModel
                                              //           .value.bmi);*/
                                              //             print("xx");
                                              //
                                              //             Navigator.pop(
                                              //                 context);
                                              //             /*print('${controller.bmiModel
                                              //                 .value.bmi.toStringAsFixed(2)}'+ '\n' + '${controller.bmiModel
                                              //                 .value.comments}');*/
                                              //           },
                                              //           child:
                                              //               Text('OK')),
                                              //     ],
                                              //   ),
                                              // );
                                              add_bmi();
                                              controller
                                                  .keyForm.value
                                                  .currentState
                                              !.reset();

                                            }
                                            else{
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.ERROR,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: 'Error',
                                                desc: 'You must fill all the information',
                                                btnOkOnPress: () {},
                                              )..show();
                                            }
                                          }, // End OnPressesd

                                          label:
                                          const Text('CALCULATE'),
                                          icon: const Icon(Icons.done),
                                          style: ElevatedButton.styleFrom(
                                              primary:
                                              Color(0xFFE5A9379),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10))) // End styleForm
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.width * 0.05,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blueGrey)),
                                      child: ExpansionTile(
                                        title: Text('show'),
                                        children: [
                                          //ToDO Firebase
                                          FutureBuilder(
                                              future: controller.Bmiref!.get(),
                                              builder: (context,AsyncSnapshot snapshot)
                                              {
                                                if(!snapshot.hasData){
                                                  return Center(
                                                    child: SpinKitCircle(
                                                      color: Colors.amber,
                                                    ),
                                                  );
                                                }
                                                else { return
                                                  DataTable(
                                                      headingRowColor:
                                                      MaterialStateProperty
                                                          .all(Colors
                                                          .blueGrey),
                                                      //ToDO Firebase
                                                      columns:  Bmicolumn.map((e) => DataColumn(
                                                        label: Text(e),
                                                      )).toList(),

                                                      rows: controller.Bmirow.map((e) {
                                                        return DataRow(
                                                            cells: e.map((e){
                                                              return DataCell(
                                                                  Text('$e')
                                                              );
                                                            }).toList()
                                                        );
                                                      }).toList()

                                                  );
                                                }
                                              }
                                          ), // future builder
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),

                    // second page
                    Stack(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: Get.width * 0.35,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        ListView(
                          padding: EdgeInsets.all(Get.width * 0.05),
                          children: [
                            SizedBox(
                              height: Get.width * 0.3,
                            ),
                            Text(
                              'Enter your glucose result',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: Get.width * 0.08,
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                        Colors.black.withOpacity(.23),
                                        offset: Offset(0, 8),
                                        blurRadius: 8.0)
                                  ]),
                              child: Column(children: [
                                Slider(
                                    value: controller.valueHolder.value
                                        .toDouble(),
                                    min: 0,
                                    max: 700,
                                    divisions: 100,
                                    activeColor: Colors.blueGrey,
                                    inactiveColor: Colors.grey,
                                    label:
                                    '${controller.valueHolder.value.round()}',
                                    onChanged: (double newValue) {
                                      controller.valueHolder.value =
                                          newValue.round();
                                      //ToDO Firebase
                                    },
                                    semanticFormatterCallback:
                                        (double newValue) {
                                      return '${newValue.round()}';
                                    }),
                                Text(
                                  '${controller.valueHolder.value} mg/dl',
                                  style: TextStyle(fontSize: 22),
                                )
                              ] // end childern
                              ),
                            ),
                            SizedBox(
                              height: Get.width * 0.1,
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder()),
                              items: [
                                "Before Breakfast",
                                "After Breakfast",
                                "Before Lunch",
                                "After Lunch",
                                "Before Dinner",
                                "After Dinner",
                                "Before Sleep"
                              ]
                                  .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (val) {
                                controller.selectedval.value =
                                val as String;
                                //ToDO Firebase
                              },
                              hint: Text("test period"),
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 20,
                              ),
                            ),
////
                            SizedBox(
                              height: Get.width * 0.05,
                            ),
                            TextFormField(
                              readOnly: true,
                              onTap: () {

                                controller.date =
                                    Navigator.of(context).push(

                                      showPicker(
                                        context: context,
                                        value: controller.time.value,
                                        onChange: controller.onTimeChanged,
                                        minuteInterval: MinuteInterval.FIVE,
                                      ), // showpicker
                                    );
                              },
                              decoration: InputDecoration(
                                //label: Text('Select Time'),
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.access_time),
                                  hintText:
                                  '${controller.time.value.format(context)}'),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //
                            //   },
                            //   child: Container(
                            //       // padding: EdgeInsets.only(left: 15, right: 15),
                            //       height: Get.width * 0.15,
                            //       decoration: BoxDecoration(
                            //         border: Border.all(
                            //             color: Colors.grey, width: 1),
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //       child: Padding(
                            //         padding:
                            //             const EdgeInsets.only(right: 10.0,left: 15.0),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: <Widget>[
                            //             Text(
                            //               controller.time.value
                            //                   .format(context)==null?'test time':controller.time.value
                            //                   .format(context),
                            //               textAlign: TextAlign.end,
                            //               style: TextStyle(
                            //                   fontWeight:
                            //                       FontWeight.normal,
                            //                   fontSize: Get.width * 0.04,
                            //                   fontStyle:
                            //                       FontStyle.normal),
                            //             ),
                            //             Icon(
                            //               Icons.access_time,
                            //             ),
                            //           ],
                            //         ),
                            //       )),
                            // ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.15,
                                    vertical: Get.width * 0.05),
                                child: ElevatedButton.icon(
                                    onPressed: ()
                                    {
                                      //add_glu(context);


                                      if(controller.valueHolder.value != 0 && controller.selectedval.value.isNotEmpty && controller.time.value != 0)
                                      {

                                        Get.snackbar(
                                            'do you want save it?',
                                            'it will be show in the logbook',
                                            snackPosition: SnackPosition.BOTTOM,
                                            borderRadius: 0,
                                            duration: Duration(milliseconds: 4500),
                                            margin: EdgeInsets.zero,
                                            mainButton: TextButton(
                                                onPressed: () {
                                                  add_glu(context);
                                                  /*  controller.keyForm.value.currentState!.reset();
                                                  Get.back();*/
                                                  Get.to(()=>LogBookScreen())!.then((value) {
                                                    setState(() {
                                                      LogBookController().update() ;
                                                    });
                                                  });

                                          /*        Get.to(()=>LogBookScreen()) ;*/

                                                }, child: Text('Save',
                                              style: TextStyle(
                                                  color: Colors.blue
                                              ),))
                                        );
                                      }else {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.ERROR,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'Error',
                                          desc: 'You must fill all the information',
                                          btnOkOnPress: () {
                                            // controller.keyForm.value.currentState!.reset();

                                            Get.back();
                                          },

                                        )..show();
                                      }

                                      // Respond to button press
                                    },
                                    icon: Icon(Icons.done, size: 30),
                                    label: Text("Save Information"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFE5A9379),
                                    ))),
                          ],
                        )
                      ],
                    ),
                  ],
                ))
          ])),
    );
  }

  add_bmi() async {

    print("Date"+ controller.Date.value.toString());
    print("Result"+ controller.bmiModel.value.bmi.toStringAsFixed(2).toString());
    print("Status"+ controller.bmiModel.value.comments.toString());
    CollectionReference bmi_info = FirebaseFirestore.instance.collection("BMI");
    bmi_info.add({
      "Email": controller.user!.email.toString(),
      "Date": controller.Date.value.toString(),
      "Result": controller.bmiModel.value.bmi.toStringAsFixed(2).toString(),
      "Status": controller.bmiModel.value.comments.toString(),
    });

  }

  add_glu(context) async {
    CollectionReference glu_info = await
    FirebaseFirestore.instance.collection("Gluco_Measurment");
    glu_info.add({
      "Email": controller.user!.email.toString(),
      "Date": controller.Date1.value.toString(),
      "Result": controller.valueHolder.value.toString(),
      "Test_preiod": controller.selectedval.value.toString(),
      "Time": controller.time.value.format(context).toString(),
    });
  }

  List<String> Bmicolumn = [
    'Date',
    'Result ',
    'Status ',
  ];
}

/////

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0, size.height); // start path with this
    var firstStart =
    Offset(size.width / 5, size.height); // first point of curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    // second point of curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width - (size.width / 3.24),
        size.height - 105); // first point of curve
    var secondEnd = Offset(size.width, size.height - 10);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
