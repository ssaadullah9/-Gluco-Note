import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class InTasksScreen extends StatelessWidget {
  var timep = DateTime.now();
  late TimeOfDay picked;
  var selectedf , s2 , selectedff;
  static const IconData food_bank_sharp = IconData(0xe9a5, fontFamily: 'MaterialIcons');
  static const IconData medication_liquid = IconData(0xf053a, fontFamily: 'MaterialIcons');
  static const IconData fitness_center_outlined = IconData(0xf07a, fontFamily: 'MaterialIcons');
  static const IconData camera_alt_rounded = IconData(0xf60b, fontFamily: 'MaterialIcons');
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
    // for select the types id
    timep = DateTime.now();
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
  Future<Null> selectTime (BuildContext context)async{
    picked= (await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 10, minute: 20)
    ))! ;
    if (picked != null){
      timep = picked as DateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tasks'),
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
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
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          child: Column(

                            //   mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.center,
                                    child:Text("Quantity",
                                        style: new TextStyle(
                                            fontSize: 16))),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),

                                  child: Container(
                                    margin: new EdgeInsets.symmetric(horizontal:40),
                                    child: NumberInputWithIncrementDecrement(
                                      controller: TextEditingController(),
                                      min: 0,
                                      max: 10,
                                    ),
                                  ),
                                )
                              ]
                          )
                      ),
                      Container(

                        margin: EdgeInsets.symmetric(horizontal: 30, vertical:30),
                        child: Row(

                          children: <Widget>[
                            Container(
                              width: 100,
                              height:90,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Calories", textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontSize: 15)),
                                    Center(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: '30 ' , style: TextStyle(
                                                fontSize: 20 , fontWeight: FontWeight.bold
                                            )),
                                            TextSpan(text: 'cal' , style: TextStyle(
                                                color: Colors.grey
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height:90,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Fat", textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontSize: 15)),
                                    Center(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: '20 ' , style: TextStyle(
                                                fontSize: 20 , fontWeight: FontWeight.bold
                                            )),
                                            TextSpan(text: 'g' , style: TextStyle(
                                                color: Colors.grey
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height:90,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Protein", textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontSize: 15)),
                                    /*Text("30", textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontSize: 25 , fontWeight: FontWeight.bold)),*/
                                    Center(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: '30 ' , style: TextStyle(
                                                fontSize: 20 , fontWeight: FontWeight.bold
                                            )),
                                            TextSpan(text: 'g' , style: TextStyle(
                                                color: Colors.grey
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                      Container(
                        // child:Center(
                          padding: EdgeInsets.only(top:30, bottom: 50),
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
                    ]),
              ),
            ),


            Container(
                margin:EdgeInsets.only(top:37) ,

                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(

                      children: <Widget>[

                        DropdownButton(

                          alignment: Alignment.bottomCenter,
                          dropdownColor: Colors.white38,
                          isExpanded: true,
                          hint:Container(width:double.infinity, child:Text("Liquid Type", style: TextStyle(fontSize: 20), textAlign:TextAlign.center,)),
                          items: ["Coffee ","Tea ","Juice", "Soup","Milk"].map((e) => DropdownMenuItem(
                            child: Container(width:double.infinity,child: Text("$e", style: TextStyle(fontSize: 20), textAlign:TextAlign.center,)) , value: e,)).toList(),
                          onChanged: (val){
                            selectedf= val ;
                          },
                          value: selectedf ,),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                            child: Column(

                              //   mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.center,
                                      child:Text("Quantity",
                                          style: new TextStyle(
                                              fontSize: 18))),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),

                                    child: Container(
                                      margin: new EdgeInsets.symmetric(horizontal:40),
                                      child: NumberInputWithIncrementDecrement(
                                        controller: TextEditingController(),
                                        min: 0,
                                        max: 10,
                                      ),
                                    ),
                                  )
                                ]
                            )






                        ),
                        Container(

                          margin: EdgeInsets.symmetric(horizontal: 30, vertical:30),
                          child: Row(

                            children: <Widget>[
                              Container(
                                width: 100,
                                height:90,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Calories", textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 15)),
                                      Center(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '30 ' , style: TextStyle(
                                                  fontSize: 20 , fontWeight: FontWeight.bold
                                              )),
                                              TextSpan(text: 'cal' , style: TextStyle(
                                                  color: Colors.grey
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                height:90,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Fat", textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 15)),
                                      Center(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '20 ' , style: TextStyle(
                                                  fontSize: 20 , fontWeight: FontWeight.bold
                                              )),
                                              TextSpan(text: 'g' , style: TextStyle(
                                                  color: Colors.grey
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                height:90,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Protein", textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 15)),
                                      /*Text("30", textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontSize: 25 , fontWeight: FontWeight.bold)),*/
                                      Center(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '30 ' , style: TextStyle(
                                                  fontSize: 20 , fontWeight: FontWeight.bold
                                              )),
                                              TextSpan(text: 'g' , style: TextStyle(
                                                  color: Colors.grey
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
                        Container(
                          // child:Center(
                            padding: EdgeInsets.only(top:50),
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
                      ]                                  ),
                )

            ),
            Container(
              //tap No3
                margin:EdgeInsets.only(top:6) ,
                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child:new   Padding(
                                    padding: EdgeInsets.all(15),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Name',

                                      ),
                                    ),

                                  ),
                                ) ,
                                IconButton(
                                  onPressed: (){

                                    AlertDialog(
                                      title: Text('Reset settings?'),
                                      content: Text('This will reset your device to its default factory settings.'),
                                      actions: [
                                        FlatButton(
                                          textColor: Color(0xFF6200EE),
                                          onPressed: () {},
                                          child: Text('CANCEL'),
                                        ),
                                        FlatButton(
                                          textColor: Color(0xFF6200EE),
                                          onPressed: () {},
                                          child: Text('ACCEPT'),
                                        ),
                                      ],
                                    ) ;
                                  } ,
                                  icon: Icon(Icons.camera_enhance),
                                )
                              ]
                          ),

                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                          child: Column(

                              children: <Widget>[
                                CustomDropdownButton2(
                                  // isExpanded:true,
                                  hint: 'How often',
                                  dropdownItems: items,
                                  value: selectedValue,
                                  // buttonHeight: 40,
                                  buttonWidth: 260,
                                  // itemPadding: 240,
                                  dropdownWidth:260,
                                  itemHeight: 40,
                                  onChanged: (value) {
                                    selectedValue = value;
                                  },
                                ),
                              ]
                          ),

                        ),
                        Container(

                          margin: EdgeInsets.symmetric(horizontal: 30, vertical:30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: <Widget>[

                              Expanded(

                                  child:Column(
                                    children: [
                                      Text("Amount",
                                          style: new TextStyle(
                                              fontSize: 15)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),

                                        child: Container(

                                          margin: new EdgeInsets.symmetric(horizontal:17),
                                          child: NumberInputWithIncrementDecrement(
                                            controller: TextEditingController(),
                                            min: 0,
                                            max: 4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )

                              ),
                              Spacer(),
                              Expanded(
                                child: DropdownButton(

                                  alignment: Alignment.bottomCenter,
                                  dropdownColor: Colors.white38,
                                  isExpanded: true,
                                  hint:Container(width:double.infinity, child:Text(" Type", style: TextStyle(fontSize: 20), textAlign:TextAlign.center,)),
                                  items: ["Pill", "Injection", "Topical","Liquid"].map((e) => DropdownMenuItem(
                                    child: Container(width:double.infinity,child: Text("$e", style: TextStyle(fontSize: 20), textAlign:TextAlign.center,)) , value: e,)).toList(),
                                  onChanged: (val){
                                    selectedff= val ;
                                  },
                                  value: selectedff ,),

                              ),],
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.only(top:30),
                          child: Center(

                              child: Column(

                                children: [

                                  IconButton(
                                    icon: Icon(Icons.alarm),
                                    iconSize: 40,
                                    onPressed: (){
                                      selectTime(context);
                                      print(timep);
                                    },
                                  ),
                                  Text('Time ${timep.hour}:${timep.minute}', style: TextStyle(fontSize: 25))
                                ],
                              )
                          ),
                        ),
                        Container(
                          // child:Center(
                            padding: EdgeInsets.only(top:30 , bottom: 50),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFE5A9379), ) ,
                              onPressed: () {
                                // Respond to button press
                              },

                              icon: Icon(Icons.add, size: 30),
                              label: Text("Add reminder"),

                            )

                          //  )

                        )
                      ]                                  ),
                )
            ),
            Container(
              //tap No4
                margin:EdgeInsets.only(top:37) ,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,

                  child: Column(

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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(90))),
                          margin: EdgeInsets.only(top: 40 , left: 50 , right: 50),
                          width: 190,
                          height:190,
                          child: Card(
                              elevation: 4,
                              color: Color(0xfffafafa),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text('Calories burnt ' ,style: TextStyle(
                                        fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold
                                    ), textAlign: TextAlign.center,),
                                  ),


                                  Container(
                                    child: Expanded(
                                      child: CircularPercentIndicator(
                                        radius: 60.0,
                                        lineWidth: 10.0,
                                        percent: 0.5,
                                        animation: true,
                                        animationDuration: 4000,
                                        center: new Text('50.0%' , style: TextStyle(
                                            fontSize: 20
                                        ),),
                                        progressColor: Color(0xFFEA9363),

                                      ), ),
                                  ),
                                ],
                              )

                          ),

                        ) ,

                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(90))),
                          margin: EdgeInsets.only(top: 40 , left: 50 , right: 50),
                          height:100,
                          child: Card(
                              elevation: 4,
                              color: Color(0xfffafafa),
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
                                        percent: 0.3,
                                        center: Text("30.0%"),
                                        barRadius: const Radius.circular(16),
                                        progressColor: Colors.red,
                                        trailing: Icon(Icons.directions_run),
                                      ),
                                    ),
                                  ),


                                ],
                              )

                          ),

                        ) ,


                        Container(
                          // child:Center(
                            padding: EdgeInsets.only(top:30, bottom: 50),
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




                )

            ),
          ],
        ),
      ),
    );
  }
}
