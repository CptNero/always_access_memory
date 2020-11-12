import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/NoteModel.dart';

class NoteList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<NoteModel> notes;
    NoteModel.insertNote(new NoteModel(id: 1, name: "Sajt", description: "lol"));
    NoteModel.fetchAll().then((value) => {notes = value});

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(notes[index].name)
          )
        );
      },
    );
  }
}

