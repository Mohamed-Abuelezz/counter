// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:counter/helpers/mySharedPreference.dart';
import 'package:dio/dio.dart';
import 'package:log_print/log_print.dart';

class MyDio {
  var dio = Dio();
  var response;

  Future<dynamic> getHttp({
    required var url,
    var queryParameters,
    var header,
  }) async {
    response = await dio.get(url,
        queryParameters: queryParameters,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: header ??
                {
                  'Authorization':
                      MySharedPreference.prefs!.getString('user_token') ?? ''
                }));

    LogPrint(response.toString(), type: LogPrintType.success);

    return response.data;
  }

  Future<dynamic> postHttp({
    required var url,
    var formData,
    var header,
  }) async {
    response = await dio.post(url,
        data: formData,
        options: Options(
            followRedirects: true,
            // validateStatus: (status) {
            //   return status! < 500;
            // },
            headers: header ??
                {
                  'Authorization':
                      MySharedPreference.prefs!.getString('user_token') ?? '',
                  "Accept": "application/json"
                },
            receiveDataWhenStatusError: true));

    LogPrint(response.toString(), type: LogPrintType.success);

    return response.data;
  }

  /////////////////////////////////
}
