import 'package:intl/intl.dart';

class GlocuMeasurement {
  final String? date;
  final String? email;
  final String? result;
  final String? testPeriod;
  final String? time;

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
  factory GlocuMeasurement.fromDoc(Map<String, dynamic> dataDoc) {
    return GlocuMeasurement(
        date: DateFormat.yMd().format(DateTime.parse(
          dataDoc['Date'],
        )),
        email: dataDoc['Email'],
        result: dataDoc['Result'],
        testPeriod: dataDoc['Test_preiod'],
        time: dataDoc['Time']);
  }
}
