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
        title: Container(
          // To align the text to the center of the appbar
          padding: const EdgeInsets.only(left: 50.0),
          child: Text(
            // Text with Home Food and white colored font
            'Home Food',
            style: TextStyle(color: Colors.white, fontFamily: 'LiterataBook'),
          ),
        ),
        backgroundColor: Color(0xff4CB5AB),
      ),
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
                    Text('Name'),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(5.0),
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    Text('Description'),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(5.0),
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    Text('Price'),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(5.0),
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    Text('Photos'),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(5.0),
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.black26,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.arrow_upward),
                            Text('Upload Photo'),
                          ],
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
