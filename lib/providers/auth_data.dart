import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthData with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  FirebaseUser _user;

  FirebaseUser get user => _user;

  void changeBool(){
    showSpinner= !showSpinner;
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    _user = await _auth.currentUser();
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String recoverAccountEmail) async {
    await _auth.sendPasswordResetEmail(email: recoverAccountEmail);
  }

  Future<void> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _user = result.user;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _user = result.user;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
