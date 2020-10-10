import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/screens/SplashScreen.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return SplashPage();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:t_teet/Screens/GetStartedScreen.dart';
//import 'package:t_teet/Screens/HomeScreen.dart';
//
//class App extends StatefulWidget {
//  App({Key key}) : super(key: key);
//
//  @override
//  _AppState createState() => _AppState();
//}
//
//class _AppState extends State<App> {
//  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//  FirebaseUser user;
//
//  @override
//  void initState() {
//    super.initState();
//    getCurrentUser();
//  }
//
//  void getCurrentUser() async {
//    FirebaseUser _user = await _firebaseAuth.currentUser();
//    setState(() {
//      user = _user;
//    });
//  }
//
//  signOut() {
//    FirebaseAuth.instance.signOut();
//  }
//
//  //SignIn
//  signIn(AuthCredential authCreds) {
//    FirebaseAuth.instance.signInWithCredential(authCreds);
//  }
//
//  signInWithOTP(smsCode, _verificationId) {
//    AuthCredential authCreds = PhoneAuthProvider.getCredential(
//        verificationId: _verificationId, smsCode: smsCode);
//    signIn(authCreds);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    print(user);
//    return Scaffold(
//        body: user != null
//            ? HomeScreen(
//          user: user,
//        )
//            : LoginSignUpPage());
//  }
//}