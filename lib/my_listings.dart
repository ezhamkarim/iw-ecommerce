import 'add_item.dart';
import 'edit_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyListings extends StatefulWidget {
  @override
  _MyListingsState createState() => _MyListingsState();
}

class _MyListingsState extends State<MyListings> {
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
        backgroundColor: Colors.teal
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('My Listings'),
                ListFood(
                  Image_location: 'assets/images/nasi_dagang.png',
                  Image_name: 'Nasi Keisnin',
                ),
                ListFood(
                  Image_location: 'assets/images/nasi_dagang.png',
                  Image_name: 'Nasi Keselasa',
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyItemAdd()));
        },
        backgroundColor: Color(0xff009688),
        child: Icon(Icons.add),
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
            backgroundColor: Color(0xffB92D00),
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => MyListings())),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }
}

class ListFood extends StatelessWidget {
  Dialogs dialogs = new Dialogs();

  final String Image_location;
  final String Image_name;

  ListFood({
    this.Image_location,
    this.Image_name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff009688),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      margin: EdgeInsets.all(10.0),
      height: 100.0,
      width: 400.0,
      child: Row(
        children: <Widget>[
          Image.asset(
            Image_location,
            fit: BoxFit.fitHeight,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: 140,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Image_name,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'RM 17.90',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        dialogs.information(context,
                            'Are you sure want to delete this listing ?');
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyItemEdit()));
                      },
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
