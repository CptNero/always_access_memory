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
  TextEditingController _noteAddressCityController = TextEditingController();
  TextEditingController _noteAddressStreetController = TextEditingController();
  TextEditingController _noteAddressHouseNumberController = TextEditingController();

  @override
  void initState() {
    _noteNameController.text = note.name;
    _noteDescriptionController.text = note.description;

    List<String> splitAddress = note.address.split(";");
    _noteAddressCityController.text = splitAddress[0];
    _noteAddressStreetController.text = splitAddress[1];
    _noteAddressHouseNumberController.text = splitAddress[2];
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
              child: Text(AamLocalizations.of(context).stringById('addAddress')),
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
                                  decoration: InputDecoration(labelText: AamLocalizations.of(context).stringById('city')),
                                ),
                                TextFormField(
                                  controller: _noteAddressStreetController,
                                  decoration: InputDecoration(labelText: AamLocalizations.of(context).stringById('street')),
                                ),
                                TextFormField(
                                  controller: _noteAddressHouseNumberController,
                                  decoration:
                                  InputDecoration(labelText: AamLocalizations.of(context).stringById('houseNumber')),
                                ),
                              ],
                            )));
                  },
                );
              },
            ),
            ElevatedButton(
              child: Text("Edit"),
              onPressed: () async {
                await Provider.of<NoteModel>(context, listen: false).updateNote(NoteModel(
                    id: note.id,
                    name: _noteNameController.value.text,
                    description: _noteDescriptionController.value.text,
                    address: _noteAddressCityController.value.text + ";" + _noteAddressStreetController.value.text + ";" + _noteAddressHouseNumberController.value.text,
                    image: note.image),);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}