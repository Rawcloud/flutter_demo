import 'package:flutter/material.dart';
import 'package:residemenu/residemenu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'connectivity.dart';
import 'path_provider.dart';
//import 'main_content.dart';

class SlideMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SlideMenuState();
  }
}

class SlideMenuState extends State<SlideMenu> with TickerProviderStateMixin {
  MenuController _menuController;
  String checkMsg = '';
  Widget tempWidget (msg){
    if(msg == '菜单一'){
      return new MyConnectivity();
    }else if(msg == '菜单三'){
      return new Text('测试界面');
    } else {
      return new Column(
        children: <Widget>[
          new Text('水平轮播组件'),
//          new Container(
//            height: 100.0,
//            child: new ListView.builder(
//              scrollDirection: Axis.horizontal,
//              shrinkWrap: true,
//              itemCount: 10,
//              itemBuilder: (context, index) => new Image.asset(
//                'images/menu_background.png',
//                width: 400.0,
//                height: 100.0,
//                fit: BoxFit.cover,
//              ),
//            ),
//          ),
          new SizedBox(
              height: 200.0,
              width: 350.0,
              child: new Carousel(
                images: [
                  new ExactAssetImage('images/menu_background.png'),
                  new ExactAssetImage('images/menu_background.png'),
                  new ExactAssetImage("images/user.jpg")
                ],
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.lightGreenAccent,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.purple.withOpacity(0.5),
                borderRadius: true,
              )
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
      );
    }
  }

  Widget _buildItem(BuildContext context,String msg) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: const ResideMenuItem(
          title: '菜单*',
          icon: const Icon(
            Icons.home,
            color: Colors.grey,
          ),
          right: const Icon(
            Icons.arrow_right,
            color: Colors.grey,
          ),
        ),
        onTap: () {
//          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('你点击了$msg')));
          _menuController.closeMenu();
          _showToast(msg);
        },
      ),
    );
  }

  void _showToast(content) {
    checkMsg = content;
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
//        bgcolor: "#e74c3c",
//        textcolor: '#ffffff',
        timeInSecForIos: 2,
      gravity: ToastGravity.CENTER,
    );
    setState(() {
      tempWidget(content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ResideMenu.scafford(
      direction: ScrollDirection.LEFT,
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage('images/menu_background.png'),
            fit: BoxFit.cover),
      ),
      controller: _menuController,
      leftScaffold: new MenuScaffold(
        header: new ConstrainedBox(
          constraints: new BoxConstraints(maxHeight: 80.0, maxWidth: 80.0),
          child: new CircleAvatar(
            backgroundImage: new AssetImage('images/user.jpg'),
            radius: 40.0,
          ),
        ),
        children: <Widget>[
          _buildItem(context, '菜单一'),
          _buildItem(context, '菜单二'),
          _buildItem(context, '菜单三'),
          _buildItem(context, '菜单四'),
          _buildItem(context, '菜单五'),
        ],
      ),
      child: new Scaffold(
        body: new Column(
          children: <Widget>[
            tempWidget(checkMsg),
          ],
        ),
        appBar: new AppBar(
            title: new Text('SlideMenu'),
            leading: new GestureDetector(
              child: const Icon(Icons.menu),
              onTap: () {
                _menuController.openMenu(true);
              },
            )),
      ),
      onClose: () {
        print('closed');
      },
      onOpen: (left) {},
      onOffsetChange: (offset) {},
    );
  }

  @override
  void initState() {
    super.initState();
    _menuController = new MenuController(vsync: this);
  }
}
