import 'package:firebase_notes/screens/authscreens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('NOTES', style: TextStyle(fontSize: 25, letterSpacing: 1.2),),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(Icons.fingerprint, color: Colors.blueAccent,),
                label: Text('Login!'),
              ),

              RaisedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  icon: Icon(Icons.person_add, color: Colors.blueAccent,),
                  label: Text('Sign Up!')),
            ],
          )
        ],
      ),
    );
  }
}
