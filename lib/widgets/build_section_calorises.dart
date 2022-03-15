import 'package:flutter/material.dart';

class BuildCaloriseAndClucoseWidget extends StatelessWidget {
  final String? label;
  final String? amount;
  final Color? color;

  const BuildCaloriseAndClucoseWidget({Key? key,
    this.label = 'Label',
    this.amount = '20',
    this.color = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.16),
                  offset: Offset(0, 4),
                  blurRadius: 10.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '$label',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '$amount',
              style: TextStyle(
                  fontSize: 14, color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
