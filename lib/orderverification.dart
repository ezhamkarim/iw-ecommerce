import 'package:flutter/material.dart';
import 'package:sign_in_flutter/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class MyOrderVerification extends StatefulWidget {
  String productName;
  String sellerId;
  String sellerName;
  int quantity;
  double price;
  String productImage;
  String documentID;

  MyOrderVerification(this.productName, this.sellerId,this.sellerName, this.quantity,
      this.price, this.productImage, this.documentID);

  @override
  _MyOrderVerificationState createState() => _MyOrderVerificationState(
      productName, sellerId, sellerName, quantity, price, productImage, documentID);
}

class _MyOrderVerificationState extends State<MyOrderVerification> {
  

String _productName;
String _sellerId;
  String _sellerName;
  int _quantity;
  double _price;
  String _productImage;
  String _documentID;

_MyOrderVerificationState(this._productName,this._sellerId,this._sellerName,this._quantity,this._price,this._productImage,this._documentID);
CrudMethods crudObj = CrudMethods();

  
  File _image;
  String photoUrl;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $image');
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        firebaseStorageRef.putFile(_image); //TODO Progress bar
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    final ref = FirebaseStorage.instance.ref().child(fileName);

    photoUrl = await ref.getDownloadURL();
    print('HIIIII NOTICE ME' + photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Food', style: TextStyle(fontFamily: 'LiterataBook')),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text('Please provide payment proof '),
              Container(
                padding: EdgeInsets.all(4.0),
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(_sellerName),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Container clicked");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          leading: Image.network(
                            _productImage,
                            
                          ),
                          title: Text(
                            _productName,
                            style: TextStyle(
                              fontFamily: 'LiterataBook',
                            ),
                          ),
                          subtitle: Text('RM' + _price.toStringAsFixed(2),
                              style: TextStyle(
                                fontFamily: 'LiterataBook',
                              )),
                          trailing: Text(
                              'Quantity: ' + _quantity.toString(),
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.all(
                  Radius.circular(15)
                )
              ),
              height: 200,
              
              child: StreamBuilder(
                stream: Firestore.instance.collection('users').document(_sellerId).snapshots(),
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Payment Instructions'),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Container(
                          height: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Seller bank '+snapshot.data['bank'],style: TextStyle(color: Colors.white),),
                                  
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Seller location '+snapshot.data['location'] ,style: TextStyle(color: Colors.white),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Seller bank number '+snapshot.data['bankNumber'],style: TextStyle(color: Colors.white),),
                                  
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Seller phone no '+snapshot.data['noPhone'],style: TextStyle(color: Colors.white),),
                                  
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print('Container Tapped');
              getImage();
            },
            child: Container(
              margin: EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                child: (_image != null)
                    ? Image.file(_image, fit: BoxFit.fill)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.file_upload),
                          Text("Upload photo"),
                        ],
                      ),
              ),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                uploadPic(context);
                confirmImageDialog(context);
              },
              color: Colors.teal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Confirm Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: RaisedButton(
                padding: const EdgeInsets.all(8.0),
                onPressed: () {
                  // TODO update order to dtabase
                  Map<String, dynamic> paymentImageData = {
                    'productPaymentProof': photoUrl
                  };

                  crudObj.updateData(
                      _documentID, paymentImageData, 'orders');
                  dialogTrigger(context, 'Payment has Uploaded');
                },
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('Confirm'),
              ),
            ),
          )
        ],
      ),
    );
  }

  dialogTrigger(BuildContext context, String title) {
    /* information(BuildContext context, String title) */ {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff009688),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}

Future<bool> confirmImageDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xff009688),
        title: Text(
          'Image is Added !',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
