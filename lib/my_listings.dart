import 'package:sign_in_flutter/sign_in.dart';
import 'add_item.dart';
import 'edit_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          backgroundColor: Colors.teal),
      body: ListingList(),
      
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

class ListingList extends StatefulWidget {
  @override
  _ListingListState createState() => _ListingListState();
}

class _ListingListState extends State<ListingList> {
  
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  
  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('product').where('sellerId', isEqualTo : userID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data, data.documentID)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data, String documentID) {
    final product = Listings.fromSnapshot(data);

    return ListFoodCard(
      product.productUrl,
      product.name,
      product.price,
    );
  }
}

class Listings {
  final String name;
  final double price;
  final String productUrl;
  final DocumentReference reference;

  Listings.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['price'] != null),
        assert(map['photoUrl'] != null),
        productUrl = map['photoUrl'],
        name = map['name'],
        price = map['price'];

  Listings.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class ListFoodCard extends StatelessWidget {
  Dialogs dialogs = new Dialogs();

  final String _image;
  final String _title;
  final double _price;

  ListFoodCard(this._image, this._title, this._price);

  MyItemEdit updateData = MyItemEdit();
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
          Expanded(
            flex: 1,
            child: Container(
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(_image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: 140,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _title,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Rm' +
                      _price.toStringAsFixed(
                          _price.truncateToDouble() == _price ? 2 : 2),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyItemEdit()));
                          
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
            ),
          )
        ],
      ),
    );
  }
}
