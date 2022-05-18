import 'dart:async';

//import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:test_saja/screens/add_reminder.dart';
import 'package:test_saja/screens/bottom_bar_screens/logbook.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

import '../widgets/notificationService.dart';

class InTaksScreen extends StatefulWidget {
  static const IconData food_bank_sharp =
      IconData(0xe9a5, fontFamily: 'MaterialIcons');
  static const IconData medication_liquid =
      IconData(0xf053a, fontFamily: 'MaterialIcons');
  static const IconData fitness_center_outlined =
      IconData(0xf07a, fontFamily: 'MaterialIcons');
  static const IconData camera_alt_rounded =
      IconData(0xf60b, fontFamily: 'MaterialIcons');

  @override
  State<InTaksScreen> createState() => _InTaksScreenState();
}

class _InTaksScreenState extends State<InTaksScreen> {
  void getDataFromFireBaseHealthInfo() async {
    data = FirebaseFirestore.instance.collection("Health_Info");
    await data!.get().then((snapShot) {
      _w = int.parse('${snapShot.docs[0]['Weight']}');
      _l = int.parse('${snapShot.docs[0]['Height']}');

      print(_w);
    });
  }

  var timep;
  var t;
  var picked;
  var user = FirebaseAuth.instance.currentUser;
  var selectedf, s2, selectedff;

  List<dynamic> types = [];

  List<dynamic> typesname = [];

  List<dynamic> food = [];

  List<dynamic> ex = [];

  List<dynamic> time = [];

  List<dynamic> ex_cal = [];

  //************
  String med_name = '';
  String med_time = ' ';

  List<String>? category = [];
  List<String>? exercise = [];
  List<String>? liq = [];
  List<List<dynamic>>? categoryType = [];
  List<dynamic>? liquidType = [];

  List<dynamic>? exerciseTypes = [];

  List<List<dynamic>>? exercisemet = [];
  double calories = 0.0;
  var selectCategory;
  var selectCategoryType;
  int FinishedTime = 1;
  var selectExerciseType;
  var selectliquidType;
  dynamic selectExerciseTime;
  var protein;
  String med_type = '';
  dynamic med_q;
  //************
  CollectionReference? data;
  String? typesID;

  String? foodID;

  String? exID;

  String? timeID;

  String? selectedex;

  String? selectedValue;

  List<String> items = [
    LocaleKeys.every_day.tr,
    LocaleKeys.every_week.tr,
    LocaleKeys.two_times_aweek.tr,
    LocaleKeys.three_times_aweek.tr,
    LocaleKeys.every_two_weeks.tr,
    // LocaleKeys.once_amonth.tr,
  ];

  late String dropdownValue;

