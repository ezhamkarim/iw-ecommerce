import 'package:flutter/material.dart';
import 'package:sign_in_flutter/crud.dart';
import 'package:sign_in_flutter/home_page.dart';
import 'package:sign_in_flutter/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditLocation extends StatelessWidget {
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
          Container(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              ),
              radius: 40,
              backgroundColor: Colors.transparent,
            ),
          ),
          Text(userName, style: TextStyle(
            fontSize: 18.0 
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Current location: '),
              StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection('users')
                      .document(userID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return Text(snapshot.data['location']);
                  }),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            width: 360.0,
            child: Column(
              children: <Widget>[
                Text('Choose another location:', style: TextStyle(color: Colors.white70),),
                LocationDropdown(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LocationDropdown extends StatefulWidget {
  @override
  _LocationDropdownState createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {

  
  var places = ['','Mutiara Ville','SkyPark Residences','Glomac', 'Garden Plaza', 'The Arc','V Residence', 'Sri Ampang Mas', 'Elaeis 2', 'Elaeis 1', 'Villa Aman', 'Klang Dynasty', 'Sri Green Blk CA1', 'D Melor'];
  var dropdownValue = '';
  CrudMethods crudObj = CrudMethods();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<String>(
      items: places.map<DropdownMenuItem<String>>((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          this.dropdownValue = newValue;
          Map<String, dynamic> locationData = {'location': dropdownValue};
          crudObj.updateData(userID, locationData, 'users');
          //tukar dropdown value
        });
      },
      value: dropdownValue,
    );
  }
}
