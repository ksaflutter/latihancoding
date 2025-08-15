// import 'dart:async';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import '../model/user.dart';

// class DBHelper {
//   static const String tableName = 'users';

//   static Future<Database> databaseHelper() async {
//     final dbPath = await getDatabasesPath();
//     return openDatabase(
//       join(dbPath, 'peserta.db'),
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE $tableName (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             email TEXT NOT NULL,
//             password TEXT NOT NULL,
//             name TEXT NOT NULL
//           )
//         ''');
//       },
//       version: 1,
//     );
//   }

//   static Future<void> registerUser(User user) async {
//     final db = await databaseHelper();
//     await db.insert(tableName, user.toMap());
//   }

//   static Future<List<User>> getAllUsers() async {
//     final db = await databaseHelper();
//     final List<Map<String, dynamic>> results = await db.query(tableName);
//     return results.map((e) => User.fromMap(e)).toList();
//   }
// }
