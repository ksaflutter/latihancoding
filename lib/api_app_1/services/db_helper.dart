// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../models/user.dart';
// import '../models/attendance.dart';

import 'package:flutter_application_1/api_app_1/models/attendant.dart';
import 'package:flutter_application_1/api_app_1/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperApi1 {
  static final DBHelperApi1 instance = DBHelperApi1._init();
  static Database? _database;

  DBHelperApi1._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('attendance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE attendance(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        status TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');
  }

  // User operations
  Future<int> createUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUser(String email, String password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  // Attendance operations
  Future<int> createAttendance(Attendance attendance) async {
    final db = await database;
    return await db.insert('attendance', attendance.toMap());
  }

  Future<List<Attendance>> getAttendanceByUserId(int userId) async {
    final db = await database;
    final maps = await db.query(
      'attendance',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'date DESC, time DESC',
    );

    return maps.map((map) => Attendance.fromMap(map)).toList();
  }

  Future<int> updateAttendance(Attendance attendance) async {
    final db = await database;
    return await db.update(
      'attendance',
      attendance.toMap(),
      where: 'id = ?',
      whereArgs: [attendance.id],
    );
  }

  Future<int> deleteAttendance(int id) async {
    final db = await database;
    return await db.delete(
      'attendance',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, int>> getAttendanceSummary(int userId) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT status, COUNT(*) as count
      FROM attendance
      WHERE userId = ?
      GROUP BY status
    ''', [userId]);

    Map<String, int> summary = {
      'Present': 0,
      'Absent': 0,
      'Late': 0,
    };

    for (var row in result) {
      summary[row['status'] as String] = row['count'] as int;
    }

    return summary;
  }
}
