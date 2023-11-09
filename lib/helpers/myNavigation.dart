// ignore_for_file: file_names

import 'package:flutter/material.dart';

Future<void> myNavigation(
    {required BuildContext context,
    required Widget screen,
    bool withReplacement = false}) async {
  if (!withReplacement) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  } else {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => screen), (route) => false);
  }
}
