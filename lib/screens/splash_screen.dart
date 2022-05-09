import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      Future.delayed(
        const Duration(seconds: 2),
            () => Navigator.pushReplacementNamed(context, homeScreenRoute),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Text(
          "Quiz\nLet's get started!",
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.white,
            fontFamily: 'Satisfy',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
