


import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;


Future<Firestore> getFirestoreInstance() async{
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: const FirebaseOptions(
      googleAppID: 'com.rider.t_teet_rider',
      gcmSenderID: '991972971500',
      apiKey: 'AIzaSyDNe2hXR89_yf35Smrl90OUq7vEXAK2flY',
      projectID: 't-teet',
    ),
  );
  return Firestore(app: app);
}

Future<FirebaseStorage> getFirebaseStorage() async{
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: const FirebaseOptions(
      googleAppID: '1:79601577497:ios:5f2bcc6ba8cecddd',
      gcmSenderID: '991972971500',
      apiKey: 'AIzaSyBPPiGGXbniI4k4Qr9uz4d_4Z2ZXLzxcH4',
      projectID: 't-teet',
    ),
  );

  final FirebaseStorage storage = FirebaseStorage(
      app: app, storageBucket: 'gs://t-teet.appspot.com');
  return storage;
}



Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
  // Replace with server token from firebase console settings.
  final String serverToken = '<Server-Token>';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  );

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': 'this is a body',
          'title': 'this is a title'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': await firebaseMessaging.getToken(),
      },
    ),
  );

  final Completer<Map<String, dynamic>> completer =
  Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
    },
  );

  return completer.future;
}

Future<Map<String, dynamic>> acceptUserRequest(String fcm,String id) async {
  // Replace with server token from firebase console settings.
  final String serverToken = 'AAAA5vYyU-w:APA91bHFJPRcEr-_jdUmBrzDBTPjTTsVxlK0fo12Mn8_qLyssT90kLC55l_c5KYEJ8Q__dmynLE8dCsSKwA_oQ8RTIpFmZlYaHXRI7_Q108EtyBUMk8CoSaHYlSJ7leKF7UlfZZD2fl5';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  );

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': 'Will arrive in 5 mins',
          'title': 'Rider has accepted your Request'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          'id': id,
          'type': "accepted",
//          'fcm': StorageManager().getFcmToken()
        },
        'to': fcm,
      },
    ),
  );

  final Completer<Map<String, dynamic>> completer =
  Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
    },
  );

  return completer.future;
}
Future<Map<String, dynamic>> arrivedRequest(String fcm,String id) async {
  // Replace with server token from firebase console settings.
  final String serverToken = 'AAAA5vYyU-w:APA91bHFJPRcEr-_jdUmBrzDBTPjTTsVxlK0fo12Mn8_qLyssT90kLC55l_c5KYEJ8Q__dmynLE8dCsSKwA_oQ8RTIpFmZlYaHXRI7_Q108EtyBUMk8CoSaHYlSJ7leKF7UlfZZD2fl5';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  );

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': 'You are on Ride',
          'title': 'Rider has started trip'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          'id': id,
          'type': "arrived",
//          'fcm': StorageManager().getFcmToken()
        },
        'to': fcm,
      },
    ),
  );

  final Completer<Map<String, dynamic>> completer =
  Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
    },
  );

  return completer.future;
}
Future<Map<String, dynamic>> dropRequest(String fcm,String id) async {
  // Replace with server token from firebase console settings.
  final String serverToken = 'AAAA5vYyU-w:APA91bHFJPRcEr-_jdUmBrzDBTPjTTsVxlK0fo12Mn8_qLyssT90kLC55l_c5KYEJ8Q__dmynLE8dCsSKwA_oQ8RTIpFmZlYaHXRI7_Q108EtyBUMk8CoSaHYlSJ7leKF7UlfZZD2fl5';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  );

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': 'Trip has been stopped',
          'title': 'Rider has reached Destination'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          'id': id,
          'type': "drop",
//          'fcm': StorageManager().getFcmToken()
        },
        'to': fcm,
      },
    ),
  );

  final Completer<Map<String, dynamic>> completer =
  Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
    },
  );

  return completer.future;
}
