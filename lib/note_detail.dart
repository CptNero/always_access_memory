import 'package:always_access_memory/Models/NoteModel.dart';
import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  final NoteModel note;

  NoteDetail(this.note);


  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.note.description),
          ],
        ),
      ),
    );
  }
}