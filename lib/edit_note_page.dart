import 'package:always_access_memory/I10n/localizations.dart';
import 'package:always_access_memory/Models/NoteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNotePage extends StatefulWidget {
  NoteModel note;

  EditNotePage(this.note);

  @override
  _EditNotePageState createState() => _EditNotePageState(note);
}

class _EditNotePageState extends State<EditNotePage> {
  NoteModel note;
  _EditNotePageState(this.note);

  TextEditingController _noteNameController = TextEditingController();
  TextEditingController _noteDescriptionController = TextEditingController();

  @override
  void initState() {
    _noteNameController.text = note.name;
    _noteDescriptionController.text = note.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AamLocalizations.of(context).stringById('addNote')),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _noteNameController,
              decoration: InputDecoration(
                  labelText: "Note name"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Field is mandatory";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _noteDescriptionController,
              decoration: InputDecoration(
                  labelText: "Note description"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Field is mandatory";
                }
                return null;
              },
            ),
            ElevatedButton(
              child: Text("Edit"),
              onPressed: () async {
                await Provider.of<NoteModel>(context, listen: false).updateNote(NoteModel(id: note.id, name: _noteNameController.value.text, description: _noteDescriptionController.value.text));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}