import 'package:flutter/material.dart';
class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

//  var light_color = Colors.white;
//  var dark_color = Colors.black;
  static bool isDark = false;
  var theme_text_color = Colors.black;//isDark?Colors.white:Colors.black;//= light_color;
  var theme_view_color = Colors.white;//isDark?Colors.black:Colors.white;//= light_color;

  invertTheme() {
    isDark = !isDark;
    theme_text_color = isDark?Colors.white:Colors.black;
    theme_view_color = isDark?Colors.black:Colors.white;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: theme_view_color,
//        appBar: AppBar(
//          iconTheme: IconThemeData(color: Colors.grey),
//          backgroundColor: theme_view_color,
//          elevation: 0.0,
//          leading: Icon(Icons.arrow_back, color: Colors.grey),
//          actions: <Widget>[
//            Icon(
//              Icons.favorite,
//              color: Colors.grey,
//            ),
//            Icon(
//              Icons.more_vert,
//              color: Colors.grey,
//            )
//            // Options button
//          ],
//        ),
        body: Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 15.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            ("assets/images/elon_musk_royal_society.jpg"),
                          ),
                          radius: 60.0,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          child: CircleAvatar(
                              radius: 12,
                              backgroundImage: AssetImage(
                                ("assets/images/twitter_verified.jpg"),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "Elon Musk",
                  style: TextStyle(
                    color: theme_text_color,
                    fontWeight: FontWeight.w700,
                    fontSize: 32.0,
                  ),
                ),
                Text(
                  "PRODUCT DESIGNER",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(139, 139, 139, 1.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 10.0, 0.0),
                  child: Text(
                    "Create great interfaces",
                    style: TextStyle(
                        color: theme_text_color,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal
                    ),
                  ),
                ),
                Text(
                  "@TwWorks",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.underline,
                    color: theme_view_color,
                  ),
                ),
                Container(
                  width: 250.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/twitter2.png",
                          width: 20,
                          height: 20,
                        ),
                        Image.asset(
                          "assets/images/medium.png",
                          width: 20,
                          height: 20,
                        ),
                        Image.asset(
                          "assets/images/linkedin2.png",
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  child: Text(
                    "Hire Me",
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    setState(() {
                      invertTheme();
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 45.0,
                  minWidth: 170,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                Divider(
                  color: theme_text_color,
                  indent: 50,
                  endIndent: 50,
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              ("assets/images/Dribbble-icon.png"),
                            ),
                            radius: 40.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 2.0),
                            child: Text(
                              "1.3k",
                              style: TextStyle(
                                  color: theme_text_color,
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: Color.fromRGBO(204, 206, 216, 0.9),
                                fontSize: 22,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              ("assets/images/behance-logo.png"),
                            ),
                            radius: 40.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 2.0),
                            child: Text(
                              "1.3k",
                              style: TextStyle(
                                  color: theme_text_color,
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: Color.fromRGBO(204, 206, 216, 0.9),
                                fontSize: 22,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
