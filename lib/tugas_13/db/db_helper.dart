import 'package:flutter_application_1/tugas_13/models/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('books.db');
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
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const textTypeNullable = 'TEXT';
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title $textType,
        author $textType,
        description $textType,
        genre $textType,
        totalPages $integerType,
        currentPage INTEGER DEFAULT 0,
        status TEXT DEFAULT 'to_read',
        coverImagePath $textTypeNullable,
        dateAdded $textType,
        dateCompleted $textTypeNullable
      )
    ''');
  }

  Future<Book> createBook(Book book) async {
    final db = await instance.database;
    final id = await db.insert('books', book.toMap());
    return book.copyWith(id: id);
  }

  Future<Book?> readBook(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'books',
      columns: [
        'id',
        'title',
        'author',
        'description',
        'genre',
        'totalPages',
        'currentPage',
        'status',
        'coverImagePath',
        'dateAdded',
        'dateCompleted'
      ],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Book.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;
    const orderBy = 'dateAdded DESC';
    final result = await db.query('books', orderBy: orderBy);
    return result.map((json) => Book.fromMap(json)).toList();
  }

  Future<List<Book>> searchBooks(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'books',
      where: 'title LIKE ? OR author LIKE ? OR genre LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'dateAdded DESC',
    );
    return result.map((json) => Book.fromMap(json)).toList();
  }

  Future<List<Book>> getBooksByStatus(String status) async {
    final db = await instance.database;
    final result = await db.query(
      'books',
      where: 'status = ?',
      whereArgs: [status],
      orderBy: 'dateAdded DESC',
    );
    return result.map((json) => Book.fromMap(json)).toList();
  }

  Future<int> updateBook(Book book) async {
    final db = await instance.database;
    return db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await instance.database;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getTotalBooks() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM books');
    return result.first['count'] as int;
  }

  Future<int> getCompletedBooks() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM books WHERE status = ?', ['completed']);
    return result.first['count'] as int;
  }

  Future<int> getCurrentlyReading() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM books WHERE status = ?', ['reading']);
    return result.first['count'] as int;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
