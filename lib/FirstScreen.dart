import 'package:flutter/material.dart';
import 'package:sign_in_flutter/cartview.dart';
import 'package:sign_in_flutter/login_page.dart';
import 'package:sign_in_flutter/sellerprofile.dart';
import 'package:sign_in_flutter/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<FirebaseUser> currentUser = authService.getCurrentUser();
String userUID;

class FattahAmien extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    currentUser.then((value) {
      userUID = value.uid;
    });

    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.teal,
              title: Text(
                'Home Food',
                style: TextStyle(
                  fontFamily: 'LiterataBook',
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () {

                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => MyCart()
                      )
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
            drawer: DrawerNav(),
            body: ProductList(),
          );
        });
  }
}

class DrawerNav extends StatefulWidget {
  @override
  _DrawerNavState createState() => _DrawerNavState();
}

class _DrawerNavState extends State<DrawerNav> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal[100],
        child: ListView(
          padding: EdgeInsets.only(top: 40.0),
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    //"http://pngimg.com/uploads/dog/dog_PNG50322.png"
                    imageUrl,
                    ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
            ),
            Divider(height: 48.0, color: Color.fromARGB(0, 0, 0, 0)),
            /* StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(userUID)
                  .snapshots(),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data['displayName'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'LiterataBook',
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),  */
            Text(
              userName,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'LiterataBook',
              ),
            ),
            Divider(height: 48.0, color: Color.fromARGB(0, 0, 0, 0)),
            Text(
              userID,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'LiterataBook',
              ),
              textAlign: TextAlign.center,
            ),
            Divider(height: 48.0, color: Color.fromARGB(0, 0, 0, 0)),
            GestureDetector(
              onTap: () {
                print('Open profile');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MySellerProfile()));
              }, // TODO: Implement navigation to profile page
              child: Text(
                'Profile',
                style: TextStyle(fontFamily: 'LiterataBook'),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(height: 24.0, color: Color.fromARGB(0, 0, 0, 0)),
            GestureDetector(
              onTap: () {
                print('Open favourites');
              }, // TODO: Implement navigation to favourites page
              child: Text(
                'Favourites',
                style: TextStyle(fontFamily: 'LiterataBook'),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(height: 24.0, color: Color.fromARGB(0, 0, 0, 0)),
            GestureDetector(
              onTap: () {
                print('Open notifications');
              }, // TODO: Implement navigation to notifications page
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Notifications',
                    style: TextStyle(fontFamily: 'LiterataBook'),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    '(0)', // TODO: Implement notifications counter
                    style: TextStyle(
                        fontFamily: 'LiterataBook', color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(height: 24.0, color: Color.fromARGB(0, 0, 0, 0)),
            GestureDetector(
              onTap: () {
                print('Open setting');
              }, // TODO: Implement navigation to setting page
              child: Text(
                'Setting',
                style: TextStyle(fontFamily: 'LiterataBook'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: RaisedButton(
                onPressed: () {
                  authService.signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), ModalRoute.withName('/'));
                },
                color: Colors.teal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
            )
          ],
        ),
      ),
    );
  }


}

class ProductCard extends StatelessWidget {
  final String id, _image, _title, _seller, _price, _description;

  ProductCard(this.id, this._image, this._title, this._seller, this._price,
      this._description);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 12.0),
            width: 380.0,
            height: 160.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              image: DecorationImage(
                image: ExactAssetImage(_image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 380.0,
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
            color: Colors.teal[100],
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      _seller,
                      style: TextStyle(color: Color.fromARGB(172, 0, 0, 0)),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  color: Colors.teal,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add, color: Colors.white),
                      Text('Add to cart',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(_price, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ProductCard(
          '0001',
          'assets/images/nasi_dagang.png',
          'Nasi Kerabu',
          'Kak Senak',
          "RM17.90",
          'Very Delicious Fried Rice. 10/10.',
        ),
        ProductCard(
          '0001',
          'assets/images/nasi_dagang.png',
          'Nasi Daging',
          'Kak Enak',
          "RM39.90",
          'Very Delicious Fried Rice. 10/10.',
        ),
        ProductCard(
          '0001',
          'assets/images/nasi_dagang.png',
          'Nasi Dagang',
          'Kak Senah',
          "RM14.90",
          'Very Delicious Fried Rice. 10/10.',
        ),
        ProductCard(
          '0001',
          'assets/images/nasi_dagang.png',
          'Nasi Keselasa',
          'Kak Benak',
          "RM7.90",
          'Very Delicious Fried Rice. 10/10.',
        ),
      ],
    );
  }
}
