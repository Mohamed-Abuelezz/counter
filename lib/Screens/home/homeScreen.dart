import 'dart:convert';
import 'dart:io';

import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Providers/auth/reportHistoryProvider.dart';
import 'package:counter/Screens/Global/myListEmptyDesc.dart';
import 'package:counter/Screens/Global/myLoading.dart';
import 'package:counter/Screens/home/components/bottomSheetWidget.dart';
import 'package:counter/Screens/imagePreview/imagePreviewScreen.dart';
import 'package:counter/Screens/reportDetails/reportDetailsScreen.dart';
import 'package:counter/Screens/reportsHistory/reportsHistoryScreen.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_photo_editor/flutter_photo_editor.dart';
import 'package:image/image.dart';
import 'package:image_editor_plus/options.dart';
//import 'package:image_editor/image_editor.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/src/widgets/image.dart' as ImageWidget;
import 'dart:developer';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  image_picker.ImagePicker? picker;
// Pick an image.
  image_picker.XFile? photo;
  img.Image? depthImage;
  int count = 0;
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

  List<List<double>> getDepthFullInformation(img.Image image) {
    if (image != null) {
      final int width = image.width;
      final int height = image.height;

      // Create a 2D list to store depth values for each pixel
      List<List<double>> depthInformation = List.generate(
          height,
          (y) => List.generate(
                width,
                (x) {
                  // Extract the grayscale pixel value at the specified coordinates
                  final int pixelValue = image.getPixel(x, y).index.toInt();

                  // Normalize the depth value to the range [0, 1]
                  return pixelValue / 255.0;
                },
              ),
          growable: false);

      return depthInformation;
    }
    return [[]]; // Return an empty list if the image is not loaded
  }

  img.Image createDepthImage(List<List<double>> depthInformation) {
    final int width = depthInformation[0].length;
    final int height = depthInformation.length;

    final img.Image depthImage = img.Image(width: width, height: height);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int grayValue;
        if (depthInformation[y][x] > .70) {
          grayValue = (depthInformation[y][x] * 255).toInt();
          count = count + 1;
        } else {
          grayValue = (depthInformation[y][x] * 10).toInt();
        }
        // final int grayValue = (depthInformation[y][x] * 255).toInt();
        final color = depthImage.getColor(grayValue, grayValue, grayValue);
        depthImage.setPixel(x, y, color);
      }
    }

    return depthImage;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportHistoryProvider>(
        builder: (context, reportHistoryProvider, child) {
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                    child: SizedBox(
                        child: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizesContants.Title_1,
                      fontWeight: FontWeight.bold),
                ))),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Card(
                      // color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),

                      elevation: 2,
                      margin: EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              return bottomSheet(
                                  photoType: 'out', context: context);
                            },
                          );

                          ////////////////////
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  CupertinoIcons.camera,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Out',
                                  style: TextStyle(
                                      fontSize: FontSizesContants.Body),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      color: Colors.white,
                      elevation: 2,
                      margin: EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              return bottomSheet(
                                  photoType: 'in', context: context);
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  CupertinoIcons.camera,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'In',
                                  style: TextStyle(
                                      fontSize: FontSizesContants.Body),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text(
                      'Recent Reports',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizesContants.Title_1),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // myNavigation(
                        //     context: context, screen: ReportsHistoryScreen());

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ReportsHistoryScreen(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: FontSizesContants.Body),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                reportHistoryProvider.isLoadingGetReports
                    ? showMyLoading(context)
                    : Container(
                        height: 105,
                        child: reportHistoryProvider.reports.isEmpty ||
                                reportHistoryProvider.reports == null
                            ? Center(child: MyListEmptyDesc())
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: reportHistoryProvider.reports.length,
                                itemBuilder: (context, index) {
                                  return index > 5
                                      ? SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            myNavigation(
                                                context: context,
                                                screen: ReportDetailsScreen(
                                                  report: reportHistoryProvider
                                                      .reports[index],
                                                ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 0,
                                            ),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '${DateTime.parse(reportHistoryProvider.reports[index].createdAt!).year.toString()}-${DateTime.parse(reportHistoryProvider.reports[index].createdAt!).month.toString().padLeft(2, '0')}-${DateTime.parse(reportHistoryProvider.reports[index].createdAt!).day.toString().padLeft(2, '0')}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              FontSizesContants
                                                                  .Smallest),
                                                    ),
                                                    Text(
                                                      '${DateFormat.jm().format(DateTime.parse(reportHistoryProvider.reports[index].createdAt!))}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              FontSizesContants
                                                                  .Smallest),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                }),
                      )
              ],
            ),
          ),
        )),
      );
    });
  }

  Widget bottomSheet(
      {required String photoType, required BuildContext context}) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
