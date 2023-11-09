import 'dart:convert';
import 'dart:io';

import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Providers/auth/loginProvider.dart';
import 'package:counter/Providers/auth/reportHistoryProvider.dart';
import 'package:counter/Screens/Global/myButton.dart';
import 'package:counter/Screens/Global/myHeader.dart';
import 'package:counter/Screens/Global/myListEmptyDesc.dart';
import 'package:counter/Screens/Global/myLoading.dart';
import 'package:counter/Screens/Global/myTextField.dart';
import 'package:counter/Screens/home/components/bottomSheetWidget.dart';
import 'package:counter/Screens/imagePreview/imagePreviewScreen.dart';
import 'package:counter/Screens/reportDetails/reportDetailsScreen.dart';
import 'package:counter/Screens/reportsHistory/reportsHistoryScreen.dart';
import 'package:counter/helpers/myAlerts.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_photo_editor/flutter_photo_editor.dart';
import 'package:image/image.dart';
import 'package:image_editor_plus/options.dart';
//import 'package:image_editor/image_editor.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/src/widgets/image.dart' as ImageWidget;
import 'dart:developer';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      _userNameController.text =
          MySharedPreference().getSharedPref()!.getString('user_name')!;
      _emailController.text =
          MySharedPreference().getSharedPref()!.getString('user_email')!;
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, loginProvider, child) {
      return Form(
        key: _formKey,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
                child: Column(
              children: [
                MyHeader(
                  centerWidget: Text(
                    'Edit Account',
                    style: TextStyle(fontSize: 30),
                  ),
                  withBack: false,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        MyTextField(
                          lable: 'Username',
                          prefixIcon: Icon(Icons.person_outline),
                          controller: _userNameController,
                          validation: (val) {
                            if (val!.isEmpty) {
                              return 'Please Insert Value';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          lable: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          controller: _emailController,
                          validation: (val) {
                            if (val!.isEmpty) {
                              return 'Please Insert Value';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                            lable: 'Old Password',
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                            ),
                            controller: _oldPasswordController,
                            validation: (value) {
                              if (_passwordController.text.isNotEmpty &&
                                  value!.isEmpty) {
                                return 'Please Insert Value';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                            lable: 'New Password',
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                            ),
                            controller: _passwordController,
                            validation: (value) {
                              // if (value!.isEmpty) {
                              //   return 'Please Insert Value';
                              // }

                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                            lable: 'Confirm New Password',
                            validation: (val) {
                              // if (val!.isEmpty) {
                              //   return 'يرجي ادخال قيمة';
                              // }
                              if (val.toString() != _passwordController.text) {
                                return 'Please Insert Password !';
                              }
                              return null;
                            },
                            controller: _confirmPasswordController,
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                            ),
                            keyboardType: TextInputType.visiblePassword),
                        SizedBox(
                          height: 20,
                        ),
                        loginProvider.isLoadingEditAccount
                            ? showMyLoading(context)
                            : MyButton(
                                title: 'Edit Account',
                                function: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // final fcmToken = await FirebaseMessaging
                                    //     .instance
                                    //     .getToken();

                                    //             if (context.mounted) {
                                    loginProvider
                                        .editAccount(context: context, body: {
                                      'user_name': _userNameController.text,
                                      'email': _emailController.text,
                                      'new_password': _passwordController.text,
                                      'old_password':
                                          _oldPasswordController.text,
                                      //     'fcm_token': fcmToken,
                                    }).then((value) {
                                      print(value);
                                      if (value['status'] == 200) {
                                        mySuccessAlert(context: context);
                                        // myNavigation(
                                        //     context: context,
                                        //     screen: NavigationScreen(),
                                        //     withReplacement: true);
                                      }
                                    });
                                  }
                                  //       }
                                },
                                color: Theme.of(context).primaryColor),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))),
      );
    });
  }
}
