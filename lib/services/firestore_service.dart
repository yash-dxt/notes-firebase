import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notes/models/note_model.dart';
import 'dart:async';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveNotes(Note note, String email) async {
    return _db
        .collection(email)
        .document(note.id.toString())
        .setData(note.toMap());
  }

  Stream<List<Note>> getNotes(String email) {
    return _db.collection(email).snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Note.fromMap(document.data))
        .toList());
  }

  Future<void> removeNote(Note note, String email) {
    return _db.collection(email).document(note.id).delete();
  }
}
