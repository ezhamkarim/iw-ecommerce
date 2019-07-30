import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
class CrudMethods {

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    Firestore.instance.collection(collection).add(data);
    print('hello');

  }
}