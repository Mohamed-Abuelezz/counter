// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:counter/Constants/fontSizesContants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget {
  var rightWidget;
  var centerWidget;
  var withBack;
  var backFunction;
  MyHeader(
      {super.key,
      this.rightWidget = const SizedBox(),
      this.centerWidget = const SizedBox(),
      this.withBack = true,
      this.backFunction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        withBack
            ? IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () {
                  if (backFunction != null) {
                    backFunction();
                  } else {
                    Navigator.pop(context);
                  }
                },
              )
            : const SizedBox(),
        centerWidget,
        rightWidget,
      ],
    );
  }
}
