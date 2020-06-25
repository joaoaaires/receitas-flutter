import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;
  static DatabaseHelper _databaseHelper;

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._internalConstructor();
    print(
      ">>>>>>>>> Iniciando Banco Uma Unica Vez. ${_databaseHelper.hashCode}",
    );
    return _databaseHelper;
  }

  DatabaseHelper._internalConstructor();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    var path = await getDatabasesPath();
    return openDatabase(
      join(path, "data.db"),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<Null> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS receita (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idserver INT,
          titulo TEXT NOT NULL
      );
      ''',
    );
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS ingrediente (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idserver INT,
          idreceita INT NOT NULL,
          descricao TEXT
      );
      ''',
    );
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS modopreparo (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idserver INT,
          idreceita INT NOT NULL,                    
          descricao TEXT
      );
      ''',
    );
  }

}
