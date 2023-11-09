// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

Future<void> myConfirmAlert(
    {required BuildContext context,
    required Function function,
    String? msg}) async {
  QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: msg ?? '',
      confirmBtnText: 'Confirm',
      cancelBtnText: 'Close',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        function();
      });
}

Future<void> myErrorAlert(
    {required BuildContext context, required String msg}) async {
  QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: msg,
      confirmBtnText: 'تأكيد',
      confirmBtnColor: Theme.of(context).primaryColor);
}

Future<void> mySuccessAlert({
  required BuildContext context,
  Function? function,
}) async {
  QuickAlert.show(
      context: context,
      title: 'نجاح',
      type: QuickAlertType.success,
      text: 'تمت العملية بنجاح!',
      confirmBtnText: 'تأكيد',
      confirmBtnColor: Theme.of(context).primaryColor,
      onConfirmBtnTap: () {
        if (function != null) {
          function();
        }
      });
}

Future<void> myInfoAlert(
    {required BuildContext context, required String msg}) async {
  QuickAlert.show(
      context: context,
      title: 'تنويه',
      type: QuickAlertType.info,
      text: msg,
      confirmBtnText: 'تأكيد',
      confirmBtnColor: Theme.of(context).primaryColor);
}
