import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Future<Database> initDB() async {
    String dbPath = join(await getDatabasesPath(), 'database.db');
    Database db = await openDatabase(
      dbPath,
      onCreate: (db, ver) async {
        await db.execute(
          'CREATE DATABASE Results(id INTEGER PRIMARY KEY AUTOINCREMENT)',
        );
      },
      version: 1,
    );

    return db;
  }
}
