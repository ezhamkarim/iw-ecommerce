import 'package:flutter/material.dart';
import 'checkout.dart';

class MyOrderVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Food', style: TextStyle(fontFamily: 'LiterataBook')),
        backgroundColor: Colors.teal,
      ),
      body: ListView( //TODO implementation to get data from database
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text('Please Confirm Your order'),
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
                        child: Text('Kak Esah Kitchen')),
                    GestureDetector(
                      onTap: () {
                        print("Container clicked");
                      },
                      child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/nasi_dagang.png',
                              height: 70,
                              width: 70,
                            ),
                            title: Text(
                              'Nasi Dagang',
                              style: TextStyle(
                                fontFamily: 'LiterataBook',
                              ),
                            ),
                            subtitle: Text('RM' + ' 17.00',
                                style: TextStyle(
                                  fontFamily: 'LiterataBook',
                                )),
                            trailing: Text('Quantity :' + '2',
                                style: TextStyle(fontSize: 15)),
                          )),
                    ),
                    Container(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/nasi_dagang.png',
                            height: 70,
                            width: 70,
                          ),
                          title: Text(
                            'Nasi Dagang',
                            style: TextStyle(
                              fontFamily: 'LiterataBook',
                            ),
                          ),
                          subtitle: Text('Rm 17.00',
                              style: TextStyle(
                                fontFamily: 'LiterataBook',
                              )),
                          trailing: Text('Quantity' + '2',
                              style: TextStyle(fontSize: 15)),
                        )),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Delivery Location',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Kuala Lumpur, Selangor'),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Total: ' + ' Rm34.00'),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 300,
              color: Colors.teal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Payment Instructions'),
                  Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                        height: 200.0,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
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
                padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
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
              padding: const EdgeInsets.all(8.0),
            child: Center(
              child: RaisedButton(
                padding: const EdgeInsets.all(8.0),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyCheckout()));
                },
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('Confirm'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
