// ignore_for_file: file_names

import 'package:counter/Screens/loginScreen.dart';
import 'package:counter/helpers/myAlerts.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HandleDioErrors {
  static handleHttpException({var exception, BuildContext? context}) async {
    debugPrint(exception.toString());

    bool result = await InternetConnectionChecker().hasConnection;

    if (result == false) {
      myErrorAlert(
          context: context!,
          msg: 'حدث خطأ يرجي مراجعة اتصالك بالانترنت او التواصل معنا!');
    } else if (exception.response!.statusCode == 422) {
      // For Validation Errors

      myInfoAlert(
          context: context!, msg: exception.response!.data['message']! ?? '');
    } else if (exception.response!.statusCode == 401) {
      // For Auth Exoired Token Errors

      MySharedPreference mySharedPreference = MySharedPreference();

      mySharedPreference.getSharedPref()!.remove('user_id');
      mySharedPreference.getSharedPref()!.remove('user_token');
      mySharedPreference.getSharedPref()!.remove('user_name');
      mySharedPreference.getSharedPref()!.remove('user_image');
      mySharedPreference.getSharedPref()!.remove('enable_notifications');

      myNavigation(
          context: context!,
          screen: const LoginScreen(),
          withReplacement: true);
    } else if (exception.response!.statusCode == 403) {
      // For UnActive users

      myErrorAlert(
          context: context!,
          msg: exception.response!.data['message']! ??
              'تم ايقاف حسابك لاسباب مخالفة يرجي التواصل معنا!');
    } else if (exception.response!.statusCode == 404) {
      // For NotFound Errors

      myErrorAlert(
          context: context!,
          msg: exception.response!.data['message']! ?? 'البيانات غير متاحة!');
    } else {
      // For General Errors

      myErrorAlert(
          context: context!,
          msg: 'حدث خطأ يرجي مراجعة اتصالك بالانترنت او التواصل معنا!');
    }
  }
}
