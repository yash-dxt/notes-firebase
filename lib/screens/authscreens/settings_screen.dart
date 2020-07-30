import 'package:firebase_notes/providers/auth_data.dart';
import 'package:firebase_notes/screens/authscreens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    return Consumer<AuthData>(
      builder: (BuildContext context, authData, Widget child) {
        final user = authData.user;
        return ModalProgressHUD(
          inAsyncCall: authData.showSpinner,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Sign Out Screen'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello ' + user.email),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        user.isEmailVerified
                            ? print('already verified')
                            : user.sendEmailVerification();
                      },
                      child: Text('Send Verification Link!'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        authData.changeBool();

                        await authData.signOut();
                        authData.changeBool();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      },
                      child: Text(' Sign Out !'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('To become an elite you have to verify your email'),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter new password here'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        await user.updatePassword(password);
                      },
                      child: Text('Reset password!'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter new Email here'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        await user.updateEmail(email);
                      },
                      child: Text('Reset password!'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
