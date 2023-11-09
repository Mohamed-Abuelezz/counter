// import 'dart:io';

// import 'package:counter/Constants/fontSizesContants.dart';
// import 'package:counter/Screens/imagePreview/imagePreviewScreen.dart';
// import 'package:counter/helpers/myNavigation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class BottomSheetWidget extends StatefulWidget {
//   Function(File arg) function;

//   BottomSheetWidget({super.key, required this.function});

//   @override
//   State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
// }

// class _BottomSheetWidgetState extends State<BottomSheetWidget> {
//   final ImagePicker picker = ImagePicker();
// // Pick an image.
//   late final XFile? photo;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () async {
// // Capture a photo.

//               photo = await picker.pickImage(source: ImageSource.camera);

//               if (photo != null) {
//                 widget.function(File(photo!.path));
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Icon(CupertinoIcons.camera),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     'Camera',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: FontSizesContants.Body),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Divider(),
//           InkWell(
//             onTap: () async {
//               photo = await picker.pickImage(source: ImageSource.gallery);

//               if (photo != null) {
//                 widget.function(File(photo!.path));
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Icon(CupertinoIcons.rectangle_stack_person_crop),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     'Gallery',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: FontSizesContants.Body),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
