import 'dart:async';
//import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
//import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:test_saja/screens/addreminder.dart';


class InTaksScreen extends StatefulWidget {
  static const IconData food_bank_sharp = IconData(0xe9a5, fontFamily: 'MaterialIcons');
  static const IconData medication_liquid = IconData(0xf053a, fontFamily: 'MaterialIcons');
  static const IconData fitness_center_outlined = IconData(0xf07a, fontFamily: 'MaterialIcons');
  static const IconData camera_alt_rounded = IconData(0xf60b, fontFamily: 'MaterialIcons');

  @override
  State<InTaksScreen> createState() => _InTaksScreenState();
}
class _InTaksScreenState extends State<InTaksScreen> {
  var timep;
  var t;
  var picked;

  var selectedf, s2, selectedff;

  List<dynamic> types = [];

  List<dynamic> typesname = [];

  List<dynamic> food = [];

  List<dynamic> ex = [];

  List<dynamic> time = [];

  List<dynamic> ex_cal = [];

  //************

  List<String>? category = [];
  List<String>? exercise = [];

  List<List<dynamic>>? categoryType = [];

  List<dynamic>? exerciseTypes = [];

  List<List<dynamic>>? exerciseTime = [];

  var selectCategory;
  var selectCategoryType;

  var selectExerciseType;
  var selectExerciseTime;
  var protein;

  //************

  String ? typesID;

  String ? foodID;

  String ? exID;

  String ? timeID;

  String ? selectedex;

  String? selectedValue;

  List<String> items = [
    'Every Day',
    'Every Week',
    'Two Times a week',
    'Three Times a week',
    'Every two weeks',
    'Once a month',
  ];

  late String dropdownValue;

