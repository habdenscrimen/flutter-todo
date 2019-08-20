import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './model.dart';

class TodoService {
  static final _databaseName = "flutter_todo.db";
  static final _databaseVersion = 1; // Increment when changing schema.

  // Make this a singleton class.
  TodoService._privateConstructor();
  static final TodoService instance = TodoService._privateConstructor();

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
        $columnDone INTEGER NOT NULL
      )
    ''');
  }

  Future add(TodoModel todo) async {
    Database db = await database;
    await db.insert(tableTodo, todo.toMap());
  }

  Future<List<TodoModel>> list() async {
    Database db = await database;
    List<Map> records = await db.query(tableTodo);

    return records.isNotEmpty
        ? records.map((t) => TodoModel.fromMap(t)).toList()
        : [];
  }
}
