// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:counter/Constants/urls.dart';
import 'package:counter/Models/Report.dart';
import 'package:counter/helpers/handleDioErrors.dart';
import 'package:counter/helpers/myAlerts.dart';
import 'package:counter/helpers/myDio.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'dart:convert' as JSON;

class ReportProvider with ChangeNotifier {
  MyDio myDio = MyDio();
  MySharedPreference mySharedPreference = MySharedPreference();
  dynamic response;

  bool isLoadingSendImage = false;
  bool isLoadingSendResult = false;
  dynamic imageResult;
  dynamic originaBoxs;

  int originalCount = 0;
  int count = 0;
  Future<dynamic> sendImage(
      {required BuildContext context,
      bool withLoading = true,
      bool showErrorDialog = true,
      var body}) async {
    originaBoxs = [];
    originalCount = 0;
    count = 0;
    if (withLoading) {
      isLoadingSendImage = true;
      notifyListeners();
    }
    print(body);
    try {
      response = await myDio.postHttp(
          url: (apiBaseURL + uploadPictureApi),
          formData: FormData.fromMap(body));

      if (response['status'] == 200) {
        imageResult = response['data'];

        originalCount = JSON.jsonDecode(JSON.jsonDecode(imageResult))["count"];
        count = JSON.jsonDecode(JSON.jsonDecode(imageResult))["count"];

        originaBoxs = response['data'];
        // debugPrint(imageResult.toString());
        notifyListeners();
      }
    } on DioError catch (e) {
      print('>>>>>>>' + e.stackTrace.toString());
      if (showErrorDialog == true) {
        HandleDioErrors.handleHttpException(context: context, exception: e);
      }
    } catch (e) {
      print('>>>>>>>' + e.toString());

      if (showErrorDialog == true) {
        myErrorAlert(context: context, msg: 'حدث خطأ يرجي التواصل معنا!');
      }
    }

    if (withLoading) {
      isLoadingSendImage = false;
      notifyListeners();
    }
    print(originalCount);
    print(JSON.jsonDecode(JSON.jsonDecode(imageResult))["count"]);

    return response;
  }

  Future<dynamic> sendResult(
      {required BuildContext context,
      bool withLoading = true,
      bool showErrorDialog = true,
      var body}) async {
    originaBoxs = [];
    originalCount = 0;
    count = 0;
    if (withLoading) {
      isLoadingSendResult = true;
      notifyListeners();
    }
    print(body);
    try {
      response = await myDio.postHttp(
          url: (apiBaseURL + uploadReportResultsApi),
          formData: FormData.fromMap(body));

      if (response['status'] == 200) {
        // imageResult = response['data'];

        // debugPrint(imageResult.toString());
        notifyListeners();
      }
    } on DioError catch (e) {
      print('>>>>>>>' + e.response.toString());
      if (showErrorDialog == true) {
        HandleDioErrors.handleHttpException(context: context, exception: e);
      }
    } catch (e) {
      //   print('>>>>>>>' + e.toString());

      if (showErrorDialog == true) {
        myErrorAlert(context: context, msg: 'حدث خطأ يرجي التواصل معنا!');
      }
    }

    if (withLoading) {
      isLoadingSendResult = false;
      notifyListeners();
    }

    return response;
  }

  /////////////////////////////////////////////////////////

  updateCount(int newVal) {
    //  print(count);
    count = newVal;
    notifyListeners();
  }

  updateImageResult() {
    //  print(count);
    imageResult = originaBoxs;

    notifyListeners();
  }
}
