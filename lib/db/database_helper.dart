import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/cidade.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE city(id INTEGER PRIMARY KEY, name TEXT, country TEXT, populationInMillions TEXT, type TEXT)');
  }

  Future<int> inserirCidade(CidadeModel cidade) async {
    var dbClient = await db;
    var result = await dbClient.insert("cidade", cidade.toMap());
    return result;
  }

  Future<List> getCidades() async {
    var dbClient = await db;
    var result = await dbClient.query("cidade",
        columns: ["id", "name", "country", "populationInMillions", "type"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM cidade'));
  }

  Future<CidadeModel> getCidade(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("cidade",
        columns: ["id", "name", "country", "populationInMillions", "type"],
        where: 'ide = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new CidadeModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteCidade(int id) async {
    var dbClient = await db;
    return await dbClient.delete("cidade", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCidade(CidadeModel cidade) async {
    var dbClient = await db;
    return await dbClient.update("cidade", cidade.toMap(),
        where: "id = ?", whereArgs: [cidade.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
