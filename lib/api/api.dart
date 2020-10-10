import 'dart:io';

import 'package:t_teet_rider/api/model/profileModel.dart';
import 'package:t_teet_rider/api/notifier/profileNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

getFoods() async {
  print('hello world');
  QuerySnapshot snapshot = await Firestore.instance
      .collection('users')
      .orderBy("+9779808603897", descending: true)
      .getDocuments();

  List<Food> _foodList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    print(document.data);
    print('********************************************');
    _foodList.add(food);

  });

//  foodNotifier.foodList = _foodList;
}
