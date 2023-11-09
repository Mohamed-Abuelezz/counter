import 'dart:io';

import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Providers/auth/reportProvider.dart';
import 'package:counter/Screens/Global/myButton.dart';
import 'package:counter/Screens/Global/myHeader.dart';
import 'package:counter/Screens/Global/myLoading.dart';
import 'package:counter/Screens/home/components/bottomSheetWidget.dart';
import 'package:counter/Screens/resultImage/resultImageScreen.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePreviewScreen extends StatefulWidget {
  File file;
  String inOrout;
  ImagePreviewScreen({super.key, required this.file, required this.inOrout});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  void initState() {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyHeader(
              rightWidget: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Retry',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              child: Image.file(widget.file),
            )),
            SizedBox(
              height: 20,
            ),
            Consumer<ReportProvider>(builder: (context, reportProvider, child) {
              return reportProvider.isLoadingSendImage
                  ? showMyLoading(context)
                  : MyButton(
                      title: 'Count',
                      function: () {
                        Future.delayed(Duration.zero, () async {
                          reportProvider.sendImage(body: {
                            'image':
                                await MultipartFile.fromFile(widget.file.path),
                            'depth_image': 'null',
                          }, context: context).then((value) {
                            if (value['status'] == 200) {
                              myNavigation(
                                  context: context,
                                  screen: ResultImageScreen(
                                    file: File(widget.file.path),
                                    inOrout: widget.inOrout,
                                  ));
                            }
                          });
                        });
                      },
                      color: Theme.of(context).primaryColor);
            }),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
