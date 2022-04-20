import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController{
 // var glucose = 10.obs;
 // var Calorise = 12.0.obs;

  List GlucoseVal = [
  ].obs ;
  List CalPer = [
  ].obs ;
  List CalVal = [
  ].obs ;

  CollectionReference?  Glucose ;
  CollectionReference?  IndecatorRef ;
  var user = FirebaseAuth.instance.currentUser ;
  String date = DateFormat.yMd().format(DateTime.now()) ;

  Future<void> getGluData() async {
      Glucose = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await Glucose!.where("Email" , isEqualTo: user!.email.toString()).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        print(element["Result"]);
        GlucoseVal.add(element['Result']);
       // GlucoseVal.add(element['Result']);
      });
        print("hoooooome") ;
    });
    print(GlucoseVal) ;
  }

  Future<void> getIndecator () async{
    IndecatorRef = FirebaseFirestore.instance.collection("ex");
    await IndecatorRef!.where("Email" , isEqualTo: user!.email.toString()).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
      /* Ex_Cal= (element['ex_cal']);
    Ex_Per= (element['ex_per']);*/
        CalPer.add(element['ex_per']);
        CalVal.add(element['ex_cal']);
      });
      print("hoooooome") ;
    });
    print(CalVal) ;

  }

  @override
  void onInit() {
    getGluData() ;
    getIndecator () ;
    super.onInit();
  }
}