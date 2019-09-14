import 'package:flutter/material.dart';
import 'package:flutter_shopping_task_w3/dataapi/dataApi.dart';
import 'package:flutter_shopping_task_w3/views/bags.dart';
import 'package:flutter_shopping_task_w3/views/favoritesTab.dart';
import 'package:flutter_shopping_task_w3/views/homeTab.dart';
import 'package:flutter_shopping_task_w3/views/profileTab.dart';

void main() => runApp(HomeRootWidget());

class HomeRootWidget extends StatelessWidget {
  static final tabsKey = new GlobalKey<_HomeViewState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tantra Shopping',
      home: HomeView(
        key: tabsKey,
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  int _selectedIndex =0;

  TabController tabController;
  @override
  void initState() {
    super.initState();
    DataApi apiInstance = new DataApi();
    apiInstance.getShoesData(context);
    apiInstance.getBagsData(context);
    apiInstance.getJacketsData(context);
    tabController = TabController(
      length: 4,
      initialIndex: 0,
      vsync: this
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    print('select $_selectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Color.fromRGBO(87, 62, 189, 1.0),
          height: 50.0,
          child: TabBar(
            labelColor: Colors.white30,
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.transparent,
            controller: tabController,
            tabs:
            [
              _tabItem(icon: Icon(Icons.home),title: "",),
              _tabItem(icon: Icon(Icons.chat_bubble_outline),title: ""),
              _tabItem(icon: Icon(Icons.favorite_border),title: ""),
              _tabItem(icon: Icon(Icons.person_outline),title: ""),

            ],
            onTap: _onItemTapped,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          ShoppingHomeView(),
          BagsView(),
          FavoritesView(),
          ProfileWidget(),
        ],
      ),
    );
  }

  _tabItem({Icon icon,String title}){
    return  Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
      children: <Widget>[
        icon,
        Text(title)
      ],
      ),
    );
  }
}


