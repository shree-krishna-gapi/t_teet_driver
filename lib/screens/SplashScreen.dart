import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_teet_rider/screens/GetStartedScreen.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => GetStartedScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 50),
            child: FadeAnimation(0.2,Image.asset("assets/images/logowithguru.PNG"))),
          ),
    );
  }
}
