import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui';

void main() => runApp(MyApp());

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'route1':
      return MyHomePage(title: 'Flutter Demo Home Page1');
    case 'route2':
      return MyHomePage(title: 'Flutter Demo Home Page2');
    default:
      return MyHomePage(title: 'Flutter Demo Home Page3');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter当做个module',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _widgetForRoute(///路由解析出来
          window.defaultRouteName), //window.defaultRouteName是dart:ui
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const toAndroidPlugin =
      const MethodChannel('module.com.netease.androidflutter.toandroid/plugin');
  static const fromAndroiPlugin =
      const EventChannel('module.com.netease.androidflutter.toflutter/plugin');

  StreamSubscription _fromAndroidSub;
  var _nativeParams;

  //初始化
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startfromAndroiPlugin();
  }
  ///从android监听信息
  void _startfromAndroiPlugin() {
    if (_fromAndroidSub == null) {
      _fromAndroidSub = fromAndroiPlugin
          .receiveBroadcastStream()
          .listen(_onfromAndroiEvent, onError: _onfromAndroiError);
    }
  }

  void _onfromAndroiEvent(Object event) {
    setState(() {
      _nativeParams = event;
    });
  }

  void _onfromAndroiError(Object error) {
    setState(() {
      _nativeParams = "error";
      print(error);
    });
  }

  //flutter 调用原生的跳转（无参数）
  Future<Null> _jumpToNative() async {
    String result = await toAndroidPlugin.invokeMethod('withoutParams');

    print(result);
  }
  //flutter调用原生的跳转(带参数)
  Future<Null> _jumpToNativeWithParams() async {
    Map<String, String> map = {"flutter": "这是一条来自flutter的参数"};

    String result = await toAndroidPlugin.invokeMethod('withParams', map);

    print(result);
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("flutter当作modlule"),
      ),
      body: Center(
          child: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('跳转到原生界面'),
                onPressed: () {
                  _jumpToNative();
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('跳转到原生界面(带参数)'),
                onPressed: () {
                  _jumpToNativeWithParams();
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new Text('这是一个从原生获取的参数：$_nativeParams'),
          ),
        ],
      )),

    );
  }
}
