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
                    Text('WELCOME!', style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1.2),),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email', border: OutlineInputBorder()),
                        validator: (input) =>
                            input.isNotEmpty ? null : "Enter a valid email!",
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,

                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
                        validator: (input) => input.length > 6
                            ? null
                            : "Enter a password greater than 6 characters",
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try {
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
                              } on Exception catch (e) {
                                print('error!');
                              }
                            }
                          },
                          icon: Icon(Icons.adjust),
                          label: Text('Login!'),
                        ),
                        SizedBox(width: 22,)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('OR'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,

                      child: TextField(
                        onChanged: (value) {
                          recoverAccountEmail = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                            labelText: 'Enter email to reset password'),
                      ),
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
