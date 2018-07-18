import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PathProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PathProviderState();
  }
}

class PathProviderState extends State<PathProvider> {

  Future<Directory> _tempDirectory;
  Future<Directory> _appDocumentDirectory;
  Future<Directory> _externalDocumentDirectory;

  //获取临时文件目录
  void _requestTempDirectory() {
    setState(() {
      _tempDirectory = getTemporaryDirectory();
    });
  }

  //获取应用文件目录
  void _requestAppDocumentDirectory() {
    setState(() {
      _appDocumentDirectory = getApplicationDocumentsDirectory();
    });
  }

  //获取扩展存储目录
  void _requestExternalDocumentDirectory() {
    setState(() {
      _externalDocumentDirectory = getExternalStorageDirectory();
    });
  }

  //创建目录路径显示控件
  Widget _buidDirectory(BuildContext context,AsyncSnapshot<Directory> snapshot) {
    Text text = const Text('');
    if(snapshot.connectionState == ConnectionState.done) {
      if(snapshot.hasError) {
        text = new Text('Error:${snapshot.error}');
      } else if(snapshot.hasData) {
        text = new Text('path:${snapshot.data.path}');
      } else {
        text = new Text('path unavailabel');
      }
    }
    return new Padding(padding: const EdgeInsets.all(16.0) ,child: text,);
  }

  @override
  Widget build(BuildContext context) {
    return
//      new Scaffold(
//      appBar: new AppBar(
//        title: new Text('path provider demo'),
//      ),
//      body:
      new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.all(16.0),
                  child: new RaisedButton(onPressed: _requestTempDirectory,child: new Text('Get Temporary Directory'),),
                ),
              ],
            ),
            new Expanded(
              child: new FutureBuilder<Directory>(builder: _buidDirectory,future: _tempDirectory,),
            ),
            new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new RaisedButton(onPressed: _requestAppDocumentDirectory,child: new Text('Get Application Document Directory'),),
                ),
              ],
            ),
            new Expanded(
              child: new FutureBuilder<Directory>(
                builder: _buidDirectory,
                future: _appDocumentDirectory,
              ),
            ),
            new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new RaisedButton(
                    onPressed: _requestExternalDocumentDirectory,
                    child: new Text('${Platform.isIOS ? "External directories are unavailable"
                    "on IOS" :
                        "Get External Storage Directory"
                    }'),
                  ),
                ),
              ],
            ),
            new Expanded(
              child: new FutureBuilder<Directory>(
                future: _externalDocumentDirectory,
                builder: _buidDirectory,
              ),
            ),
          ],
        ),
      );
//    );
  }
}