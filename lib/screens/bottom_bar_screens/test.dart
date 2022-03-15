import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/const/colors.dart';
import 'package:test_saja/controller/test_controller.dart';
import '/Custom_Dialog.dart';
import '/bmi.dart';
import 'package:flutter/cupertino.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {




  final controller = Get.put(TestBMIController());

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          ()=>Column(
            // first tab content
              children: [
                Expanded(
                  child: Container(
                    height: Get.width * 0.12,
                    color: Colors.blueGrey,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              controller.index.value = 0;
                              controller.controllerPageView
                                  .value.jumpToPage(0);
                            },
                            child: AnimatedContainer(
                              duration: Duration(
                                  milliseconds: 500),
                              alignment: Alignment.center,
                              child: Text('BMI',style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: controller.index.value==0
                                              ?mainColor
                                              :Colors.transparent,
                                          width: 3
                                      )
                                  )
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              controller.index.value = 1;
                              controller.controllerPageView
                                  .value.jumpToPage(1);
                            },
                            child: AnimatedContainer(
                              duration: Duration(
                                  milliseconds: 500),
                              alignment: Alignment.center,
                              child: Text('Glucose Measurement',style: TextStyle(
                                  fontWeight: FontWeight.bold

                              ),),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: controller.index.value == 1
                                              ?mainColor
                                              :Colors.transparent,
                                          width: 3
                                      )
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: PageView(
                      controller: controller.controllerPageView.value,
                  onPageChanged: (val){
                    controller.index.value = val;
                  },
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: Get.width *0.35,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        Obx(
                                ()=>Column(
                              children: [
                                SizedBox(height: Get.width * 0.1,),
                                Expanded(
                                  child: Form(
                                    key: controller.keyForm.value,
                                    child: ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(Get.width * 0.05),
                                      children: [
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Height (cm)",
                                          ),
                                          validator: (val){
                                            return val!.trim().isEmpty
                                                ?'can\'t be empty'
                                                :null;
                                          },
                                          onChanged: (val) {
                                            controller.heightOfUser.value = double.parse(val);
                                          },
                                        ),
                                        SizedBox(height: Get.width*0.05),
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Weight (kg)",
                                          ),
                                          validator: (val){
                                            return val!.trim().isEmpty
                                                ?'can\'t be empty'
                                                :null;
                                          },
                                          onChanged: (value1) {
                                            controller.weightOfUser.value = double.parse(value1);
                                          },
                                        ),
                                        SizedBox(height: Get.width*0.05),
                                        ElevatedButton.icon(
                                            onPressed: () {
                                            if(controller.keyForm.value.currentState!.validate()){
                                              controller.bmi1.value = controller.weightOfUser.value /
                                                  ((controller.heightOfUser.value / 100) *
                                                      (controller.heightOfUser.value / 100));

                                              if (controller.bmi.value >= 18.5 && controller.bmi.value <= 25) {
                                                controller.bmiModel.value = BMIModel(
                                                    bmi: controller.bmi1.value,
                                                    isNormal: true,
                                                    comments: "You are Totaly Fit");
                                              } else if (controller.bmi1.value < 18.5) {
                                                controller.bmiModel.value = BMIModel(
                                                    bmi: controller.bmi1.value.roundToDouble(),
                                                    isNormal: false,
                                                    comments:
                                                    "You are Underweighted");
                                              } else {
                                                controller.bmiModel.value = BMIModel(
                                                    bmi: controller.bmi1.value,
                                                    isNormal: false,
                                                    comments: "You are Overweighted");
                                              }
                                              showDialog(
                                                context: context,
                                                builder: (context) => CustomDialogBox(
                                                  title: " RESULT",
                                                  descriptions:
                                                  "Your BMI is ${controller.bmi1.value.round()} \n ${controller.comments.value}",
                                                  text: "Ok",
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('OK'))
                                                  ],
                                                ),
                                              );
                                            }else{

                                            }
                                            }, // End OnPressesd

                                            label: const Text('CALCULATE'),
                                            icon: const Icon(Icons.done),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xFFE5A9379),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        10))) // End styleForm
                                        ),
                                        SizedBox(height: Get.width*0.05,),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blueGrey
                                            )
                                          ),
                                          child: ExpansionTile(
                                            title: Text('show'),
                                            children: [
                                              DataTable(
                                                  headingRowColor:
                                                  MaterialStateProperty.all(Colors.blueGrey),
                                                  columns: const [
                                                    DataColumn(label: Text('Status')),
                                                    DataColumn(label: Text('Result')),
                                                    DataColumn(label: Text('Date '))
                                                  ],
                                                  rows: const [
                                                    DataRow(cells: [
                                                      DataCell(Text('Normal')),
                                                      DataCell(Text('23')),
                                                      DataCell(Text('2/2/2022')),
                                                    ]),
                                                    DataRow(cells: [
                                                      DataCell(Text('OverWeight')),
                                                      DataCell(Text('40')),
                                                      DataCell(Text('27/2/2022')),
                                                    ]),
                                                  ])
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                      ],
                    ),

                    // second page
                    Stack(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: Get.width *0.35,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        ListView(
                          padding: EdgeInsets.all(
                            Get.width * 0.05
                          ),
                          children: [
                            SizedBox(height: Get.width * 0.05,),
                            Text('Enter your glucose result',
                              textAlign: TextAlign.center , style: TextStyle(
                                  fontSize: 20
                              ),),
                            SizedBox(height: Get.width * 0.08,),
                            Card(
                                color: Colors.white,
                                child: Padding(
                                  padding:  EdgeInsets.all(Get.width * 0.05),
                                  child: Column(children: [
                                    Slider(
                                        value: controller.valueHolder.value.toDouble(),
                                        min: 1,
                                        max: 700,
                                        divisions: 100,
                                        activeColor: Colors.blueGrey,
                                        inactiveColor: Colors.grey,
                                        label: '${controller.valueHolder.value.round()}',
                                        onChanged: (double newValue) {

                                          controller.valueHolder.value =
                                              newValue.round();
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
                                )),
                            SizedBox(height: Get.width * 0.15,),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                border: OutlineInputBorder()
                              ),
                              items: [
                                "before breakfast",
                                "after breakfast",
                                "before lunch",
                                "after lunch",
                                "before dinner",
                                "after dinner",
                                "before sleep"
                              ].map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (val) {
                                  controller.selectedval.value = val as String;
                              },
                              hint: Text("test time"),
                              icon:  Icon(
                                Icons.announcement_outlined ,size: 20,) ,
                            ),
////
                          SizedBox(height: Get.width * 0.05,),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  showPicker(
                                    context: context,
                                    value: controller.time.value,
                                    onChange: controller.onTimeChanged,
                                    minuteInterval:
                                    MinuteInterval.FIVE,
                                    // Optional onChange to receive value as DateTime
                                    onChangeDateTime:
                                        (DateTime dateTime) {
                                      print(dateTime);
                                    },
                                  ), // showpicker
                                );
                              },
                              child: Container(
                                // padding: EdgeInsets.only(left: 15, right: 15),
                                  height: Get.width * 0.15,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        controller.time.value.format(context),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.normal),
                                      ),
                                      SizedBox(height: 10),
                                         Icon(
                                          Icons.access_time,
                                        ),
                                    ],
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.15,
                                  vertical: Get.width* 0.05
                                ),
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Respond to button press
                                    },
                                    icon: Icon(Icons.done, size: 30),
                                    label: Text("Save Information"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFE5A9379),)
                                )

                            ) ,
                          ],
                        )

                      ],
                    ),
                  ],
                ))
              ])
      ),
    );
  }
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
