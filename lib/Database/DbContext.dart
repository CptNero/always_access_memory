import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbContext {

 static  Future<Database> getDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'always_access_memory_database.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE notes(id INTEGER PRIMARY KEY, name TEXT, description TEXT)",
          );
        }
    );

    return database;
  }
}


