import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sign_in_flutter/orderverification.dart';


class MyCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Food', style: TextStyle(fontFamily: 'LiterataBook')),
        backgroundColor: Colors.teal,
      ),
      body: ListView(children: <Widget>[ //TODO implementation to get data from database
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context)=> MyOrderVerification()
                          ));
                        },
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text('Confirm'),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
