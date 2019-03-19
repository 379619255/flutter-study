import 'package:flutter_ui_demo/global_config.dart';
import 'package:flutter/material.dart';

//有状态的widget
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //输入搜索框
  Widget searchInput() {
    return new Container(
      //容器
      child: new Row(
        children: <Widget>[
          new Container(
            child: new FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: new Icon(Icons.arrow_back, color: GlobalConfig.fontColor),
                label: new Text("")),
            width: 60.0,
          ),
          new Expanded(
              child: new TextField(
            //文本输入框
            autofocus: true,
            //InputDecoration.collapsed可以禁用装饰线，而是使用外面包围的Container的装饰线
            decoration: new InputDecoration.collapsed(
                hintText: "搜索内容",
                hintStyle: new TextStyle(color: GlobalConfig.fontColor)),
          )),
        ],
      ),
      decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: GlobalConfig.searchBackgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: GlobalConfig.themeData,
      home: new Scaffold(
        appBar: new AppBar(
          title: searchInput(),
        ),
        body: new SingleChildScrollView(
          //创建一个可滚动单个小部件的框
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Text("222",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0)),
                margin:
                    const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
                alignment: Alignment.topLeft,
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    child: new Chip(
                      label: new FlatButton(
                          onPressed: () {},
                          child: new Text(
                            "汽车关税下调",
                            style: new TextStyle(color: GlobalConfig.fontColor),
                          )),
                      backgroundColor: GlobalConfig.dark == true
                          ? Colors.white10
                          : Colors.black12,
                    ),
                    margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    alignment: Alignment.topLeft,
                  ),
                  new Container(
                    child: new Chip(
                      label: new FlatButton(
                          onPressed: () {},
                          child: new Text("李彦宏传闻辟谣",
                              style: new TextStyle(
                                  color: GlobalConfig.fontColor))),
                      backgroundColor: GlobalConfig.dark == true
                          ? Colors.white10
                          : Colors.black12,
                    ),
                    margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    alignment: Alignment.topLeft,
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    child: new Chip(
                      label: new FlatButton(
                          onPressed: () {},
                          child: new Text("小米",
                              style: new TextStyle(
                                  color: GlobalConfig.fontColor))),
                      backgroundColor: GlobalConfig.dark == true
                          ? Colors.white10
                          : Colors.black12,
                    ),
                    margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    alignment: Alignment.topLeft,
                  ),
                  new Container(
                    child: new Chip(
                      label: new FlatButton(
                          onPressed: () {},
                          child: new Text("555",
                              style: new TextStyle(
                                  color: GlobalConfig.fontColor))),
                      backgroundColor: GlobalConfig.dark == true
                          ? Colors.white10
                          : Colors.black12,
                    ),
                    margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    alignment: Alignment.topLeft,
                  ),
                ],
              ),
              new Container(
                child: new Text("搜索历史",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0)),
                margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                alignment: Alignment.topLeft,
              ),
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      child: new Icon(
                        Icons.access_time,
                        color: GlobalConfig.fontColor,
                        size: 16.0,
                      ),
                      margin: const EdgeInsets.only(right: 12.0),
                    ),
                    new Expanded(
                      child: new Container(
                        child: new Text(
                          "业余爱好",
                          style: new TextStyle(
                              color: GlobalConfig.fontColor, fontSize: 14.0),
                        ),
                      ),
                    ),
                    new Container(
                      child: new Icon(Icons.clear,
                          color: GlobalConfig.fontColor, size: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
