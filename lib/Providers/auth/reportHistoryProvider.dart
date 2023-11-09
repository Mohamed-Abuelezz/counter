// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'package:counter/Constants/urls.dart';
import 'package:counter/Models/Report.dart';
import 'package:counter/helpers/handleDioErrors.dart';
import 'package:counter/helpers/myAlerts.dart';
import 'package:counter/helpers/myDio.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

class ReportHistoryProvider with ChangeNotifier {
  MyDio myDio = MyDio();
  MySharedPreference mySharedPreference = MySharedPreference();
  dynamic response;

  bool isLoadingGetReports = false;
  List<Report> reports = [];
  Future<dynamic> getReports(
      {required BuildContext context,
      bool withLoading = true,
      bool showErrorDialog = true,
      var body}) async {
    reports = [];
    if (withLoading) {
      isLoadingGetReports = true;
      notifyListeners();
    }
    print(body);
    try {
      response = await myDio.getHttp(
          url: (apiBaseURL + reportsApi), queryParameters: body);

      if (response['status'] == 200) {
        reports = List<Report>.from(response['body']['report']
            .map((model) => Report.fromJson(model))).toList();

        notifyListeners();
      }
    } on DioError catch (e) {
      print('>>>>>>>' + e.response.toString());
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
      isLoadingGetReports = false;
      notifyListeners();
    }

    return response;
  }
}
