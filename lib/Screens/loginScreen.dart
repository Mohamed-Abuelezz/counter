import 'package:counter/Constants/fontSizesContants.dart';
import 'package:counter/Providers/auth/loginProvider.dart';
import 'package:counter/Screens/Global/myButton.dart';
import 'package:counter/Screens/Global/myLoading.dart';
import 'package:counter/Screens/Global/myTextField.dart';
import 'package:counter/Screens/navigation/navigationScreen.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizesContants.Title_2),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Login to your account',
                  style: TextStyle(fontSize: FontSizesContants.Body),
                ),
                SizedBox(
                  height: 80,
                ),
                MyTextField(
                  lable: 'Email Or Username',
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
                  height: 10,
                ),
                MyTextField(
                    lable: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                    ),
                    controller: _passwordController,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please Insert Value';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword),
                SizedBox(
                  height: 5,
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       // myNavigation(
                //       //     context: context, screen: ForgotPasswordScreen());
                //     },
                //     child: Text(
                //       'Forgot Password?',
                //       style: TextStyle(
                //           decoration: TextDecoration.underline,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),

                Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                  return loginProvider.isLoadingLogin
                      ? showMyLoading(context)
                      : MyButton(
                          title: 'Login',
                          function: () async {
                            if (_formKey.currentState!.validate()) {
                              // final fcmToken = await FirebaseMessaging
                              //     .instance
                              //     .getToken();

                              //             if (context.mounted) {
                              loginProvider.login(context: context, body: {
                                'user_name': _emailController.text,
                                'password': _passwordController.text,
                                //     'fcm_token': fcmToken,
                              }).then((value) {
                                print(value);
                                if (value['status'] == 200) {
                                  myNavigation(
                                      context: context,
                                      screen: NavigationScreen(),
                                      withReplacement: true);
                                }
                              });
                            }
                            //       }
                          },
                          color: Theme.of(context).primaryColor);
                }),
                SizedBox(
                  height: 10,
                ),
                // MyButton(
                //     title: 'Continue as a guest',
                //     function: () {},
                //     color: Theme.of(context).primaryColor),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('Don’t have an account?'),
                //     TextButton(
                //         onPressed: () {
                //           // myNavigation(
                //           //     context: context, screen: RegisterScreen());
                //         },
                //         child: Text(
                //           'Sign Up',
                //           style: TextStyle(
                //             decoration: TextDecoration.underline,
                //           ),
                //         )),
                //   ],
                // ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
