import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "input",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("输入事件"),
        ),
        body: new MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel("samples.flutter.io/battery");
  String _batteryLevel = "Unknown battery level.";

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      print("dart -_getBatteryLevel");
//      在通道上调用此方法
      final int result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      print("dart -setState");
      _batteryLevel = batteryLevel;
    });
  }

  //跳转不传参数
  Future<Null> _toIntentNoData() async {
    String result = await platform.invokeMethod('withNOData');
    print(result);
  }

  //跳转传入参数
  Future<Null> _toIntentData() async {
    Map<String, String> map = {"flutter": "这是一条来自flutter的参数"};

    String result = await platform.invokeMethod('withData', map);

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    print("dart -build");
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new RaisedButton(
          onPressed: _getBatteryLevel,
          child: new Text("Get battery level"),
        ),
        new RaisedButton(
            onPressed: _toIntentNoData, child: new Text("跳转-不传参数")),
        new RaisedButton(onPressed: _toIntentData,
        child: new Text("跳转--传参数"),
        ),
        new Text("当前电量:$_batteryLevel"),
      ],
    );
  }
}
