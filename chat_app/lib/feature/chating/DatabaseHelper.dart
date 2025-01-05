// import 'dart:io';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
//   return DatabaseHelper();
// });
//
// class DatabaseHelper {
//
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//
//   static Database? _database;
//
//   DatabaseHelper._internal();
//
//   factory DatabaseHelper() => _instance;
//
//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await initDatabase();
//     }
//     return _database!;
//   }
//
//   static const _databaseName = "whatsapp_clone.db";
//   final int _databaseVersion = 1;
//
//   final tableMessages = 'message';
//   final columnId = 'columnId';
//   final columnSenderId = 'senderId';
//   final columnReceiverId = 'receiverId';
//   final columnMessage = 'text';
//   final columnType = 'type';
//   final columnTimeSent = 'timeSent';
//   final columnIsSeen = 'isSeen';
//
//   Future<Database> initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _databaseName);
//     return await openDatabase(
//       path,
//       version: _databaseVersion,
//       onCreate: _createDb,
//     );
//   }
//
//   Future<void> _createDb(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $tableMessages (
//         $columnId TEXT PRIMARY KEY,
//         $columnSenderId TEXT NOT NULL,
//         $columnReceiverId TEXT NOT NULL,
//         $columnMessage TEXT NOT NULL,
//         $columnType TEXT NOT NULL,
//         $columnTimeSent TEXT NOT NULL,
//         $columnIsSeen TEXT NOT NULL
//       )
//     ''');
//   }
//
//   Future<int> insertMessage(Map<String, dynamic> row) async {
//     Database db = await database;
//     return await db.insert('message', row);
//   }
//
//   Future<int> updateMessage(Map<String, dynamic> row) async {
//     Database db = await database;
//     int id = row['id'];
//     return await db.update('message', row, where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<int> deleteMessage(int id) async {
//     Database db = await database;
//     return await db.delete('message', where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<void> delete() async {
//     Database db = await database;
//     return await db.execute("DROP TABLE IF EXISTS message");
//   }
//
//   Future<List<Map<String, dynamic>>> getMessages(String receiverId) async {
//     Database db = await database;
//
//     print("My receiverID == > $receiverId");
//
//     return await db.query('message',
//         where: 'senderId = ? OR receiverId = ?',
//         whereArgs: [receiverId, receiverId]);
//   }
// }
//
