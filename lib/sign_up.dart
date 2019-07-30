import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'home_page.dart';
/* dependencies
  add flutter_auth_buttons:
 */

class MySignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'HomeFood',
          style: TextStyle(fontFamily: 'LiterataBook'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6.0,
              ),
              Text('Sign Up',
                  style: TextStyle(fontSize: 15, color: Colors.black)),
              Container(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(   //TODO implemention to get the data from the text field
                      decoration: InputDecoration(
                          labelText: 'Display Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide())))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CheckBox(),
                  Text('Are you want to be seller?')
                ],
              ),
              GoogleSignInButton(
                text: 'Link with Google',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("You're signed up"),
                        content: new Text("Welcome Back!"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Ok"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FattahAmien()));
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                onPressed: () {},
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('Confirm'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckBox extends StatefulWidget {
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _selVerify = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            value: _selVerify,
            onChanged: (bool value) {
              setState(() {
                _selVerify = value;
              });
            }),
      ],
    );
  }
}
