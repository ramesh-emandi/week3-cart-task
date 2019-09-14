import 'dart:async';
import 'package:flutter_shopping_task_w3/db/modals/shoes_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShoesDbHelper {
  static final ShoesDbHelper _dataBaseHelperInstance =
      new ShoesDbHelper.internal();

  ShoesDbHelper.internal();

  factory ShoesDbHelper() => _dataBaseHelperInstance;

  final String shoesTable = 'Shoes';

  static Database _shoesDatabase;

  Future<Database> get db async {
    if (_shoesDatabase != null) {
      return _shoesDatabase;
    }
    _shoesDatabase = await initDb();

    return _shoesDatabase;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'shoes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int dbVersion) async {
    await db.execute(
        "CREATE TABLE $shoesTable(title TEXT PRIMARY KEY, category TEXT, price TEXT, image TEXT, description TEXT, colors TEXT)");
  }

  Future<int> saveShoes(Shoes shoe) async {
    var dbClient = await db;
    int result = await dbClient.insert(shoesTable, shoe.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
    return result;
  }

  Future<List<Shoes>> getShoes() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Shoes');
    List<Shoes> shoesList = new List();
    for (int i = 0; i < list.length; i++) {
      var eachshoe = new Shoes(
        title: list[i]["title"],
        price: list[i]["price"],
        description: list[i]["description"],
        category: list[i]["category"],
        colors: list[i]["colors"],
        image: list[i]["image"],
      );
      shoesList.add(eachshoe);
    }
    print("DB data.... " + shoesList.toString());
    return shoesList;
  }

  Future<int> deleteShoes(Shoes shoe) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Shoes WHERE title = ?', [shoe.title]);
    return res;
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    int res = await dbClient.rawDelete('DELETE FROM Shoes');
    return res;
  }

  Future<bool> update(Shoes shoe) async {
    print(shoe.toMap());
    var dbClient = await db;
    int res = await dbClient.update("Shoes", shoe.toMap(),
        where: "title = ?", whereArgs: <String>[shoe.title]);
    print(res);
    return res > 0 ? true : false;
  }
}
