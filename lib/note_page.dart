import 'package:always_access_memory/Models/NoteModel.dart';
import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  NoteModel note;

  NotePage(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note.name)),
      body: Center(child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              subtitle: Text(note.description, style: TextStyle(fontSize: 20)),
            )
          ],
        )
      ),
      ),
    );
  }
}
