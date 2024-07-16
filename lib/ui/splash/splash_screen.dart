import 'dart:async';

import 'package:daily_missions_app/ui/auth/register/register_screen.dart';
import 'package:daily_missions_app/ui/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'Splash-Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).splashColor,
      child: Image.asset('assets/images/logo-splash.png'),
    );
  }
}

//
// decoration: BoxDecoration(
// image: DecorationImage(
// fit: BoxFit.cover,
// image: AssetImage(ThemeMode == ThemeMode.light
// ? 'assets/images/splash_light.png'
//     : 'assets/images/splash_dark.png'),
// ),
// ),
