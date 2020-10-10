import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:t_teet_rider/models/RideRequest.dart';
import 'package:t_teet_rider/rider/auth/DocDetails.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/detail/vehicleAdd.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/detail/vehicleInfo.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/help.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/learningCenter.dart';
import 'package:t_teet_rider/screens/EmailPage.dart';
import 'package:t_teet_rider/screens/GenderPage.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/screens/MessageUserListPage.dart';
import 'package:t_teet_rider/screens/NamePage.dart';
import 'package:t_teet_rider/screens/RideRequestScreen.dart';
import 'package:t_teet_rider/screens/SignupScreen.dart';
import 'package:t_teet_rider/screens/SplashScreen.dart';
import 'package:t_teet_rider/screens/OnRide.dart';
import 'package:t_teet_rider/screens/InvoicePage.dart';
import 'package:t_teet_rider/screens/RatingCustomer.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/screens/TermsOfServicePage.dart';
import 'package:t_teet_rider/utils/PushNotificationService.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/vehicle.dart';

import 'screens/SplashScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'T-teet guru',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'gothamRegular'
      ),
      home: SplashPage(), //SplashPage
      routes: {
        '/home' : (context)=>HomeScreen(),
        '/onride': (context)=>OnRide(),
        '/messaging': (context)=>MessageUserListPage(),
//        '/invoice': (context)=>InvoicePage(),
//        '/rating': (context)=>RatingCustomer(),

      },
    );
  }
}
