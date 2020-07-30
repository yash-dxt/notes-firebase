import 'package:firebase_notes/providers/note_data.dart';
import 'package:flutter/material.dart';

import 'models/note_model.dart';
class NoteCard extends StatelessWidget {
  const NoteCard({this.title, this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final Color black = Color(0xFF1e2022);

    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
          child: Column(
            children: [
              Text(
                '$title',
                style: TextStyle(
                    color: black,
                    letterSpacing: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: .5,
                width: double.infinity,
                color: black,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  '$content',
                  style: TextStyle(
                      color: black,
                      fontSize: 14,
                      wordSpacing: 1.25,
                      letterSpacing: 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class RemoveDialog extends StatelessWidget {
  const RemoveDialog({
    Key key,
    @required this.note,
    @required this.email,
    this.noteData,
  }) : super(key: key);

  final Note note;
  final String email;
  final NoteData noteData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete?',
        style: TextStyle(color: Color(0xFF49565e)),
      ),
      actions: [
        FlatButton(
            child: Text(
              'YES',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              noteData.removeFromNotes(note, email);
              Navigator.pop(context);
            }),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: TextStyle(color: Color(0xFF49565e)),
            ))
      ],
    );
  }
}
