import 'package:firebase_notes/providers/auth_data.dart';
import 'package:firebase_notes/providers/note_data.dart';
import 'package:firebase_notes/screens/authscreens/welcome_screen.dart';
import 'package:firebase_notes/screens/notes_screen.dart';
import 'package:firebase_notes/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthData authData = AuthData();
  await authData.getCurrentUser();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return authData;
      },
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) => NoteData(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          backgroundColor: Color(0xFFf0f5f9),
          cardColor: Color(0xFFc9d6df),
          primaryColor: Color(0xFFc9d6df),
          accentColor: Color(0xFF52616b),
          ),
      debugShowCheckedModeBanner: false,
      home: Provider.of<AuthData>(context, listen: false).user == null
          ? WelcomeScreen()
          : StreamProvider(
              create: (BuildContext context) {
                final firebaseService = FirestoreService();
                return firebaseService.getNotes(
                    Provider.of<AuthData>(context, listen: false).user.email);
              },
              child: NotesScreen(
                  Provider.of<AuthData>(context, listen: false).user.email)),
    );
  }
}
//;
