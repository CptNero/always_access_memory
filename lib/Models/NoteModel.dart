import 'dart:core';
import 'package:always_access_memory/Database/DbContext.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import '../Database/DbContext.dart';

class NoteModel extends ChangeNotifier {
  int id;
  String name;
  String description;
  String address;

  NoteModel({this.id, this.name, this.description, this.address});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address' : address,
    };
  }

  Future<void> insertNote(NoteModel note) async {
    final Database db = await DbContext.getDatabase();

    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    notifyListeners();
    await db.close();
    return;
  }

  Future<void> updateNote(NoteModel note) async {
    final db = await DbContext.getDatabase();

    await db.update(
      'notes',
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );

    notifyListeners();
    return;
  }

  Future<void> deleteNote(int id) async {
    final db = await DbContext.getDatabase();

    await db.delete(
      'notes',
      where: "id = ?",
      whereArgs: [id],
    );

    notifyListeners();
    return;
  }

  Future<List<NoteModel>> fetchAll() async  {
    final Database db = await DbContext.getDatabase();

    final List<Map<String, dynamic>> notes = await db.query('notes');

    return List.generate(notes.length, (i) {
      return NoteModel(
        id: notes[i]['id'],
        name: notes[i]['name'],
        description: notes[i]['description'],
        address: notes[i]['address'],
      );
    });
  }

  void refresh() async {
    notifyListeners();
  }
}