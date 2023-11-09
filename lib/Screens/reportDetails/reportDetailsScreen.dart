import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Models/Report.dart';
import 'package:counter/Providers/auth/reportHistoryProvider.dart';
import 'package:counter/Screens/Global/myHeader.dart';
import 'package:counter/Screens/Global/myListEmptyDesc.dart';
import 'package:counter/Screens/Global/myLoadingList.dart';
import 'package:counter/Screens/reportDetails/components/reportDetailsItem.dart';
import 'package:counter/Screens/reportsHistory/components/reportHistoryItemList.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportDetailsScreen extends StatefulWidget {
  Report report;

  ReportDetailsScreen({super.key, required this.report});

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context
          .read<ReportHistoryProvider>()
          .getReports(body: null, context: context)
          .then((value) {
        if (value['status'] == 200) {}
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  MyHeader(
                      centerWidget: Text(
                    'Report',
                    style: TextStyle(
                        fontSize: FontSizesContants.Title_2,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    DateFormat.yMMMMd()
                        .format(DateTime.tryParse(widget.report.createdAt!)!),
                    style: TextStyle(fontSize: FontSizesContants.Title_1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat.jm()
                        .format(DateTime.tryParse(widget.report.createdAt!)!),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizesContants.Title_2),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ReportDetailsItem(
                            title: 'From',
                            desc: '${widget.report.company} ',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ReportDetailsItem(
                            title: 'Skewers Number:',
                            desc: '${widget.report.skewersNumber}',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ReportDetailsItem(
                            title: 'Skewer Diameter:',
                            desc: '${widget.report.skewersDiameter} cm',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ReportDetailsItem(
                            title: 'Skewer Length:',
                            desc: '${widget.report.skewersLength}  cm',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ReportDetailsItem(
                            title: 'Payload Weight:',
                            desc: '${widget.report.payloadWeight} tons',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ReportDetailsItem(
                            title: 'Company:',
                            desc: '${widget.report.company} ',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ReportDetailsItem(
                            title: 'Uploaded To:',
                            desc: MySharedPreference()
                                .getSharedPref()!
                                .getString('user_name')!,
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
