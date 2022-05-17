import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavBaRController extends GetxController {
  var user = FirebaseAuth.instance.currentUser;
  CollectionReference? profileRef;
  String name = '';

  getData() async {
    profileRef = FirebaseFirestore.instance.collection("Acounts");
    await profileRef!
        .where("Email", isEqualTo: user!.email.toString())
        .get()
        .then((snapShot) {
      for (var element in snapShot.docs) {
        name = element['Name'];
      }
    });
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