  int _w = 0;
  int _l = 0;
  double calo = 0;
  @override
  void initState() {
    getDataFromFireBaseHealthInfo();
    timep = TimeOfDay.now();
    this.category = [
      LocaleKeys.Fruits.tr,
      LocaleKeys.Meats.tr,
      LocaleKeys.Eggs.tr,
      LocaleKeys.Carbohydrates.tr,
      LocaleKeys.Sweets.tr,
      LocaleKeys.IceCream.tr,
      LocaleKeys.Other.tr //add new
    ];
    this.categoryType = [
      [
        {"name": LocaleKeys.Apple.tr, "cal": 95, "fat": 0.3, "pro": 0.5},
        {"name": LocaleKeys.Apricot.tr, "cal": 17, "fat": 0.14, "pro": 0.49},
        {"name": LocaleKeys.avocado.tr, "cal": 322, "fat": 29.47, "pro": 4.02},
        {"name": LocaleKeys.Banana.tr, "cal": 105, "fat": 0.4, "pro": 1.3},
        {"name": LocaleKeys.olive.tr, "cal": 16, "fat": 1.43, "pro": 0.13},
        {"name": LocaleKeys.cherry.tr, "cal": 4, "fat": 0.01, "pro": 0.07},
        {"name": LocaleKeys.dates.tr, "cal": 20, "fat": 0, "pro": 0.2},
        {"name": LocaleKeys.grape.tr, "cal": 3, "fat": 0.01, "pro": 0.04},
        {"name": LocaleKeys.Java_Plum.tr, "cal": 5, "fat": 0.02, "pro": 0.06},
        {"name": LocaleKeys.Kiwifruit.tr, "cal": 46, "fat": 0.4, "pro": 0.87},
        {"name": LocaleKeys.Lime.tr, "cal": 20, "fat": 0.13, "pro": 0.47},
        {"name": LocaleKeys.mango.tr, "cal": 135, "fat": 0.56, "pro": 1.06},
        {"name": LocaleKeys.Orange.tr, "cal": 62, "fat": 0.2, "pro": 1.9},
        {"name": LocaleKeys.Pineapple.tr, "cal": 40, "fat": 0.1, "pro": 0.45},
        {
          "name": LocaleKeys.Pomegranate.tr,
          "cal": 105,
          "fat": 0.46,
          "pro": 1.46
        },
        {"name": LocaleKeys.Peach.tr, "cal": 38, "fat": 0.24, "pro": 0.89},
        {"name": LocaleKeys.Pear.tr, "cal": 96, "fat": 0.2, "pro": 0.63},
        {"name": LocaleKeys.strawberry.tr, "cal": 4, "fat": 0.04, "pro": 0.08},
        {"name": LocaleKeys.Watermelon.tr, "cal": 46, "fat": 0.23, "pro": 0.93},
        {
          "name": LocaleKeys.Watermelon2.tr,
          "cal": 1355,
          "fat": 6.78,
          "pro": 27.56
        },
      ],
      [
        {
          "name": LocaleKeys.Chicken.tr,
          "cal": 239,
          "fat": 14,
          "pro": 27
        }, //done
        {
          "name": LocaleKeys.Fried_Fish.tr,
          "cal": 199,
          "fat": 11.37,
          "pro": 16.72
        },
        {
          "name": LocaleKeys.Grilled_Fish.tr,
          "cal": 123,
          "fat": 1.33,
          "pro": 25.53
        }, //done
        {
          "name": LocaleKeys.Tuna.tr,
          "cal": 108,
          "fat": 0.95,
          "pro": 23.38
        }, //done
        {"name": LocaleKeys.meat.tr, "cal": 143, "fat": 3.5, "pro": 26}, //done
      ],
      [
        {"name": LocaleKeys.Omelet.tr, "cal": 98, "fat": 7.14, "pro": 6.81},
        //done (Fatsecret)
        {"name": LocaleKeys.Fried.tr, "cal": 89, "fat": 6.76, "pro": 6.24},
        //done
        {"name": LocaleKeys.Boiled.tr, "cal": 77, "fat": 5.28, "pro": 6.26},
        //done
      ],
      [
        {
          "name": LocaleKeys.White_Bread.tr,
          "cal": 66,
          "fat": 0.82,
          "pro": 1.91
        },
        //done
        {"name": LocaleKeys.Pasta.tr, "cal": 131, "fat": 1.05, "pro": 5.15},
        //done
        {"name": LocaleKeys.Spaghetti.tr, "cal": 157, "fat": 0.92, "pro": 5.76},
        //done
        {
          "name": LocaleKeys.Chicken_rice.tr,
          "cal": 150,
          "fat": 5.44,
          "pro": 5.66
        },
        //done
        {
          "name": LocaleKeys.White_Rice.tr,
          "cal": 129,
          "fat": 0.28,
          "pro": 2.66
        },
        //done
        {
          "name": LocaleKeys.Brown_Rice.tr,
          "cal": 110,
          "fat": 0.89,
          "pro": 2.56
        },
        //done
      ],
      [
        {"name": LocaleKeys.Snickers.tr, "cal": 80, "fat": 4, "pro": 1.5},
        //done
        {"name": LocaleKeys.Maltesers.tr, "cal": 180, "fat": 9, "pro": 3},
        //Done
        {"name": LocaleKeys.Milky_Way.tr, "cal": 240, "fat": 9, "pro": 2},
        //done
        {"name": LocaleKeys.Jellybeans.tr, "cal": 41, "fat": 0.01, "pro": 0},
        //done
      ],
      [
        {"name": LocaleKeys.Vanilla.tr, "cal": 145, "fat": 7.92, "pro": 2.52},
        //done
        {"name": LocaleKeys.Chocolate.tr, "cal": 125, "fat": 6.38, "pro": 2.2},
        //done
        {
          "name": LocaleKeys.Strawberry.tr,
          "cal": 111,
          "fat": 4.87,
          "pro": 1.86
        },
        //done
      ],
    ];
    this.liquidType = [
      {"name": LocaleKeys.Apple_juice.tr, "cal": 117, "fat": 0.27, "pro": 0.15},
      {
        "name": LocaleKeys.Banana_Juice.tr,
        "cal": 218,
        "fat": 0.81,
        "pro": 2.67
      },
      {"name": LocaleKeys.Carrot_Juice.tr, "cal": 94, "fat": 0.35, "pro": 2.24},
      {"name": LocaleKeys.Grape_Juice.tr, "cal": 154, "fat": 0.2, "pro": 1.42},
      {
        "name": LocaleKeys.Grapefruit_Juice.tr,
        "cal": 94,
        "fat": 0.25,
        "pro": 1.28
      },
      {"name": LocaleKeys.Mango_Juice.tr, "cal": 140, "fat": 0, "pro": 0},
      {"name": LocaleKeys.Orange_juice.tr, "cal": 112, "fat": 0.5, "pro": 1.74},
      {
        "name": LocaleKeys.Passion_fruit_juice.tr,
        "cal": 126,
        "fat": 0.12,
        "pro": 0.96
      },
      {
        "name": LocaleKeys.Strawberry_Juice.tr,
        "cal": 90,
        "fat": 1.42,
        "pro": 0.71
      },
      {"name": LocaleKeys.Tomato_Juice.tr, "cal": 41, "fat": 0.12, "pro": 1.85},
      {"name": LocaleKeys.Tea.tr, "cal": 2, "fat": 0, "pro": 0},
      {"name": LocaleKeys.Green_tea.tr, "cal": 2, "fat": 0, "pro": 0},
      {"name": LocaleKeys.Milk.tr, "cal": 122, "fat": 4.88, "pro": 8.03},
      {"name": LocaleKeys.Milk_Shake.tr, "cal": 382, "fat": 13.84, "pro": 9.03},
      {
        "name": LocaleKeys.Chocolate_Milk.tr,
        "cal": 208,
        "fat": 8.48,
        "pro": 7.92
      },
      {
        "name": LocaleKeys.Coffee_with_Milk.tr,
        "cal": 6,
        "fat": 0.15,
        "pro": 0.33
      },
      {"name": LocaleKeys.Coffee_Americano.tr, "cal": 5, "fat": 0, "pro": 0},
      {
        "name": LocaleKeys.Latte_Coffee.tr,
        "cal": 135,
        "fat": 5.51,
        "pro": 8.81
      },
      {
        "name": LocaleKeys.Espresso_Coffee.tr,
        "cal": 1,
        "fat": 0.11,
        "pro": 0.07
      },
      {"name": LocaleKeys.Cappuccino.tr, "cal": 56, "fat": 2.99, "pro": 3.06},
      {
        "name": LocaleKeys.French_Vanilla_Coffee.tr,
        "cal": 60,
        "fat": 2.5,
        "pro": 0
      },
      {
        "name": LocaleKeys.Turkish_Coffee.tr,
        "cal": 46,
        "fat": 0.02,
        "pro": 0.13
      },
      {"name": LocaleKeys.Other.tr},
    ];

    this.exerciseTypes = [
      {"name": LocaleKeys.Aerobics.tr, "met": 6.83},
      {"name": LocaleKeys.Baseball.tr, "met": 5},
      {"name": LocaleKeys.Basketball.tr, "met": 8},
      {"name": LocaleKeys.Billiards.tr, "met": 2.5}, //done
      {"name": LocaleKeys.Bowling.tr, "met": 3},
      {"name": LocaleKeys.Cycling.tr, "met": 9.5},
      {"name": LocaleKeys.Dancing.tr, "met": 4.5},
      {"name": LocaleKeys.Fishing.tr, "met": 4.5},
      {"name": LocaleKeys.Football.tr, "met": 7},
      {"name": LocaleKeys.Hiking.tr, "met": 6},
      {"name": LocaleKeys.Ice_skating.tr, "met": 7},
      {"name": LocaleKeys.Racquet_sports.tr, "met": 8.5},
      {"name": LocaleKeys.Running.tr, "met": 9.8},
      {"name": LocaleKeys.Swimming.tr, "met": 8},
      {"name": LocaleKeys.Walking.tr, "met": 3.8},
    ];
  }

