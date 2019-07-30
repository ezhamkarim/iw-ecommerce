import 'my_listings.dart';
import 'package:flutter/material.dart';

class MyItemEdit extends StatefulWidget {
  @override
  _MyItemEditState createState() => _MyItemEditState();
}

class _MyItemEditState extends State<MyItemEdit> {
  Dialogs dialogs = new Dialogs();
  String name;
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
                            //TODO implemention to get the data from the text field
                            decoration: InputDecoration(
                                labelText: 'Product Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide())))),
                    Container(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            minLines: 4,
                            maxLines: 4,
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
                            //TODO implemention to get the data from the text field
                            decoration: InputDecoration(
                                labelText: 'Price',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide())))),
                    GestureDetector(
                      onTap: () {}, // TODO input image function & replace image
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.file_upload),
                              Text("Upload photo"),
                            ],
                          ),
                        ),
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
                          dialogs.information(context, 'Item updated.');
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

class Dialogs {
  information(BuildContext context, String title) {
    return showDialog(
        context: context,
        barrierDismissible: true,
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
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyListings())),
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
