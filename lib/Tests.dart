import 'package:flutter/material.dart';
import '/Custom_Dialog.dart';
import '/bmi.dart';
import 'package:flutter/cupertino.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';

// void main() => runApp(MyApp());

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPage(),
    );
  }
}
*/

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  //const ({Key? key}) : super(key: key);

  TimeOfDay _time = TimeOfDay.now().replacing(hour: 11, minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  var selectedval1;
  int valueHolder = 20;

  double _heightOfUser = 5;
  double _weightOfUser = 5;
  double _bmi = 0;
  double bmi = 0;

  String comments = "";
  late BMIModel _bmiModel;

  //
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(

            elevation: 0.0,
            backgroundColor: Colors.blueGrey,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(' BMI '),
                ),
                //
                Tab(
                  child: Text('glucose measurement'),
                ),
              ],
            ),
            //title: Text('TabView'),
          ),
          body: TabBarView(
            // first tab content
              children: [
                // first Container

///// start
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 55, 20, 15),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Height (cm)",
                                ),
                                onChanged: (value2) {
                                  setState(() {
                                    _heightOfUser = double.parse(value2);
                                  });
                                },
                              ),
                            )),
                        Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Weight (kg)",
                                ),
                                onChanged: (value1) {
                                  setState(() {
                                    _weightOfUser = double.parse(value1);
                                  });
                                },
                              ),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 4,
                          padding: EdgeInsets.fromLTRB(50, 20, 50, 50),
                          child: SizedBox(
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _bmi = _weightOfUser /
                                        ((_heightOfUser / 100) *
                                            (_heightOfUser / 100));

                                    if (bmi >= 18.5 && bmi <= 25) {
                                      _bmiModel = BMIModel(
                                          bmi: _bmi,
                                          isNormal: true,
                                          comments: "You are Totaly Fit");
                                    } else if (_bmi < 18.5) {
                                      _bmiModel = BMIModel(
                                          bmi: _bmi.roundToDouble(),
                                          isNormal: false,
                                          comments:
                                          "You are Underweighted");
                                    } else {
                                      _bmiModel = BMIModel(
                                          bmi: _bmi,
                                          isNormal: false,
                                          comments: "You are Overweighted");
                                    }
                                  }); // end OnState

                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialogBox(
                                      title: " RESULT",
                                      descriptions:
                                      "Your BMI is ${_bmi.round()} \n ${comments}",
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
                                }, // End OnPressesd

                                label: const Text('CALCULATE'),
                                icon: const Icon(Icons.done),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFE5A9379),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10))) // End styleForm
                            ),
                          ),
                        ),
                        /* DataTable(
                                  columns: [
                                    DataColumn(
                                        label: Text('ID')
                                    )
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(
                                          Text(
                                              'rr'
                                          )
                                      )
                                    ])
                                  ])*/

                        DataTable(
                            columnSpacing: 30.0,
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
                  ),
                ),

                //// end

                // second page
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),

                        Center(
                          child: Text('Enter your glucose result',
                            textAlign: TextAlign.center , style: TextStyle(
                                fontSize: 20
                            ),),
                        ),

                        Center(
                            child: Card(
                                margin: EdgeInsets.fromLTRB(15, 35, 15, 35),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(children: [
                                    Container(
                                        child: Slider(
                                            value: valueHolder.toDouble(),
                                            min: 1,
                                            max: 700,
                                            divisions: 100,
                                            activeColor: Colors.blue,
                                            inactiveColor: Colors.grey,
                                            label: '${valueHolder.round()}',
                                            onChanged: (double newValue) {
                                              setState(() {
                                                valueHolder =
                                                    newValue.round();
                                              });
                                            },
                                            semanticFormatterCallback:
                                                (double newValue) {
                                              return '${newValue.round()}';
                                            })),
                                    Text(
                                      '$valueHolder mg/dl',
                                      style: TextStyle(fontSize: 22),
                                    )
                                  ] // end childern
                                  ),
                                ))),

                        Center(
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  padding:
                                  EdgeInsets.only(left: 15, right: 15),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton<String>(
                                    items: [
                                      "before breakfast",
                                      "after breakfast",
                                      "before lunch",
                                      "after lunch",
                                      "before dinner",
                                      "after dinner",
                                      "before sleep"
                                    ]
                                        .map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedval1 = val;
                                      });
                                    },
                                    value: selectedval1,
                                    hint: Text("test time"),
                                    isExpanded: true,
                                    iconSize: 36,
                                    icon: new Icon(
                                      Icons.announcement_outlined ,size: 20,) ,
                                  ),
                                ))),
////

                        Center(
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                // padding: EdgeInsets.only(left: 15, right: 15),
                                  height: 60,
                                  width: 500,
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
                                        _time.format(context),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.normal),
                                      ),
                                      SizedBox(height: 10),
                                      IconButton(
                                        icon: Icon(
                                          Icons.access_time,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            showPicker(
                                              context: context,
                                              value: _time,
                                              onChange: onTimeChanged,
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
                                      ),
                                    ],
                                  ))),
                        ),
                        Container(
                            padding: EdgeInsets.all(60),
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
/*
                            DataTable(

                                columns: const [

                                  DataColumn(
                                      label: Text('Statutes')),
                                  DataColumn(
                                      label: Text('Result')),
                                  DataColumn(
                                      label: Text('Date '))
                                ],
                                rows: const [
                                  DataRow(cells: [
                                    DataCell( Text('rr')),
                                    DataCell(Text('bb')),
                                    DataCell(Text('nn')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell( Text('aa')),
                                    DataCell(Text('vv')),
                                    DataCell(Text('pp')),
                                  ]),
                                ])
*/

                      ],
                    ),
                  ),
                ),
              ]),
        ));
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
