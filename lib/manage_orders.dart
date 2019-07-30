import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        backgroundColor: Colors.teal
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Manage Orders'),
                ),
                Orders(
                  user_name: "Mary Jane Holland",
                  color_code: 0xff009688,
                  description: 'Accept order ?',
                ),
                Orders(
                  user_name: "Senah Binti Selamat",
                  color_code: 0xff954F4F,
                  description: 'Order paid ?',

                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Paid Orders'),
                ),
                Orders(
                  user_name: "Amien Yoo",
                  color_code: 0xff954F4F,
                  description: 'Order delivered ?',
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

class Orders extends StatelessWidget {
  final String description;
  final int color_code;
  final String user_name;
  final String prod_name;
  final String prod_quantity;

  Orders({
    this.description,
    this.color_code,
    this.user_name,
    this.prod_name,
    this.prod_quantity,
  });
  Dialogs dialogs = new Dialogs();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container decoration
      decoration: new BoxDecoration(
        color: Color(color_code),
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
      ),
      // Container constraints
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(10.0),
      height: 100.0,
      // Inside Container
      child: ListTile(
        // Column for contents
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              user_name,
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
                dialogs.information(context, description);
              },
              child: Icon(
                Icons.check_circle,
                color: Colors.white30,
              ),
            )
          ],
        ),
      ),
    );
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

