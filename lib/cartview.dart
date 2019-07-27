import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'checkout.dart';


class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Food', style: TextStyle(fontFamily: 'LiterataBook')),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder( //TODO implementation to get data from database
        itemCount: 3,
        itemBuilder: (context, index) => index == 0
            ? Container(
                padding: const EdgeInsets.all(4.0),
                child: Text('Please Confirm Your order Haiiiiiiiii'),
              )
            : Column(
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
                                trailing: Container(
                                  height: 30,
                                  width: 120.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.teal,
                                        ),
                                        onPressed: () {},
                                      ),
                                      Text("1"),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.teal,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
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
                                      onPressed: () {},
                                    ),
                                    Text("1"),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.teal,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        
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
                            Text('Total: ' + ' Rm34.00'),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                            padding: const EdgeInsets.all(8.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyCheckout()));
                            },
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: Text('Confirm'),
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
              ),
      ),
    );
  }
} //endclass
