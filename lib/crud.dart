import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

 
class CrudMethods {
  
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    final docRef = await Firestore.instance.collection(collection).add(data);
    print('hello');

    print(docRef.documentID);
    
  }

  getData() async{
    return await Firestore.instance.collection('product').snapshots();
  }

  updateData(selectedDoc , newValues){
    Firestore.instance.collection('product').document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });

  }
}
