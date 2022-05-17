import 'package:intl/intl.dart';

class BMI {
  final String? date;
  final String? email;
  final String? result;
  final String? status;

  const BMI({
    required this.date,
    required this.email,
    required this.result,
    required this.status,
  });

  factory BMI.empty() {
    return BMI(date: '', email: '', result: '', status: '');
  }
  factory BMI.fromDoc(Map<String, dynamic> dataDoc) {
    return BMI(
        date: DateFormat.yMd().format(DateTime.parse(
          dataDoc['Date'],
        )),
        email: dataDoc['Email'],
        result: dataDoc['Result'],
        status: dataDoc['Status']);
  }
}

/*
Date
"2022-05-12 01:39:14.235176"
Email
"maramfaisal@gmail.com"
Result
"271.43"
Status
" Overweighte*/
