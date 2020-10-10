import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:t_teet_rider/models/RideRequest.dart';
import 'package:t_teet_rider/screens/InvoicePage.dart';
import 'package:t_teet_rider/screens/RideRequestScreen.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Utils.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PushNotificationService {
  PushNotificationService._();

  factory PushNotificationService() => _instance;

  static final PushNotificationService _instance = PushNotificationService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  RideRequest rideRequest;

  // TODO: implement initState

  bool _initialized = false;
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

  Future<void> init(BuildContext context) async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          print("tester notification");
          _showNotification(context, message);
//          BottomModalHome();
        },
//        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          Future.delayed(Duration(seconds: 4)); //Allow time to build dashboard
//          showNotificationDetail(context, message);
          _showNotification(context, message);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
//          showNotificationDetail(context, message);
          _showNotification(context, message);
        },
      );
      // For testing purposes print the Firebase Messaging token
      String fcmToken = await _firebaseMessaging.getToken();
      StorageManager().setFCMToken(fcmToken);
      print("FirebaseMessaging token: $fcmToken");

      _initialized = true;

//      await FCMRepository().registerForNotifications(fcmToken);
    }
  }

  deinit(String fcmToken, String authToken, String idToken) async {
    if (_firebaseMessaging != null) {
      //although null check might not be needed, but added just to be safe
      await _firebaseMessaging.deleteInstanceID();
    }
    _initialized = false;

//    FCMRepository().unRegisterFromNotifications(fcmToken, authToken, idToken);

    print('Firebase deinit');
  }

  showNotificationDetail(BuildContext context, Map<String, dynamic> message) {
    var aps = message['aps'];
    var alert = aps['alert'];
    String title = alert['title'];
    String body = alert['body'];
    String notificationId = message['messageId'];

//    NotificationRepository().markNotificaions(notificationId);

    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
              onPressed: () =>
                  Navigator.of(buildContext, rootNavigator: true).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: AppColor.colorPrimary),
              ),
            )
          ],
        );
      },
    );
  }

  showCancelAlertDialog(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width / 24),
      ),
      backgroundColor: Colors.transparent,
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

  showNotificationDetailForeground(
      BuildContext context, Map<String, dynamic> message) {
    var alert = message['notification'];
    String title = alert['title'];
    String body = alert['body'];
    String notificationId = message['messageId'];
    var data = message['data'];

    var id = data['id'];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RideRequestScreen(id)),
    );

//    getRequest("$id", context);

//    var height = MediaQuery.of(context).size.height;
//    var width = MediaQuery.of(context).size.width;
  }

  Future<void> _showNotification(
      BuildContext context, Map<String, dynamic> message) async {
    var alert = message['notification'];
    var id = message['id'];
    String title = alert['title'];
    String body = alert['body'];
//    String notificationId = message['messageId'];

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification:
            showNotificationDetailForeground(context, message));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max,
        playSound: true,
        priority: Priority.High,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page

    showDialog(
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {},
          )
        ],
      ),
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    print("from background");

    // Or do other work.
  }

  void getRequest(String id, BuildContext context) async {
    Firestore.instance
        .collection('transactions')
        .document(id)
        .get()
        .then((value) {
      rideRequest = RideRequest.fromJson(value.data);
      showDialogs(rideRequest, context);
    });
  }

  void showDialogs(RideRequest rideRequest, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
//    NotificationRepository().markNotificaions(notificationId);

    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return Padding(
          padding: const EdgeInsets.only(top: 419.75),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
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
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: new BoxDecoration(
                                    color: AppColor.colorPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Icon(
                                  Icons.radio_button_unchecked,
                                  color: AppColor.colorPrimary,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Pickup Location"),
                                    Text("${rideRequest.fromcity}")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Travel Distance"),
                                    Text("${rideRequest.distance}")
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: AppColor.colorPrimary,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Dropoff Location"),
                                    Text("${rideRequest.tocity}")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Rider Distance"),
                                    Text("${rideRequest.distance}")
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 1.0,
                                width: width * 0.95,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "${rideRequest.paymentType}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Nrs. ${rideRequest.basefare + (rideRequest.fare * rideRequest.distance)}",
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
                                        Navigator.pop(context);
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
                                        Navigator.pop(context);
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
            ),
          ),
        );
      },
    );
  }

  void showArrivedDialog(RideRequest rideRequest, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return Padding(
          padding: const EdgeInsets.only(top: 419.75),
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
                        height: height / 1.5,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: width * 0.08),
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
                                SizedBox(width: width * 0.08),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "name",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: width / 5,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: width * 0.08,
                                ),
                                Icon(
                                  Icons.radio_button_unchecked,
                                  color: AppColor.colorPrimary,
                                ),
                                Text(
                                  "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
                                  style: TextStyle(
                                      color: AppColor.colorPrimary,
                                      fontSize: 18),
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: AppColor.colorPrimary,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: width * 0.08,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Pickup Location",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${rideRequest.fromcity}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.08,
                                )
                              ],
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
                                        Navigator.pop(context);
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
          padding: const EdgeInsets.only(top: 350.75),
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
                        height: height / 2.5,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: width * 0.08),
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
                                SizedBox(width: width * 0.08),
                                Column(
                                  children: <Widget>[
                                    SizedBox(width: width * 0.08),
                                    Text(
                                      "${rideRequest.name}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: width / 5,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: width * 0.08,
                                ),
                                Icon(
                                  Icons.radio_button_unchecked,
                                  color: AppColor.colorPrimary,
                                ),
                                Text(
                                  "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
                                  style: TextStyle(
                                      color: AppColor.colorPrimary,
                                      fontSize: 18),
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: AppColor.colorPrimary,
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Dropoff Location",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${rideRequest.tocity}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.08,
                                )
                              ],
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
                                        Navigator.pop(context);
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
          padding: const EdgeInsets.only(top: 300.75),
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
                        height: height * 0.35,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
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
                                Container(
                                  width: 80,
                                  height: height / 25,
                                  decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: AppColor.colorPrimary,
                                    shape: BoxShape.rectangle,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: width * 0.08,
                                ),
                                Icon(
                                  Icons.radio_button_unchecked,
                                  color: AppColor.colorPrimary,
                                ),
                                Text(
                                  "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
                                  style: TextStyle(
                                      color: AppColor.colorPrimary,
                                      fontSize: 18),
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: AppColor.colorPrimary,
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Dropoff Location",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${rideRequest.tocity}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.08,
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

Firestore firestore;

initialize() async {
  getFirestoreInstance().then((value) {
    firestore = value;
  });
}

getTransactions(String id) async {
  firestore
      .collection('users')
      .snapshots()
      .listen((data) => data.documents.forEach((doc) {
            // requestRider(doc["fcm"]);
            print("name: ${doc["name"]}");
            print("email:${doc["email"]}");
            //  print("fcm: ${doc["fcm"]}");
          }));
}
