import 'package:flutter/material.dart';
import 'package:flutter_shopping_task_w3/dataapi/dataApi.dart';
import 'package:flutter_shopping_task_w3/main.dart';

class BagsView extends StatefulWidget {
  @override
  _BagsViewState createState() => _BagsViewState();
}

class _BagsViewState extends State<BagsView> {

  var bagsData = [];
  @override
  void initState() {
    super.initState();
    DataApi().getBagsData(context).then((onValue){
     if(mounted){
       setState(() {
         bagsData = onValue;
       });
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        primary: true,
        crossAxisCount: 2,
        childAspectRatio: 0.80,
        children: List.generate(bagsData.length, (index){
          return Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Material(
              child: InkWell(
                splashColor: Colors.deepPurple,
                onTap: (){
                  DataApi().saveDataToFavoritesDataBase(bagsData[index]);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Added to Favorites'),
                    duration: Duration(seconds: 3),
                  ));
//                  HomeRootWidget.tabsKey.currentState.tabController.animateTo(2);
                },
                child: new Card(

                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(5.0))),
                    elevation: 1.5,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Hero(
                          tag: bagsData[index].title ,
                          child: new Image.network(
                            bagsData[index].image,
                            height: 150.0,
                            width: 100.0,),
                        ),
                        new Padding(
                          padding: EdgeInsets.only(left: 10.0,top: 10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Text(bagsData[index].title,style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w700,fontSize: 18.0),),
                              new Text(bagsData[index].price,style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500,fontSize: 15.0)),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          );
        }),
          ),
    );
  }
}
