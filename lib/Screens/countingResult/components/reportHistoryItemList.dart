import 'package:counter/Constants/fontSizesContants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportHistoryItemList extends StatefulWidget {
  const ReportHistoryItemList({super.key});

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
                  'July 10, 2023',
                  style: TextStyle(fontSize: FontSizesContants.Smallest),
                ),
                Text(
                  'July 10, 2023',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
