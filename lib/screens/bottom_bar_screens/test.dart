import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:test_saja/const/colors.dart';
import 'package:test_saja/controller/test_controller.dart';
import 'package:test_saja/models/bmi-model.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

import '/bmi.dart';
import '../../controller/main_controller.dart';

class TestScreen extends StatelessWidget {
  // final mainController = Get.lazyPut(() => MainController());
  final controller = Get.put(TestBMIController());

  TestScreen({Key? key}) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
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
                            controller.controllerPageView.value.jumpToPage(0);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleKeys.bmi.tr,
                              style: const TextStyle(
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
                            controller.controllerPageView.value.jumpToPage(1);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleKeys.glucose_recorder.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: controller.index.value == 1
                                      ? mainColor1
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
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
                            decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        Obx(
                          () => Column(
                            children: [
                              SizedBox(
                                height: Get.width * 0.35,
                              ),
                              Expanded(
                                child: Form(
                                  key: controller.keyForm.value,
                                  child: ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(Get.width * 0.05),
                                    children: [
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: LocaleKeys.height.tr,
                                        ),
                                        validator: (val) {
                                          return val!.trim().isEmpty
                                              ? LocaleKeys.field_required.tr
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: LocaleKeys.weight.tr,
                                        ),
                                        validator: (val) {
                                          return val!.trim().isEmpty
                                              ? LocaleKeys.field_required.tr
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
                                              if (controller
                                                  .keyForm.value.currentState!
                                                  .validate()) {
                                                controller
                                                    .bmi1.value = controller
                                                        .weightOfUser.value /
                                                    ((controller.heightOfUser
                                                                .value /
                                                            100) *
                                                        (controller.heightOfUser
                                                                .value /
                                                            100));

                                                if (controller.bmi.value >=
                                                        18.5 &&
                                                    controller.bmi.value <=
                                                        25) {
                                                  controller.bmiModel.value =
                                                      BMIModel(
                                                          bmi: controller
                                                              .bmi1.value,
                                                          isNormal: true,
                                                          comments: LocaleKeys
                                                              .normal.tr);
                                                } else if (controller
                                                        .bmi1.value <
                                                    18.5) {
                                                  controller.bmiModel.value =
                                                      BMIModel(
                                                    bmi: controller.bmi1.value
                                                        .roundToDouble(),
                                                    isNormal: false,
                                                    comments: LocaleKeys
                                                        .Underweighted.tr,
                                                  );
                                                } else {
                                                  controller.bmiModel.value =
                                                      BMIModel(
                                                    bmi: controller.bmi1.value,
                                                    isNormal: false,
                                                    comments: LocaleKeys
                                                        .Overweighted.tr,
                                                  );
                                                }
                                                Get.dialog(Center(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: Get.width * 0.5,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Get.width *
                                                                      0.1),
                                                      padding:
                                                          const EdgeInsets.all(
                                                        10.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0)),
                                                      child: ListView(
                                                        /*crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,*/
                                                        children: [
                                                          Text(
                                                            LocaleKeys
                                                                .result.tr,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20.0),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            " ${LocaleKeys.your_BMI.tr} ${controller.bmiModel.value.bmi.toStringAsFixed(2)} \n ${controller.bmiModel.value.comments}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18.0),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    addBmi();
                                                                    controller
                                                                        .keyForm
                                                                        .value
                                                                        .currentState!
                                                                        .reset();
                                                                    Get.back();
                                                                  },
                                                                  child: Text(
                                                                    LocaleKeys
                                                                        .ok.tr,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                              } else {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.ERROR,
                                                  animType:
                                                      AnimType.BOTTOMSLIDE,
                                                  title: LocaleKeys
                                                      .error_occurred.tr,
                                                  desc: LocaleKeys
                                                      .you_must_fill_fields.tr,
                                                  btnOkOnPress: () {},
                                                ).show();
                                              }
                                            }, // End OnPressed

                                            label:
                                                Text(LocaleKeys.calculate.tr),
                                            icon: const Icon(Icons.done),
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color(0xFF5A9379),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ) // End styleForm
                                            ),
                                      ),
                                      SizedBox(
                                        height: Get.width * 0.05,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        child: ExpansionTile(
                                          title: Text(LocaleKeys.show.tr),
                                          children: [
                                            //ToDO Firebase
                                            StreamBuilder(
                                                stream: controller.bmiTableData,
                                                builder: (context,
                                                    AsyncSnapshot<List<BMI>>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                      child: SpinKitCircle(
                                                        color: Colors.amber,
                                                      ),
                                                    );
                                                  } else {
                                                    return DataTable(
                                                        headingRowColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .blueGrey),
                                                        //ToDO Firebase
                                                        columns: /*bmiColumn
                                                            .map(
                                                              (e) => DataColumn(
                                                                label: Text(e),
                                                              ),
                                                            )
                                                            .toList(),*/
                                                            bmiColumn
                                                                .map(
                                                                  (e) =>
                                                                      DataColumn(
                                                                    label:
                                                                        Text(e),
                                                                  ),
                                                                )
                                                                .toList(),
                                                        rows:
                                                            // get Rows List
                                                            //fireBAse
                                                            snapshot.data!
                                                                .map(
                                                                  (bmi) =>
                                                                      DataRow(
                                                                    cells: [
                                                                      DataCell(Text(
                                                                          bmi.date ??
                                                                              '')),
                                                                      DataCell(Text(
                                                                          bmi.result ??
                                                                              '')),
                                                                      DataCell(Text(
                                                                          bmi.status ??
                                                                              '')),
                                                                    ],
                                                                  ),
                                                                )
                                                                .toList());
                                                  }
                                                }),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // second page
                    Stack(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: Get.width * 0.35,
                            decoration: const BoxDecoration(
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
                              LocaleKeys.enter_glucose_result.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: Get.width * 0.08,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.23),
                                        offset: const Offset(0, 8),
                                        blurRadius: 8.0)
                                  ]),
                              child: Column(children: [
                                Slider(
                                    value:
                                        controller.valueHolder.value.toDouble(),
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
                                  style: const TextStyle(fontSize: 22),
                                )
                              ] // end children
                                  ),
                            ),
                            SizedBox(
                              height: Get.width * 0.1,
                            ),
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder()),
                              items: [
                                LocaleKeys.Before_Breakfast.tr,
                                LocaleKeys.After_Breakfast.tr,
                                LocaleKeys.Before_Lunch.tr,
                                LocaleKeys.After_Lunch.tr,
                                LocaleKeys.Before_Dinner.tr,
                                LocaleKeys.After_Dinner.tr,
                                LocaleKeys.Before_Sleep.tr
                              ]
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                controller.selectedval.value = val as String;
                                //ToDO Firebase
                              },
                              hint: Text(LocaleKeys.test_period.tr),
                              icon: const Icon(
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
                                controller.date = Navigator.of(context).push(
                                  showPicker(
                                    context: context,
                                    value: controller.time.value,
                                    onChange: controller.onTimeChanged,
                                    minuteInterval: MinuteInterval.FIVE,
                                  ), // showPicker
                                );
                              },
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffixIcon: const Icon(Icons.access_time),
                                  hintText:
                                      controller.time.value.format(context)),
                            ),

                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.15,
                                  vertical: Get.width * 0.05),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  //add_glu(context);

                                  if (controller.valueHolder.value != 0 &&
                                      controller.selectedval.value.isNotEmpty) {
                                    Get.snackbar(
                                      LocaleKeys
                                          .do_you_want_to_save_your_result.tr,
                                      LocaleKeys.it_will_saved_logbook.tr,
                                      snackPosition: SnackPosition.BOTTOM,
                                      borderRadius: 0,
                                      duration:
                                          const Duration(milliseconds: 4500),
                                      margin: EdgeInsets.zero,
                                      mainButton: TextButton(
                                        onPressed: () {
                                          addGlu(context);
                                          Get.closeCurrentSnackbar();
                                          Get.find<MainController>()
                                              .currentIndex
                                              .value = 1;
                                        },
                                        child: Text(
                                          LocaleKeys.save.tr,
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                      ),
                                    );
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: LocaleKeys.error_occurred.tr,
                                      desc: LocaleKeys.you_must_fill_fields.tr,
                                      btnOkOnPress: () {
                                        Get.back();
                                      },
                                    ).show();
                                  }

                                  // Respond to button press
                                },
                                icon: const Icon(Icons.done, size: 30),
                                label: Text(LocaleKeys.save_info.tr),
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF5A9379),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  addBmi() async {
    // print("Date" + controller.Date.value.toString());
    // print(
    //     "Result" + controller.bmiModel.value.bmi.toStringAsFixed(2).toString());
    // print("Status" + controller.bmiModel.value.comments.toString());
    CollectionReference bmiInfo = FirebaseFirestore.instance.collection("BMI");
    bmiInfo.add({
      "Email": controller.user!.email.toString(),
      "Date": controller.Date.value.toString(),
      "Result": controller.bmiModel.value.bmi.toStringAsFixed(2).toString(),
      "Status": controller.bmiModel.value.comments.toString(),
    });
  }

  addGlu(context) async {
    CollectionReference gluInfo =
        FirebaseFirestore.instance.collection("Gluco_Measurment");
    gluInfo.add({
      "Email": controller.user!.email.toString(),
      "Date": controller.Date1.value.toString(),
      "Result": controller.valueHolder.value.toString(),
      "Test_preiod": controller.selectedval.value.toString(),
      "Time": controller.time.value.format(context).toString(),
    });
  }

  List<String> bmiColumn =
      [LocaleKeys.bmi_d.tr, LocaleKeys.bmi_r.tr, LocaleKeys.bmi_s.tr].obs;
}

/////

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

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