  @override
  void initState() {
    timep = TimeOfDay.now();
    this.category = [
      "Fruits",
      "Meats",
      "Eggs",
      "Carbohydrates",
      "Sweets",
      "Ice-Cream",
      //"Other",//add new
    ];
    this.categoryType = [
      [
        {"name": "Apple", "cal": 95, "fat": 0.3, "pro": 0.5},
        {"name": "Apricot", "cal": 17, "fat": 0.14, "pro": 0.49},
        {"name": "avocado ", "cal": 322, "fat": 29.47, "pro": 4.02},
        {"name": "Banana", "cal": 105, "fat": 0.4, "pro": 1.3},
        {
          "name": "Black Olives (1 Greek olive)",
          "cal": 16,
          "fat": 1.43,
          "pro": 0.13
        },
        {"name": "cherry", "cal": 4, "fat": 0.01, "pro": 0.07},
        {"name": "dates", "cal": 20, "fat": 0, "pro": 0.2},
        {"name": "grape", "cal": 3, "fat": 0.01, "pro": 0.04},
        {"name": "Java Plum (3 fruits) ", "cal": 5, "fat": 0.02, "pro": 0.06},
        {"name": "	Kiwifruit", "cal": 46, "fat": 0.4, "pro": 0.87},
        {"name": "Lime", "cal": 20, "fat": 0.13, "pro": 0.47},
        {"name": "mango", "cal": 135, "fat": 0.56, "pro": 1.06},
        {"name": "Orange", "cal": 62, "fat": 0.2, "pro": 1.9},
        {"name": "Pineapple (1 slice) ", "cal": 40, "fat": 0.1, "pro": 0.45},
        {"name": "Pomegranate ", "cal": 105, "fat": 0.46, "pro": 1.46},
        {"name": "Peach", "cal": 38, "fat": 0.24, "pro": 0.89},
        {"name": "Pear", "cal": 96, "fat": 0.2, "pro": 0.63},
        {"name": "strawberry", "cal": 4, "fat": 0.04, "pro": 0.08},
        {
          "name": "Watermelon (1 cup of diced)",
          "cal": 46,
          "fat": 0.23,
          "pro": 0.93
        },
        {
          "name": "Watermelon (1 melon) ",
          "cal": 1355,
          "fat": 6.78,
          "pro": 27.56
        },

      ],
      [
        {"name": "Chicken (100 g)", "cal": 239, "fat": 14, "pro": 27}, //done
        {"name": "Fried Fish (10 g) ", "cal": 199, "fat": 11.37, "pro": 16.72},
        {
          "name": "Grilled Fish (1 fillet) ",
          "cal": 123,
          "fat": 1.33,
          "pro": 25.53
        }, //done
        {"name": "Tuna (100 g) ", "cal": 108, "fat": 0.95, "pro": 23.38}, //done
        {"name": "meat (100 g) ", "cal": 143, "fat": 3.5, "pro": 26}, //done
      ],
      [
        {"name": "Omelet", "cal": 98, "fat": 7.14, "pro": 6.81},
        //done (Fatsecret)
        {"name": "Fried", "cal": 89, "fat": 6.76, "pro": 6.24},
        //done
        {"name": "Boiled", "cal": 77, "fat": 5.28, "pro": 6.26},
        //done
      ],
      [
        {"name": "White Bread (1 slice) ", "cal": 66, "fat": 0.82, "pro": 1.91},
        //done
        {"name": "Pasta (100g)", "cal": 131, "fat": 1.05, "pro": 5.15},
        //done
        {"name": "Spaghetti (100g)", "cal": 157, "fat": 0.92, "pro": 5.76},
        //done
        {"name": "Chicken rice (100g)", "cal": 150, "fat": 5.44, "pro": 5.66},
        //done
        {"name": "White Rice (100g)", "cal": 129, "fat": 0.28, "pro": 2.66},
        //done
        {"name": "Brown Rice (100g)", "cal": 110, "fat": 0.89, "pro": 2.56},
        //done
      ],
      [
        // {"name":"Oreo","cal":0.5,"fat":0.23,"pro":80},
        {"name": "Snickers (15g)", "cal": 80, "fat": 4, "pro": 1.5},
        //done
        {"name": "Maltesers (37g)", "cal": 180, "fat": 9, "pro": 3},
        //Done
        {"name": "Milky Way Bar (52.2g)", "cal": 240, "fat": 9, "pro": 2},
        //done
        {"name": "Jellybeans (10 small)", "cal": 41, "fat": 0.01, "pro": 0},
        //done
      ],
      [
        {"name": "Vanilla (1/2 cup) ", "cal": 145, "fat": 7.92, "pro": 2.52},
        //done
        {"name": "Chocolate", "cal": 125, "fat": 6.38, "pro": 2.2},
        //done
        {"name": "Strawberry", "cal": 111, "fat": 4.87, "pro": 1.86},
        //done

      ],


    ];
    this.exercise = [
      "Walking",
      "Running",
      "Swimming"

    ];
    // this.exerciseTypes=[
    //   [
    //     {"minu":"5 Minutes","calo":21},
    //     {"minu":"10 Minutes","calo":42},
    //     {"minu":"15 Minutes","calo":63},
    //     {"minu":"30 Minutes","calo":42},
    //     {"minu":"10 Minutes","calo":42},
    //     {"minu":"10 Minutes","calo":42},
    //
    //
    //   ],
    // [
    //   {"minu":"5 Minutes","calo":21},
    // {"minu":"5 Minutes","calo":21},
    //   ],
    // [
    // {"minu":"5 Minutes","calo":21},
    // {"minu":"5 Minutes","calo":21},
    //   ]
    // ];

    this.exerciseTypes = [
      "Walking",
      "Running",
      "Swimming"
    ];

    this.exerciseTime = [
      ["20 Minutes", "30 Minutes", "45 Minutes", "60 Minutes", "75 Minutes",],
      ["09 Minutes", "14 Minutes", "21 Minutes", "27 Minutes", "41 Minutes",],
      ["60 Minutes"]
    ];
  }


  String typeOthers = '';
  int indexType = 0;
  int indexType2 = 0;
  bool isLoading = false;
  bool isLoading2 = false;

