import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_saja/screens/bottom_bar_screens/home.dart';

class HomeController extends GetxController {
  late TooltipBehavior tooltipBehavior;
  List GlucoseVal = [].obs;
  List CalPer = [].obs;
  List CalVal = [].obs;

  List<GlucoseData> ChartList = [];

  CollectionReference? Glucose;
  late Stream data;
  CollectionReference? Chartref;
  CollectionReference? IndecatorRef;
  var user = FirebaseAuth.instance.currentUser;
  String date = DateFormat.yMd().format(DateTime.now());

  Future<void> getGluData() async {
    Glucose = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await Glucose!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        print(element["Result"]);
        GlucoseVal.add(element['Result']);
        // GlucoseVal.add(element['Result']);
      });
      print("hoooooome");
    });
    print(GlucoseVal);
  }

  Future<void> getIndecator() async {
    IndecatorRef = FirebaseFirestore.instance.collection("ex");
    await IndecatorRef!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        /* Ex_Cal= (element['ex_cal']);
    Ex_Per= (element['ex_per']);*/
        CalPer.add(element['ex_per']);
        CalVal.add(element['ex_cal']);
      });
      print("hoooooome");
    });
    print(CalVal);
  }

  getChartData() async {
    Chartref = await FirebaseFirestore.instance.collection("Gluco_Measurment");
    Chartref!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        print('Dispaying Charts');
        print('${element['Date']}');
        print('${element['Result']}');
        ChartList.add(GlucoseData(element['Date'], element['Result']));
        print(' End Charts');
        // ChartList.add(GlucoseData(element['Date'] , element['Result'])) ;
      });
    });
    print("dlokkkkkkkk");
    print(ChartList);
  }

  @override
  void onInit() {
    getGluData();
    getIndecator();
    getChartData();
    tooltipBehavior = TooltipBehavior(enable: true);
    super.onInit();
  }
}
