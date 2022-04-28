import 'package:flutter/material.dart';

import '../const/colors.dart';

class TextFormFiledWidget extends StatelessWidget {
  final Size? size;
  final String? hintText;
  final IconData? icon;
  var  top;
  var onChanged;
  var validation;


   TextFormFiledWidget({Key? key,
     this.size,
     this.hintText,
     this.icon,
     this.onChanged,
     this.validation,
     this.top = 70.0,
   }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: top),
      child: TextFormField(

        onChanged: onChanged,
        validator: validation,
        cursorColor: mainColor,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon,color: mainColor,),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                  color: Colors.transparent
              )
          ),
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                  color: Colors.transparent
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                  color: Colors.transparent
              )
          ),
        ),
      ),
    );
  }
}

