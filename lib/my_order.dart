import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sign_in_flutter/crud.dart';
import 'package:sign_in_flutter/orderverification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_flutter/sign_in.dart';
import 'orderverification.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
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
      body: Column(
        children: <Widget>[
          Text('My Orders'),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('orders')
                  .where('buyerId', isEqualTo: userID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return _buildList(context, snapshot.data.documents);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot
          .map((data) => _buildListItem(context, data, data.documentID))
          .toList(),
    );
  }

  Widget _buildListItem(
      BuildContext context, DocumentSnapshot data, String documentID) {
    return OrderLists(
        data['productName'],
        data['sellerId'],
        data['sellerName'],
        data['quantity'],
        data['isConfirmed'],
        data['isPaid'],
        data['price'],
        data['productUrl'],
        documentID,
        data['isCOD'],
        data['sellerLocation']);
  }
}

class OrderLists extends StatefulWidget {
  String productName;
  String sellerName;
  String sellerId;
  int quantity;
  bool isConfirmed;
  bool isPaid;
  String documentID, sellerLocation;
  double price;
  String productImage;
  bool isCod;
  OrderLists(
      this.productName,
      this.sellerId,
      this.sellerName,
      this.quantity,
      this.isConfirmed,
      this.isPaid,
      this.price,
      this.productImage,
      this.documentID,
      this.isCod,
      this.sellerLocation);

  @override
  _OrderListsState createState() => _OrderListsState(
      productName,
      sellerId,
      sellerName,
      quantity,
      isConfirmed,
      isPaid,
      price,
      productImage,
      documentID,
      isCod,
      sellerLocation);
}

class _OrderListsState extends State<OrderLists> {
  String _productName;
  String _sellerId;
  String _sellerName;
  int _quantity;
  bool _isConfirmed;
  bool _isPaid;
  String _documentID, _sellerLocation;
  double _price;
  String _productImage;
  bool _isCod;
  _OrderListsState(
      this._productName,
      this._sellerId,
      this._sellerName,
      this._quantity,
      this._isConfirmed,
      this._isPaid,
      this._price,
      this._productImage,
      this._documentID,
      this._isCod,
      this._sellerLocation);

  CrudMethods crudObj = CrudMethods();

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.orange;
    IconButton icon = IconButton(
      icon: Icon(Icons.cancel, color: Colors.white30),
      onPressed: () {
        information(
            context, 'Are you sure want to cancel this order', _documentID);
      },
    );

    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(_sellerId)
            .snapshots(),
        builder: (context, snapshot) {
          var noPhone=snapshot.data['noPhone'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('orders')
                    .document(_documentID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data['isConfirmed']) {
                    backgroundColor = Colors.teal;
                    icon = IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white30),
                      onPressed: () {
                        if (snapshot.data['isCOD']) {
                          dialogCod(context, _sellerLocation, _documentID);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrderVerification(
                                    _productName,
                                    _sellerId,
                                    _sellerName,
                                    _quantity,
                                    _price,
                                    _productImage,
                                    _documentID)),
                          );
                        }
                      },
                    );
                    if (snapshot.data['isPaid']) {
                      backgroundColor = Colors.teal;
                      icon = IconButton(
                        icon: Icon(Icons.check_circle, color: Colors.white30),
                        onPressed: () {},
                      );
                    }
                  }
                  return Card(
                    color: backgroundColor,
                    child: ListTileTheme(
                      textColor: Colors.white,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            StreamBuilder(
                              stream: Firestore.instance
                                  .collection('orders')
                                  .document(_documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data['isCOD']) {
                                  return Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.motorcycle,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        '\t[COD]',
                                      ),
                                    ],
                                  );
                                }
                                return Icon(
                                  Icons.credit_card,
                                  color: Colors.yellow,
                                );
                              },
                            ),
                            Text(
                              ' ' + _productName,
                            ),
                          ],
                        ),
                        subtitle: Text('by ' +
                            _sellerName +
                            ' (Quantity ' +
                            _quantity.toString() +
                            ')\n' +
                            'No Phone' +
                            noPhone),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            icon
                            /* GestureDetector(
                      onTap: () {
                        information(
                            context, 'Are you sure want to cancel this order');
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white30,
                      ),
                    ) */
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }

  information(BuildContext context, String title, String docID) {
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
                onPressed: () {
                  crudObj.deleteData(docID, 'orders');
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  dialogCod(BuildContext context, String sellerLocation, String docID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.teal,
            title: Text(
                'Are you sure ' + sellerLocation + ' is location for COD?  '),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Map<String, dynamic> paymentImageData = {
                    'productPaymentProof': 'COD Location Accepted'
                  };

                  crudObj.updateData(docID, paymentImageData, 'orders');
                  Navigator.pop(context);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }
}
