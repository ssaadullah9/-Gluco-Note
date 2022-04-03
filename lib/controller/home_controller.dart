import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
 // var glucose = 10.obs;
 // var Calorise = 12.0.obs;

  List GlucoseVal = [
  ].obs ;

  Future<void> getGluData() async {
    CollectionReference  Glucose = FirebaseFirestore.instance.collection("Gluco_Measurment");
    await Glucose.get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        print(element["Result"]);
        GlucoseVal.add(element['Result']);
      });

    });
  }

  @override
  void onInit() {
    getGluData() ;
    //getData();
    super.onInit();
  }
}