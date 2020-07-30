import 'package:firebase_notes/providers/auth_data.dart';
import 'package:firebase_notes/screens/authscreens/settings_screen.dart';
import 'package:firebase_notes/screens/authscreens/welcome_screen.dart';
import 'package:firebase_notes/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../notes_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String email;
    String password;
    return Consumer<AuthData>(
      builder: (BuildContext context, authData, Widget child) {
        return ModalProgressHUD(
          inAsyncCall: authData.showSpinner,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Sign up!'),
            ),
            body: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (input) =>
                          input.isNotEmpty ? null : "Enter a valid email!",
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (input) => input.length > 6
                          ? null
                          : "Enter a password greater than 6 characters",
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              authData.changeBool();

                              await authData.signUp(email, password);

                              authData.changeBool();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StreamProvider(
                                          create: (BuildContext context) {
                                        final firebaseService =
                                        FirestoreService();
                                        return firebaseService
                                            .getNotes(email);
                                      },
                                          child: NotesScreen(email))));
                            }
                          },
                          icon: Icon(Icons.arrow_drop_down_circle),
                          label: Text('Sign Up and Log In'),
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Text('Go Back '),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      },
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
