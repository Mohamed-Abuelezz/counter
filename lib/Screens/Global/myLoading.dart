// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showMyLoading(BuildContext context) {
  return SpinKitThreeInOut(
    color: Theme.of(context).primaryColor,
    size: 30.0,
  );
}
