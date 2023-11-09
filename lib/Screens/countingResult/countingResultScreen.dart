import 'dart:io';

import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Providers/auth/reportProvider.dart';
import 'package:counter/Screens/Global/myButton.dart';
import 'package:counter/Screens/Global/myHeader.dart';
import 'package:counter/Screens/Global/myLoading.dart';
import 'package:counter/Screens/Global/myTextField.dart';
import 'package:counter/Screens/navigation/navigationScreen.dart';
import 'package:counter/Screens/reportsHistory/components/reportHistoryItemList.dart';
import 'package:counter/helpers/myAlerts.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as JSON;

class CountingResultScreen extends StatefulWidget {
  Widget? image;
  File? file;
  String inOrout;
  CountingResultScreen(
      {super.key, this.image, required this.inOrout, required this.file});

  @override
  State<CountingResultScreen> createState() => _CountingResultScreenState();
}

class _CountingResultScreenState extends State<CountingResultScreen> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _skrewLengthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _fromController.text =
          MySharedPreference().getSharedPref()!.getString('user_name')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body:
            Consumer<ReportProvider>(builder: (context, reportProvider, child) {
          return SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyHeader(
                          withBack: true,
                          backFunction: () {
                            Navigator.pop(context);
                          },
                          centerWidget: Text(
                            'Counting Result',
                            style: TextStyle(
                                fontSize: FontSizesContants.Title_2,
                                fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              widget.image!,
                              SizedBox(
                                height: 20,
                              ),

                              Text(DateFormat.yMMMMd('en_US')
                                  .format(DateTime.now())),
                              Text(
                                DateFormat.jm().format(DateTime.now()),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              rowFormItem(
                                  result: '',
                                  title: 'From',
                                  textFieldController: _fromController),
                              SizedBox(
                                height: 10,
                              ),
                              rowItem(
                                  title: 'Skewers Number:',
                                  result: reportProvider.count.toString()),
                              SizedBox(
                                height: 10,
                              ),
                              rowItem(
                                  title: 'Skewer Diameter:',
                                  result: JSON.jsonDecode(JSON.jsonDecode(
                                              context
                                                  .read<ReportProvider>()
                                                  .imageResult))["size"] ==
                                          null
                                      ? '0'
                                      : JSON.jsonDecode(JSON.jsonDecode(context
                                          .read<ReportProvider>()
                                          .imageResult))["size"]),
                              SizedBox(
                                height: 10,
                              ),
                              rowFormItem(
                                  result: '',
                                  title: 'skewer length:',
                                  textFieldController: _skrewLengthController,
                                  keyboardType: TextInputType.number),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // rowItem(title: 'payload weight:', result: '180'),
                              SizedBox(
                                height: 10,
                              ),
                              rowItem(title: 'Project:', result: '180'),
                              SizedBox(
                                height: 50,
                              ),
                              Consumer<ReportProvider>(
                                  builder: (context, reportProvider, child) {
                                return reportProvider.isLoadingSendResult
                                    ? showMyLoading(context)
                                    : MyButton(
                                        title: 'Upload result to the system',
                                        function: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print(widget.file!.path);
                                            print(MySharedPreference.prefs!
                                                .getString('user_token'));
                                            // final fcmToken = await FirebaseMessaging
                                            //     .instance
                                            //     .getToken();
                                            print(JSON
                                                .jsonDecode(JSON.jsonDecode(
                                                    context
                                                        .read<ReportProvider>()
                                                        .imageResult))["size"]
                                                .runtimeType);

                                            int size = JSON.jsonDecode(JSON
                                                            .jsonDecode(context
                                                                .read<
                                                                    ReportProvider>()
                                                                .imageResult))[
                                                        "size"] ==
                                                    null
                                                ? 0
                                                : JSON.jsonDecode(
                                                    JSON.jsonDecode(context
                                                        .read<ReportProvider>()
                                                        .imageResult))["size"];

                                            if (context.mounted) {
                                              reportProvider.sendResult(
                                                  context: context,
                                                  body: {
                                                    'image': await MultipartFile
                                                        .fromFile(
                                                      widget.file!.path,
                                                    ),
                                                    'from':
                                                        _fromController.text,
                                                    'count':
                                                        reportProvider.count,
                                                    'size': size,
                                                    'skewers_length':
                                                        _skrewLengthController
                                                            .text,
                                                    'in_or_out': widget.inOrout,
                                                    // 'password': _passwordController.text,
                                                  }).then((value) {
                                                print(value);
                                                if (value['status'] == 200) {
                                                  mySuccessAlert(
                                                      context: context,
                                                      function: () {
                                                        myNavigation(
                                                            context: context,
                                                            screen:
                                                                NavigationScreen(),
                                                            withReplacement:
                                                                true);
                                                      });
                                                }
                                              });
                                            }
                                          }
                                        },
                                        color: Theme.of(context).primaryColor);
                              }),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )));
        }),
      ),
    );
  }

  Widget rowItem({required String title, required String result}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: FontSizesContants.Body),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Theme.of(context).primaryColor.withOpacity(.4),
            child: Text(
              result,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: FontSizesContants.Body),
            ),
          )
        ],
      ),
    );
  }

  Widget rowFormItem(
      {required String title,
      required String result,
      TextEditingController? textFieldController,
      TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: FontSizesContants.Body),
          ),
          Spacer(),
          Expanded(
            child: MyTextField(
                lable: 'Cm',
                controller: textFieldController,
                keyboardType: keyboardType,
                validation: (val) {
                  if (val == null) {
                    return 'field is Required';
                  }
                }),
          )
        ],
      ),
    );
  }
}
