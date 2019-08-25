import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:todo/model/todo.dart';

class TodoProvider {
  static final _databaseName = "flutter_todo.db";
  static final _databaseVersion = 1; // Increment when changing schema.

  // Make this a singleton class.
  TodoProvider._privateConstructor();
  static final TodoProvider instance = TodoProvider._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableTodo (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnDone INTEGER NOT NULL,
        $columnStartTime TEXT NOT NULL,
        $columnEndTime TEXT NOT NULL,
        $columnDay TEXT NOT NULL
      )
    ''');
  }

  Future add(TodoModel todo) async {
    Database db = await database;
    await db.insert(tableTodo, todo.toMap());
  }

  Future<List<TodoModel>> list(DateTime day) async {
    Database db = await database;
    List<Map> records = await db.query(
      tableTodo,
      where: '$columnDay = ?',
      whereArgs: [day.toIso8601String()],
    );

    return records.isNotEmpty
        ? records.map((t) => TodoModel.fromMap(t)).toList()
        : [];
  }

  Future<void> update(TodoModel todo) async {
    Database db = await database;

    return await db.update(
      tableTodo,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> delete(TodoModel todo) async {
    Database db = await database;

    await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [todo.id]);
  }
}
