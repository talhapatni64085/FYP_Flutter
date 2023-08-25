import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ground_app/Screens/Auth/signUp.dart';
import 'package:ground_app/Screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString("email") != null && prefs.getString("pass") != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Home()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegistrationScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/calogo4.png",
            height: 350,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}