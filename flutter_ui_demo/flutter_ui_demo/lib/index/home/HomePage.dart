import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/index/home/SearchPage.dart';
import 'package:flutter_ui_demo/global_config.dart';
import 'package:flutter_ui_demo/index/home/Follow.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///搜索
  Widget barSearch() {
    return new Container(
      child: new Row(
        //横向布局
        children: <Widget>[
          new Expanded(
              //自动扩展
              child: new FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(//跳转
                        new MaterialPageRoute(builder: (context) {
                      return SearchPage();
                    }));
                  },
                  icon: new Icon(Icons.search,
                      color: GlobalConfig.fontColor, size: 16.0),
                  label: new Text(
                    "1111",
                    style: new TextStyle(color: GlobalConfig.fontColor),
                  ))),
          new Container(
            /**
             * BoxDecoration:实现边框、圆角、阴影、形状、渐变、背景图像
                ShapeDecoration:实现四个边分别指定颜色和宽度、底部线、矩形边色、圆形边色、体育场（竖向椭圆）、 角形（八边角）边色
                FlutterLogoDecoration:实现Flutter图片
                UnderlineTabindicator:下划线
                decoration：绘制在child后面的装饰，设置了decoration的话，就不能设置color属性，否则会报错，此时应该在decoration中进行颜色的设置
             * **/
            decoration: new BoxDecoration(
                border: new BorderDirectional(
                    start: new BorderSide(
                        color: GlobalConfig.fontColor, width: 1.0))),
            height: 14.0,
            width: 1.0,
          ),
          new Container(
            child: new FlatButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new SearchPage();
                  }));
                },
                icon: new Icon(Icons.border_color,
                    color: GlobalConfig.fontColor, size: 14.0),
                label: new Text(
                  "提问",
                  style: new TextStyle(color: GlobalConfig.fontColor),
                )),
          )
        ],
      ),
      decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: GlobalConfig.searchBackgroundColor),
    ); //容器
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: barSearch(),
            bottom: new TabBar(
                labelColor:
                    GlobalConfig.dark == true ? Colors.red : Colors.blue,

                ///未选制表符标签的颜色。
                unselectedLabelColor:
                    GlobalConfig.dark == true ? Colors.white : Colors.black,
                tabs: [
                  new Tab(text: "关注"),
                  new Tab(text: "推荐"),
                  new Tab(text: "热榜"),
                ]),
          ),
          body: new TabBarView(
              children: [new Follow(), new Follow(), new Follow()]),
        ));
  }
}
