import 'package:firebase_notes/screens/authscreens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Notes'),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(Icons.adjust),
                label: Text('Login!'),
                color: Colors.orangeAccent,
              ),
              SizedBox(
                width: 10,
              ),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  color: Colors.orangeAccent,
                  icon: Icon(Icons.arrow_drop_down_circle),
                  label: Text('Sign Up!')),
            ],
          )
        ],
      ),
    );
  }
}
