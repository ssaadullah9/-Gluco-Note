import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:test_saja/translations/locale_keys.g.dart';
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
          drawer: FutureBuilder(
            future: controller.ProfileRef!.get(),
            builder: (context, snapshot) {
              return NavBar();
            }
          ),
          appBar: controller.pages!
          [controller.currentIndex.value]['appBar']
              ?AppBar(
            backgroundColor: Colors.blueGrey,
            title:FutureBuilder(
              future: controller.ProfileRef!.get(),
              builder: (ctx,snapShot){
                if(snapShot.hasData){
                  return Text(
                    '${LocaleKeys.hi.tr}  ${controller.Name.toString() == null ? "" : controller.Name} ,',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  );
                }else{
                  return Text("......")
;                }
              },
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
                            label: LocaleKeys.home.tr
                        ),
                        _buildIconBottomBar(
                            icon:Icons.add_chart_rounded,
                            index: 1,
                            label: LocaleKeys.logbook.tr
                        ),
                        _buildIconBottomBar(
                            icon:Icons.calculate_outlined,
                            index: 2,
                            label: LocaleKeys.tests.tr
                        ),
                        _buildIconBottomBar(
                            icon:Icons.notification_important,
                            index: 3,
                            label: LocaleKeys.reminders.tr
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
                  ?Color(0xff0E5E5A)
                  :Colors.black,),
            onPressed: () {
              controller.onTabIconBottomBar(index);
            },
          ),
        ),
        Text(label,style: TextStyle(
          color: controller.currentIndex.value == index
              ?Color(0xff0E5E5A)
              :Colors.black,
        ),)
      ],
    );
  }

}

