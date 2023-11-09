import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Models/Report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportHistoryItemList extends StatefulWidget {
  Report? report;

  ReportHistoryItemList({super.key, this.report});

  @override
  State<ReportHistoryItemList> createState() => _ReportHistoryItemListState();
}

class _ReportHistoryItemListState extends State<ReportHistoryItemList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "${DateTime.parse(widget.report!.createdAt!).year.toString()}-${DateTime.parse(widget.report!.createdAt!).month.toString().padLeft(2, '0')}-${DateTime.parse(widget.report!.createdAt!).day.toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: FontSizesContants.Smallest),
                ),
                Text(
                  '${DateFormat.jm().format(DateTime.parse(widget.report!.createdAt!))}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizesContants.Title_1),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
