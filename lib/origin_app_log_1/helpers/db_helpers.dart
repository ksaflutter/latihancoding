import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class DatabaseHelperSatu {
  static Database? _database;

  static DatabaseHelperSatu? _instance;

  DatabaseHelperSatu._internal();

  factory DatabaseHelperSatu() {
    _instance ??= DatabaseHelperSatu._internal();

    return _instance!;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  //get sha256 => null;

  get instance => null;

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Insert default admin user for testing
    String hashedPassword = _hashPassword('admin123');
    await db.insert('users', {
      'name': 'Admin User',
      'email': 'admin@example.com',
      'password': hashedPassword,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  String _hashPassword(String password) {
    var bytes = utf8.encode(password); // ubah password jadi bytes
    var digest = sha256.convert(bytes); // hash dengan sha256
    return digest.toString(); // hasil hash dalam bentuk string hex
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    try {
      // Hash password before storing
      User hashedUser = user.copyWith(
        password: _hashPassword(user.password),
      );
      return await db.insert('users', hashedUser.toMap());
    } catch (e) {
      print('Error inserting user: $e');
      rethrow;
    }
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (maps.isNotEmpty) {
        return User.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Error getting user by email: $e');
      return null;
    }
  }

  Future<User?> authenticateUser(String email, String password) async {
    final db = await database;
    try {
      String hashedPassword = _hashPassword(password);
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, hashedPassword],
      );

      if (maps.isNotEmpty) {
        return User.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Error authenticating user: $e');
      return null;
    }
  }

  Future<bool> emailExists(String email) async {
    final user = await getUserByEmail(email);
    return user != null;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('users');
      return List.generate(maps.length, (i) => User.fromMap(maps[i]));
    } catch (e) {
      print('Error getting all users: $e');
      return [];
    }
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    try {
      return await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      print('Error updating user: $e');
      return 0;
    }
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    try {
      return await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting user: $e');
      return 0;
    }
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}
