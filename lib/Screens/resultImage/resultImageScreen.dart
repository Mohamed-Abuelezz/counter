import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Providers/auth/reportProvider.dart';
import 'package:counter/Screens/Global/myButton.dart';
import 'package:counter/Screens/Global/myHeader.dart';
import 'package:counter/Screens/countingResult/countingResultScreen.dart';
import 'package:counter/Screens/home/components/bottomSheetWidget.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as JSON;

import 'package:screenshot/screenshot.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ResultImageScreen extends StatefulWidget {
  File file;
  String inOrout;
  ResultImageScreen({super.key, required this.file, required this.inOrout});

  @override
  State<ResultImageScreen> createState() => _ResultImageScreenState();
}

class _ResultImageScreenState extends State<ResultImageScreen> {
  List<Map<dynamic, dynamic>> positions = [];

  int? imageWidth;
  int? imageHeigth;
  int _counter = 0;
  Uint8List? _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Future.delayed(Duration.zero, () async {
    //   File image =
    //       File(widget.file.path); // Or any other way to get a File instance.
    //   var decodedImage = await decodeImageFromList(image.readAsBytesSync());

    //   setState(() {
    //     imageWidth = decodedImage.width;
    //     imageHeigth = decodedImage.height;
    //   });
    //   print(imageWidth);
    //   print(imageHeigth);
    // });

    // context.read<ReportProvider>().imageResult;
    // (JSON.jsonDecode(JSON.jsonDecode(
    //         context.read<ReportProvider>().imageResult))["boxes"] as List)
    //     .forEach((element) {
    //   positions.add(Transform(
    //       transform: Matrix4.translationValues(element[0], element[1], 1),
    //       child: CircleAvatar(
    //         radius: 10,
    //         child: Center(
    //             child: Text(
    //           '1',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(fontSize: FontSizesContants.Smallest),
    //         )),
    //         backgroundColor: Colors.blue,
    //       )));
    // });
    (JSON.jsonDecode(JSON.jsonDecode(
            context.read<ReportProvider>().imageResult))["boxes"] as List)
        .asMap()
        .forEach((index, element) {
      //    this.index =  index + 1;
      positions.add({
        'Transform': Transform(
            transform: Matrix4.translationValues(
                ((element[2] + element[0]) / 2) - 10,
                ((element[3] + element[1]) / 2) - 10,
                0),
            child: Container(
              margin: EdgeInsets.all(0),
              child: CircleAvatar(
                radius: 10,
                child: Container(
                  child: Center(
                    //     child: Text(
                    //   '1',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       fontSize: FontSizesContants.Smallest,
                    //       color: Colors.white),
                    // )
                    child: Icon(
                      CupertinoIcons.check_mark,
                      color: Colors.white,
                      size: 8,
                    ),
                  ),
                ),
                backgroundColor: Color.fromARGB(61, 104, 127, 1),
              ),
            )),
        'x': ((element[2] + element[0]) / 2) - 10,
        'y': ((element[3] + element[1]) / 2) - 10,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ReportProvider>(builder: (context, reportProvider, child) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyHeader(
                // rightWidget: InkWell(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text(
                //     'Retry',
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                rightWidget: SizedBox(),
                centerWidget: InkWell(
                  onTap: () {
                    //  Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Result : ',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Consumer<ReportProvider>(
                          builder: (context, reportProvider, child) {
                        return Container(
                          color: Theme.of(context).primaryColor.withOpacity(.4),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            // '${JSON.jsonDecode(JSON.jsonDecode(reportProvider.imageResult))["count"]} ',
                            reportProvider.count.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 512,
                        child: Zoom(
                          initTotalZoomOut: true,
                          maxScale: 2.5,
                          enableScroll: false,
                          //  zoomSensibility: 0,
                          initScale: 1,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  ///your items
                                  GestureDetector(
                                    onTapDown: (TapDownDetails details) {
                                      // Get the x and y coordinates when the container is tapped
                                      double x = details.localPosition.dx;
                                      double y = details.localPosition.dy;

                                      // Do something with x and y coordinates
                                      print('X: $x, Y: $y');

                                      // List<Map<dynamic, dynamic>> ranges = positions
                                      //     .takeWhile((number) =>
                                      //         number['x'] + 10 < x && number['x'] + 10 > x)
                                      //     .take(20)
                                      //     .toList();
                                      bool isClickedOnPosition = false;

                                      for (Map<dynamic, dynamic> position
                                          in positions) {
                                        if ((x >= position['x'] - 4 &&
                                                x <= position['x'] + 16) &&
                                            (y >= position['y'] &&
                                                y <= position['y'] + 16)) {
                                          print(position['x']);
                                          print(position['y']);
                                          setState(() {
                                            positions.remove(position);
                                            isClickedOnPosition = true;
                                            context
                                                .read<ReportProvider>()
                                                .updateCount(context
                                                        .read<ReportProvider>()
                                                        .count -
                                                    1);

                                            positions
                                                .asMap()
                                                .forEach((index, element) {
                                              element['Transform'] = Transform(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          ((element[2] +
                                                                      element[
                                                                          0]) /
                                                                  2) -
                                                              8,
                                                          ((element[3] +
                                                                      element[
                                                                          1]) /
                                                                  2) -
                                                              8,
                                                          0),
                                                  child: Container(
                                                    margin: EdgeInsets.all(0),
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      child: Container(
                                                        child: Center(
                                                          //     child: Text(
                                                          //   '1',
                                                          //   textAlign:
                                                          //       TextAlign.center,
                                                          //   style: TextStyle(
                                                          //       fontSize:
                                                          //           FontSizesContants
                                                          //               .Smallest,
                                                          //       color:
                                                          //           Colors.white),
                                                          // )
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .check_mark,
                                                            color: Colors.white,
                                                            size: 8,
                                                          ),
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              46, 255, 1, 90),
                                                    ),
                                                  ));
                                            });

                                            //   positions = List.from(positions);

                                            //   setState(() {
                                            //     positions.replaceRange(
                                            //         0, positions.length, positions);
                                            //   });
                                          });

                                          break;
                                        }
                                      }

                                      if (isClickedOnPosition == false) {
                                        context
                                            .read<ReportProvider>()
                                            .updateCount(context
                                                    .read<ReportProvider>()
                                                    .count +
                                                1);

                                        setState(() {
                                          positions.add({
                                            'Transform': Transform(
                                                transform:
                                                    Matrix4.translationValues(
                                                        x - 10, y - 10, 0),
                                                child: Container(
                                                  margin: EdgeInsets.all(0),
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    child: Container(
                                                      child: Center(
                                                        //     child: Text(
                                                        //   '1',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style: TextStyle(
                                                        //       fontSize:
                                                        //           FontSizesContants
                                                        //               .Smallest,
                                                        //       color:
                                                        //           Colors.white),
                                                        // )
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .check_mark,
                                                          color: Colors.white,
                                                          size: 8,
                                                        ),
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            130, 126, 3, 46),
                                                  ),
                                                )),
                                            'x': (((x + 8) + x) / 2) - 10,
                                            'y': (((y + 8) + y) / 2) - 10,
                                          });
                                        });
                                      }
                                    },
                                    child: Screenshot(
                                      controller: screenshotController,
                                      child: Container(
                                        //       constraints: BoxConstraints(minWidth: 512, maxHeight: 512),

                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: FileImage(
                                                widget.file,
                                              ),
                                              fit: BoxFit.fill),
                                        ),
                                        width: 512,
                                        height: 512,
                                        // width: double.tryParse(imageWidth.toString()),
                                        // height: double.tryParse(imageHeigth.toString()),
                                        child: Stack(
                                            children: positions
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                          return entry.value['Transform']
                                              as Widget;
                                        }).toList()),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Icon(CupertinoIcons.add_circled),
                    //         Text('Add Tag')
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         Icon(CupertinoIcons.minus_circle),
                    //         Text('Remove Tag')
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        reportProvider.count < reportProvider.originalCount
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  if (context.read<ReportProvider>().count >
                                      context
                                          .read<ReportProvider>()
                                          .originalCount) {
                                    positions.removeAt(
                                        context.read<ReportProvider>().count -
                                            1);

                                    context.read<ReportProvider>().updateCount(
                                        context.read<ReportProvider>().count -
                                            1);
                                  }
                                },
                                child: Column(
                                  children: [
                                    Icon(CupertinoIcons.arrow_left,
                                        color: Colors.orange),
                                    Text('back')
                                  ],
                                ),
                              ),
                        InkWell(
                          onTap: () {
                            // if (context.read<ReportProvider>().count >
                            //     context
                            //         .read<ReportProvider>()
                            //         .originalCount) {
                            // positions.removeRange(
                            //     context.read<ReportProvider>().originalCount,
                            //     context.read<ReportProvider>().count);

                            context.read<ReportProvider>().updateCount(
                                context.read<ReportProvider>().originalCount);
                            positions.clear();
                            context.read<ReportProvider>().updateImageResult();
                            (JSON.jsonDecode(JSON.jsonDecode(context
                                    .read<ReportProvider>()
                                    .imageResult))["boxes"] as List)
                                .asMap()
                                .forEach((index, element) {
                              //    this.index =  index + 1;
                              positions.add({
                                'Transform': Transform(
                                    transform: Matrix4.translationValues(
                                        ((element[2] + element[0]) / 2) - 10,
                                        ((element[3] + element[1]) / 2) - 10,
                                        0),
                                    child: Container(
                                      margin: EdgeInsets.all(0),
                                      child: CircleAvatar(
                                          radius: 10,
                                          child: Container(
                                            child: Center(
                                              //     child: Text(
                                              //   '1',
                                              //   textAlign: TextAlign.center,
                                              //   style: TextStyle(
                                              //       fontSize: FontSizesContants
                                              //           .Smallest,
                                              //       color: Colors.white),
                                              // )
                                              child: Icon(
                                                CupertinoIcons.check_mark,
                                                color: Colors.white,
                                                size: 8,
                                              ),
                                            ),
                                          ),
                                          backgroundColor:
                                              Color.fromARGB(61, 104, 127, 1)),
                                    )),
                                'x': element[0],
                                'y': element[1],
                              });
                            });

                            //      }
                          },
                          child: Column(
                            children: [
                              Icon(CupertinoIcons.gobackward,
                                  color: Colors.red),
                              Text('Reset')
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    positions.isEmpty &&
                            (JSON.jsonDecode(JSON.jsonDecode(
                                        reportProvider.imageResult))["boxes"]
                                    as List) !=
                                (JSON.jsonDecode(JSON.jsonDecode(
                                        reportProvider.originaBoxs))["boxes"]
                                    as List)
                        ? SizedBox()
                        : MyButton(
                            title: 'Show Result',
                            function: () {
                              screenshotController
                                  .capture()
                                  .then((Uint8List? image) async {
                                //Capture Done

                                setState(() async {
                                  _imageFile = image;

                                  final tempDir = await getTemporaryDirectory();
                                  final file = await new File(
                                          '${tempDir.path}/image.jpg')
                                      .create();
                                  file.writeAsBytesSync(_imageFile!);

                                  print(file.path);
                                  myNavigation(
                                      context: context,
                                      screen: CountingResultScreen(
                                        image: Image.memory(
                                          _imageFile!,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .3,
                                        ),
                                        file: file,
                                        inOrout: widget.inOrout,
                                      ));
                                });
                              }).catchError((onError) {
                                print(onError);
                              });
                            },
                            color: Theme.of(context).primaryColor),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
      }),
    );
  }

  double calculateRadius(double x1, double y1, double x2, double y2) {
    // Calculate the distance between two points using the distance formula
    double distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));

    // Radius of the circle is half of the distance between the two points
    double radius = distance / 2;

    return radius;
  }
}
