import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class CrudMethods {
  

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    final docRef = await Firestore.instance.collection(collection).add(data);
    print('hello');

    
    
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
