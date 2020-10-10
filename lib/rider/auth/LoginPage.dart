import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Utils.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:quiver/async.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';
import 'package:t_teet_rider/utils/keyboardStatus.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/toastManager.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  String phoneNo, verificationId, otpCode;
  final formKey = new GlobalKey<FormState>();
  bool codeSent = false;

  @override
  void initState() {
    initialize();

    super.initState();
  }
  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0.0,
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBarBack(txt:'Back',onPressed: (){
                Navigator.of(context).pop();
              },),
            ],
          )
        ),
        backgroundColor: Colors.white,
      ),
      body: codeSent ?FadeAnimation(0.2, codeUI(width, height)):FadeAnimation(0.2,loginUI(height, width, context)),
    );
  }

  Container loginUI(double height, double width, BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: width * 0.065),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "What's your number?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "We'll text a code to verify your phone",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            Stack(children: <Widget>[
              Center(
                child: Container(
                  height: 48,
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[200],
                        width: 0.6,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        padding: EdgeInsets.only(left: 9),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/nepal_flag.png',
                              height: 22,
                              fit: BoxFit.cover,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 0.6,
                        color: Colors.grey[200],
                      ),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  '+977',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      letterSpacing: 0.4),
                                ),
                                Expanded(
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: new TextField(
                                            controller: _phoneController,
                                            decoration: new InputDecoration(
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                                borderSide: BorderSide(
                                                    width: 0.0,
                                                    color: Colors.transparent),
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                letterSpacing: 0.4),
                                            keyboardType: TextInputType.number,
                                            onChanged: (_phoneController) {
                                              print('--------------------');
//                                              sendCode();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.1,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: Text("We will send a code to " + _phoneController.text,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w300)),
            ),
            KeyboardStatus(minHeight: height * 0.13, maxHeight :height * 0.35,),
            Center(
              child: Container(
                height: height * 0.07,
                width: width * 0.7,
                child: VerifyButton(text:'Send Code',onPressed: sendCode),
              ),
            ),
          ],
        ),
      ),
    );
  }
  sendCode()async {

    final phone = _phoneController.text.trim();
    phoneNo = "+977$phone";
    if(phone.length == 10) {
      bool connection = await networkStatus();
      if(connection) {
        showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                content: Wait(txt:'please wait...'),
              );
            });
        _checkUser("+977$phone").then((value) {
          Navigator.pop(context);
          if (value) {
            print("true");
            loginUser(phoneNo, context);
            setState(() {
              codeSent = true;
            });
            startTimer();
          } else {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text("There is no user. Please SignUp"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        textColor: Colors.white,
                        color: AppColor.colorPrimary,
                        onPressed: () {},
                      )
                    ],
                  );
                });
          }
        });
      }
      else {
        ToastManager().fromValidationError(context,'please, check your internet connection');
      }
    }
    else {
      ToastManager().fromValidationError(context,'please, insert valid 10 digit');
    }
  }
  Container codeUI(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: width * 0.065),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter the code",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Sent to ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                           '+977 ' +_phoneController.text,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
              Padding(
              padding: EdgeInsets.only(right: width*0.06),
          child: Row(
            children: [
              Text("$_current", style: TextStyle(fontSize: 15)),
              SizedBox(width: 4,),
              Text('sec',style: TextStyle(fontSize: 14))
            ],
          )),

                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: OTPTextField(
                  length: 6,
                  width: width * 0.65,
                  fieldWidth: width * 0.08,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceBetween,
                  onCompleted: (value) {
                    otpCode = value;
                    print(otpCode);
                  },
                  onChanged: (value) {
                    otpCode = value;
                    print(otpCode);
                  },
                  fieldStyle: FieldStyle.underline),
            ),
            KeyboardStatus(minHeight: height * 0.195, maxHeight :height * 0.41,),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                "I didn't receive any code. ",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: sendCode,
                child: Text("Send it again",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ),
            ]),
           SizedBox(height: 15,),
            Center(
              child: Container(
                height: height * 0.07,
                width: width * 0.7,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: AppColor.colorPrimary,
                    child: Text('Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        )),
                    onPressed: () {
//                      print("phone $phoneNo");
                      print(otpCode);
                      if(otpCode != null && otpCode.length == 6) {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: true, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Wait(txt:'Please wait...'),
                              );
                            });
                        loginUser(phoneNo, context);
                      }
                       else {
                        ToastManager().fromValidationError(context,'Please, insert valid 6 digit');
                      }

                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
  int _start = 60;
  int _current = 60;


  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;
          Navigator.pop(context);
          if (user != null) {
            redirectToHome(phone, context);
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          final code = otpCode;
          AuthCredential credential = PhoneAuthProvider.getCredential(
              verificationId: verificationId, smsCode: code);

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;
          print("${user.displayName}");
          print("${user.email}");
          print("${user.phoneNumber}");
          user.getIdToken().then((value) {
            print("${value.token}");
            print("${value.expirationTime}");
          });
          print("${user.isAnonymous}");
          if (user != null) {
            redirectToHome(phone, context);
          } else {
            print("Error");
          }
        },
        codeAutoRetrievalTimeout: null);
  }

  void redirectToHome(String phone, BuildContext context) {
    StorageManager().setLogin(true);
    StorageManager().setPhoneNumber(phone).then((value) => {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen()))
    });
  }

  Firestore firestore;

  initialize() async {
    getFirestoreInstance().then((value) {
      firestore = value;
    });
  }

  Future<bool> _checkUser(String phone) async {
    var snapshot = await firestore.collection('riders').document(phone).get();

    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}


