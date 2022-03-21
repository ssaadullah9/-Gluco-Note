import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
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

  var picked;

  var selectedf , s2 , selectedff;

  List<dynamic> types =[];

  List<dynamic> typesname =[];

  List<dynamic> food=[];

  List<dynamic> ex=[];

  List<dynamic> time=[];

  List<dynamic> ex_cal=[];

  String ? typesID;

  String ? foodID;

  String ? exID ;

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
  void initState(){
    timep = TimeOfDay.now();
    this.types.add({"id": 1, "label":"Fruits"});
    this.types.add({"id": 2, "label":"Meats "});
    this.types.add({"id": 3, "label":"Eggs  "});
    this.types.add({"id": 4, "label":"Carbohydrates  "});
    this.types.add({"id": 5, "label":"Sweets "});
    this.types.add({"id": 6, "label":"Ice-Cream "});

    this.typesname= [
      {"ID": 1 , "Name":"Apple", "parentID": 1},
      {"ID": 2 , "Name":"Orange", "parentID": 1},
      {"ID": 3 , "Name":"Banana", "parentID": 1},
      {"ID": 4 , "Name":"dates", "parentID": 1},
      {"ID": 1 , "Name":"Chicken", "parentID": 2},
      {"ID": 2 , "Name":"Fried Fish", "parentID": 2},
      {"ID": 3 , "Name":"Fillet-fish", "parentID": 2},
      {"ID": 4 , "Name":"meat", "parentID": 2},
      {"ID": 1 , "Name":"Omelet", "parentID": 3},
      {"ID": 2 , "Name":"Fried", "parentID": 3},
      {"ID": 3 , "Name":"Boiled", "parentID": 3},
      {"ID": 1 , "Name":"White Bread", "parentID": 4},
      {"ID": 2 , "Name":"Pasta", "parentID": 4},
      {"ID": 3 , "Name":"Spaghetti", "parentID": 4},
      {"ID": 4, "Name":"chicken kabsa", "parentID": 4},
      {"ID": 5, "Name":"White Rice", "parentID": 4},

      {"ID": 1 , "Name":"Oreo", "parentID": 5},
      {"ID": 2 , "Name":"Snickers", "parentID": 5},
      {"ID": 3 , "Name":"Maltesers", "parentID": 5},
      {"ID": 1, "Name":"Vanilla", "parentID": 6},
      {"ID": 2, "Name":"Chocolate ", "parentID": 6},
      {"ID": 3 , "Name":"Strawberry ", "parentID": 6},
    ];

    this.ex.add({"id": 1, "label":"Walking"});
    this.ex.add({"id": 2, "label":"Running"});
    this.ex.add({"id": 3, "label":"Swimming"});

    this.ex_cal= [
      {"ID": 1 , "Name":"20 Minutes", "parentID": 1},
      {"ID": 2 , "Name":"30 Minutes", "parentID": 1},
      {"ID": 3 , "Name":"45 Minutes", "parentID": 1},
      {"ID": 4 , "Name":"60 Minutes", "parentID": 1},
      {"ID": 5 , "Name":"20 Minutes", "parentID": 1},
      {"ID": 1, "Name":"09 Minutes", "parentID": 2},
      {"ID": 2 , "Name":"14 Minutes", "parentID": 2},
      {"ID": 3 , "Name":"21 Minutes", "parentID": 2},
      {"ID": 4 , "Name":"27 Minutes", "parentID": 2},
      {"ID": 5 , "Name":"41 Minutes", "parentID": 2},
      {"ID": 1 , "Name":"60 Minutes", "parentID": 3},
    ];
  }

  Future<void> selectTime (BuildContext context)async{
    picked= (await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 10, minute: 20)
    ))! ;
    if (picked != null){
      timep = picked;
    }
  }
  int cal_liq( int x , int u)
  {

    var result = x * u ;
    return result as int ;

  }


  String selected_Ltype = '';
  var selected_Lquantity ;
  var L_calories ;
  int liquid_result =0   ;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('InTakes'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Solids', icon: Icon(Icons.local_pizza)),
              Tab(text: 'Liquids' ,icon: Icon(Icons.emoji_food_beverage)),
              Tab(text: 'Medication',icon: Icon(Icons.medication)),
              Tab(text: 'Exercise',icon: Icon(Icons.directions_run)),
            ],unselectedLabelColor: Colors.blueGrey,
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
                children: <Widget>[
                  FormHelper.dropDownWidgetWithLabel(
                    context,
                    "Category:",
                    "Select Type: ",
                    this.typesID,
                    this.types,
                        (onChangedVal){
                      this.typesID = onChangedVal;
                      print("Selected Types : $onChangedVal");
                      this.food= this.typesname.where(
                              (stateItem) => stateItem["parentID"].toString()==onChangedVal.toString()).toList();
                      this.foodID=null;
                    },
                        (onValidateval){
                      if (onValidateval==null){
                        return 'please slecet type';
                      }
                      return null;
                    },
                    // borderColor: Theme.of(context).primaryColor,
                    borderColor: Colors.black ,
                    // borderFocusColor: Theme.of(context).primaryColor,
                    borderFocusColor: Colors.black54 ,
                    borderRadius: 10,
                    optionLabel: "label",
                    optionValue: "id",


                  ),
                  FormHelper.dropDownWidgetWithLabel(
                    context,
                    "Type:" ,
                    "Select type",
                    this.foodID,
                    this.food,
                        (onChangedVal){
                      this.foodID=onChangedVal;
                      print("Selected type: ");
                    },
                        (onValidate){
                      return null;
                    }
                    ,
                    // borderColor: Theme.of(context).primaryColor,
                    borderColor: Colors.black ,
                    // borderFocusColor: Theme.of(context).primaryColor,
                    borderFocusColor: Colors.black54 ,
                    borderRadius: 10,
                    optionValue: "ID",
                    optionLabel: "Name",

                  ),
                  SizedBox(height: Get.width * 0.05,),
                  Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Quantity",
                            style:  TextStyle(
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
                            max: 10,
                            onChanged: (val){
                              print(val);
                            },
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
                          amount: '0',
                          module: 'cal'
                      ), _buildContainerSolids(
                          label: 'Fat',
                          amount: '0',
                          module: 'g'
                      ), _buildContainerSolids(
                          label: 'Protein',
                          amount: '0',
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
                          Get.snackbar(
                              'do you want save it?',
                              'it will be show in the logbook',
                              snackPosition: SnackPosition.BOTTOM,
                              borderRadius: 0,
                              duration: Duration(milliseconds: 4500),
                              margin: EdgeInsets.zero,
                              mainButton: TextButton(onPressed: (){}, child: Text('Save',style: TextStyle(
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
                      onChanged: (val){
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
                    onChanged: (val){
                      L_calories = val ;
                    },
                  ) , SizedBox(),
                  Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Quantity",
                            style:  TextStyle(
                                fontSize: 18)),
                        SizedBox(height: Get.width * 0.05,),
                        NumberInputWithIncrementDecrement(
                          controller: TextEditingController(),
                          min: 0,
                          max: 10,
                          onDecrement: (val){
                            selected_Lquantity = val ;

    },
                          onIncrement: (val){
                            selected_Lquantity = val ;

    },
                          onChanged: (val){
                         //   print(selected_Lquantity);
                            selected_Lquantity = val  ;

                          },
                        )
                      ]
                  ),
                  SizedBox(height: Get.width * 0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildContainerSolids(
                          label: 'Calories',
                          amount: '0',
                          module: 'cal'
                      ), _buildContainerSolids(
                          label: 'Fat',
                          amount: '0',
                          module: 'g'
                      ), _buildContainerSolids(
                          label: 'Protein',
                          amount: '0',
                          module: 'g'
                      ),
                    ],
                  ),
                  SizedBox(height: Get.width * 0.1,),
                  ElevatedButton.icon(
                      onPressed: () {
                       print(L_calories);
                       print(selected_Lquantity);
                        print("############") ;
                   liquid_result= cal_liq(L_calories , selected_Lquantity)   ;
                        print(liquid_result.toInt());
                        Get.snackbar(
                            'do you want save it?',
                            'it will be show in the logbook',
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 0,
                            duration: Duration(milliseconds: 4500),
                            margin: EdgeInsets.zero,
                            mainButton: TextButton(onPressed: (){}, child: Text('Save',style: TextStyle(
                                color: Colors.blue
                            ),))
                        );

                      },
                      icon: Icon(Icons.add, size: 30),
                      label: Text("Calculate"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFE5A9379),)
                  )
                ]                                  ),

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
                      suffixIcon:  IconButton(
                        onPressed: (){
                        } ,
                        icon: Icon(Icons.camera_enhance),
                      ),
                    ),
                  ) ,
                  SizedBox(height: Get.width * 0.1,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                      items: items.map((e) => DropdownMenuItem(
                        child: Text('$e'),
                        value: e,
                      )).toList(),
                      hint: Text('How Often'),
                      onChanged: (val){}),
                  SizedBox(height: Get.width * 0.1,),

                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                    items: ["Pill", "Injection", "Topical","Liquid"].map((e) =>
                        DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        )).toList(),
                    onChanged: (val){},
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
                          max: 4,
                          onChanged: (val){

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
                      primary: Color(0xFFE5A9379), ) ,
                    onPressed: () {
                      //ToDo
                    Get.to(()=>AddnewReminder(
                      //send parametr
                    ));
                    },

                    icon: Icon(Icons.add, size: 30),
                    label: Text("Add reminder"),

                  )
                ]                                  ),

            ListView(
                children: <Widget>[
                  FormHelper.dropDownWidgetWithLabel(
                    context,
                    "Types:",
                    "Select Type: ",
                    this.exID,
                    this.ex,
                        (onChangedVal){
                      this.exID = onChangedVal;
                      print("Selected Types : $onChangedVal");
                      this.time= this.ex_cal.where(
                              (stateItem) => stateItem["parentID"].toString()==onChangedVal.toString()).toList();
                      this.timeID=null;
                    },
                        (onValidateval){
                      if (onValidateval==null){
                        return 'please slecet type';
                      }
                      return null;
                    },
                    // borderColor: Theme.of(context).primaryColor,
                    borderColor: Colors.black ,
                    // borderFocusColor: Theme.of(context).primaryColor,
                    borderFocusColor: Colors.black54 ,
                    borderRadius: 10,
                    optionLabel: "label",
                    optionValue: "id",


                  ),

                  FormHelper.dropDownWidgetWithLabel(
                    context,
                    "Time:",
                    "Select type",
                    this.timeID,
                    this.time,
                        (onChangedVal){
                      this.timeID=onChangedVal;
                      print("Selected type: ");
                    },
                        (onValidate){
                      return null;
                    }
                    ,
                    // borderColor: Theme.of(context).primaryColor,
                    borderColor: Colors.black ,
                    // borderFocusColor: Theme.of(context).primaryColor,
                    borderFocusColor: Colors.black54 ,
                    borderRadius: 10,
                    optionValue: "ID",
                    optionLabel: "Name",

                  ),

                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal:                       Get.width * 0.08,
                        vertical: Get.width * 0.04
                    ),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.23),
                              offset: Offset(0,8),
                              blurRadius: 8
                          )
                        ]
                    ),
                    width: Get.width * 0.5,
                    height:Get.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Calories burnt ' ,style: TextStyle(
                            fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
                        ),),


                        Expanded(
                          child: CircularPercentIndicator(
                            radius: Get.width * 0.135,
                            lineWidth: 10.0,
                            //ToDo FireBase
                            percent: 0.65,
                            animation: true,
                            animationDuration: 4000,
                            center: new Text('50.0%' , style: TextStyle(
                                fontSize: 20
                            ),),
                            progressColor: Color(0xFFEA9363),

                          ), ),
                      ],
                    ),

                  ) ,

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.23),
                              offset: Offset(0,8),
                              blurRadius: 8
                          )
                        ]
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.08,
                        vertical: Get.width * 0.02
                    ),
                    padding: EdgeInsets.all(10.0),
                    height:Get.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Container(
                            child: Text('Exercise Time ' ,style: TextStyle(
                                fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
                            ), textAlign: TextAlign.center,),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 15),

                            child:  LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 150,
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

                  ) ,

                  SizedBox(height: Get.width * 0.05,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: ElevatedButton.icon(
                          onPressed: () {
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

  Widget _buildContainerSolids({label,amount,module}){
    return                       Container(
      width: Get.width *0.25,
      height:Get.width * 0.25,                        child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("$label", textAlign: TextAlign.center,
              style: new TextStyle(
                  fontSize: 15)),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '$amount ' , style: TextStyle(
                      fontSize: 20 , fontWeight: FontWeight.bold
                  )),
                  TextSpan(text: '$module' , style: TextStyle(
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
}
