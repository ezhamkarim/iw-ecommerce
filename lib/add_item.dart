import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'crud.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'sign_in.dart';

class MyItemAdd extends StatefulWidget {
  @override
  _MyItemAddState createState() => _MyItemAddState();
}

class _MyItemAddState extends State<MyItemAdd> {
  File _image;
  String name;
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
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    final ref = FirebaseStorage.instance.ref().child(fileName);

    photoUrl = await ref.getDownloadURL();
    print('HIIIII NOTICE ME' + photoUrl);
  }

  CrudMethods crudObj = CrudMethods();
  // final String url;
  final textInputName = TextEditingController();
  final textInputPrice = TextEditingController();
  final textInputDescription = TextEditingController();

  @override
  void dispose() {
    textInputName.dispose();
    textInputPrice.dispose();
    textInputDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Container(
            // To align the text to the center of the appbar

            child: Text(
              // Text with Home Food and white colored font
              'Home Food',
              style: TextStyle(color: Colors.white, fontFamily: 'LiterataBook'),
            ),
          ),
          backgroundColor: Colors.teal),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Add new item to your product listings'),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: textInputName,
                        //TODO implemention to get the data from the text field
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            minLines: 4,
                            maxLines: 4,
                            controller: textInputDescription,
                            textAlign: TextAlign
                                .start, //TODO implemention to get the data from the text field
                            decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide())))),
                    Container(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            controller: textInputPrice,
                            keyboardType: TextInputType.number,
                            //TODO implemention to get the data from the text field
                            decoration: InputDecoration(
                                labelText: 'Price',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide())))),
                    GestureDetector(
                      onTap: () {
                        print('Container Tapped');
                        getImage();
                      }, // TODO input image function & replace image
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 50.0),
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
                      margin: const EdgeInsets.only(top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          double price = double.parse(textInputPrice.text);

                          Map<String, dynamic> productData = {
                            'name': textInputName.text,
                            'description': textInputDescription.text,
                            'price': price,
                            'sellerId': userID,
                            'sellerName': userName,
                            'photoUrl': photoUrl
                          };

                          crudObj
                              .addData('product', productData)
                              .then((result) {
                            dialogTrigger(context, textInputName.text);
                          });
                          /* Firestore.instance.collection('product').add(map).catchError(() {
                            print('Fattah Amien kacak <3');
                          }); */
                        },
                        color: Colors.blue,
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
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

Future<bool> dialogTrigger(BuildContext context, String title) async {
  /* information(BuildContext context, String title) */ {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff009688),
          title: Text(
            title + ' is Added',
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
