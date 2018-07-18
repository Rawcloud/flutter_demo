import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

class MyConnectivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyConnectivityState();
  }
}

class MyConnectivityState extends State<MyConnectivity> {

  String _connectionStatus = 'Unkown';
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      setState(() {
        _connectionStatus = result.toString();
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<Null> initConnectivity() async {
    String connectionStatus;
    try{
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }
    if(!mounted) {
      return;
    }
    setState(() {
      _connectionStatus = connectionStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Connectivirty demo'),
//      ),
//      body: new Center(
//        child: new Text('Connection Status:$_connectionStatus\n'),
//      ),
//    );
    return new Center(
        child: new Text('Connection Status:$_connectionStatus\n'),
      );
  }
}