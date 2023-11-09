import 'package:counter/Screens/loginScreen.dart';
import 'package:counter/Screens/navigation/navigationScreen.dart';
import 'package:counter/helpers/myNavigation.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      if (MySharedPreference().getSharedPref()!.containsKey('user_token')) {
        myNavigation(
            context: context,
            screen: NavigationScreen(),
            withReplacement: true);
      } else {
        myNavigation(
            context: context, screen: LoginScreen(), withReplacement: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/icons/logo.png',
          width: 150,
        ).animate()
  .fade(duration: 2.seconds)
  .scale(delay: 2.seconds).rotate(delay: 2.seconds) // runs after fade.,
      ),
    );
  }
}
