//App logo of t-teet and the center image is left to integrate

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/rider/auth/LoginPage.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';

import 'NamePage.dart';
import 'SignupScreen.dart';
import 'package:t_teet_rider/rider/auth/VehicleDetails.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[

          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.8),
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.asset('assets/images/started.jpg',  fit: BoxFit.cover,
                height: double.infinity,
//                width: double.infinity,
                  alignment: Alignment.center,
                  colorBlendMode: BlendMode.softLight,),
              ),
            ),
          ),
          Positioned(
            bottom: 0,top: 0, right: 0,left: 0,
            child: Container(height: height, decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.4),
                  AppColor.verylightPrimary.withOpacity(0.9),
                  AppColor.verylightPrimary,
                ],
              ),
            ),
            ),

          ),
          Positioned(
            child: Container(height: height, decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.2),
                  AppColor.verylightPrimary.withOpacity(0.8),
                  AppColor.verylightPrimary,
                ],
              ),
            ),),

          ),
          Positioned(
            child: Container(height: height, decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.4),
                  AppColor.verylightPrimary.withOpacity(0.7),
                  AppColor.verylightPrimary,
                ],
              ),
            ),),

          ),
          Positioned(
            child: Container(height: height, decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.5),
                  AppColor.verylightPrimary,
                ],
              ),
            ),),
          ),
          Positioned(
            child: Container(height: height, decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.0),
                  AppColor.verylightPrimary.withOpacity(0.3),
                  AppColor.verylightPrimary,
                ],
              ),
            ),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeAnimation(
                0.1, Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Image.asset('assets/images/logowithguru.PNG',width: 200,),
                ),
              ),
              FadeAnimation(
                0.2, Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Column(children: <Widget>[
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          height:height*0.1 ,
                          width: width*0.7,
                          child: RaisedButton(
                              elevation: 0.0,
                              color: AppColor.colorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(height*0.1),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                                );
                              },
                              child: Text("Sign up",
                                  style: new TextStyle(
                                      fontSize: 30.0, color: Colors.white))),
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 15),
                        height: height*0.1,
                        width: width*0.7,
                        child: RaisedButton(
                            elevation: 0.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(height*0.1),
                                side:
                                BorderSide(color: AppColor.colorPrimary, width: 3.0)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text("Log in",
                                style:
                                new TextStyle(fontSize: 30.0, color: Colors.black))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 15.0),
                                children: <TextSpan>[
                                  TextSpan(text: "Ready to ride? "),
                                  TextSpan(
                                      text: "Open the user app",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //what to do
                                        })
                                ]),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 120, right: 20.0),
                              child: Container(color: Colors.black, height: 0.8, width: 128))
                        ],
                      ),
                    ),
                  ],),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}


