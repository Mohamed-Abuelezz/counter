// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static  SharedPreferences? prefs;

  Future<void> initSharedPref() async {
// Obtain shared preferences.
    prefs = await SharedPreferences.getInstance();
  }


  SharedPreferences?  getSharedPref() {


    return prefs;
  }




}
