import 'package:firebase_notes/providers/auth_data.dart';
import 'package:firebase_notes/screens/authscreens/welcome_screen.dart';
import 'package:firebase_notes/screens/notes_screen.dart';
import 'package:firebase_notes/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String email, recoverAccountEmail;
    String password;
    return Consumer<AuthData>(
      builder: (BuildContext context, authData, Widget child) {
        return ModalProgressHUD(
          inAsyncCall: authData.showSpinner,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Login'),
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

                              await authData.signIn(email, password);
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
                          icon: Icon(Icons.adjust),
                          label: Text('Login!'),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value) {
                        recoverAccountEmail = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter email to reset password'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        await authData
                            .sendPasswordResetEmail(recoverAccountEmail);
                      },
                      child: Text('Reset password!'),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
