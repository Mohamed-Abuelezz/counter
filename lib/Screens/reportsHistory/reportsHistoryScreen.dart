import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Providers/auth/reportHistoryProvider.dart';
import 'package:counter/Screens/Global/myHeader.dart';
import 'package:counter/Screens/Global/myListEmptyDesc.dart';
import 'package:counter/Screens/Global/myLoadingList.dart';
import 'package:counter/Screens/reportDetails/reportDetailsScreen.dart';
import 'package:counter/Screens/reportsHistory/components/reportHistoryItemList.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportsHistoryScreen extends StatefulWidget {
  const ReportsHistoryScreen({super.key});

  @override
  State<ReportsHistoryScreen> createState() => _ReportsHistoryScreenState();
}

class _ReportsHistoryScreenState extends State<ReportsHistoryScreen> {
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
                    'Reports History',
                    style: TextStyle(
                        fontSize: FontSizesContants.Title_2,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Consumer<ReportHistoryProvider>(
                      builder: (context, loginProvider, child) {
                    return Expanded(
                      child: loginProvider.isLoadingGetReports == true
                          ? MyLoadingList(
                              axis: Axis.vertical,
                              isGrid: false,
                            )
                          : loginProvider.reports.isEmpty
                              ? MyListEmptyDesc(
                                  msg: 'لاتوجد بيانات',
                                )
                              : ListView.builder(
                                  itemCount: loginProvider.reports.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        myNavigation(
                                            context: context,
                                            screen: ReportDetailsScreen(
                                              report:
                                                  loginProvider.reports[index],
                                            ));
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: ReportHistoryItemList(
                                              report: loginProvider
                                                  .reports[index])),
                                    );
                                  }),
                    );
                  }),
                ],
              ))),
    );
  }
}
