import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'event_model.dart';

class DBHelper {
  // Singleton pattern
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  // Getter supaya bisa dipanggil: DBHelper.instance
  static DBHelper get instance => _instance;

  static Database? _database;

  // Getter untuk akses database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('event_db.db');
    return _database!;
  }

  // Inisialisasi database
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Buat tabel
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        email TEXT NOT NULL,
        event TEXT NOT NULL,
        kota TEXT NOT NULL
      )
    ''');
  }

  // CREATE
  Future<int> insertEvent(EventModel event) async {
    final db = await database;
    return await db.insert('events', event.toMap());
  }

  // READ
  Future<List<EventModel>> getEvents() async {
    final db = await database;
    final result = await db.query('events', orderBy: "id DESC");
    return result.map((e) => EventModel.fromMap(e)).toList();
  }

  // UPDATE
  Future<int> updateEvent(EventModel event) async {
    final db = await database;
    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  // DELETE
  Future<int> deleteEvent(int id) async {
    final db = await database;
    return await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
