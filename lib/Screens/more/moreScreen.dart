import 'package:counter/Providers/auth/loginProvider.dart';
import 'package:counter/Providers/themeProvider.dart';
import 'package:counter/Screens/Global/myHeader.dart';
import 'package:counter/Screens/loginScreen.dart';
import 'package:counter/helpers/myAlerts.dart';
import 'package:counter/helpers/myNavigation.dart';

import 'package:counter/helpers/mySharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
//import 'package:image_editor/image_editor.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late Color pickerColor_primary;
  late Color currentColor_primary;

  late Color pickerColor_secoundry;
  late Color currentColor_secoundry;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      setState(() {
        pickerColor_primary = Theme.of(context).primaryColor;
        currentColor_primary = Theme.of(context).primaryColor;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, loginProvider, child) {
      return Scaffold(
          body: SafeArea(
              child: Column(
        children: [
          MyHeader(
            centerWidget: Text(
              'Setting',
              style: TextStyle(fontSize: 30),
            ),
            withBack: false,
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Theme ',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showPrimaryColorPicker(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // MyButton(
                        //     title: 'تعديل',
                        //     padding: EdgeInsets.all(10),
                        //     function: () {
                        //       showPrimaryColorPicker(context);
                        //     },
                        //     color: Theme.of(context).primaryColor)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                  return InkWell(
                    onTap: () {
                      myConfirmAlert(
                          context: context,
                          msg: 'Are You Sure ?',
                          function: () {
                            loginProvider
                                .logout(context: context)
                                .then((value) {
                              if (value['status'] == 200) {
                                MySharedPreference mySharedPreference =
                                    MySharedPreference();
                                mySharedPreference.getSharedPref()!.clear();

                                //       Navigator.pop(context);

                                myNavigation(
                                        context: context,
                                        screen: LoginScreen(),
                                        withReplacement: true)
                                    .then((value) {
                                  //    Navigator.pop(context);
                                });
                              }
                            });
                          }).whenComplete(() {
                        //    Navigator.pop(context);
                      });
                    },
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.exit_to_app),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // MyButton(
                            //     title: 'تعديل',
                            //     padding: EdgeInsets.all(10),
                            //     function: () {
                            //       showPrimaryColorPicker(context);
                            //     },
                            //     color: Theme.of(context).primaryColor)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      )));
    });
  }

  void showPrimaryColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختيار اللون الاساسي!'),
          content:
              Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
            return SingleChildScrollView(
              child: MaterialPicker(
                //   paletteType: PaletteType.hsv,
                pickerColor: pickerColor_primary,
                onColorChanged: (color) {
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      currentColor_primary = color;
                      pickerColor_primary = color;
                    });
                  });
                },
              ),
            );
          }),
          actions: <Widget>[
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
              return ElevatedButton(
                child: const Text('تأكيد'),
                onPressed: () {
                  setState(() => currentColor_primary = pickerColor_primary);
                  MySharedPreference()
                      .getSharedPref()!
                      .setInt('primary_color', pickerColor_primary.value);
                  themeProvider.setSelectedPrimaryColor(pickerColor_primary);

                  Navigator.pop(context);
                },
              );
            }),
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
              return ElevatedButton(
                child: const Text('اعادة تعيين'),
                onPressed: () {
                  setState(() {
                    themeProvider.setSelectedPrimaryColor(Color(0xff1d2ec7));
                    pickerColor_primary = const Color(0xff1d2ec7);
                    currentColor_primary = const Color(0xff1d2ec7);
                  });

                  MySharedPreference().getSharedPref()!.remove('primary_color');

                  Navigator.pop(context);
                },
              );
            }),
          ],
        );
      },
    );
  }
}
