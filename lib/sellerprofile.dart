
import 'package:sign_in_flutter/edit_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'manage_orders.dart';
import 'my_listings.dart';
import 'my_order.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';

class MySellerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // making AppBar with green color and Home Food Text
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

      // Body section starts here
      // ListView to enable scrolling horizontally
      body: ListView(
        children: <Widget>[
          // Container with fixed height for profile picture and name

          SizedBox(height: 50.0,),
          Container(
            height: 200,
            // Column layout for picture and name
            child: Column(
              children: <Widget>[
                Container(
                  /* decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(45.0)),
                    border: new Border.all(color: Colors.black, width: 4.0),
                  ), */
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    
                    
                    backgroundImage: NetworkImage(
                      imageUrl,
                    ),
                    radius: 60,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(
                  userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
              height: 300.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('users').document(userID).snapshots(),
                      builder: (context, snapshot) {
                        return Container(
                          
                          color: Colors.teal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Location : ' + snapshot.data['location'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyOrdersPage()));
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          'My orders >',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyListings()));
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          'My listings >',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyManageOrders()));
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Manage orders >',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditLocation()),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Edit info >',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
