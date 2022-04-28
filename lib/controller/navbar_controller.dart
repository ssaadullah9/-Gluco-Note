

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavBaRController extends  GetxController{
  var user = FirebaseAuth.instance.currentUser ;
  CollectionReference? ProfileRef ;
  var Name ;


  Future<void>  getData() async {

    ProfileRef = FirebaseFirestore.instance.collection("Acounts") ;
    await ProfileRef!.where("Email" , isEqualTo: user!.email.toString()).get().then((snapShot) {
      print(snapShot.docs.length);
      snapShot.docs.forEach((element) {
        Name = element['Name'];

      });
    });
    print(Name) ;

  }
  @override
  void onInit() {
    getData() ;
    super.onInit();
  }

}