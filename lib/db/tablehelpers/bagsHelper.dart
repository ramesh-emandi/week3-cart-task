import 'dart:async';
import 'package:flutter_shopping_task_w3/db/modals/bags_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BagsDbHelper {
  static final BagsDbHelper _dataBaseHelperInstance =
      new BagsDbHelper.internal();

  BagsDbHelper.internal();

  factory BagsDbHelper() => _dataBaseHelperInstance;

  final String bagsTable = 'Bags';

  static Database _bagsDatabase;

  Future<Database> get db async {
    if (_bagsDatabase != null) {
      return _bagsDatabase;
    }
    _bagsDatabase = await initDb();

    return _bagsDatabase;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bags.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int dbVersion) async {
    await db.execute(
        "CREATE TABLE $bagsTable(title TEXT PRIMARY KEY, category TEXT, price TEXT, image TEXT, description TEXT, colors TEXT)");
  }

  Future<int> saveBag(Bags bag) async {
    var dbClient = await db;
    int result = await dbClient.insert(bagsTable, bag.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
    return result;
  }

  Future<List<Bags>> getBag() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Bags');
    List<Bags> bagsList = new List();
    for (int i = 0; i < list.length; i++) {
      var eachBag = new Bags(
        title: list[i]["title"],
        price: list[i]["price"],
        description: list[i]["description"],
        category: list[i]["category"],
        colors: list[i]["colors"],
        image: list[i]["image"],
      );
      bagsList.add(eachBag);
    }
    print("DB data.... " + bagsList.toString());
    return bagsList;
  }

  Future<int> deleteBag(Bags bag) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Bags WHERE title = ?', [bag.title]);
    return res;
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    int res = await dbClient.rawDelete('DELETE FROM Bags');
    return res;
  }

  Future<bool> updateBag(Bags bag) async {
    print(bag.toMap());
    var dbClient = await db;
    int res = await dbClient.update("Bags", bag.toMap(),
        where: "title = ?", whereArgs: <String>[bag.title]);
    print(res);
    return res > 0 ? true : false;
  }
}
