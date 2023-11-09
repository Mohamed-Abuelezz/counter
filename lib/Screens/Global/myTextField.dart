// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  var lable;
  var validation;
  var onChanged;
  var keyboardType;
  var controller;
  var prefixIcon;
  var enable;
  EdgeInsetsGeometry? margin;
  MyTextField({
    super.key,
    @required this.lable,
    @required this.validation,
    this.controller,
    this.onChanged,
    this.prefixIcon = null,
    this.enable = true,
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    this.keyboardType = TextInputType.text,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool? _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        enabled: widget.enable,
        controller: widget.controller,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.left,
        obscureText: _passwordVisible == true ? true : false,
        inputFormatters: widget.keyboardType == TextInputType.number
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ]
            : [],
        maxLines: widget.keyboardType == TextInputType.multiline ? 3 : 1,
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).primaryColor)),

          floatingLabelBehavior: FloatingLabelBehavior.never,
          // fillColor: Color(0xffF6F6F6),
          prefixIcon: widget.prefixIcon,
          contentPadding: const EdgeInsets.all(15),
          labelText: widget.lable,
          filled: true,
          fillColor: Colors.grey.withOpacity(.0),

          labelStyle: TextStyle(
            color: Colors.black,
          ),

          hintText: widget.lable,
          hintTextDirection: TextDirection.ltr,
          hintStyle: TextStyle(color: Colors.black),

          suffixIcon: null,
        ),
        validator: widget.validation,
      ),
    );
  }
}
