import 'package:always_access_memory/I10n/localizations.dart';
import 'package:always_access_memory/Models/NoteModel.dart';
import 'package:always_access_memory/NoteList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController _noteNameController = TextEditingController();
  TextEditingController _noteDescriptionController = TextEditingController();

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
                child: Text("Add"),
                onPressed: () async {
                  await Provider.of<NoteModel>(context, listen: false).insertNote(NoteModel(name: _noteNameController.value.text, description: _noteDescriptionController.value.text));
                  Navigator.pop(context);
                },
              )
            ],
          ),
      ),
    );
  }
}