import 'dart:core';

import 'package:always_access_memory/note_detail.dart';
import 'package:always_access_memory/note_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'I10n/localizations.dart';
import 'Models/NoteModel.dart';
import 'edit_note_page.dart';

enum NoteActions { Edit, Delete }

class NoteList extends StatefulWidget {
  @override
  _NoteListWidgetState createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteList> {
  NoteModel noteModel;
  Future<List<NoteModel>> notesFuture;
  List<NoteModel> notes;

  NoteModel selectedNote;
  bool isLargeScreen = false;

  final GlobalKey<AnimatedListState> notesListKey =
      GlobalKey<AnimatedListState>();

  @override
  void initState() {
    noteModel = Provider.of<NoteModel>(context, listen: false);
    notesFuture = _getNotes(noteModel);
    selectedNote = NoteModel(name: "", description: "");
    super.initState();
  }

  Future<List<NoteModel>> _getNotes(NoteModel noteModel) async {
    return await noteModel.fetchAll();
  }

  Widget slideIt(BuildContext context, int index, animation) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.bounceIn,
            reverseCurve: Curves.bounceOut)),
        child: Card(
            child: ListTile(
          title: Text(notes[index].name),
          onTap: () {
            if (isLargeScreen) {
              this.setState(() {
                this.selectedNote = notes[index];
              });
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotePage(notes[index])));
            }
          },
          trailing: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: PopupMenuButton<NoteActions>(
                child: Icon(Icons.more_vert),
                onSelected: (NoteActions result) {
                  switch (result) {
                    case NoteActions.Edit:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditNotePage(notes[index])));
                      break;
                    case NoteActions.Delete:
                      notesListKey.currentState.removeItem(index,
                          (_, animation) => slideIt(context, index, animation),
                          duration: const Duration(milliseconds: 5000));
                      Provider.of<NoteModel>(context, listen: false)
                          .deleteNote(notes[index].id);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<NoteActions>>[
                      PopupMenuItem<NoteActions>(
                        value: NoteActions.Edit,
                        child: Text(AamLocalizations.of(context).stringById('edit')),
                      ),
                      PopupMenuItem<NoteActions>(
                        value: NoteActions.Delete,
                        child: Text( AamLocalizations.of(context).stringById('delete')),
                      ),
                    ]),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (MediaQuery.of(context).size.width > 600) {
        isLargeScreen = true;
      } else {
        isLargeScreen = false;
      }

      return Row(
        children: [
          Consumer<NoteModel>(builder: (context, note, child) {
            notesFuture = _getNotes(note);
            return Expanded(
              child: FutureBuilder<List<NoteModel>>(
                  future: notesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CircularProgressIndicator();
                    }
                    notes = snapshot.data ?? [];
                    return AnimatedList(
                      key: notesListKey,
                      initialItemCount: notes.length,
                      itemBuilder: (context, index, animation) {
                        return slideIt(context, index, animation);
                      },
                    );
                  }),
            );
          }),
          isLargeScreen
              ? Expanded(child: NoteDetail(selectedNote))
              : Container()
        ],
      );
    });
  }
}
