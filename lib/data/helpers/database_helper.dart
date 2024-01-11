import 'package:resto_fav_apps/data/models/response_restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  DatabaseHelper._internal() {
    _instance = this;
  }
  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
  static const String _tableFavorite = 'tableFavorite';

  Future<Database> _initDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/restaurant.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tableFavorite(
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             city TEXT,
             pictureId TEXT,
             rating REAL)''');
    }, version: 1);
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    } else {
      null;
    }

    return _database;
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    final db = await database;
    await db?.insert(_tableFavorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableFavorite);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>>? results = await db?.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results?.isNotEmpty == true) {
      return results?.first ?? {};
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db?.delete(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
