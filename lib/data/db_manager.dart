
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {

  String dbName = "madshop1.db";

  static final DBManager instance = DBManager._init();

  DBManager._init();

  Future<Database> get database async {
    // Get Path
    final dbPath = await getDatabasesPath();
    // Path
    final path = join(dbPath, dbName);
    // Open DB
    return openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) async {
    String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    String textType = "TEXT";
    String realType = "REAL";
    String intType = "INTEGER";
    String boolType = "INTEGER";

      final categoryTable = '''
        CREATE TABLE IF NOT EXISTS categories (
          id $idType,
          name $textType
        )
      ''';
      db.execute(categoryTable);

    final productTable = '''
        CREATE TABLE IF NOT EXISTS products (
          id $idType,
          name $textType,
          description $textType,
          price $realType,
          discount $intType,
          rate $intType,
          stock $boolType
        )
      ''';
    db.execute(productTable);

    final cartTable = '''
        CREATE TABLE IF NOT EXISTS carts (
          id $idType,
          product_id $intType,
          qty $intType,
          price $realType,
          discount $intType
        )
      ''';
    db.execute(cartTable);

    final favoriteTable = '''
        CREATE TABLE IF NOT EXISTS favorites (
          id $idType,
          product_id $intType
        )
      ''';
    db.execute(favoriteTable);
  }
}