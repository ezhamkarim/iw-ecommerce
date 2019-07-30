import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'home_page.dart';

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
              Text('Get Started', style: TextStyle(
                  fontFamily: 'LiterataBook',
                  fontSize: 40,
                  color: Colors.white
                ),),
              SizedBox(height: 50),
              _signInButton(
              ),
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FattahAmien();
              },
            ),
          );
        });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
