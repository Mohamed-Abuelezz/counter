import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Models/Report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportDetailsItem extends StatefulWidget {
  String title;
  String desc;

  ReportDetailsItem({super.key, required this.title, required this.desc});

  @override
  State<ReportDetailsItem> createState() => _ReportDetailsItemState();
}

class _ReportDetailsItemState extends State<ReportDetailsItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            widget.title!,
            style: TextStyle(fontSize: FontSizesContants.Body),
          ),
          Spacer(),
          Container(
              color: Theme.of(context).primaryColor.withOpacity(.6),
              padding: EdgeInsets.all(10),
              child: Text(
                widget.desc!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizesContants.Title_1),
              ))
        ],
      ),
    );
  }
}
