import 'dart:async';
import 'package:flutter_shopping_task_w3/db/modals/jackets_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class JacketsDbHelper {
  static final JacketsDbHelper _dataBaseHelperInstance =
      new JacketsDbHelper.internal();

  JacketsDbHelper.internal();

  factory JacketsDbHelper() => _dataBaseHelperInstance;

  final String jacketsTable = 'Jackets';

  static Database _jacketsDatabase;

  Future<Database> get db async {
    if (_jacketsDatabase != null) {
      return _jacketsDatabase;
    }
    _jacketsDatabase = await initDb();

    return _jacketsDatabase;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'jacketss.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int dbVersion) async {
    await db.execute(
        "CREATE TABLE $jacketsTable(title TEXT PRIMARY KEY, category TEXT, price TEXT, image TEXT, description TEXT, colors TEXT)");
  }

  Future<int> saveJacket(Jackets jacket) async {
    var dbClient = await db;
    int result = await dbClient.insert(jacketsTable, jacket.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
    return result;
  }

  Future<List<Jackets>> getJacket() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Jackets');
    List<Jackets> jacketsList = new List();
    for (int i = 0; i < list.length; i++) {
      var eachBag = new Jackets(
        title: list[i]["title"],
        price: list[i]["price"],
        description: list[i]["description"],
        category: list[i]["category"],
        colors: list[i]["colors"],
        image: list[i]["image"],
      );
      jacketsList.add(eachBag);
    }
    print("DB data.... " + jacketsList.toString());
    return jacketsList;
  }

  Future<int> deleteJacket(Jackets jacket) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Jackets WHERE title = ?', [jacket.title]);
    return res;
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    int res = await dbClient.rawDelete('DELETE FROM Jackets');
    return res;
  }

  Future<bool> update(Jackets jacket) async {
    print(jacket.toMap());
    var dbClient = await db;
    int res = await dbClient.update("Jackets", jacket.toMap(),
        where: "title = ?", whereArgs: <String>[jacket.title]);
    print(res);
    return res > 0 ? true : false;
  }
}
