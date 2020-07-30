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
              title: Text('Settings'),
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
                    user.isEmailVerified
                        ? RaisedButton.icon(
                            icon: Icon(Icons.email),
                            onPressed: () async {
                              authData.changeBool();
                              await user.sendEmailVerification();
                              await authData.getCurrentUser();
                              authData.changeBool();
                            },
                            label: Text('Send Verification Link!'),
                          )
                        : Text("You're verified!"),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () async {
                        authData.changeBool();

                        await authData.signOut();
                        authData.changeBool();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      },
                      label: Text(' Sign Out '),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        authData.changeBool();
                        await authData.sendPasswordResetEmail(user.email);
                        authData.changeBool();
                      },
                      child: Text('Reset password!'),
                    ),
                    SizedBox(
                      height: 10,
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
