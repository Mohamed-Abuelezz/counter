// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {


  Color primaryColor = Color(0xff1d2ec7);

  setSelectedPrimaryColor(Color primaryColorChoosen) {
    primaryColor = primaryColorChoosen;
    notifyListeners();
  }


  /////////////////////
}
