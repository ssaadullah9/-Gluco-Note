import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '/const/colors.dart';
import '/controller/main_controller.dart';
import '../widgets/navbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/screens/in_taks_screen.dart';

class MainScreen extends StatelessWidget {
  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return  Obx(
        ()=>Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: NavBar(),
          appBar: controller.pages!
          [controller.currentIndex.value]['appBar']
          ?AppBar(
            title: Text(
              'Hi  ,',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ):null,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.add,color: Colors.white,),
            onPressed: () {
              Get.to(() => InTaksScreen());
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          body: Obx(() => controller.pages![
          controller.currentIndex.value]
          ['page']),

          bottomNavigationBar: Obx(
                  ()=>Container(
                height: Get.width * 0.18,
                child: BottomAppBar(
                  color: Colors.white,
                  shape: CircularNotchedRectangle(), //shape of notch
                  notchMargin: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      //children inside bottom appbar
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildIconBottomBar(
                            icon:Icons.home,
                            index: 0,
                            label: 'Home'
                        ),
                        _buildIconBottomBar(
                            icon:Icons.add_chart_rounded,
                            index: 1,
                            label: 'LogBook'
                        ),
                        _buildIconBottomBar(
                            icon:Icons.calculate_outlined,
                            index: 2,
                            label: 'Tests'
                        ),
                        _buildIconBottomBar(
                            icon:Icons.calculate_outlined,
                            index: 3,
                            label: 'Reminder'
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
        )
    );
  }
  Widget _buildIconBottomBar({icon,index,label = 'lable'}){
    return Column(
      children: [
        Expanded(
          child: IconButton(
            icon:
            Icon(icon,
              color: controller.currentIndex.value == index
                  ?Colors.green
                  :Colors.black,),
            onPressed: () {
              controller.onTabIconBottomBar(index);
            },
          ),
        ),
        Text(label,style: TextStyle(
          color: controller.currentIndex.value == index
              ?Colors.green
              :Colors.black,
        ),)
      ],
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
