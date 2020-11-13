import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/NoteModel.dart';

enum NoteActions {Edit, Delete}

class NoteList extends StatefulWidget {
  @override
  _NoteListWidgetState createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteList> {
  NoteModel noteModel;
  Future<List<NoteModel>> notesFuture;
  List<NoteModel> notes;

  @override
  void initState() {
    noteModel = Provider.of<NoteModel>(context, listen: false);
    notesFuture = _getNotes(noteModel);
    super.initState();
  }

  Future<List<NoteModel>> _getNotes(NoteModel noteModel) async {
    return await noteModel.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteModel>(
        builder: (context, note, child) {
          notesFuture = _getNotes(note);
          return FutureBuilder<List<NoteModel>>(
              future: notesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }
                notes = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                          title: Text(notes[index].name),
                          trailing: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: PopupMenuButton<NoteActions>(
                              child: Icon(Icons.more_vert),
                              onSelected: (NoteActions result) {
                                switch(result) {
                                  case NoteActions.Edit:
                                    break;
                                  case NoteActions.Delete:
                                    Provider.of<NoteModel>(context, listen: false).deleteNote(notes[index].id);
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<NoteActions>>[
                                const PopupMenuItem<NoteActions>(
                                  value: NoteActions.Edit,
                                  child: Text("Edit"),
                                ),
                                const PopupMenuItem<NoteActions>(
                                  value: NoteActions.Delete,
                                  child: Text("Delete"),
                                ),
                              ]
                            ),
                          ),
                        ));
                  },
                );
              });
        });
  }
}
