import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_saja/models/calBurn-model.dart';
import 'package:test_saja/screens/bottom_bar_screens/home.dart';

import '../models/glocu_measurement.dart';

class HomeController extends GetxController {
  late TooltipBehavior tooltipBehavior;
  List GlucoseVal = [].obs;
  List CalPer = [].obs;
  List CalVal = [].obs;
  List<GlocuMeasurement> gHigh = [];
  List<GlucoseData> ChartList = [];
  List<GlocuMeasurement> glocuMeasurements = [];
  List<CalBurned> calIndicator = [];
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

  Stream<List<GlucoseData>>? getChartData() {
    Chartref = FirebaseFirestore.instance.collection("Gluco_Measurment");
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

  Stream<List<CalBurned>>? get getIndicator => FirebaseFirestore.instance
          .collection("ex")
          .where("Email",
              isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
          .snapshots()
          .map((QuerySnapshot? snapShot) {
        // print(FirebaseAuth.instance.currentUser!.email);
        // print("snapShot!.docs.length: ${snapShot!.docs.length}");
        calIndicator.clear();

        if (snapShot != null && snapShot.docs.isNotEmpty) {
          // print("snapShot.docs.length:${snapShot.docs.length}");
          for (var doc in snapShot.docs) {
            // print('doc: ${doc.id}');

            var data = doc.data() as Map<String, dynamic>;
            // print("data['Email']:${data['Email']}");
            calIndicator.add(CalBurned.fromDoc(data));
          }
          // print("glocuMeasurements[0].email:${glocuMeasurements[0].email}");
          return calIndicator;
        }
        return [];

        // for (var i = 0; i < snapShot.docs.length; i++) {
        //   gluRow.add([]);
        //   for (var j = 0; j < 3; j++) {
        //     gluRow[i].add(snapShot.docs[i]['Result'].toString());
        //     gluRow[i].add(snapShot.docs[i]['Test_preiod'].toString());
        //     gluRow[i].add(snapShot.docs[i]['Time'].toString());
        //     gluRow[i].add(DateFormat.yMd()
        //         .format(DateTime.parse(snapShot.docs[i]['Date']))
        //         .toString());
        //     break;
        //   }
        // }
      });

  Stream<List<GlocuMeasurement>>? get getHighGlu => FirebaseFirestore.instance
          .collection("Gluco_Measurment")
          .where("Email",
              isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
          .snapshots()
          .map((QuerySnapshot? snapShot) {
        // print(FirebaseAuth.instance.currentUser!.email);
        // print("snapShot!.docs.length: ${snapShot!.docs.length}");
        gHigh.clear();

        if (snapShot != null && snapShot.docs.isNotEmpty) {
          // print("snapShot.docs.length:${snapShot.docs.length}");
          for (var doc in snapShot.docs) {
            // print('doc: ${doc.id}');

            var data = doc.data() as Map<String, dynamic>;
            gHigh.add(GlocuMeasurement.fromDoc(data));
          }
          gHigh.sort((x, y) => x.result!.compareTo(y.result!));

          return gHigh;
        }
        return [];

        // for (var i = 0; i < snapShot.docs.length; i++) {
        //   gluRow.add([]);
        //   for (var j = 0; j < 3; j++) {
        //     gluRow[i].add(snapShot.docs[i]['Result'].toString());
        //     gluRow[i].add(snapShot.docs[i]['Test_preiod'].toString());
        //     gluRow[i].add(snapShot.docs[i]['Time'].toString());
        //     gluRow[i].add(DateFormat.yMd()
        //         .format(DateTime.parse(snapShot.docs[i]['Date']))
        //         .toString());
        //     break;
        //   }
        // }
      });

  @override
  void onInit() {
    getGluData();
    getIndecator();
    getChartData();
    tooltipBehavior = TooltipBehavior(enable: true);
    super.onInit();
  }
}
