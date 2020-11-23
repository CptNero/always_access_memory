import 'package:always_access_memory/Models/NoteModel.dart';
import 'package:always_access_memory/display_picture_screen.dart';
import 'package:flutter/material.dart';

import 'I10n/localizations.dart';
import 'google_maps.dart';

class NotePage extends StatelessWidget {
  final NoteModel note;

  NotePage(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note.name)),
      body: Center(child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Visibility(
              visible: note.description.isNotEmpty || note.description != "",
              child: ListTile(
                title: Text( AamLocalizations.of(context).stringById('description')),
                subtitle: Text(note.description, style: TextStyle(fontSize: 20)),
              ),
            ),
            Visibility(
              visible: note.address != ";;",
              child: ListTile(
                title: Text( AamLocalizations.of(context).stringById('relatedAddress')),
                subtitle: Text(note.address.replaceAll(";", " "), style: TextStyle(fontSize: 20)),
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    print(note.address.length);
                    return NoteMap(note.address);
                  });
                },
              ),
            ),
            Expanded(child: DisplayPictureScreen(imageAsBase64: note.image))
          ],
        )
      ),
      ),
    );
  }
}
