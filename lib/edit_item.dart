import 'package:flutter/services.dart';

import 'my_listings.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'crud.dart';

class MyItemEdit extends StatefulWidget {
  String productID;
  String title;
  String description;
  double price;
  String fotoUrl;
  MyItemEdit(
      this.productID, this.title, this.description, this.price, this.fotoUrl);

  @override
  _MyItemEditState createState() =>
      _MyItemEditState(productID, title, description, price, fotoUrl);
}

class _MyItemEditState extends State<MyItemEdit> {
  String _productID;
  String _title;
  String _description;
  double _price;
  String _fotoUrl;
  _MyItemEditState(this._productID, this._title, this._description, this._price,
      this._fotoUrl);

  File _image;

  String photoUrl;

  Dialogs dialogs = new Dialogs();

  Map<String, dynamic> newValue;

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

  CrudMethods crudObj = CrudMethods();

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
    print('HAIIIIIIIIIIIIIIIIIIIIIIII' + _productID);
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
                child: Text('Edit Item'),
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
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15)
                            ],

                            //TODO implemention to get the data from the text field
                            decoration: InputDecoration(
                                labelText: 'Product Name',
                                hintText: _title,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide())))),
                    Container(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            controller: textInputDescription,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            textCapitalization: TextCapitalization.sentences,
                            minLines: 1,
                            maxLines: 2,
                            textAlign: TextAlign
                                .start, 
                            //TODO implemention to get the data from the text field
                            decoration: InputDecoration(
                                labelText: 'Short description',
                                hintText: _description,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide())))),
                    Container(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            controller: textInputPrice,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3)
                            ],
                            //TODO implemention to get the data from the text field
                            decoration: InputDecoration(
                                labelText: 'Price',
                                
                                hintText: _price.toString(),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide())))),
                    GestureDetector(
                      onTap: () {
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
                              : Image.network(_fotoUrl)
                        ),
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: () {
                          uploadPic(context);
                          dialogs.confirmImageDialog(context);
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
                          if(textInputDescription.text==''||textInputName.text==''||textInputPrice.text==''||photoUrl==null){
                            dialogInputInvalid(context);
                            return;
                          }
                          double price = double.parse(textInputPrice.text);

                          newValue = {
                            'name': textInputName.text,
                            'description': textInputDescription.text,
                            'price': price,
                            'photoUrl': photoUrl
                          };
                          print('TESTT1');
                          crudObj.updateData(_productID, newValue, 'product');
                          print('TESTT2');
                          dialogs.information(context, textInputName.text);
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

  dialogInputInvalid(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xffB92D00),
            title: Text(
              'Input is Invalid!',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
            
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }
}

class Dialogs {
  confirmImageDialog(BuildContext context) {
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

  information(BuildContext context, String title) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff009688),
            title: Text(
              title + 'updated',
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
        });
  }
}
