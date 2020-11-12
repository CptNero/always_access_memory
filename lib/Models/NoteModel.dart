import 'dart:core';
import 'package:always_access_memory/Database/DbContext.dart';
import 'package:sqflite/sqflite.dart';
import '../Database/DbContext.dart';

class NoteModel {
  int id;
  String name;
  String description;

  NoteModel({this.id, this.name, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description
    };
  }

  static Future<void> insertNote(NoteModel note) async {
    final Database db = await DbContext.getDatabase();

    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    db.close();
  }

  static Future<List<NoteModel>> fetchAll() async  {
    final Database db = await DbContext.getDatabase();

    final List<Map<String, dynamic>> notes = await db.query('notes');

    return List.generate(notes.length, (i) {
      return NoteModel(
        id: notes[i]['id'],
        name: notes[i]['name'],
        description: notes[i]['description'],
      );
    });
  }
}