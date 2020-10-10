
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Utils.dart';

class User extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<User> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FlatButton(
        child: Text("send Text"),
        onPressed: _addMessage,
      ),
    );
  }

  Firestore firestore;

  initialize() async{
  getFirestoreInstance().then((value){
    firestore = value;
  });
}

  CollectionReference get messages => firestore.collection('messages');

  Future<void> _addMessage() async {
    await messages.add(<String, dynamic>{
      'message': 'Hello world!',
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
