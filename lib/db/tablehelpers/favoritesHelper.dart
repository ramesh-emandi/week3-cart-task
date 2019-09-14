import 'dart:async';
import 'package:flutter_shopping_task_w3/db/modals/favorites_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDbHelper {
  static final FavoritesDbHelper _dataBaseHelperInstance =
      new FavoritesDbHelper.internal();

  FavoritesDbHelper.internal();

  factory FavoritesDbHelper() => _dataBaseHelperInstance;

  final String favoritesTable = 'Favorites';
  static Database _favoritesDatabase;

  Future<Database> get db async {
    if (_favoritesDatabase != null) {
      return _favoritesDatabase;
    }
    _favoritesDatabase = await initDb();

    return _favoritesDatabase;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'favorites.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int dbVersion) async {
    await db.execute(
        "CREATE TABLE $favoritesTable(title TEXT PRIMARY KEY, category TEXT, price TEXT, image TEXT, description TEXT, colors TEXT)");
  }

  Future<int> saveFavorite(Favorites favorites) async {
    var dbClient = await db;
    int result = await dbClient.insert(favoritesTable, favorites.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
    return result;
  }

  Future<List<Favorites>> getFavorite() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Favorites');
    List<Favorites> favoritesList = new List();
    for (int i = 0; i < list.length; i++) {
      var eachItem = new Favorites(
        title: list[i]["title"],
        price: list[i]["price"],
        description: list[i]["description"],
        category: list[i]["category"],
        colors: list[i]["colors"],
        image: list[i]["image"],
      );
      favoritesList.add(eachItem);
    }
    print("DB data.... " + favoritesList.toString());
    return favoritesList;
  }

  Future<int> deleteFavorite(Favorites favorites) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Favorites WHERE title = ?', [favorites.title]);
    return res;
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    int res = await dbClient.rawDelete('DELETE FROM Favorites');
    return res;
  }

  Future<bool> update(Favorites favorite) async {
    print(favorite.toMap());
    var dbClient = await db;
    int res = await dbClient.update("Favorites", favorite.toMap(),
        where: "title = ?", whereArgs: <String>[favorite.title]);
    print(res);
    return res > 0 ? true : false;
  }
}
