import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/biodata.dart';
import '../models/user.dart';

class DBHelperAll1 {
  static final DBHelperAll1 instance = DBHelperAll1._init();
  static Database? _database;

  DBHelperAll1._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('student_biodata.db');
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

  Future<void> _createDB(Database db, int version) async {
    const userTable = '''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        name TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''';

    const biodataTable = '''
      CREATE TABLE biodata(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        dateOfBirth TEXT NOT NULL,
        gender TEXT NOT NULL,
        address TEXT NOT NULL,
        phone TEXT NOT NULL,
        studentClass TEXT NOT NULL,
        course TEXT NOT NULL,
        registrationDate TEXT NOT NULL,
        registrationTime TEXT NOT NULL,
        userId INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''';

    await db.execute(userTable);
    await db.execute(biodataTable);
  }

  // User Operations
  Future<int> insertUser(User user) async {
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

  // Biodata Operations
  Future<int> insertBiodata(Biodata biodata) async {
    final db = await database;
    return await db.insert('biodata', biodata.toMap());
  }

  Future<List<Biodata>> getAllBiodata(int userId) async {
    final db = await database;
    final maps = await db.query(
      'biodata',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );

    return maps.map((map) => Biodata.fromMap(map)).toList();
  }

  Future<int> updateBiodata(Biodata biodata) async {
    final db = await database;
    return await db.update(
      'biodata',
      biodata.toMap(),
      where: 'id = ?',
      whereArgs: [biodata.id],
    );
  }

  Future<int> deleteBiodata(int id) async {
    final db = await database;
    return await db.delete(
      'biodata',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
