import 'package:always_access_memory/I10n/localizations.dart';
import 'package:always_access_memory/Models/NoteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController _noteNameController = TextEditingController();
  bool noteNameFieldIsNotValid = false;

  TextEditingController _noteDescriptionController = TextEditingController();
  TextEditingController _noteAddressCityController = TextEditingController();
  TextEditingController _noteAddressStreetController = TextEditingController();
  TextEditingController _noteAddressHouseNumberController =
      TextEditingController();

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
              key: Key("NoteNameFormField"),
              controller: _noteNameController,
              decoration: InputDecoration(labelText: "Note name", errorText: noteNameFieldIsNotValid ? "Field is mandatory" : null),
              validator: (value) {
                print("validating");
                if (value.isEmpty) {
                  return "Name field is mandatory";
                }
                return null;
              },
            ),
            Text(""),
            TextFormField(
              controller: _noteDescriptionController,
              decoration: InputDecoration(labelText: "Note description"),
              validator: (value) {
                if (value.isEmpty) {
                  return "Description field is mandatory";
                }
                return null;
              },
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [ElevatedButton(
                child: Text("Add address"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          elevation: 16,
                          child: Container(
                              child: Column(
                            children: [
                              TextFormField(
                                controller: _noteAddressCityController,
                                decoration: InputDecoration(labelText: "City"),
                              ),
                              TextFormField(
                                controller: _noteAddressStreetController,
                                decoration: InputDecoration(labelText: "Street"),
                              ),
                              TextFormField(
                                controller: _noteAddressHouseNumberController,
                                decoration:
                                    InputDecoration(labelText: "House number"),
                              ),
                            ],
                          )));
                    },
                  );
                },
              ),]
            ),
            ElevatedButton(
              key: Key("SubmitNoteButton"),
              child: Text("Add"),
              onPressed: () async {
                if (_noteNameController.text.isNotEmpty) {
                  await Provider.of<NoteModel>(context, listen: false).insertNote(
                      NoteModel(
                          name: _noteNameController.value.text,
                          description: _noteDescriptionController.value.text,
                          address: _noteAddressCityController.value.text +
                              ";" +
                              _noteAddressStreetController.value.text +
                              ";" +
                              _noteAddressHouseNumberController.value.text));
                  Navigator.pop(context);
                }
                setState(() {
                  noteNameFieldIsNotValid = true;
                });

              },
            )
          ],
        ),
      ),
    );
  }
}
