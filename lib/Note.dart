import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/NoteModel.dart';

class Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Card(
        child: new Row (
          children: <Widget>[
            Text("Sajt")
          ],
        )
      )
    );
  }
}