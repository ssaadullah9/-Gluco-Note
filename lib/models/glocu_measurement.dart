import 'package:cloud_firestore/cloud_firestore.dart';

class GlocuMeasurement {
  final String date;
  final String email;
  final String result;
  final String testPeriod;
  final String time;

  const GlocuMeasurement({
    required this.date,
    required this.email,
    required this.result,
    required this.testPeriod,
    required this.time,
  });
  factory GlocuMeasurement.empty() {
    return const GlocuMeasurement(
        date: '', email: '', result: '', testPeriod: '', time: '');
  }
  factory GlocuMeasurement.fromDoc(DocumentSnapshot dataDoc) {
    var data = dataDoc.data() as Map<String, dynamic>;
    return GlocuMeasurement(
        date: data['Date'],
        email: data['Email'],
        result: data['Result'],
        testPeriod: data['Test_period'],
        time: data['Time']);
  }
}
