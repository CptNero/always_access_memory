import 'dart:convert';
import 'dart:io';

import 'package:always_access_memory/I10n/localizations.dart';
import 'package:always_access_memory/Models/NoteModel.dart';
import 'package:always_access_memory/take_picture_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

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
  TextEditingController _noteAddressHouseNumberController = TextEditingController();
  String imagePath = "";
  String imageAsBase64 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AamLocalizations.of(context).stringById('addNote')),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                key: Key("NoteNameFormField"),
                controller: _noteNameController,
                decoration: InputDecoration(
                    labelText: AamLocalizations.of(context).stringById('name'),
                    errorText: noteNameFieldIsNotValid ? AamLocalizations.of(context).stringById('fieldIsMandatory') : null),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Name field is mandatory";
                  }
                  return null;
                },
              ),
              Text(""),
              TextFormField(
                controller: _noteDescriptionController,
                decoration: InputDecoration(labelText: AamLocalizations.of(context).stringById('description')),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Description field is mandatory";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ElevatedButton(
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
                    onPressed: () async {
                      WidgetsFlutterBinding.ensureInitialized();
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;

                      imagePath = await Navigator.push(context, MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera),)) as String;

                      var bytes = File(imagePath).readAsBytesSync();
                      imageAsBase64 = base64Encode(bytes);
                      print(imageAsBase64);
                    },
                    child: Icon(Icons.camera),
                  ),
                ]
              ),
              ElevatedButton(
                key: Key("SubmitNoteButton"),
                child: Text(AamLocalizations.of(context).stringById('add')),
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
                                _noteAddressHouseNumberController.value.text,
                            image: imageAsBase64,
                        ));
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
      ),
    );
  }
}
