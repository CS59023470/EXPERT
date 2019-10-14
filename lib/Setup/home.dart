import 'package:flutter/material.dart';

import 'Location.dart';
import 'ProFile.dart';
import 'assessment.dart';
import 'camera.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFEBE4D6),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 325.0, right: 20.0, top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ProFile()));
                            },
                            child: Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      image: new AssetImage("assets/menu.png"), height: 45.0, width: 45.0)
                                ],//<Widget>[]
                              ),//Column
                            ),//Container,
                          )//GestureDetector
                      )//Padding
                    ],//<Widget>[]
                  ),//Row
                  new Text("MENU",style: new TextStyle(fontSize: 65.0)),
                  new SizedBox(
                      height: 35.0),//SizeBox
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 142.0,),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LandingScreen()));
                          },
                          child: new Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Image(
                                    image: new AssetImage("assets/camera.png"),
                                    height: 100, width: 100),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Text("CAMERA",style: new TextStyle(fontSize: 20)),
                  new SizedBox(
                      height: 35.0),//SizeBox
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 141.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LocationPage()));
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Image(
                                    image: new AssetImage("assets/position.png"),
                                    height: 100, width: 100),
                              ],//<Widget>[]
                            ),//Column
                          ),//Container
                        ),//GestureDetector
                      ),//Padding
                    ],//<Widget>[]
                  ),//Row
                  new Text("BEEF POSITION",style: new TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 155.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Assessment()));
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Image(
                                    image: new AssetImage("assets/checklist.png"),
                                    height: 100, width: 100),
                              ],//<Widget>[]
                            ),//Column
                          ),//Container
                        ),//GestureDetector
                      ),//Padding
                    ],//<Widget>[]
                  ),//Row
                  new Text("ASSESSMENT",style: new TextStyle(fontSize: 20)),
                ],//<Widget>[]
              ),//Column
            ),//Container
          ),//Padding
        ],//<Widget>[]
      ),//ListView
    );//Scaffold
  }
}