import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Utils.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/toastManager.dart';

class TermsOfService extends StatefulWidget {
  @override
  _TermsOfService createState() => _TermsOfService();
}

class _TermsOfService extends State<TermsOfService> {
  bool initial = false;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: AppColor.verylightPrimary),
                  child: FadeAnimation(
                    0.1, Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top:24),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.blue[700]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.5),
                                child: Text(
                                  "Before you can proceed you must read and agree to t-teet Terms of Services",
                                  style: TextStyle(fontSize: 9.0, color: Colors.white,fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(20,24,20,20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "t-teet Terms Of Services",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text(
                              "Last Updated: July 25,2020",
                              style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  "The quick brown fox jumps over the lazy dog The quick"
                                      "brown fox jumps over the lazy dog The quick brown fox jumps over the lazy "
                                      "dog The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog The quick"
                                      "brown fox jumps over the lazy dog The quick brown fox jumps over the lazy "
                                      "dog The quick jumps over the lazy dog",style: textStyle,
                                textAlign: TextAlign.justify,),
                              SizedBox(
                                height: 18
                              ),
                              Text("1. Heading one",style: textStyleTitle,),
                              SizedBox(height: 3,),
                              Text(
                                  "The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog The"
                                      "quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog",style: subTextStyle,),
                              SizedBox(height: 18),
                              Text("2. Heading two",style: textStyleTitle),
                              SizedBox(height: 3,),
                              Text(
                                  "The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy "
                                      "dog The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog",style: subTextStyle),
                              SizedBox(height: 18),
                              Text("3. Heading Three",style: textStyleTitle),
                              SizedBox(height: 3,),
                              Text(
                                  "The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog The "
                                      "quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog",style: subTextStyle),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              FadeAnimation(
                0.2, Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Transform.scale( scale: 1.3,
                          child: Checkbox(
                            value: initial,
                            onChanged: (bool value) {
                              print(value);
                              setState(() {
                                initial = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          "I agree to the t-teet Terms of services",
                          style: TextStyle(color: Colors.blue[700],fontSize: 12),
                        ),
                        SizedBox(width: 10,)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: height * 0.08,
                    width: width * 0.6,
                    child: NextButton(text:'I agree',onPressed:() async{
                      print("click agree checkbox");
                      bool connection = await networkStatus();
                      if(connection) {
                        if (initial) {
                          _addRider();
                        }else {
                          ToastManager().fromValidation(context,'Please, agree terms of services');
                        }
                      } else {
                        ToastManager().fromValidationError(context,'Please, check your network connection');
                      }

                    }),
                  ),
                  SizedBox(height: 35,),
                ],
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
  final textStyle = TextStyle(fontSize: 12,color: Colors.black54);
  final subTextStyle = TextStyle(fontSize: 12, color: Colors.black54);
  final textStyleTitle = TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black54);
  Firestore firestore;

  initialize() async {
    getFirestoreInstance().then((value) {
      firestore = value;
    });
  }

  Future<void> _addRider() async {

      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              content: Wait(txt:'please wait...'),
            );
          });

    var manager = StorageManager();
    var user = await manager.getUser();

    print(user.name);
    await firestore.collection("riders").document("${user.phone}").setData({
      "name": user.name,
      "phone": user.phone,
      "gender": user.gender,
      "email": user.email,

      "city": user.city,
      "licensePhoto": user.licensePhoto,
      "blueBookFrontPhoto": user.blueBookFrontPhoto,
      "blueBookBackPhoto": user.blueBookBackPhoto,
      "publicOrPrivate": user.publicOrPrivate,
      "licenseNumber": user.licenseNumber,
      "licenseExpiryDate": user.licenseExpiryDate,
      "vehicleName": user.vehicleName,
      "vehicleNumber": user.vehicleNumber,
    "vehicleModel": user.vehicleModel,
    "vehicleYear": user.vehicleYear,
    "vehicleDoor": user.vehicleDoor,




    }).then((value) {
      Navigator.of(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}


