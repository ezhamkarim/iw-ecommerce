import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_flutter/sign_in.dart';


class CrudMethods {
  

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    Firestore.instance.collection(collection).add(data);
    print('hello');
  }

  updateData(String selectedDoc , Map<String,dynamic> newValues, String collection) {
    Firestore.instance.collection(collection).document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });

  }
 

  deleteData(docID, String collection){
    Firestore.instance.collection(collection).document(docID).delete().catchError((e) {

      print(e);
    });
  }

 
}