  Future<void> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 10, minute: 20)
    ))!;
    if (picked != null) {
      timep = picked;
    }
  }


  String selected_Ltype = '';
  dynamic selected_Lquantity = 0;
  dynamic solids_result;
  dynamic selected_squantity;
  dynamic L_calories = 0;
  dynamic sfat = 0;
  dynamic spro = 0;
  dynamic liquid_result = 0;
  dynamic protein_s = 0,
      fat_s = 0,
      cal_s = 0,
      Scal = 0;
  dynamic tim = 0,
      h = 0,
      w = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Intakes', style: TextStyle(
              color: Colors.white
          ),),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Solids', icon: Icon(Icons.local_pizza)),
              Tab(text: 'Liquids', icon: Icon(Icons.emoji_food_beverage)),
              Tab(text: 'Medication', icon: Icon(Icons.medication)),
              Tab(text: 'Exercise', icon: Icon(Icons.directions_run)),
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
            ListView(
                padding: EdgeInsets.all(15.0),
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Category: ',
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
                          hintText: 'selectCategory',
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
                          'Type: ',
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
                      : DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      if (val == null) {
                        return 'Error';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'SelectType', border: OutlineInputBorder()),
                    items: categoryType![indexType]
                        .map((e) {
                      return DropdownMenuItem(
                        child: Text('${e['name']}'),
                        value: e['name'],
                      );
                    }).toList(),
                    onChanged: selectCategory == null ? null
                        : (val) {
                      selectCategoryType = val;
                    },
                  ),

                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  // SizedBox(height: Get.width * 0.05,),
                  // selectCategory=='Other'?
                  // TextFormField(
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: 'enter calories..'
                  //   ),
                  //   onChanged: (val) {
                  //     selectCategoryType = int.parse(val);
                  //   },
                  // ): SizedBox(),

                  Column(

                      children: <Widget>[
                        Text("Quantity",
                            style: TextStyle(
                                fontSize: Get.width * 0.05,
                                fontWeight: FontWeight.bold
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.3,
                              vertical: Get.width * 0.025
                          ),
                          child: NumberInputWithIncrementDecrement(
                            controller: TextEditingController(),
                            min: 0,

                            onDecrement: (val) {
                              selected_squantity = val;
                            },
                            onIncrement: (val) {
                              selected_squantity = val;
                            },
                            onChanged: (val) {
                              selected_squantity = val;
                            },

                            // onChanged: (val) {
                            //   print(val);
                            // },
                          ),
                        )
                      ]
                  ),
                  SizedBox(height: Get.width * 0.05,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildContainerSolids(
                          label: 'Calories',
                          amount: Scal,
                          module: 'cal'
                      ), _buildContainerSolids(
                          label: 'Fat',
                          amount: sfat,
                          module: 'g'
                      ), _buildContainerSolids(
                          label: 'Protein',
                          amount: spro,
                          module: 'g'
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: Get.width * 0.1
                    ),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          for (var i = 0; i < categoryType!.length; i++) {
                            for (var j = 0; j < categoryType![i].length; j++) {
                              if (selectCategoryType ==
                                  categoryType![i][j]["name"]) {
                                //هون عرفي 3 متحولات واسندي القيمة الهن واعرضيهن عادي
                                print(categoryType![i][j]["cal"]);
                                cal_s = categoryType![i][j]["cal"];
                                Scal = cal_s * selected_squantity;
                                print(categoryType![i][j]["fat"]);
                                fat_s = categoryType![i][j]["fat"];
                                sfat = fat_s * selected_squantity;
                                print(categoryType![i][j]["pro"]);
                                protein_s = categoryType![i][j]["pro"];
                                spro = protein_s * selected_squantity;
                                setState(() {

                                });
                              }
                            }
                          }
                          Get.snackbar(
                              'do you want save it?',
                              'it will be show in the logbook',
                              snackPosition: SnackPosition.BOTTOM,
                              borderRadius: 0,
                              duration: Duration(milliseconds: 4500),
                              margin: EdgeInsets.zero,
                              mainButton: TextButton(
                                  onPressed: () {
                                    add_intakes("solids",cal_s ,selected_squantity ,selectCategoryType.toString());
                                    Scal=0;
                                    sfat=0;
                                    spro=0;
                                    // solids_result = cal_s * selected_squantity;
                                    print(solids_result);
                                    setState(() {});
                                  }, child: Text('Save',
                                style: TextStyle(
                                    color: Colors.blue
                                ),))
                          );
                        },
                        icon: Icon(Icons.add, size: 30),
                        label: Text("Calculate"),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFE5A9379),)
                    ),
                  )
                ]),
            //screen2
            ListView(
                padding: EdgeInsets.all(Get.width * 0.08),
                children: <Widget>[
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder()
                      ),
                      items: [
                        "Coffee ",
                        "Tea ",
                        "Juice",
                        "Soup",
                        "Milk",
                        "Others"
                      ].map((e) =>
                          DropdownMenuItem(
                            child: Text('$e'),
                            value: e,
                          )).toList(),
                      hint: Text('Select Liquids'),
                      onChanged: (val) {
                        selected_Ltype = val as String;
                        setState(() {
                          print(selected_Ltype);
                        });
                      }),
                  SizedBox(height: Get.width * 0.05,),
                  //selected_Ltype=='Others'?
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'enter calories..'
                    ),
                    onChanged: (val) {
                      L_calories = int.parse(val);
                    },
                  ), SizedBox(),
                  Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Quantity",
                            style: TextStyle(
                                fontSize: 18)),
                        SizedBox(height: Get.width * 0.05,),
                        NumberInputWithIncrementDecrement(
                          controller: TextEditingController(),
                          min: 0,
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
                      ]
                  ),
                  SizedBox(height: Get.width * 0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      _buildContainerlequids(
                          label: 'Calories',
                          amount: liquid_result,
                          module: 'cal'
                      ),
                      // _buildContainerSolids(
                      //     label: 'Fat',
                      //     amount: '0',
                      //     module: 'g'
                      // ), _buildContainerSolids(
                      //     label: 'Protein',
                      //     amount: '0',
                      //     module: 'g'
                      // ),
                    ],
                  ),
                  SizedBox(height: Get.width * 0.1,),
                  ElevatedButton.icon(
                      onPressed: () {
                        liquid_result = L_calories * selected_Lquantity;
                        print(liquid_result);
                        setState(() {});
                        Get.snackbar(
                            'do you want save it?',
                            'it will be show in the logbook',
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 0,
                            duration: Duration(milliseconds: 4500),
                            margin: EdgeInsets.zero,
                            mainButton: TextButton(onPressed: () {
                              add_intakes("liquids",liquid_result,selected_Lquantity ,selected_Ltype);
                              liquid_result = 0;
                              setState(() {});
                            },
                                child: Text('Save', style: TextStyle(
                                    color: Colors.blue
                                ),)

                            )
                        );
                      },
                      icon: Icon(Icons.add, size: 30),
                      label: Text("Calculate"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFE5A9379),)
                  )
                ]),

            //screen3
            ListView(
                padding: EdgeInsets.all(
                    Get.width * 0.05
                ),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      //suffixIcon: IconButton(
                      // onPressed: () {},
                      // icon: Icon(Icons.camera_enhance),
                      // ),
                    ),
                  ),
                  SizedBox(height: Get.width * 0.1,),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder()
                      ),
                      items: items.map((e) =>
                          DropdownMenuItem(
                            child: Text('$e'),
                            value: e,
                          )).toList(),
                      hint: Text('How Often'),
                      onChanged: (val) {}),
                  SizedBox(height: Get.width * 0.1,),

                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                    items: ["Pill", "Injection", "Topical", "Liquid"].map((e) =>
                        DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        )).toList(),
                    onChanged: (val) {},
                    hint: Text('Type'),
                  ),
                  SizedBox(height: Get.width * 0.05,),
                  Text('Amount',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.05
                    ),),
                  SizedBox(height: Get.width * 0.05,),
                  Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Expanded(
                        flex: 2,
                        child: NumberInputWithIncrementDecrement(
                          controller: TextEditingController(),
                          min: 0,

                          onChanged: (val) {

                          },
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),

                  SizedBox(height: Get.width * 0.05,),

                  SizedBox(height: Get.width * 0.05,),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE5A9379),),
                    onPressed: () {
                      //ToDo
                      Get.to(() =>
                          AddnewReminder(
                            //send parametr
                          ));
                    },

                    icon: Icon(Icons.add, size: 30),
                    label: Text("Add reminder"),

                  )
                ]),

            ListView(
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Types: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.06,
                          ),
                        )
                      ],
                    ),
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          hintText: 'selectType', border: OutlineInputBorder()),
                      items: exerciseTypes!.map((e) {
                        return DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (val) {
                        selectExerciseType = val;
                        indexType2 =
                            exerciseTypes!.indexOf('$selectExerciseType');
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Time: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.06,
                          ),
                        )
                      ],
                    ),
                  ),
                  isLoading2
                      ? Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      if (val == null) {
                        return 'Error';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'SelectTime', border: OutlineInputBorder()),
                    items: exerciseTime![indexType2]
                        .map((e) {
                      return DropdownMenuItem(
                        child: Text('$e'),
                        value: e,
                      );
                    }).toList(),
                    onChanged: selectExerciseType == null ? null
                        : (val) {
                      selectExerciseTime = val;
                      tim = selectExerciseTime;
                    },
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.08,
                        vertical: Get.width * 0.04
                    ),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.23),
                              offset: Offset(0, 8),
                              blurRadius: 8
                          )
                        ]
                    ),
                    width: Get.width * 0.5,
                    height: Get.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Calories burnt ', style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),


                        Expanded(
                          child: CircularPercentIndicator(
                            radius: Get.width * 0.135,
                            lineWidth: 10.0,
                            //ToDo FireBase
                            percent: 0.65,
                            animation: true,
                            animationDuration: 4000,
                            center: new Text('50.0%', style: TextStyle(
                                fontSize: 20
                            ),),
                            progressColor: Color(0xFFEA9363),

                          ),),
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
                              blurRadius: 8
                          )
                        ]
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.08,
                        vertical: Get.width * 0.02
                    ),
                    padding: EdgeInsets.all(10.0),
                    height: Get.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Container(
                            child: Text('Exercise Time ', style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ), textAlign: TextAlign.center,),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 15),

                            child: LinearPercentIndicator(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 150,
                              animation: true,
                              lineHeight: 25.0,
                              animationDuration: 4000,
                              //ToDo FireBase
                              percent: 0.64,
                              center: Text("64.0%"),
                              barRadius: const Radius.circular(16),
                              progressColor: Colors.red,
                              trailing: Icon(Icons.directions_run),
                            ),
                          ),
                        ),


                      ],
                    ),

                  ),

                  SizedBox(height: Get.width * 0.05,),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.08),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            cal_swimming(tim, h, w);
                            // Respond to button press
                          },
                          icon: Icon(Icons.add, size: 30),
                          label: Text("Calculate"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFE5A9379),)
                      )

                    //  )

                  )
                ]
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerSolids({label, amount, module}) {
    return Container(
      width: Get.width * 0.25,
      height: Get.width * 0.25, child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("$label", textAlign: TextAlign.center,
              style: new TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '$amount ', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold
                  )),
                  TextSpan(text: '$module', style: TextStyle(
                      color: Colors.grey
                  )),
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
      width: Get.width * 0.5,
      height: Get.width * 0.25, child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("$label", textAlign: TextAlign.center,
              style: new TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '$amount ', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold
                  )),
                  TextSpan(text: '$module', style: TextStyle(
                      color: Colors.grey
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  // add_lequids() async {
  //   CollectionReference liquid_ref = FirebaseFirestore.instance.collection(
  //       "Liquids");
  //   liquid_ref.add(
  //       {
  //         "Liquid_Cal": liquid_result.toString(),
  //         "Liquid_Type": selected_Ltype.toString(),
  //         "Liquid_Quantity": selected_Lquantity.toString(),
  //       }
  //
  //   );
  // }

  add_intakes(String type , int cal , int qu ,String cate) async {
    CollectionReference solieds_ref = FirebaseFirestore.instance.collection(
        "intakes");
    solieds_ref.add(
        {
          "intakes_Cal": cal,
          "intakes_category": cate.toString(),
          "intakes_Quantity": qu,
          "intakes_type":type,

        }
    );
  }


  cal_swimming(String val, int w, int t) {
    dynamic calories;
    if (val == "swimming")
      calories = t * 4 * 3.5 * w / (200 * 60);
    else if (val == "walking")
      calories = t * 3 * 3.5 * w / (200 * 60);
    else if (val == "Running")
      calories = t * 8 * 3.5 * w / (200 * 60);
  }
}