import 'package:always_access_memory/AddNotePage.dart';
import 'package:always_access_memory/Models/NoteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => AddNotePage(),
          )
        );
        NoteModel note = NoteModel();
      }
    );
  }
}