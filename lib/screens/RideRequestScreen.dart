import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiver/async.dart';
import 'package:t_teet_rider/models/RideRequest.dart';
import 'package:t_teet_rider/screens/InvoicePage.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';
import 'package:t_teet_rider/utils/Utils.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';

class RideRequestScreen extends StatefulWidget {
  String id;

  RideRequestScreen(this.id);

  @override
  _RideRequestScreenState createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(27.6667, 85.3500),
    zoom: 14.4746,
  );
  var rideRequest = RideRequest();
  int _start = 60;
  int _current = 10;
  int _currentIndex = 1;

  List<GroupModel> _group = [
    GroupModel(
      text: "Customer is not ready to go",
      index: 1,
    ),
    GroupModel(
      text: "I waited for  too long",
      index: 2,
    ),
    GroupModel(
      text: "I accepted wrong request",
      index: 3,
    ),
  ];

  showCancelAlertDialog(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width / 24),
      ),
      backgroundColor: Colors.grey[200],
      title: Column(
        children: <Widget>[
          Text(
            "Do you really want to cancel?",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            "Let us know to help us improve.",
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: width / 2,
              height: height / 2.5,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(8.0),
                      children: _group
                          .map((item) => RadioListTile(
                        activeColor: Colors.black,
                        groupValue: _currentIndex,
                        title: Text("${item.text}"),
                        value: item.index,
                        onChanged: (val) {
                          setState(() {
                            _currentIndex = val;
                          });
                        },
                      ))
                          .toList(),
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: height / 20,
                          width: width * 0.5,
                          child: RaisedButton(
                            child: Text(
                              "Cancel my ride",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: AppColor.colorPrimary,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(height * 0.1),
                            ),
                          ),
                        ),
                        SizedBox(height: height / 50),
                        Container(
                          height: height / 20,
                          width: width * 0.5,
                          child: RaisedButton(
                            child: Text(
                              "Decline",
                              style: TextStyle(
                                color: AppColor.colorPrimary,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(height * 0.1),
                                side: BorderSide(
                                    color: AppColor.colorPrimary, width: 3.0)),
                          ),
                        )
                      ]),
                ],
              ),
            );
          }),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  @override
  void initState() {
    getData();
    startTimer();
    super.initState();
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          initialCameraPosition: initialLocation,
        ),

        //Below is the code for BottomModalSheet
        Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: Column(children: <Widget>[
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: height * 0.50,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.0),
                                topRight: Radius.circular(24.0))),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.04, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: new BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                alignment: Alignment.center,
                                                image: NetworkImage(
                                                    Constants.PLACEHOLDER),
                                                fit: BoxFit.fill)),
                                      )),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${rideRequest.name}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              )
                                              //as the rating
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("$_current",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            Text("sec",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16))
                                          ]),
                                    ),
                                    width: 80,
                                    height: 80,
                                    decoration: new BoxDecoration(
                                      color: AppColor.colorPrimary,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.radio_button_unchecked,
                                            color: AppColor.colorPrimary,
                                          ),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                          GreenDots(),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                          GreenDots(),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                          GreenDots(),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                          GreenDots(),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                          Icon(
                                            Icons.location_on,
                                            color: AppColor.colorPrimary,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width * 0.01),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Pickup Location",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              "${rideRequest.fromcity}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: height * 0.09,
                                            ),
                                            Text(
                                              "Dropoff Location",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              "${rideRequest.tocity}",
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "Travel Distance",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "${rideRequest.distance}",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          SizedBox(
                                            height: height * 0.09,
                                          ),
                                          Text(
                                            "Rider Distance",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "${rideRequest.distance}",
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
//                            Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              mainAxisAlignment: MainAxisAlignment.spaceAround,
//                              children: <Widget>[
//                                Icon(
//                                  Icons.radio_button_unchecked,
//                                  color: AppColor.colorPrimary,
//                                ),
//                                Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text("Pickup Location"),
//                                    Text("${rideRequest.fromcity}")
//                                  ],
//                                ),
//                                Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text("Travel Distance"),
//                                    Text("${rideRequest.distance}")
//                                  ],
//                                ),
//                              ],
//                            ),
//                            SizedBox(
//                              height: height * 0.02,
//                            ),
//                            Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              mainAxisAlignment: MainAxisAlignment.spaceAround,
//                              children: <Widget>[
//                                Icon(
//                                  Icons.location_on,
//                                  color: AppColor.colorPrimary,
//                                ),
//                                Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text("Dropoff Location"),
//                                    Text("${rideRequest.tocity}")
//                                  ],
//                                ),
//                                Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text("Rider Distance"),
//                                    Text("${rideRequest.distance}")
//                                  ],
//                                ),
//                              ],
//                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 1.0,
                                width: width * 0.95,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "Payment : ${rideRequest.paymentType}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Nrs. ${rideRequest.basefare + (rideRequest.fare * (rideRequest.distance))}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: height / 15.5,
                                  width: width / 2.5,
                                  child: RaisedButton(
                                      elevation: 0.0,
                                      color: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(height * 0.1),
                                      ),
                                      onPressed: () {
                                        showCancelAlertDialog(context);
                                      },
                                      child: Text("Reject",
                                          style: new TextStyle(
                                              color: Colors.white))),
                                ),
                                Container(
                                  height: height / 15.5,
                                  width: width / 2.5,
                                  child: RaisedButton(
                                      elevation: 0.0,
                                      color: AppColor.colorPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(height * 0.1),
                                      ),
                                      onPressed: () {
                                        acceptUserRequest(rideRequest.userToken,
                                            rideRequest.id);
//                                        Navigator.pop(context);
                                        showArrivedDialog(rideRequest, context);
                                      },
                                      child: Text("Accept",
                                          style: new TextStyle(
                                              color: Colors.white))),
                                ) 
                              ],
                            )
                          ],
                        ),
                      ))
                ]),
              ),
            )
          ],
        ),
      ]),
    );
  }

  void getData() {
    Firestore.instance
        .collection('transactions')
        .document("${widget.id}")
        .get()
        .then((value) {
      setState(() {
        rideRequest = RideRequest.fromJson(value.data);
      });
    });
  }

  void showArrivedDialog(RideRequest rideRequest, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return Padding(
          padding: EdgeInsets.only(top: height * 0.55),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                child: Column(children: <Widget>[
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: width,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.04, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: new BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                alignment: Alignment.center,
                                                image: NetworkImage(
                                                    Constants.PLACEHOLDER),
                                                fit: BoxFit.fill)),
                                      )),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${rideRequest.name}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              )
                                              //as the rating
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.04, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.radio_button_unchecked,
                                    color: AppColor.colorPrimary,
                                  ),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  Icon(
                                    Icons.location_on,
                                    color: AppColor.colorPrimary,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            SizedBox(
                              width: width * 0.08,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.04),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Pickup Location",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "${rideRequest.fromcity}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: height / 15.5,
                                  width: width / 2.5,
                                  child: RaisedButton(
                                      elevation: 0.0,
                                      color: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(height * 0.1),
                                      ),
                                      onPressed: () {
                                        showCancelAlertDialog(context);
                                      },
                                      child: Text("Cancel Request",
                                          style: new TextStyle(
                                              color: Colors.white))),
                                ),
                                Container(
                                  height: height / 15.5,
                                  width: width / 2.5,
                                  child: RaisedButton(
                                      elevation: 0.0,
                                      color: AppColor.colorPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(height * 0.1),
                                      ),
                                      onPressed: () {
//                                        Navigator.pop(context);
                                        showPickupDialog(rideRequest, context);
                                      },
                                      child: Text("Arrived",
                                          style: new TextStyle(
                                              color: Colors.white))),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                ]),
              ),
            ),
          ),
        );
        ;
      },
    );
  }

  void showPickupDialog(RideRequest rideRequest, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return Padding(
          padding: EdgeInsets.only(top: height*0.55),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                child: Column(children: <Widget>[
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: width,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.04, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: new BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    alignment: Alignment.center,
                                                    image: NetworkImage(
                                                        Constants.PLACEHOLDER),
                                                    fit: BoxFit.fill)),
                                          )),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${rideRequest.name}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              )
                                              //as the rating
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.04, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.radio_button_unchecked,
                                    color: AppColor.colorPrimary,
                                  ),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  Icon(
                                    Icons.location_on,
                                    color: AppColor.colorPrimary,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.04),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Dropoff Location",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "${rideRequest.tocity}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: height / 15.5,
                                  width: width / 2.5,
                                  child: RaisedButton(
                                      elevation: 0.0,
                                      color: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(height * 0.1),
                                      ),
                                      onPressed: () {
                                        showCancelAlertDialog(context);
                                      },
                                      child: Text("Cancel request",
                                          style: new TextStyle(
                                              color: Colors.white))),
                                ),
                                Container(
                                  height: height / 15.5,
                                  width: width / 2.5,
                                  child: RaisedButton(
                                      elevation: 0.0,
                                      color: AppColor.colorPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(height * 0.1),
                                      ),
                                      onPressed: () {
//                                        Navigator.pop(context);
                                        arrivedRequest(rideRequest.userToken,
                                            rideRequest.id);
                                        showDropDialog(rideRequest, context);
                                      },
                                      child: Text("Pick Up",
                                          style: new TextStyle(
                                              color: Colors.white))),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                ]),
              ),
            ),
          ),
        );
        ;
      },
    );
  }




  void showDropDialog(RideRequest rideRequest, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return Padding(
          padding:  EdgeInsets.only(top: height*0.55),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Dialog(
              backgroundColor: Colors.grey[200],
              insetPadding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                child: Column(children: <Widget>[
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(

                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.0),
                                topRight: Radius.circular(24.0))),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.04, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: new BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    alignment: Alignment.center,
                                                    image: NetworkImage(
                                                        Constants.PLACEHOLDER),
                                                    fit: BoxFit.fill)),
                                          )),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${rideRequest.name}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              )
                                              //as the rating
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.04, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.radio_button_unchecked,
                                    color: AppColor.colorPrimary,
                                  ),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  GreenDots(),
                                  Icon(
                                    Icons.location_on,
                                    color: AppColor.colorPrimary,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.04),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Dropoff Location",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "${rideRequest.tocity}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: height * 0.08,
                                  width: width * 0.7,
                                  child: RaisedButton(
                                      elevation: 0.0,
                                      color: AppColor.colorPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(height * 0.1),
                                      ),
                                      onPressed: () {
                                        dropRequest(rideRequest.userToken,
                                            rideRequest.id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InvoicePage(rideRequest)),
                                        );
                                      },
                                      child: Text("Drop",
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 30.0))),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                ]),
              ),
            ),
          ),
        );
      },
    );
  }



}

class GroupModel {
  String text;
  int index;

  GroupModel({this.text, this.index});
}
