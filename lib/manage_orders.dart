import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_flutter/crud.dart';
import 'package:sign_in_flutter/sign_in.dart';

class MyManageOrders extends StatefulWidget {
  @override
  _MyManageOrdersState createState() => _MyManageOrdersState();
}

class _MyManageOrdersState extends State<MyManageOrders> {
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
          Text('Manage Orders'),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('orders')
                  .where('sellerId', isEqualTo: userID)
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
    return ManageOrderLists(
        data['productName'],
        data['sellerName'],
        data['buyerName'],
        data['quantity'],
        data['isConfirmed'],
        data['isPaid'],
        documentID);
  }
}

class ManageOrderLists extends StatefulWidget {
  String productName;
  String sellerName;
  String buyerName;
  int quantity;
  bool isConfirmed;
  bool isPaid;
  String documentID;
  ManageOrderLists(this.productName, this.sellerName, this.buyerName,
      this.quantity, this.isConfirmed, this.isPaid, this.documentID);

  @override
  _ManageOrderListsState createState() => _ManageOrderListsState(productName,
      sellerName, buyerName, quantity, isConfirmed, isPaid, documentID);
}

class _ManageOrderListsState extends State<ManageOrderLists> {
  String _productName;
  String _sellerName;
  String _buyerName;
  int _quantity;
  bool _isConfirmed;
  bool _isPaid;
  String _documentID;
  _ManageOrderListsState(this._productName, this._sellerName, this._buyerName,
      this._quantity, this._isConfirmed, this._isPaid, this._documentID);
  CrudMethods crudObj = CrudMethods();

  bool _isConfirmedActive = false;
  bool _isPaidActive = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream : Firestore.instance
                      .collection('orders')
                      .document(_documentID)
                      .snapshots(),
      builder: (context, snapshot) {
    

    _isConfirmedActive = _isConfirmed;
    _isPaidActive = _isPaid;

    print(_productName +
        ": isConfirmed? " +
        _isConfirmedActive.toString() +
        "; isPaid? " +
        _isPaidActive.toString());
    Color backgroundColor = !_isConfirmedActive ? Colors.orange : Colors.teal;
    //Text  text = Text('Not Confirm', style: TextStyle(fontSize: 10.0, color: Colors.white30));

    IconButton icon = IconButton(
      icon: Icon(Icons.check_circle, color: Colors.white),
      onPressed: () {
        information(
            context, 'Are you sure want to accept this order?', _documentID);
      },
    );

    if (_isConfirmedActive) {
      //text = Text('Order Confirm', style: TextStyle(fontSize: 10.0, color: Colors.white30),);
      icon = IconButton(
        icon: Icon(Icons.arrow_forward, color: Colors.white),
        onPressed: () {
          isPaidDialog(
              context, 'Are you sure payment have been made?', _documentID);
        },
      );
      if (_isPaidActive) {
        //text = Text('Order Paid', style: TextStyle(fontSize: 10.0, color: Colors.white30),);
        icon = IconButton(
          icon: Icon(Icons.done_outline, color: Colors.white),
          onPressed: () {
            isFuilfilledDialog(context, _documentID);
          },
        );
      }
    }

  

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
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
                          Text('\t[COD]', ),
                        ],
                      );
                    }
                    return Icon(Icons.credit_card, color: Colors.yellow,);
                  },
                ),
                Text(
                  ' ' + _productName,
                ),
              ],
            ),
            subtitle: Text('wanted by ' +
                _buyerName +
                ' (Quantity ' +
                _quantity.toString() +
                ')\n'
                +'No phone :'+snapshot.data['buyerNoPhone']),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[icon],
            ),
          ),
        ),
      ),
    );
      }
    );
  }

  isPaidDialog(BuildContext context, String title, String documentID) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(documentID)
              .snapshots(),
          builder: (context, snapshot) {
            return AlertDialog(
              backgroundColor: Color(0xff009688),
              title: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              content: Container(
                padding: const EdgeInsets.all(1.0),
                child: (snapshot.data['productPaymentProof'] != '')
                    ? (snapshot.data['productPaymentProof'] ==
                            'COD Location Accepted')
                        ? Text(
                            'COD location accepted',
                            style: TextStyle(color: Colors.white),
                          )
                        : Image.network(snapshot.data['productPaymentProof'])
                    : Text(
                        'No payment received!',
                        style: TextStyle(color: Colors.white),
                      ),
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
                    Map<String, dynamic> isPaiddata = {'isPaid': true};
                    crudObj.updateData(documentID, isPaiddata, 'orders');
                    setState(() {
                      _isPaid = !_isPaid;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  isFuilfilledDialog(BuildContext context, String documentID) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal,
          title: Text(
            'Order fulfilled?',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Please make sure that the order has been fulfilled before tapping "Yes".',
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
                crudObj.deleteData(documentID, 'orders');
                Navigator.pop(context);
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  information(BuildContext context, String title, String documentID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff009688),
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
                  Map<String, dynamic> isConfirmdata = {'isConfirmed': true};
                  crudObj.updateData(documentID, isConfirmdata, 'orders');
                  setState(() {
                    _isConfirmed = !_isConfirmed;
                  });
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
