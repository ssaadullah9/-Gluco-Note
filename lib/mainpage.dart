import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '/const/colors.dart';
import '/controller/main_controller.dart';
import 'widgets/navbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/screens/in_tasks_screen.dart';

class main_page extends StatelessWidget {
  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          'Hi  ,',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => InTasksScreen());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(() => controller.pages![controller.currentIndex.value]['page']),
      bottomNavigationBar: Obx(
          ()=>BottomAppBar(
            color: mainColor,
            shape: CircularNotchedRectangle(), //shape of notch
            notchMargin: 5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                //children inside bottom appbar
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home,color: controller.currentIndex.value == 0?Colors.white:Colors.black,),
                    onPressed: () {
                      controller.onTabIconBottomBar(0);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_chart_rounded,color: controller.currentIndex.value == 1?Colors.white:Colors.black,),
                    onPressed: () {
                      controller.onTabIconBottomBar(1);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_a_photo,color: controller.currentIndex.value == 2?Colors.white:Colors.black,),
                    onPressed: () {
                      controller.onTabIconBottomBar(2);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.calculate_outlined,color: controller.currentIndex.value == 3?Colors.white:Colors.black,),
                    onPressed: () {
                      controller.onTabIconBottomBar(3);
                    },
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}

/*
BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.black87,
        onTap: (index){
          controller.currentIndex.value = index;
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_chart_rounded),label: 'LogBook'),
          BottomNavigationBarItem(icon: Icon(Icons.add_a_photo),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calculate_outlined),label: 'Tests'),
        ],
      )
 */
class GlucoseDate {
  final String GDay;

  final double Glevel;

  GlucoseDate(this.GDay, this.Glevel);
}

dynamic getCulomnData() {
  List<GlucoseDate> columnData = <GlucoseDate>[
    GlucoseDate('Sun', 10.9),
    GlucoseDate('Mon', 9.1),
    GlucoseDate('Tue', 7.7),
    GlucoseDate('Wed', 7.0),
    GlucoseDate('Thu', 7.2),
    GlucoseDate('Fri', 8.0),
    GlucoseDate('Sat', 5),
  ];
  return columnData;
}

/*
BottomAppBar(
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
                    onPressed: (){ Navigator.pushNamed(context, '
                    /logbook');},

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
      )
 */
