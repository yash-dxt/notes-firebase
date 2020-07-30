import 'package:firebase_notes/models/note_model.dart';
import 'package:firebase_notes/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class NoteData with ChangeNotifier {
  final firestoreService = FirestoreService();
  Uuid uuid = Uuid();

  void removeFromNotes(Note note, String email) {
    firestoreService.removeNote(note, email);
    notifyListeners();
  }

  void addNewNote(Note note, String email) {
    Note noteWithId;
    note.id = uuid.v4();
    noteWithId = note;

    firestoreService.saveNotes(noteWithId, email);
    notifyListeners();
  }

  void editNote(Note note, String email) {
    firestoreService.saveNotes(note, email);
    notifyListeners();
  }
}