  var updated;
  var other2;
  var other;
  String typeOthers = '';
  int indexType = 0;
  int indexType2 = 0;
  int indexType3 = 0;
  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;

  String percent = '0';
  int milliseconds = 5000;
  // Future<void> selectTime(BuildContext context) async {
  //   picked = (await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay(hour: 10, minute: 20)
  //   ))!;
  //   if (picked != null) {
  //     timep = picked;
  //   }
  // }
  double circlePrograce = 0.0;
  String selected_Ltype = '';
  dynamic selected_Lquantity;
  dynamic solids_result;
  dynamic selected_squantity;
  dynamic L_calories = 0;
  dynamic sfat = 0;
  dynamic spro = 0;
  dynamic liquid_result = 0;
  dynamic protein_s = 0,
      fat_s = 0,
      cal_s = 0,
      Scal = 0,
      cal_l = 0,
      fat_l = 0,
      pro_l = 0;
  dynamic tim = 0, h = 0, w = 0;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            LocaleKeys.Intakes.tr,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: LocaleKeys.Solids.tr, icon: Icon(Icons.local_pizza)),
              Tab(
                  text: LocaleKeys.Liquids.tr,
                  icon: Icon(Icons.emoji_food_beverage)),
              Tab(text: LocaleKeys.Medication.tr, icon: Icon(Icons.medication)),
              Tab(
                  text: LocaleKeys.Exercise.tr,
                  icon: Icon(Icons.directions_run)),
            ],
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            indicatorColor: Colors.blueGrey,
            indicatorWeight: 3,

            // indicator: BoxDecoration(
            //   color: Colors.blueGrey,
            //   borderRadius: BorderRadius.circular(50.0)
            // ),
          ),
        ),
        body: TabBarView(
          children: [
            //screen1
            ListView(padding: EdgeInsets.all(15.0), children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.Category.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.05,
                      ),
                    )
                  ],
                ),
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText: LocaleKeys.SelectCategory.tr,
                      border: OutlineInputBorder()),
                  items: category!.map((e) {
                    return DropdownMenuItem(
                      child: Text('$e'),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (val) {
                    selectCategory = val;
                    indexType = category!.indexOf('$selectCategory');
                    isLoading = true;
                    Timer(Duration(milliseconds: 500), () {
                      isLoading = false;
                      setState(() {});
                    });
                    setState(() {});
                  }),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.Type_r.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.05,
                      ),
                    )
                  ],
                ),
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : selectCategory == LocaleKeys.Other.tr
                      ? TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: LocaleKeys.enter_cal.tr,
                          ),
                          onChanged: (val) {
                            other = int.parse(val);
                          },
                        )
                      : DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val == null) {
                              return 'Error';
                            }
                          },
                          decoration: InputDecoration(
                              hintText: LocaleKeys.SelectType.tr,
                              border: OutlineInputBorder()),
                          items: categoryType![indexType].map((e) {
                            return DropdownMenuItem(
                              child: Text('${e['name']}'),
                              value: e['name'],
                            );
                          }).toList(),
                          onChanged: selectCategory == null
                              ? null
                              : (val) {
                                  selectCategoryType = val;
                                },
                        ),

              SizedBox(
                height: Get.width * 0.05,
              ),

              Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(LocaleKeys.Quantity.tr,
                        style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: Get.width * 0.05,
                    ),
                    NumberInputWithIncrementDecrement(
                      controller: TextEditingController(),
                      min: 1,
                      onDecrement: (val) {
                        selected_squantity = val;
                      },
                      onIncrement: (val) {
                        selected_squantity = val;
                      },
                      onChanged: (val) {
                        selected_squantity = val;
                      },
                    )
                  ]),
              // SizedBox(height: Get.width * 0.09,),
              SizedBox(
                height: Get.width * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildContainerSolids(
                      label: LocaleKeys.calories.tr,
                      amount: Scal,
                      module: 'cal'),
                  _buildContainerSolids(
                      label: LocaleKeys.Fat.tr, amount: sfat, module: 'g'),
                  _buildContainerSolids(
                      label: LocaleKeys.Protein.tr, amount: spro, module: 'g'),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.01, vertical: Get.width * 0.1),
                child: ElevatedButton.icon(
                    onPressed: () {
                      if (selectCategory == null ||
                          selectCategoryType == null ||
                          selected_squantity == null) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.BOTTOMSLIDE,
                          title: LocaleKeys.error.tr,
                          desc: LocaleKeys.e_fill.tr,
                          btnOkOnPress: () {},
                        )..show();
                      } else {
                        if (selectCategory == LocaleKeys.Other.tr) {
                          Scal = other * selected_squantity;
                          print(Scal);
                        }

                        for (var i = 0; i < categoryType!.length; i++) {
                          if (selectCategory == LocaleKeys.Other.tr) {
                            Scal = other * selected_squantity;
                            sfat = 0;
                            spro = 0;
                          }

                          for (var j = 0; j < categoryType![i].length; j++) {
                            if (selectCategoryType ==
                                categoryType![i][j]["name"]) {
                              print(categoryType![i][j]["cal"]);
                              cal_s = categoryType![i][j]["cal"];
                              Scal = cal_s * selected_squantity;
                              print(categoryType![i][j]["fat"]);
                              fat_s = categoryType![i][j]["fat"];
                              sfat = fat_s * selected_squantity;
                              print(categoryType![i][j]["pro"]);
                              protein_s = categoryType![i][j]["pro"];
                              spro = protein_s * selected_squantity;
                              sfat = sfat.toStringAsFixed(2);
                              spro = spro.toStringAsFixed(2);
                              Scal = Scal.toStringAsFixed(2);

                              setState(() {});
                            }
                          }
                        }
                        Get.snackbar(LocaleKeys.D_save.tr, LocaleKeys.s_log.tr,
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 0,
                            duration: Duration(milliseconds: 4500),
                            margin: EdgeInsets.zero,
                            mainButton: TextButton(
                                onPressed: () {
                                  add_intakes(
                                      "solids",
                                      cal_s,
                                      selected_squantity,
                                      selectCategoryType.toString());
                                  Scal = 0;
                                  sfat = 0;
                                  spro = 0;
                                  Timer(Duration(seconds: 2), () {
                                    Navigator.pop(context, LogBookScreen());
                                  });
                                  // solids_result = cal_s * selected_squantity;
                                  print(solids_result);
                                  setState(() {});
                                },
                                child: Text(
                                  LocaleKeys.save.tr,
                                  style: TextStyle(color: Colors.blue),
                                )));
                      }
                    },
                    icon: Icon(Icons.add, size: 30),
                    label: Text(LocaleKeys.calculate.tr),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE5A9379),
                    )),
              )
            ]),
            //screen2
            ListView(padding: EdgeInsets.all(15.0), children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.Liquid_type.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.05,
                      ),
                    )
                  ],
                ),
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText: LocaleKeys.s_liq.tr,
                      border: OutlineInputBorder()),
                  items: liquidType!.map((e) {
                    return DropdownMenuItem(
                      child: Text('${e['name']}'),
                      value: e['name'] ?? e,
                    );
                  }).toList(),
                  onChanged: (val) {
                    selectliquidType = val;
                    indexType3 = liquidType!.indexOf('$selectliquidType');
                    isLoading2 = true;
                    Timer(Duration(milliseconds: 500), () {
                      isLoading2 = false;
                      setState(() {});
                    });
                    setState(() {});
                  }),
              SizedBox(
                height: 10.0,
              ),
              isLoading2
                  ? Center(child: CircularProgressIndicator())
                  : selectliquidType == LocaleKeys.Other.tr
                      ? TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: LocaleKeys.enter_cal.tr,
                          ),
                          onChanged: (val) {
                            other2 = int.parse(val);
                          },
                        )
                      : SizedBox(),
              SizedBox(height: 10),
              Column(children: <Widget>[
                //Spacer(flex:1,),
                Text(LocaleKeys.quantity.tr, style: TextStyle(fontSize: 18)),

                SizedBox(
                  height: Get.width * 0.05,
                ),
                NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  min: 1,
                  onDecrement: (val) {
                    selected_Lquantity = val;
                  },
                  onIncrement: (val) {
                    selected_Lquantity = val;
                  },
                  onChanged: (val) {
                    selected_Lquantity = val;
                  },
                )
              ]),
              SizedBox(
                height: Get.width * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildContainerlequids(
                      label: LocaleKeys.calories.tr,
                      amount: liquid_result,
                      module: 'cal'),
                  _buildContainerSolids(
                      label: LocaleKeys.Fat.tr, amount: fat_l, module: 'g'),
                  _buildContainerSolids(
                      label: LocaleKeys.Protein.tr, amount: pro_l, module: 'g'),
                ],
              ),
              SizedBox(
                height: Get.width * 0.1,
              ),
              Container(
                child: ElevatedButton.icon(
                    onPressed: () {
                      if (selectliquidType == null ||
                          selected_Lquantity == null ||
                          other2 == null) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.BOTTOMSLIDE,
                          title: LocaleKeys.error.tr,
                          desc: LocaleKeys.e_fill.tr,
                          btnOkOnPress: () {},
                        )..show();
                      } else {
                        for (var i = 0; i < selectliquidType!.length; i++) {
                          if (selectliquidType == LocaleKeys.Other.tr) {
                            liquid_result = other2 * selected_Lquantity;
                            fat_l = 0;
                            pro_l = 0;
                          } else if (selectliquidType ==
                              liquidType![i]["name"]) {
                            cal_l = liquidType![i]["cal"];
                            liquid_result = cal_l * selected_Lquantity;
                            print(liquidType![i]["fat"]);
                            fat_l = liquidType![i]["fat"];
                            fat_l = fat_l * selected_Lquantity;
                            print(liquidType![i]["pro"]);
                            pro_l = liquidType![i]["pro"];
                            pro_l = pro_l * selected_Lquantity;

                            liquid_result = cal_l * selected_Lquantity;
                            print(liquid_result);
                          }
                        }
                        // liquid_result = liquid_result.toStringAsFixed(2);
                        // pro_l = pro_l.toStringAsFixed(2);
                        // fat_l = fat_l.toStringAsFixed(2);
                        setState(() {});

                        Get.snackbar(LocaleKeys.D_save.tr, LocaleKeys.s_log.tr,
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 0,
                            duration: Duration(milliseconds: 4500),
                            margin: EdgeInsets.zero,
                            mainButton: TextButton(
                                onPressed: () {
                                  add_intakes("liquids", liquid_result,
                                      selected_Lquantity, selectliquidType);
                                  liquid_result = 0;
                                  pro_l = 0;
                                  fat_l = 0;
                                  // Timer(
                                  //     Duration(
                                  //         seconds: 2
                                  //     ) ,
                                  //         () {
                                  //
                                  //       Navigator.pop(context ,LogBookScreen()) ;
                                  //     }
                                  // ) ;
                                  setState(() {});
                                },
                                child: Text(
                                  LocaleKeys.save.tr,
                                  style: TextStyle(color: Colors.blue),
                                )));
                      }
                    },
                    icon: Icon(Icons.add, size: 30),
                    label: Text(LocaleKeys.calculate.tr),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE5A9379),
                    )),
              )
            ]),

            //screen3
            ListView(
                padding: EdgeInsets.all(Get.width * 0.05),
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: LocaleKeys.name.tr,
                      ),
                      onChanged: (val) {
                        med_name = val as String;
                        setState(() {});
                      }),
                  SizedBox(
                    height: Get.width * 0.1,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      items: items
                          .map((e) => DropdownMenuItem(
                                child: Text('$e'),
                                value: e,
                              ))
                          .toList(),
                      hint: Text(LocaleKeys.How_Often.tr),
                      onChanged: (val) {
                        med_time = val as String;
                      }),
                  SizedBox(
                    height: Get.width * 0.1,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    items: [
                      LocaleKeys.pill.tr,
                      LocaleKeys.Injection.tr,
                      LocaleKeys.Topical.tr,
                      LocaleKeys.Liquidd.tr
                    ]
                        .map((e) => DropdownMenuItem(
                              child: Text('$e'),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      med_type = val as String;
                    },
                    hint: Text(LocaleKeys.type.tr),
                  ),
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  Text(
                    LocaleKeys.quantity.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.05),
                  ),
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  Row(
                    children: [
                      //  Expanded(child: SizedBox()),
                      Expanded(
                        flex: 2,
                        child: NumberInputWithIncrementDecrement(
                          controller: TextEditingController(),
                          min: 1,
                          onDecrement: (val) {
                            med_q = val;
                          },
                          onIncrement: (val) {
                            med_q = val;
                          },
                          onChanged: (val) {
                            med_q = val;
                          },
                        ),
                      ),
                      //Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE5A9379),
                    ),
                    onPressed: () {
                      if (med_name.isEmpty ||
                          med_time == null ||
                          med_type == null ||
                          med_q == null) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.BOTTOMSLIDE,
                          title: LocaleKeys.error.tr,
                          desc: LocaleKeys.e_fill.tr,
                          btnOkOnPress: () {},
                        )..show();
                      } else {
                        //ToDo
                        bool showText;
                        Get.to(
                            () => AddnewReminder(

                                //send parametr
                                ),
                            arguments: [med_name, med_time, med_type, med_q]);
                      }
                    },
                    icon: Icon(Icons.add, size: 30),
                    label: Text(LocaleKeys.add_new_reminder.tr),
                  )
                ]),
            //screen 4
            ListView(padding: EdgeInsets.all(15.0), children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.All_Exercises.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.05,
                      ),
                    )
                  ],
                ),
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText: LocaleKeys.e_type.tr,
                      border: OutlineInputBorder()),
                  items: exerciseTypes!.map((e) {
                    return DropdownMenuItem(
                      child: Text('${e['name']}'),
                      value: e['name'] ?? e,
                    );
                  }).toList(),
                  onChanged: (val) {
                    // print(val);
                    selectExerciseType = val;
                    indexType2 = exerciseTypes!.indexOf('$selectExerciseType');
                    isLoading2 = true;
                    Timer(Duration(milliseconds: 200), () {
                      isLoading2 = false;
                      setState(() {});
                    });
                    setState(() {});
                  }),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.Minutes_Performed.tr,
                      style: TextStyle(
                        color: Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.05,
                      ),
                    )
                  ],
                ),
              ), ////
              isLoading2
                  ? Center(child: CircularProgressIndicator())
                  : TextFormField(
                      maxLength: 3,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: LocaleKeys.m.tr,
                      ),
                      onChanged: (val) {
                        selectExerciseTime = val;
                      },
                      onEditingComplete: () {
                        print(selectExerciseTime);
                        FinishedTime = int.parse(selectExerciseTime);
                        milliseconds = int.parse(selectExerciseTime) * 60000;
                        print(milliseconds);
                        FocusScope.of(context).unfocus();
                        int i = 0;
                        Timer.periodic(
                            Duration(milliseconds: milliseconds ~/ 100),
                            (timer) {
                          setState(() {
                            percent = '$i';
                            if (i == 100) {
                              timer.cancel();
                            }
                            i++;
                          });
                        });
                      },
                    ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.08, vertical: Get.width * 0.04),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.23),
                          offset: Offset(0, 8),
                          blurRadius: 8)
                    ]),
                width: Get.width * 0.5,
                height: Get.width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.cal_burned.tr,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: CircularPercentIndicator(
                        radius: Get.width * 0.135,
                        lineWidth: 10.0,
                        //ToDo FireBase
                        percent: calo,
                        animation: true,
                        animationDuration: 2000,
                        center: Text(
                          "${calories}",
                          style: TextStyle(fontSize: 20),
                        ),
                        progressColor: Color(0xFFEA9363),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.23),
                          offset: Offset(0, 8),
                          blurRadius: 8)
                    ]),
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.08, vertical: Get.width * 0.02),
                padding: EdgeInsets.all(10.0),
                height: Get.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          LocaleKeys.e_timee.tr,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: (selectExerciseTime == null ||
                                selectExerciseTime == '0')
                            ? LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 150,
                                lineHeight: 25.0,
                                animation: true,
                                animationDuration: 0,
                                percent: 0,
                                center: Text('0%'),
                                barRadius: const Radius.circular(16),
                                progressColor: Colors.red,
                                trailing: Icon(Icons.directions_run),
                              )
                            : LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 150,
                                lineHeight: 25.0,
                                animation: true,
                                animationDuration: milliseconds,
                                percent: (selectExerciseTime == null ||
                                        selectExerciseTime == '0')
                                    ? 0
                                    : 1,
                                center: Text('${percent}%'),
                                barRadius: const Radius.circular(16),
                                progressColor: Colors.red,
                                trailing: Icon(Icons.directions_run),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.width * 0.05,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                  child: FutureBuilder(
                      future: data!.get(),
                      builder: (context, snapshot) {
                        return ElevatedButton.icon(
                            onPressed: () {
                              if (exerciseTypes == null ||
                                  selectExerciseTime == null) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: LocaleKeys.error.tr,
                                  desc: LocaleKeys.e_fill.tr,
                                  btnOkOnPress: () {},
                                )..show();
                              } else
                                for (var j = 0;
                                    j < exerciseTypes!.length;
                                    j++) {
                                  if (selectExerciseType ==
                                      exerciseTypes![j]["name"]) {
                                    print(exerciseTypes![j]["name"]);
                                    print(exerciseTypes![j]["met"]);
                                    selectExerciseTime =
                                        double.parse(selectExerciseTime);
                                    //  calories = selectExerciseTime * exerciseTypes![j]["met"] * 3.5 * 53/200 *60;

                                    calories = ((milliseconds / 60000) *
                                        exerciseTypes![j]["met"] *
                                        3.5 *
                                        _w /
                                        _l);

                                    calo = calories / 500;
                                    print(calo);
                                    calories = double.parse(
                                        (calories).toStringAsFixed(2));
                                    print(calories);
                                    add_ex(selectExerciseType, calories, calo);
                                    NotificationService().showNotification(
                                        1,
                                        LocaleKeys.e_timee.tr,
                                        LocaleKeys.e_fin.tr,
                                        FinishedTime);
                                    initState();
                                  }
                                }
                            },
                            icon: Icon(Icons.add, size: 30),
                            label: Text(LocaleKeys.calculate.tr),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFE5A9379),
                            ));
                      })

                  //  )

                  )
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerSolids({label, amount, module}) {
    return Container(
      width: Get.width * 0.25,
      height: Get.width * 0.25,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("$label",
                textAlign: TextAlign.center,
                style:
                    new TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '$amount ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: '$module', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerlequids({label, amount, module}) {
    return Container(
      width: Get.width * 0.25,
      height: Get.width * 0.25,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("$label",
                textAlign: TextAlign.center,
                style:
                    new TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '$amount ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: '$module', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  add_intakes(String type, int cal, int qu, String cate) async {
    CollectionReference solieds_ref =
        FirebaseFirestore.instance.collection("intakes");
    solieds_ref.add({
      "Email": user!.email.toString(),
      "intakes_Cal": cal,
      "intakes_category": cate.toString(),
      "intakes_Quantity": qu,
      "intakes_type": type,
    });

    cal_swimming(String val, int w, int t) {
      dynamic calories;
      if (val == "swimming")
        calories = t * 4 * 3.5 * w / (200 * 60);
      else if (val == "walking")
        calories = t * 3 * 3.5 * w / (200 * 60);
      else if (val == "Running") calories = t * 8 * 3.5 * w / (200 * 60);

      return calories;
    }
  }

  add_ex(exerciseTypes, double calories, double calo) {
    CollectionReference ex_ref = FirebaseFirestore.instance.collection("ex");
    ex_ref.add({
      "Email": user!.email.toString(),
      "ex_type": exerciseTypes,
      "ex_cal": calories,
      "ex_per": calo,
    });
  }
}
