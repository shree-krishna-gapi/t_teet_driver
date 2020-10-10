import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:t_teet_rider/screens/NamePage.dart';
import 'package:t_teet_rider/utils/Colors.dart';

class OtpVerify extends StatefulWidget {
  final String phone;
  const OtpVerify({
    Key key,
    @required this.phone
  }) : super(key: key);

  @override
  _OtpVerifyState createState() => new _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> with SingleTickerProviderStateMixin {
  // Constants
  final int time = 120;
  AnimationController _controller;
  Size _screenSize;

  TextEditingController verificationNumber = TextEditingController();

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;
  get _getTimerText {
    return Container(
      height: 32,
      child: new Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            OtpTimer(_controller, 18.0, Colors.black,FontWeight.w300),
            new SizedBox(
              width: 4.0,
            ),
            Text('sec',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,
                letterSpacing: 0.2,fontSize: 15),)
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return new InkWell(
      child: new Container(
        height: 32,
        width: 96,
        decoration: BoxDecoration(
            color: AppColor.colorPrimary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(32)),
        alignment: Alignment.center,
        child: new Text(
          "Resend OTP",
          style:
          new TextStyle(fontWeight: FontWeight.w500, color: Colors.white,fontSize: 13,letterSpacing: 0.2),
        ),
      ),
      onTap: () {
        // Resend you OTP via API or anything
      },
    );
  }


  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: Duration(seconds: time))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            _hideResendButton = !_hideResendButton;
          });
        }
      });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0.0,
        title: GestureDetector(
          onTap:(){Navigator.pop(context);},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: new Container(
        width: _screenSize.width,
        padding: new EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter the code",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(
                          "Sent to ",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontSize: 15.5
                            , color: Colors.black,),
                        ),
                        Text(
                          "+977 ${widget.phone}",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontSize: 15.5, color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
                _hideResendButton ? _getTimerText : _getResendButton,
              ],
            ),
            SizedBox(height: 50,),
            Container(
//              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: Flexible(
                child: PinCodeTextField(
                  length: 6,
                  obsecureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: Duration(milliseconds: 300), // Pass
                  controller: verificationNumber,// it here
                  textInputType: 	TextInputType.number,
                  onCompleted: (v) {
                    print("Completed $v");
                    if(v == '') {
                                  Navigator.push(context, MaterialPageRoute(
                builder: (context) => NamePage()
            ));
                    }
                  },
                  onChanged: (value) {
                    print(value);
                  },
                ),
              )
            ),

          ],
        )
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return new Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
                width: 2.0,
                color: Colors.black,
              ))),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 70.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }


}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;
  FontWeight fontWeight = FontWeight.w300;
  OtpTimer(this.controller, this.fontSize, this.timeColor,this.fontWeight);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}