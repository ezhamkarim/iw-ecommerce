import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_flutter/crud.dart';
import 'sign_in.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Get Started',
                style: TextStyle(
                    fontFamily: 'LiterataBook',
                    fontSize: 40,
                    color: Colors.white),
              ),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        return OutlineButton(
          splashColor: Colors.white,
          onPressed: () {
            authService.signInWithGoogle().whenComplete(() {
              Firestore.instance
                  .collection('users')
                  .document(userID)
                  .get()
                  .then((ds) {
                if (ds.data.containsKey('location') &&
                    ds.data.containsKey('bank')) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FattahAmien();
                      },
                    ),
                  );
                } else {
                  dialogLocation(context);
                }
              });
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage("assets/images/google_logo.png"),
                    height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  dialogLocation(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogLocation();
        });
  }
}

class DialogLocation extends StatefulWidget {
  @override
  _DialogLocationState createState() => _DialogLocationState();
}

class _DialogLocationState extends State<DialogLocation> {
  CrudMethods crudObj = CrudMethods();
  final bankSellerNumber = TextEditingController();
  final noPhone = TextEditingController();
  var dropdownValue = '';
  var places = [
    '',
    'Mutiara Ville',
    'SkyPark Residences',
    'Glomac',
    'Garden Plaza',
    'The Arc',
    'V Residence',
    'Sri Ampang Mas',
    'Elaeis 2',
    'Elaeis 1',
    'Villa Aman',
    'Klang Dynasty',
    'Sri Green Blk CA1',
    'D Melor'
  ];
  var bankSelected = '';
  var banks = [
    '',
    'BSN',
    'Maybank',
    'Public Bank',
    'Bank Islam',
    'CIMB Bank',
    'Bank Rakyat',
    'Hong Leong Bank',
    'Affin Bank'
  ];
  @override
  void dispose() {
    bankSellerNumber.dispose();
    noPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.teal,
      title: Text('Please insert your information'),
      content: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            DropdownButton<String>(
              items: places
                  .map<DropdownMenuItem<String>>((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  this.dropdownValue = newValue;
                  //tukar dropdown value
                });
              },
              value: dropdownValue,
            ),
            DropdownButton<String>(
              items: banks
                  .map<DropdownMenuItem<String>>((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  this.bankSelected = newValue;
                  //tukar dropdown value
                });
              },
              value: bankSelected,
            ),
            TextFormField(
            controller: bankSellerNumber,
            keyboardType: TextInputType.number,
            inputFormatters: [LengthLimitingTextInputFormatter(20)],
            decoration: InputDecoration(
                labelText: 'Bank Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide()))),
        TextFormField(
            controller: noPhone,
            keyboardType: TextInputType.number,
            inputFormatters: [LengthLimitingTextInputFormatter(20)],
            decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide())))
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (bankSelected == '' || dropdownValue == ''|| bankSellerNumber.text ==''|| noPhone.text =='') return;
            Map<String, dynamic> locationData = {
              'location': dropdownValue,
              'bank': bankSelected,
              'bankNumber' : bankSellerNumber.text,
              'noPhone' : noPhone.text
            };

            crudObj.updateData(userID, locationData, 'users');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FattahAmien();
                },
              ),
            );
          },
          child: Text(
            'Confirm',
            style: TextStyle(color: Colors.white),
          ),
        ),
        
      ],
      /* content: Center(
            child: DropdownButton<String>(
              items: <String>['Tamarind Square', 'Emvi','Unimai'].map((String value){
                  return DropdownMenuItem<String>(value: value,child: Text(value),);
              }).toList(),
              onChanged: (_){},
            ),
            
          ), */
    );
  }
}
