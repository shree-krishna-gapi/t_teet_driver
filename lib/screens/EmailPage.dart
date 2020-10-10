import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:t_teet_rider/screens/registerScreen/chooseCity.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/screens/TermsOfServicePage.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';
import 'package:t_teet_rider/utils/keyboardStatus.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarBack(txt:'Back',onPressed: (){
              Navigator.of(context).pop();
            },),
            AppBarSkip(txt:'Skip',onPressed: (){
            },),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: width,
              child: FadeAnimation(
                0.1, Padding(
                  padding: EdgeInsets.only(top: height * 0.05, left:30.0),
                  child: SignUpPageTitle(txt:"What's Your Email Address?"),
                ),
              ),
            ),
            Expanded(
              child: FadeAnimation(
                0.2, Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width * 0.8,
                          padding: EdgeInsets.only(top: height * 0.05),
                          child: TextFormField(
                            autofocus: true,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: "Email Address (Optional)",
                            ),
                          ),
                        ),
                        KeyboardStatus(minHeight: height * 0.1, maxHeight :height * 0.38,),
                        Container(
                          // padding: EdgeInsets.only(top: height * 0.3),
                          child: SizedBox(
                            height: height * 0.08,
                            width: width * 0.6,
                            child: RaisedButton(
                              child: Text(
                                "Next",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              textColor: Colors.white,
                              onPressed: () {
                                StorageManager()
                                    .setEmail(emailController.value.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChooseCity()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(height * 0.1),
                              ),
                              color:  AppColor.colorPrimary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


