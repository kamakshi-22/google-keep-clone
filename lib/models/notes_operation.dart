import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NotesOperation extends ChangeNotifier {
  final List<Note> _notes = [];
  List<Note> get getNotes {
    return _notes;
  }

  void addNewNote(String title, String description) {
    Note note = Note(title: title, description: description);
    _notes.add(note);
    notifyListeners();
  }

  NotesOperation() {}
}

