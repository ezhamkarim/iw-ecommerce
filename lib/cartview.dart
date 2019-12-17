import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_flutter/sign_in.dart';
import 'checkout.dart';
import 'cart.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    var sellers = cart.cart.keys.toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Food', style: TextStyle(fontFamily: 'LiterataBook')),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        //TODO implementation to get data from database
        itemCount: sellers.length,
        itemBuilder: (context, index) => Bakul(sellers[index]),
      ),
    );
  }
} //endclass

class Bakul extends StatefulWidget {
  //TODO initialise sellerName
  String sellerId;
  Bakul(this.sellerId);

  @override
  _BakulState createState() => _BakulState(sellerId);
}

class _BakulState extends State<Bakul> {
  String _sellerId;
  _BakulState(this._sellerId);
  List<Map<String, dynamic>> productsList;

    
  @override
  Widget build(BuildContext context) {
    
    var cart = Provider.of<Cart>(context);
    //cart.getSellerTotal(_sellerId);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
                child: StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance
                        .collection('users')
                        .document(_sellerId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return Text(snapshot.data['displayName']);
                    }),
              ),
              ListView.builder(
               // Firestore.instance.collection('users').document(userID).collection('cart').document(_sellerId).setData({'products' : }),
                shrinkWrap: true,
                itemCount: cart.cart[_sellerId].length,
                itemBuilder: (context, index) {
                  productsList = cart.cart[_sellerId];
                  return CartItem(
                    
                    productsList[index]['productId'],
                    productsList[index]['quantity'],
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  
                  Text('RM '), //TODO
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Text('Confirm'),
                    onPressed: () {
                    
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCheckout(),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
        Divider(
          height: 10,
          color: Colors.grey,
        )
      ],
    );
  
  }
  updateState(){
    setState(() {
      
    });
  }
}

class CartItem extends StatefulWidget {
  int quantity;
  String productId;
  String sellerId;
  CartItem(this.productId, this.quantity);

  @override
  _CartItemState createState() => _CartItemState(productId,quantity);
}

class _CartItemState extends State<CartItem> {
  String _productId ,imageUrl, title;
  int _quantity;
  _CartItemState(this._productId,this._quantity);
  double price;

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    DocumentReference ref =
        Firestore.instance.collection('product').document(_productId);
  
        
    return StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              leading: Image.network(
                snapshot.data['photoUrl'],
                height: 70,
                width: 70,
              ),
              title: Text(
                snapshot.data['name'],
                style: TextStyle(
                  fontFamily: 'LiterataBook',
                ),
              ),
              subtitle: Text(
                snapshot.data['price'].toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: 'LiterataBook',
                ),
              ),
              trailing: Container(
                height: 30,
                width: 120.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        
                        setState(() {
                         cart.decreaseQuantity(_productId);
                        
                        });
                        
                      },
                    ),
                    Text(cart.getQuantity(_productId).toString(),),
                    
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        setState(() {
                          cart.increaseQuantity(_productId);
                        });
                        
                      },
                    ),
                    
                  ],
                ),
              ),
            ),
          );
        });
  }
}
