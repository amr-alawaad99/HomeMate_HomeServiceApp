import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_register_methods/shared/resources/constants_manager.dart';
import 'package:login_register_methods/shared/resources/assets_manager.dart';

import '../../shared/resources/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay(){
    _timer = Timer(
      Duration(seconds: 3),
      _goNext,
    );
  }

  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 124,
              height: 124,
              child: Image.asset(ImageAssets.splashLogo),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'HomeMate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto"
              ),
            ),
          ],
        ),
      ),
    );
  }


}
