import 'dart:async';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/calculator.png'),
            const Center(
                child: Text(
              'Calculator',
              style: TextStyle(
                  fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
            )
            ),
          ],
        ),
      ),
    );
  }
}
