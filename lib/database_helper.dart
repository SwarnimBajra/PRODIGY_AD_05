import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'qr_codes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE qr_codes(id INTEGER PRIMARY KEY, data TEXT, format TEXT, timestamp TEXT)',
        );
      },
    );
  }

  Future<void> insertQRCode(String data, String format) async {
    final db = await database;
    await db.insert(
      'qr_codes',
      {
        'data': data,
        'format': format,
        'timestamp': DateTime.now().toIso8601String()
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getQRCodes() async {
    final db = await database;
    return await db.query('qr_codes');
  }
}