// Capture a photo.
              photo = null;
              picker = null;
              picker = new image_picker.ImagePicker();

              photo = await picker!
                  .pickImage(source: image_picker.ImageSource.camera);
              if (photo != null) {
                try {
                  // ignore: use_build_context_synchronously
                  final editedImage =
                      await PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: ImageEditor(
                      image: photo, // <-- Uint8List of image
                      appBarColor: Colors.blue,
                      blurOption: BlurOption(),
                    ),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );

                  // Get the directory where the file will be saved
                  String directory =
                      (await getApplicationDocumentsDirectory()).path;

                  // Specify the file path
                  String filePath =
                      '$directory/file_name.extension'; // Replace 'file_name.extension' with your desired file name and extension
                  writeUint8ListToFile(editedImage, filePath).then((value) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ImagePreviewScreen(
                        file: value!,
                        inOrout: photoType,
                      ),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  });
                } catch (e) {
                  //  print(e);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(CupertinoIcons.camera),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizesContants.Body),
                  )
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () async {
// Capture a photo.
              photo = null;
              picker = null;
              picker = new image_picker.ImagePicker();

              photo = await picker!
                  .pickImage(source: image_picker.ImageSource.gallery);

              if (photo != null) {
                try {
                  // ignore: use_build_context_synchronously
                  final editedImage =
                      await PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: ImageEditor(
                      image: photo, // <-- Uint8List of image
                      appBarColor: Colors.blue,
                    ),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );

                  // Get the directory where the file will be saved
                  String directory =
                      (await getApplicationDocumentsDirectory()).path;

                  // Specify the file path
                  String filePath =
                      '$directory/file_name.extension'; // Replace 'file_name.extension' with your desired file name and extension
                  writeUint8ListToFile(editedImage, filePath).then((value) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ImagePreviewScreen(
                        file: value!,
                        inOrout: photoType,
                      ),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  });
                } catch (e) {
                  //  print(e);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(CupertinoIcons.rectangle_stack_person_crop),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizesContants.Body),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double estimateDepth(File imageFile) {
    // Calculate depth estimate based on relative object sizes
    // This is a simple example and won't provide accurate depth information
    // You may need to fine-tune this logic or use a machine learning model for better results.
    double depth = 0.0; // Depth estimation (you can use any scale you like)

    // Example logic: objects closer to the camera appear larger
    // You can adjust the logic based on your specific use case
    // This is just a simple placeholder
    if (imageFile != null) {
      // Measure the size of an object in the image (e.g., a person)
      double objectSizeInImagePixels =
          100.0; // Adjust this value based on your object size

      // Calculate depth based on a reference object size and the known real-world size
      double referenceObjectSizeInRealWorld =
          1.0; // Adjust this value based on your reference object size
      depth = referenceObjectSizeInRealWorld / objectSizeInImagePixels;
    }

    return depth;
  }

  Future<File?> writeUint8ListToFile(
      Uint8List uint8List, String filePath) async {
    try {
      File file = File(filePath);

      // Write the Uint8List data to the file
      await file.writeAsBytes(uint8List);

      return file;
    } catch (e) {
      // Handle errors that occurred during the file writing process
      print('Error: $e');
      return null;
    }
  }
}
