// ignore_for_file: file_names, camel_case_types

import 'package:counter/Constants/fontSizesContants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String title;
  final Function function;
  final Color color;
  final EdgeInsetsGeometry padding;

  const MyButton(
      {required this.title,
      required this.function,
      required this.color,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      super.key});

  @override
  State<MyButton> createState() => MyButton_State();
}

class MyButton_State extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          elevation: 1,
          padding: widget.padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          widget.title,
          style:
              TextStyle(color: Colors.white, fontSize: FontSizesContants.Body),
        ),
        onPressed: () {
          widget.function();
        },
      ),
    );
  }
}
