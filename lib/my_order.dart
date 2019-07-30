import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  Dialogs dialogs = new Dialogs();

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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('My Orders'),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xff009688),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                  ),
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(10.0),
                  height: 100.0,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Kak Esah Kitchen',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              OrderLists(
                                prod_name: 'Nasi Keisnin',
                                prod_quantity: '2',
                              ),
                              OrderLists(
                                prod_name: 'Nasi Keselasa',
                                prod_quantity: '1',
                              ),
                              OrderLists(
                                prod_name: 'Nasi Kerabu',
                                prod_quantity: '3',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            dialogs.information(context,
                                'Are you sure want to cancel this order');
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Confirmed Orders'),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xff954F4F),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                  ),
                  margin: EdgeInsets.all(15.0),
                  height: 100.0,
                  width: 325,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Cawkurk Ey Chah Bochawh',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                OrderLists(
                                  prod_name: 'Nasi Daging Manusia',
                                  prod_quantity: '4',
                                ),
                                OrderLists(
                                  prod_name: 'Nasi Kerabu Depan',
                                  prod_quantity: '1',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Paid Orders'),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xff954F4F),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                  ),
                  margin: EdgeInsets.all(15.0),
                  height: 70.0,
                  width: 325,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Amien Yoo',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              OrderLists(
                                prod_name: 'Nasi Kerja Hari Isnin',
                                prod_quantity: '2',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
                onPressed: () => Navigator.pop(context),
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

class OrderLists extends StatelessWidget {
  final String prod_name;
  final String prod_quantity;

  OrderLists({
    this.prod_name,
    this.prod_quantity,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      '- ' + prod_name + ' ' + '(' + prod_quantity + ')',
      style: TextStyle(color: Colors.white70, fontSize: 12),
    );
  }
}
