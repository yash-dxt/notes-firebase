import 'package:firebase_notes/models/note_model.dart';
import 'package:firebase_notes/providers/note_data.dart';
import 'package:firebase_notes/screens/authscreens/settings_screen.dart';
import 'package:firebase_notes/screens/edit_note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets.dart';
import 'new_note.dart';

class NotesScreen extends StatelessWidget {
  final String email;

  NotesScreen(this.email);

  @override
  Widget build(BuildContext context) {
    List<Note> notes = Provider.of<List<Note>>(context) == null
        ? []
        : Provider.of<List<Note>>(context);

    return Consumer<NoteData>(
      builder: (BuildContext context, noteData, Widget child) {
        return Scaffold(
          floatingActionButton: Padding(
              padding: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return NewNote(
                      email: email,
                    );
                  }));
                },
                child: Icon(Icons.add),
              )),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  InkWell(
                      child: Icon(Icons.settings),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsScreen()));
                      }),
                  SizedBox(width: 5,)
                ],
                backgroundColor: Color(0xFF49565e),
                title: Text(
                  'Your Notes',
                  style: TextStyle(color: Colors.white),
                ),
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: Container(),
              ),
              SliverPadding(padding: EdgeInsets.all(10)),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final note = notes[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return EditNote(
                          note: note,
                          email: email,
                        );
                      }));
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          child: RemoveDialog(
                            note: note,
                            email: email,
                            noteData: noteData,
                          ));
                      //
                    },
                    child: NoteCard(
                      title: note.title,
                      content: note.content,
                    ),
                  );
                }, childCount: notes.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              ),
            ],
          ),
        );
      },
    );
  }
}
