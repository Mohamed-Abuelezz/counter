// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'package:counter/Constants/urls.dart';
import 'package:counter/helpers/handleDioErrors.dart';
import 'package:counter/helpers/myAlerts.dart';
import 'package:counter/helpers/myDio.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  MyDio myDio = MyDio();
  MySharedPreference mySharedPreference = MySharedPreference();
  dynamic response;

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;

  bool isLoadingEditAccount = false;

  Future<dynamic> login(
      {required BuildContext context,
      bool withLoading = true,
      bool showErrorDialog = true,
      var body}) async {
    if (withLoading) {
      isLoadingLogin = true;
      notifyListeners();
    }
    print(body);
    try {
      response = await myDio.postHttp(
          url: (apiBaseURL + userLoginApi), formData: FormData.fromMap(body));
      print('>>>>><<<<<>>>>>>><<<<<');

      if (response['status'] == 200) {
        mySharedPreference
            .getSharedPref()!
            .setInt('user_id', response['body']['user']['id']);

        mySharedPreference
            .getSharedPref()!
            .setString('user_token', 'Bearer ' + response['body']['token']);

        mySharedPreference
            .getSharedPref()!
            .setString('user_name', response['body']['user']['user_name']);

        mySharedPreference
            .getSharedPref()!
            .setString('user_email', response['body']['user']['email']);
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
      isLoadingLogin = false;
      notifyListeners();
    }

    return response;
  }

  Future<dynamic> logout(
      {required BuildContext context,
      bool withLoading = true,
      bool showErrorDialog = true,
      var body}) async {
    if (withLoading) {
      isLoadingLogout = true;
      notifyListeners();
    }

    try {
      response = await myDio.postHttp(url: (apiBaseURL + logoutApi));

      if (response['status'] == 200) {}
    } on DioError catch (e) {
      print(e.response);
      if (showErrorDialog == true) {
        HandleDioErrors.handleHttpException(context: context, exception: e);
      }
    } catch (e) {
      if (showErrorDialog == true) {
        myErrorAlert(context: context, msg: 'حدث خطأ يرجي التواصل معنا!');
      }
    }

    if (withLoading) {
      isLoadingLogout = false;
      notifyListeners();
    }

    return response;
  }

  //////////////////////////////////////
  Future<dynamic> editAccount(
      {required BuildContext context,
      bool withLoading = true,
      bool showErrorDialog = true,
      var body}) async {
    if (withLoading) {
      isLoadingEditAccount = true;
      notifyListeners();
    }
    print(body);

    try {
      response = await myDio.postHttp(
          url: (apiBaseURL + editAccountApi), formData: FormData.fromMap(body));
      print('>>>>><<<<<>>>>>>><<<<<');

      if (response['status'] == 200) {
        mySharedPreference
            .getSharedPref()!
            .setInt('user_id', response['body']['user']['id']);

        mySharedPreference
            .getSharedPref()!
            .setString('user_name', response['body']['user']['user_name']);

        mySharedPreference
            .getSharedPref()!
            .setString('user_email', response['body']['user']['email']);
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
      isLoadingEditAccount = false;
      notifyListeners();
    }

    return response;
  }
}
