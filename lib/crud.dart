import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_flutter/sign_in.dart';


class CrudMethods {
  

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    final docRef = await Firestore.instance.collection(collection).add(data);
    print('hello');
  }

  Future<void> addSellerDatatoCart(String collection, Map<String, Map< String, List<Map<String,dynamic>>>> data) async{
    await Firestore.instance.collection(collection).document(userID).setData(data,merge: true);
  }

  addNewProducttoCart(String collection,  Map<String,dynamic> data, String sellerID) {
    Firestore.instance.collection(collection).document(userID).updateData({'cart' : {sellerID : FieldValue.arrayUnion([data])}});


    
  }
  updateQuantity(Map<String, Map< String, List<Map<String,dynamic>>>> data){
    Firestore.instance.collection('users').document(userID).updateData(data).catchError((e){
      print(e);
    });
  }

  updateData(String selectedDoc , Map<String,dynamic> newValues) {
    Firestore.instance.collection('product').document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });

  }

  deleteData(docID){
    Firestore.instance.collection('product').document(docID).delete().catchError((e) {

      print(e);
    });
  }
}
