// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyListEmptyDesc extends StatelessWidget {
  var msg;
  MyListEmptyDesc({super.key, this.msg = 'لاتوجد بيانات!'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/empty.gif',
            width: 60,
          ),
          Text(
            msg,
            style: const TextStyle(),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
