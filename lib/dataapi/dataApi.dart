import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_shopping_task_w3/db/modals/bags_modal.dart';
import 'package:flutter_shopping_task_w3/db/modals/favorites_modal.dart';
import 'package:flutter_shopping_task_w3/db/modals/jackets_modal.dart';
import 'package:flutter_shopping_task_w3/db/modals/shoes_modal.dart';
import 'package:flutter_shopping_task_w3/db/tablehelpers/bagsHelper.dart';
import 'package:flutter_shopping_task_w3/db/tablehelpers/favoritesHelper.dart';
import 'package:flutter_shopping_task_w3/db/tablehelpers/jacketsHelper.dart';
import 'package:flutter_shopping_task_w3/db/tablehelpers/shoesHelper.dart';

class DataApi{
  var bagsData;
  var jacketsData;
  var shoesData;

  Future<List> getBagsData(BuildContext context) async{
    var bagData = await DefaultAssetBundle.of(context).loadString("assets/json/bags.json");
    bagsData =  jsonDecode(bagData);
    print('bags data $bagsData');
    BagsDbHelper().getBag().then((data){

      if(data.length == 0){
        for(var bag in bagsData){
          Bags oneBag = Bags(
            title: bag['title'],
            description: bag['description'],
            price: bag['price'],
            category:  bag['category'],
            image:  bag['image'],
            colors: jsonEncode(bag['colors']).toString(),
          );
          BagsDbHelper().saveBag(oneBag);
        }
      }
    });
    return BagsDbHelper().getBag();
  }

  Future<List> getShoesData(BuildContext context) async{
    var shoeData = await DefaultAssetBundle.of(context).loadString("assets/json/shoes.json");
    shoesData =  jsonDecode(shoeData);
    print('shoes data $shoesData');
    ShoesDbHelper().getShoes().then((data){

      if(data.length == 0){
        for(var shoe in shoesData){
          Shoes oneShoe = Shoes(
            title: shoe['title'],
            description: shoe['description'],
            price: shoe['price'],
            category:  shoe['category'],
            image:  shoe['image'],
            colors: jsonEncode(shoe['colors']).toString(),
          );
          ShoesDbHelper().saveShoes(oneShoe);
        }
      }
    });
    return ShoesDbHelper().getShoes();
  }

  Future<List> getJacketsData(BuildContext context) async{
    var jacketData = await DefaultAssetBundle.of(context).loadString("assets/json/jackets.json");
    jacketsData =  jsonDecode(jacketData);
    print('jackets data $jacketsData');
    JacketsDbHelper().getJacket().then((data){

      if(data.length == 0){
        for(var jacket in jacketsData){
          Jackets oneJacket = Jackets(
            title: jacket['title'],
            description: jacket['description'],
            price: jacket['price'],
            category:  jacket['category'],
            image:  jacket['image'],
            colors: jsonEncode(jacket['colors']).toString(),
          );
          JacketsDbHelper().saveJacket(oneJacket);
        }
      }
    });
    return JacketsDbHelper().getJacket();  }

  saveDataToFavoritesDataBase(var data){
    Favorites oneFavorite = Favorites(
      title: data.title,
      description: data.description,
      price: data.price,
      category:  data.category,
      image:  data.image,
      colors: data.colors,
    );
    FavoritesDbHelper().saveFavorite(oneFavorite);
  }
}