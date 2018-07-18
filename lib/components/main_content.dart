import 'package:flutter/material.dart';

class MainContent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MainContentState();
  }
}

class MainContentState extends State<MainContent>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Text('水平滚动组件'),
          new Container(
            height: 100.0,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => new Image.asset(
                'images/menu_background.png',
                width: 400.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Text('测试'),
              new Text('测试'),
              new Text('测试'),
              new Text('测试'),
              new Text('测试'),
            ],
            itemExtent: 50.0,
          ),
        ],
      ),
    );
  }
}