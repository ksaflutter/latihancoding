import 'package:flutter_application_1/tugas_13/models/book.dart';
import 'package:path/path.dart'; // membantu gabungkan path file database sesuai sistem.
import 'package:sqflite/sqflite.dart'; // library SQLite untuk Flutter.

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper
      ._init(); // menerapkan Singleton Pattern (biar hanya ada 1 instance DatabaseHelper di aplikasi)
  static Database? _database;
  DatabaseHelper._init(); // constructor privat (hanya bisa dipanggil dari dalam class)
  Future<Database> get database async {
    if (_database != null)
      return _database!; // _database ....tempat menyimpan objek database yang sedang aktif.
    _database = await _initDB(
        'books.db'); // Jika _database sudah ada → langsung dipakai.
    return _database!; // belum → panggil _initDB untuk membuat database baru (books.db).
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath =
        await getDatabasesPath(); // cari lokasi folder database di device.
    final path = join(
        dbPath, filePath); // gabungkan folder + nama file database (books.db)
    return await openDatabase(
      path,
      version: 1,
      onCreate:
          _createDB, // callback untuk membuat tabel saat database pertama kali dibuat.
    );
  }

  Future _createDB(Database db, int version) async {
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const textTypeNullable = 'TEXT';
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,      // id → primary key auto increment.
        title $textType,                         // title, author, description, genre → text wajib diisi.
        author $textType,
        description $textType,
        genre $textType,
        totalPages $integerType,
        currentPage INTEGER DEFAULT 0,
        status TEXT DEFAULT 'to_read',           // status baca (to_read, reading, completed)
        coverImagePath $textTypeNullable,            // opsional (null boleh)
        dateAdded $textType,
        dateCompleted $textTypeNullable              // tanggal selesai (boleh null)
      )
    ''');
  }

  Future<Book> createBook(Book book) async {
    // Insert buku baru ke tabel.
    final db = await instance.database;
    final id = await db.insert(
        'books', book.toMap()); // book.toMap() → ubah objek Book ke bentuk Map.
    return book.copyWith(id: id); // buat objek baru dengan id hasil insert.
  }

  Future<Book?> readBook(int id) async {
    // Cari buku berdasarkan id.
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
      return Book.fromMap(maps.first); // Jika ketemu → convert ke Book
    } else {
      return null; // Kalau nggak ada → return null
    }
  }

  Future<List<Book>> readAllBooks() async {
    // Ambil semua buku.
    final db = await instance.database;
    const orderBy = 'dateAdded DESC'; // Urutkan dari terbaru (dateAdded DESC)
    final result = await db.query('books', orderBy: orderBy);
    return result
        .map((json) => Book.fromMap(json))
        .toList(); // Convert setiap baris hasil query jadi objek Book
  }

  Future<List<Book>> searchBooks(String query) async {
    // Cari buku berdasarkan title, author, atau genre
    final db = await instance.database;
    final result = await db.query(
      'books',
      where:
          'title LIKE ? OR author LIKE ? OR genre LIKE ?', // Gunakan LIKE untuk pencarian mirip (bukan exact match)
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'dateAdded DESC',
    );
    return result.map((json) => Book.fromMap(json)).toList();
  }

  Future<List<Book>> getBooksByStatus(String status) async {
    // Ambil semua buku dengan status tertentu (reading, completed, dll)
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
    // Update detail buku berdasarkan id
    final db = await instance.database;
    return db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    // Hapus buku berdasarkan id
    final db = await instance.database;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getTotalBooks() async {
    // getTotalBooks → hitung semua buku
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM books');
    return result.first['count'] as int;
  }

  Future<int> getCompletedBooks() async {
    // getCompletedBooks → hitung semua buku dengan status completed
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM books WHERE status = ?', ['completed']);
    return result.first['count'] as int;
  }

  Future<int> getCurrentlyReading() async {
    // getCurrentlyReading → hitung semua buku dengan status reading
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM books WHERE status = ?', ['reading']);
    return result.first['count'] as int;
  }

  Future close() async {
    // Tutup koneksi database ketika aplikasi selesai
    final db = await instance.database;
    db.close();
  }
}
